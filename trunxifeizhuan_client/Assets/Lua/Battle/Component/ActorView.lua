local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local mBloodManager = require "Module/Combat/BloodManager"
local ActorView = LuaClass("ActorView",ActorObserver);
local mDoFileUtil = require "Utils/DoFileUtil";
local mNotifyEnum = require"Enum/NotifyEnum"
local mEffectManager = require "Battle/Manager/EffectManager"
local mCommonEffects = mEffectManager.mCommonEffects;
local UnityEngine = UnityEngine;
local GameObject = UnityEngine.GameObject;

function ActorView:Awake()
	self.mModelView = self:CreateModel(function (go)self:OnLoadModelCompleted(go);end);
	self:ShowModel(mCommonEffects.mBorn);
	self:AddObservers();
end

function ActorView:OnLoadModelCompleted(go)
	local owner = self:GetActor();
	local modelView = self.mModelView;
	owner.mCollider = modelView:AttachCollider();
	owner.mTransform = modelView.mTransform;
	self.mGameObject = go;
end

function ActorView:CreateModel(loadCallback)
	local owner = self:GetActor();
	local modelView = mDoFileUtil:DoFile("Battle/View/ModelView").LuaNew(owner.mActorVo.mModel,loadCallback);
	modelView:SetPosition(owner.mPosition);
	modelView:SetRotation(owner.mRotation);
	modelView:SetModelScale(owner:GetModelScale());

	return modelView;
end

function ActorView:AddObservers()

	self:RegisterListener(mNotifyEnum.OnAddBuff,function (buff)
		self:AddBuffEffect(buff.mConfig.effect);
	end);
	self:RegisterListener(mNotifyEnum.OnRemoveBuff,function (buff)
		self:RemoveBuffEffect(buff.mConfig.effect);
	end);
	self:RegisterListener(mNotifyEnum.OnToggleModel,function (flag)
		self:ToggleModel(flag);
	end);

	self:RegisterListener(mNotifyEnum.OnShowHitEffect,function (params)
		self:ShowHitEffect(params[1],params[2]);
	end);
	
	self:RegisterListener(mNotifyEnum.OnBeKilled,function ()
		self:ShowEffect(mCommonEffects.mDead);
	end);
end

function ActorView:ToogleSwimState(buff)
	if buff:IsSwimState() then
		self.mModelView:ToogleSwimState(self:GetActor():ContainsSwimState());
	end
end

function ActorView:AddModelObservers()
	local component = self:GetActor():AddComponent("ActorObserver","ModelComponent");

	component:RegisterListener(mNotifyEnum.Position,function (position)
		self.mModelView:SetPosition(position);
	end);
	component:RegisterListener(mNotifyEnum.Rotation,function (rotation)
		self.mModelView:SetRotation(rotation);
	end);
	component:RegisterListener(mNotifyEnum.LerpToRotation,function (rotation)
		self.mModelView:LerpToRotation(rotation,0.5);
	end);
	component:RegisterListener(mNotifyEnum.Animation,function (state)
		self.mModelView:PlayAnimation(state);
	end);
	component:RegisterListener(mNotifyEnum.OnAddBuff,function (buff)
		self:ToogleSwimState(buff);
	end);
	component:RegisterListener(mNotifyEnum.OnRemoveBuff,function (buff)
		self:ToogleSwimState(buff);
	end);
end

function ActorView:RemoveModelObservers()
	self:GetActor():RemoveComponent("ModelComponent");
end

function ActorView:Dispose()
	self:HideModel();
	self.mModelView = nil;
	self:ClearBuffEffect();
end

function ActorView:ToggleModel(flag)
	if flag then
		self:ShowModel();
	else
		self:HideModel();
	end
end
function ActorView:ShowModel(effect)
	
	local modelView = self.mModelView;
	if modelView then
		modelView:AddModelEffect(mCommonEffects.mShadow);
		modelView:ShowView();
		self:AddModelObservers();
	end

	self:ShowEffect(effect);

	local bloodView = self.mBloodView;
	if not bloodView then
		self.mBloodView = mBloodManager:CreateBlood(self:GetActor());
	end
end

function ActorView:HideModel(effect)
	local modelView = self.mModelView;
	if modelView then
		modelView:Dispose();
		self:RemoveModelObservers();
	end

	self:ShowEffect(effect);

	local bloodView = self.mBloodView;
	if bloodView then
		mBloodManager:OnRemove(bloodView);
		self.mBloodView = nil;
	end
	self.mGameObject = nil;
end

function ActorView:ShowHitEffect(effectConfig,playHitAnimation)
	if effectConfig then
		local actor = self:GetActor();
		mEffectManager:ShowEffect(mEffectManager:GetEffect(effectConfig),actor);
		local animation = effectConfig.animation;
		if playHitAnimation and animation then
			actor:Notify(mNotifyEnum.Animation,animation);
		end
	end
end

function ActorView:ShowEffect(config)
	if not config then
		return;
	end
	local effect = mEffectManager:GetEffect(config);
	if effect then
		mEffectManager:ShowEffect(effect,self:GetActor());
	end
end

function ActorView:RemoveBuffEffect(id)

	local config = mEffectManager:GetEffectConfig(id);
	if not config then
		return;
	end

	local effects = self.mBuffEffects;
	if not effects then
		return;
	end

	local effect = effects[config];
	if effect then
		if effect:ReduceRef() < 1 then
			effects[config] = nil;
		end
	end
end

function ActorView:AddBuffEffect(id)

	local config = mEffectManager:GetEffectConfig(id);
	if not config then
		return;
	end

	if config.cls ~= "BuffEffect" then
		effect = mEffectManager:GetEffect(config);
		mEffectManager:ShowEffect(effect,self:GetActor());
		return;
	end

	local effects = self.mBuffEffects;
	if not effects then
		effects = {};
		self.mBuffEffects = effects;
	end

	local effect = effects[config];
	if not effect then
		effect = mEffectManager:GetEffect(config);
		effects[config] = effect;
	end
	effect:AddRef();
	mEffectManager:ShowEffect(effect,self:GetActor());
end

function ActorView:ClearBuffEffect()
	local effects = self.mBuffEffects;
	if not effects then
		return;
	end

	for k,v in pairs(effects) do
		v:ResetRef();
		effects[k] = nil;
	end

	self.mBuffEffects = nil;
end

function ActorView:FindNode(childName)
	local modelView = self.mModelView;
	if modelView then
		return modelView:FindNode(childName);
	end
	return nil;
end

return ActorView;