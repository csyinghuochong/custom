local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local MansionController = require "Module/Mansion/MansionController"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local MansionEventItem = mLuaClass("MansionEventItem",mLayoutItem);
require "Module/Face/FaceConfig"
local mSuper = nil;

function MansionEventItem:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_event_item",
	};
end

function MansionEventItem:Init()
	self.mTextDesc = self:FindComponent('1/faceText','GameEmojiText');
	self.mTextDesc.enabled = true;
	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('player_item').gameObject);

	self.mButton = self:Find('btn_1').gameObject;
	self.mTextButton = self:FindComponent('btn_1/Text','Text');
	self:AddBtnClickListener(self.mButton, function() self:OnClickButton() end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MansionEventItem:OnUpdateData()
	local data = self.mData;

	self.mTextDesc:SetEmojiText(data.mContentStr);
	self.mPlayerItem:SetInfo(data:GetPlayerItemVO());

	local text = data.mSysVO.button;
	self.mButton:SetActive( text ~= '' );
	self.mTextButton.text = text;
end

function MansionEventItem:OnClickButton(  )
	MansionController:SendVisitPlayer(self.mData:GetPlayerID());
end

return MansionEventItem;