local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local MansionFeastDetailItem = mLuaClass("MansionFeastDetailItem",mLayoutItem);
local mSuper = nil;

function MansionFeastDetailItem:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_feast_detail_item",
	};
end

function MansionFeastDetailItem:Init( )
	self.mTextName = self:FindComponent( 'Text_2', 'Text' );
	self.mTextCost = self:FindComponent( 'Text_4', 'Text' );
	self.mCostIcon = self:FindComponent( 'Image_1', 'Image' );
	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('player_item').gameObject);
	
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MansionFeastDetailItem:OnUpdateData()
	local data = self.mData;
	local costType, costNum = data:GetCostInfo( );

	self.mTextCost.text = costNum;
	self.mTextName.text = data.mPlayer.name;
	self.mPlayerItem:SetInfoByPlayerBase(data.mPlayer);
	self.mGameObjectUtil:SetImageSprite(self.mCostIcon,mGameModelManager.BagModel:GetSellIconByType( costType ) );
end

return MansionFeastDetailItem;