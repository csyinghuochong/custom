local BaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local GameObject = UnityEngine.GameObject;
local BuffView = require "Module/Combat/BuffView"
local BloodView = mLuaClass("BloodView",BaseView);
local mCameraController = require "Manager/CameraController"
local mSuperBloodView = require "Module/Combat/SuperBloodView"
local ActorTypeEnum = require "Module/Combat/ActorTypeEnum"
local Vector3 = Vector3;
local CanvasType = typeof(UnityEngine.Canvas);
local mUpdateManager = require "Manager/UpdateManager"

function BloodView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "blood_view",
		["ParentLayer"] = mBattleLayer,--m3DBattleLayer,--mBattleLayer,
	};
end

function  BloodView:Init()
	self.mImageRound = self:Find('blood/Image_round');
	self.mBloodGraphic = self:FindComponent('blood/Image_blood', 'GameGraphic');
	--self.mCampGraphic = self:FindComponent("blood/Image_camp","GameGraphic");
	self.mLevelText = self:FindComponent("blood/Text_level","Text");
	self.mRestrainGraphic = self:FindComponent('Image_restrain', 'GameGraphic');
	self.mBuffView = BuffView.LuaNew(self:Find('blood/buffView').gameObject);
	self.mCanvas = self.mTransform:GetComponent(CanvasType);
	self.mBloodRoot = self:Find("blood").gameObject;
end

function BloodView:RemoveObservers(actor)
	if actor then
		actor:RemoveComponent("BloodComponent");
	end
end

function BloodView:AddObservers(actor)

	local component = actor:AddComponent("ActorObserver","BloodComponent");
	local mNotifyEnum = component:GetNotifyEnum();

	component:RegisterListener(mNotifyEnum.OnOtherSelectSkill,function (skill)
		self:ToggleRestrain(skill,true);
	end);
	component:RegisterListener(mNotifyEnum.OnOtherUseSkill,function (skill)
		self:ToggleRestrain(skill,false);
	end);
	component:RegisterListener(mNotifyEnum.Health,function (value)
		self:UpdateHealth(value);
	end);
	component:RegisterListener(mNotifyEnum.AttackBar,function (value)
		self:UpdateAttackBar(value);
	end);
end

function BloodView:GetClass()
	return "BloodView";
end

function BloodView:Restrain0(skill,actor,target)
	if actor.mTeam == target.mTeam then
		return 1;
	else
		return -1;
	end
end

function BloodView:Restrain1(skill,actor,target)

	if actor.mTeam == target.mTeam then
		return -1;
	end
	
	return skill:Restrain(target);
end

function BloodView:Restrain2(skill,actor,target)
	if actor == target then
		return 1;
	else
		return -1;
	end
end

function BloodView:Restrain4(skill,actor,target)
	if actor.mTeam == target.mTeam then
		return 1;
	end
	return -1;
end

function BloodView:Restrain(skill,actor,target)
	local targetType = skill.mTargetType;
	if targetType == 0 then
		return self:Restrain0(skill,actor,target);
		elseif targetType == 1 then
			return self:Restrain1(skill,actor,target);
			elseif targetType == 2 then
				return self:Restrain2(skill,actor,target);
				elseif targetType == 4 then
					return self:Restrain4(skill,actor,target);
				end

	return -1;
end

--克制关系
function BloodView:ToggleRestrain(skill,flag)

	local graphic = self.mRestrainGraphic;
	local data = self.mData;

	if not graphic or not data then
		return;
	end

	local actor = skill.mOwner;

	if flag == false or actor:IsPlayerControl() == false or data:IsInState1015() then
		graphic.gameObject:SetActive(false);
		return;
	end

	local restrain = self:Restrain(skill,actor,data);
	if restrain == -1 then
		graphic.gameObject:SetActive(false);
		return;
	end

	graphic:SetSpriteByIndex(restrain,true);
	graphic.gameObject:SetActive(true);

end

function BloodView:ResetTransform()
	local transform = self.mTransform;
	transform.localEulerAngles = Vector3.zero;
	transform.localScale = Vector3.one * self.mScale;
end

function BloodView:OnViewShow()
	local data = self.mData;
	if not data then 
		return;
	end
	mUpdateManager:AddLateUpdate(self);

	local restrain = self.mRestrainGraphic;
	local isAlive = data:IsAlive();

	if data:IsAlive() then
		self.mBloodRoot:SetActive(true);
		restrain.gameObject:SetActive(false);
	else
		self.mBloodRoot:SetActive(false);
		restrain.gameObject:SetActive(true);
		restrain:SetSpriteByIndex(1,true);
		return;
	end
	
	--self.mScale = data.mActorVo.mBloodScale; 
	--self:ResetTransform();

	self.mName = data.mName;
	self.mLevelText.text = data:GetLevel();

	self.mBloodGraphic:SetSpriteByIndex(data.mTeam - 1,false);
	--self.mCampGraphic:SetSpriteByIndex(data.mCamp - 1,false);
	self:UpdateHealth(data:GetHealthPersent());
	self:UpdateAttackBar(data:GetAttackBarPersent());
	self.mBuffView:OnViewShow(data);
	self:AddObservers(data);
end

function BloodView:OnViewHide(  )
	local superBlood = self.mSuperBlood;
	if superBlood ~= nil then
		superBlood:CloseView();
		self.mSuperBlood = nil;
	end

	self.mBuffView:OnViewHide();
	self:RemoveObservers(self.mData);
	mUpdateManager:RemoveLateUpdate(self);
end

function BloodView:Dispose()
	mUpdateManager:RemoveLateUpdate(self);
end

function BloodView:SetData(data)
	self.mData = data;

	if data.mActorVo.mActorType == ActorTypeEnum.ActorBoss then
		self.mSuperBlood = mSuperBloodView.LuaNew();
		self.mSuperBlood:ShowView( data.mActorVo.mActorID );
	end
	self.mModelView = data:GetComponent("ActorView").mModelView;
end

function BloodView:UpdateHealth(hp)
	local health = self:Clamp01(hp);
	local blood = self.mBloodGraphic;
	if blood then
		blood.transform.localScale = Vector3.New(health, 1, 1);
	end

	local superBlood = self.mSuperBlood;
	if superBlood ~= nil then
		superBlood:UpdateHealth(health);
	end
end

function BuffView:GetBuffView()
	return self.mBuffView;
end

function BloodView:Clamp01(value)
	return math.min(math.max(0,value),1);
end
function BloodView:UpdateAttackBar(value)
	local transform = self.mImageRound;
	if transform then
		transform.localScale = Vector3.New(self:Clamp01(value), 1, 1);
	end
	local superBlood = self.mSuperBlood;
	if superBlood ~= nil then
		superBlood:UpdateAttackBar(value);
	end
end

function BloodView:UpdatePosition()
	local modelView = self.mModelView;
	if not modelView then
		return;
	end

    local screenPoiont = mCameraController:WorldToScreenPoint(modelView:GetHPPoint());
	self.mTransform.position = mUICamera:ScreenToWorldPoint(screenPoiont); 
end

function BloodView:OnLateUpdate()
	self:UpdatePosition();
end

return BloodView;