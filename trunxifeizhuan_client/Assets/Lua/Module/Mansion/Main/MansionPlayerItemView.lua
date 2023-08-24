local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mFollowerBaseVO = require"Module/Follower/FollowerBaseVO"
local MansionController = require "Module/Mansion/MansionController"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local MansionPlayerItemView = mLuaClass("MansionPlayerItemView",mLayoutItem);
local mSuper = nil;
local mColor = Color;

function MansionPlayerItemView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_player_item_view",
	};
end

function MansionPlayerItemView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('player_item').gameObject);

    local callBack = function() self:OnClickPlayerItem() end;
	self:FindAndAddClickListener('player_item/Icon', callBack,"ty_0204", 0.5);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MansionPlayerItemView:OnUpdateData()
	local data = self.mData.mPbData.base;
	self.mTextName.text = data.name;
	self.mPlayerItem:SetInfo(  data.sex, data.position, data.level );
end

function MansionPlayerItemView:OnClickPlayerItem()
	self:SetSelected(true);
	MansionController:SendVisitPlayer(self.mData.mPlayerID);
end

return MansionPlayerItemView;