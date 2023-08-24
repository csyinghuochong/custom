local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameModelManager = require "Manager/GameModelManager"
local mTimeUtil = require "Utils/TimeUtil"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local ChatPlayerItem = mLuaClass("ChatPlayerItem",mLayoutItem);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgQian = mLanguageUtil.qian;

function ChatPlayerItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_player_item_view",
	};
end

function ChatPlayerItem:Init( )
	self.mTextTime = self:FindComponent("Time","Text");
	self.mGoPointRed = self:Find('Red').gameObject;
	self.mTextName = self:FindComponent('Name','Text');
	self.mTextNum = self:FindComponent('Red/Num','Text');
	self.mImgSex = self:FindComponent("Sex","Image");
	local go = self:Find("Player").gameObject;
	self.mPlayer = mCommonPlayerHeadView.LuaNew(go);

	self:FindAndAddClickListener("Back",function() self:ClickItem(); end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ChatPlayerItem:ClickItem()
	self:SetSelected(true);
end

function ChatPlayerItem:UpdatePoint()
	self.mData.count = 0;
	self:OnUpdateData();
end

function ChatPlayerItem:OnSelected(select)
	if select then
		local mEvent = self.mEventEnum;
		local data = self.mData;
		self:UpdatePoint();
		self:Dispatch(mEvent.ON_ITEM_SELECT_PRIVATE_PLAYER,data);
	end
end

function ChatPlayerItem:OnUpdateData()
	local data = self.mData;
	local Base = data.base;
	self.mTextName.text = Base.name;
	local isOnline = data.is_online == 1;
	local isShowRed = data.count > 0;
	self.mGoPointRed:SetActive(isShowRed);
	self.mTextNum.text = data.count;
	self.mTextTime.text = self:GetTime(data.time)..mLgQian;
	self.mPlayer:SetInfo(Base.sex,Base.position,Base.level);

	local sex = self.mSex;
	if sex ~= Base.sex then
		self.mGameObjectUtil:SetImageSprite(self.mImgSex,"common_icon_sex"..Base.sex);
		self.mSex = Base.sex;
	end
end

function ChatPlayerItem:GetTime(time)
	local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
	local second = nowTime - time;
	if second < 3600 then
		return mTimeUtil:TransToMin(second);
	elseif second < 86400 then
		return mTimeUtil:TransToHour(second);
	else
		return mTimeUtil:TransToDay(second);
	end
end

function ChatPlayerItem:OnViewHide(logicParams)
	self.mIsSelect = false;
end

return ChatPlayerItem;