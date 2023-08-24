local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local MansionFeastListItem = mLuaClass("MansionFeastListItem",mLayoutItem);
local mSuper = nil;

function MansionFeastListItem:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_feast_list_item",
	};
end

function MansionFeastListItem:Init( )
	self.mObjectJoin = self:Find( 'Image_1' ).gameObject;
	self.mTextPlayerName = self:FindComponent( 'Text_2', "Text" );
	self.mTextFeastName = self:FindComponent( 'Text_3', "Text" );
	self.mTextGuestRate = self:FindComponent( 'Text_4', "Text" );
	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('player_item').gameObject);
	self:FindAndAddClickListener("bg_1",function() self:OnClickListItem(); end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MansionFeastListItem:OnUpdateData()
	local data = self.mData;
	self.mTextPlayerName.text = data:GetPlayerName( );
	self.mTextFeastName.text = data:GetFeastName( );
	self.mTextGuestRate.text = data:GetFeastGuestRate( );
	self.mPlayerItem:SetInfo(data:GetPlayerItemVO());
	self.mObjectJoin:SetActive( data.mSelfJoin );
end

function MansionFeastListItem:OnClickListItem(  )
	self:Dispatch(self.mEventEnum.ON_SELECT_FEAST_LIST_ITEM,self.mData);
end

return MansionFeastListItem;