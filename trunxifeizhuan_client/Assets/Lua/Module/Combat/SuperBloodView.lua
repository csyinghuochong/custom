local mLuaClass = require "Core/LuaClass"
local BaseView = require "Core/BaseView"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local SuperBloodView = mLuaClass("SuperBloodView",BaseView);
local mRoleIconPath = mResourceUrl.role_icon;
local mVector3 = Vector3;
local mColor = Color;

function SuperBloodView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "super_blood_view",
		["ParentLayer"] = mBattleLayer,
	};
end

function  SuperBloodView:Init()
	self.mImageBlood = self:Find('TopRight/Image_blood');
	self.mImageRound = self:Find('TopRight/Image_round');
	self.mBossIcon = self:FindComponent( 'TopRight/Image_career', 'RawImage' );
	self.mBossIcon.color = mColor.clear;
	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end
end

function SuperBloodView:LoadIconCallback(icon)
	self.mBossIcon.texture = icon;
	self.mBossIcon.color = mColor.white;
end

function SuperBloodView:OnViewShow( monster_id )
	if self.mHp ~= nil then
		self:UpdateHealth(self.mHp);
	end

	local icon = mConfigSysmonster[monster_id].mini_icon;
	mUITextureManager.LoadTexture(mRoleIconPath, icon, self.mLoadedIcon);
end

function SuperBloodView:UpdateHealth(hp)
	local blood = self.mImageBlood;
	if blood ~= nil then
		blood.localScale = mVector3.New(hp, 1, 1);
	end
	self.mHp = hp;
end

function SuperBloodView:UpdateAttackBar(value)
	local transform = self.mImageRound;
	if transform then
		transform.localScale = Vector3.New(value, 1, 1);
	end
end

return SuperBloodView;