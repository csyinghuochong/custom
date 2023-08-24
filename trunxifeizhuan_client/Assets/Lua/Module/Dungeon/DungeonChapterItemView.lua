local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLanguageUtil = require "Utils/LanguageUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local DungeonChapterItemView = mLuaClass("DungeonChapterItemView",mLayoutItem);
local mColor = Color;
local mSuper = nil;

function DungeonChapterItemView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_chapter_item_view",
	};
end

function DungeonChapterItemView:Init()
	self.mLock = self:Find( 'Image_3' ).gameObject;
	self.mImageBg1 = self:FindComponent('Image_1', 'Image');
	self.mImageBg2 = self:FindComponent('Image_2', 'Image');
	self.mTextChapterName = self:FindComponent('Text_1', 'Text');

	local callBack = function() self:OnClickChapterItem() end;
	self:FindAndAddClickListener('button_1', callBack);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

local mLgChapterNoOpenTip = mLanguageUtil.dungeon_chapter_no_open;
function DungeonChapterItemView:OnClickChapterItem()
	local data = self.mData;
	if data:IsOpen( ) then
		self:Dispatch(self.mEventEnum.ON_SELECT_CHAPTER_ITEM, data);
	else
		mCommonTipsView.Show(mLgChapterNoOpenTip);
	end
end

function DungeonChapterItemView:OnUpdateData()
	local data = self.mData;
	self:SetSelectState( );
	self.mTextChapterName.text = data.mSysVO.chapter_name;
end

local mColor_1 = mColor.New(130 / 255,29 / 255,29 / 255);
local mColor_2 = mColor.New(86 / 255, 20 / 255, 20 / 255);
function DungeonChapterItemView:SetSelectState(  )
	local data = self.mData;
	local open = data:IsOpen( );
	self.mLock:SetActive( not open );
	self.mImageBg1.color = open and mColor.white or mColor.gray;
	self.mImageBg2.color = open and mColor.white or mColor.gray;
	self.mTextChapterName.color = open and mColor_1 or mColor_2;
end

return DungeonChapterItemView;