local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mNotifyEnum = require"Enum/NotifyEnum"
local mEventEnum = require "Enum/EventEnum"
local mActorVO = require "Battle/ActorVO"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mUITextureManager = require "Manager/UITextureManager"
local mBattleController = require "Battle/Combat/BattleController"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local ArenaCombatKingView = mLuaClass("ArenaCombatKingView",mBaseView);
local mRoleIconPath = mResourceUrl.role_icon;
local mColor = Color;

function ArenaCombatKingView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arene_combat_king_view",
		["ParentLayer"] = mBattleLayer,
	};
end

function  ArenaCombatKingView:Init()
	self.mImageRound = self:Find('Image_bar');
	self.mImageIcon =self:FindComponent('Image_icon', 'RawImage');
	self.mImageIcon.color = mColor.clear;

	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end
end

function ArenaCombatKingView:OnViewShow(  )
	self:InitKingVO();
end

function ArenaCombatKingView:InitKingVO(  )
	local kingVO = mActorVO.LuaNew();
	kingVO:InitKingVO(mCombatModelManager.mCurrentModel:GetDungeonPlay(), 2);
	local actor = mBattleController.mCombat:CreateUnRealActor(kingVO);
	local onUpdateAttackBar = function ( value )
		self:UpdateAttackBar(value);
	end
	actor:AddObserver(mNotifyEnum.AttackBar, onUpdateAttackBar);

	mUITextureManager.LoadTexture(mRoleIconPath, 'role_20031',self.mLoadedIcon);
end

function ArenaCombatKingView:UpdateAttackBar(value)
	if self.mGameObject then
		 self.mImageRound.localScale = Vector3.New(value, 1, 1);
	end
end

function ArenaCombatKingView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

return ArenaCombatKingView;