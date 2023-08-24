local mLuaClass = require "Core/LuaClass"
local RankItem = require "Module/Rank/RankItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mCheckController = require "Module/Check/CheckController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local ArenaRankItemView = mLuaClass("ArenaRankItemView",RankItem);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgLast = mLanguageUtil.check_invalid_player;
local mColor = Color;
local mSuper = nil;

function ArenaRankItemView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_rank_item_view",
	};
end

function ArenaRankItemView:Init( )
	self.mTextValue2 = self:FindComponent("Value2","Text");
	self.mImageDivision = self:FindComponent('Image_1', 'RawImage');
	self.mImageDivision.color = mColor.clear;

	self.mLoadedDivisionIcon = function (icon)
		self:OnLoadedDivisionIcon(icon);
	end
	
    mSuper = self:GetSuper(RankItem.LuaClassName);
	mSuper.Init(self);
end

function ArenaRankItemView:UpdateSubUI( data )
	self.mTextValue2.text = data.score;
	self.mTextValue.text = data:GetDivisionVoByScore( data.score ).name;
	mUITextureManager.LoadTexture(mGoodsIconPath, 'icon_001600',self.mLoadedDivisionIcon);
end

function ArenaRankItemView:OnClickItem()
	local data = self.mData;
	if data.mRobot then
		mCommonTipsView.Show( mLgLast );
	else
		mCheckController:SendGetOtherPlayer(data.player_id);
	end
end

function ArenaRankItemView:OnLoadedDivisionIcon(icon)
	self.mImageDivision.texture = icon;
	self.mImageDivision.color = mColor.white;
end

return ArenaRankItemView;