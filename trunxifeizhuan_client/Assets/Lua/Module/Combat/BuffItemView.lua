local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local SortTable = require "Common/SortTable"
local BuffItemView = mLuaClass("BuffItemView",mBaseView);
local mVector3 = Vector3;

local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local Application = UnityEngine.Application;
local mResourceManager = ResourceManager;
local mIsEditor = Application.isEditor;
local mTextureType = typeof(UnityEngine.Texture);
local mBuffIconPath = mResourceUrl.buff_icon;
local List = require "Common/List"

function BuffItemView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "buff_item",
		["ParentLayer"] = m3DBattleLayer,--mBattleLayer,
	};
end

function BuffItemView:Init()
	self.mIconImage = self:FindComponent('icon', 'RawImage');
	self.mTextTime = self:FindComponent('time', 'Text');
end

function BuffItemView:SetParent(parent)
	local transform = self.mTransform;
	transform:SetParent(parent);
	transform.localEulerAngles = mVector3.zero;
	transform.localScale = mVector3.one;
	transform.localPosition = mVector3.zero;
end

function BuffItemView:OnViewHide()
	local buffs = self.mBuffs;
	if buffs then
		buffs:Clear();
	end
end

function BuffItemView:UpdatTime(time)
	if time and time > 100 then
		time = nil;
	end
	self.mTextTime.text = time;
end

function BuffItemView:UpdateIcon(icon)
	if icon then
		mUITextureManager.LoadTexture(mBuffIconPath, icon,function (texture)
			if texture then
				local image = self.mIconImage;
				image.texture = texture;
				image:SetNativeSize();
			end
		end);
	end
end

function BuffItemView:OnViewShow(logicParams)
	if logicParams then
		logicParams();
	end
	self:Update();
end

function BuffItemView:Update()
	local buffs = self.mBuffs;
	if buffs then
		local time = 0;
		local temp = 0;
		buffs:Foreach(function (buff)
			temp = buff:GetRemainRound();
			if temp > time then
				time = temp;
			end
		end);
		self:UpdatTime(time);
	end
end

function BuffItemView:OnRemoveBuff(buff)
	local buffs = self.mBuffs;
	if buffs then
		if buffs:Remove(buff) then
			self:Update();
		end
	end
end

function BuffItemView:OnAddBuff(buff)
	local buffs = self.mBuffs;
	if not buffs then
		buffs = List.LuaNew();
		self.mBuffs = buffs;
	end
	if buffs:Insert(buff) then
		self:Update();
	end
end

function BuffItemView:GetBuffCount()
	return self.mBuffs and self.mBuffs:GetLen() or 0;
end

return BuffItemView;