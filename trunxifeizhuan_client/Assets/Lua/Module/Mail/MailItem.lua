local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mTimeUtil = require "Utils/TimeUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mGameTimer = require "Core/Timer/GameTimer"
local MailItem = mLuaClass("MailItem",mLayoutItem);
local mSuper = nil;

function MailItem:InitViewParam()
	return {
		["viewPath"] = "ui/mail/",
		["viewName"] = "mail_item_view",
	};
end

function MailItem:Init( )
	self.mTextTitle = self:FindComponent("Title","Text");
	self.mTextDay = self:FindComponent("Day","Text");
	self.mImgBox = self:FindComponent("Box","Image");
	self.mImgBoxEmpty = self:FindComponent("BoxEmpty","Image");
	self.mImgMailClose = self:FindComponent("IconClose","Image");
	self.mImgMailOpen = self:FindComponent("IconOpen","Image");

	self:FindAndAddClickListener("Back",function()self:OnClickMail();end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MailItem:OnClickMail()
	self:SetSelected(true);
end

function MailItem:OnSelected(select)
	if select then
		local mEvent = self.mEventEnum;
		local data = self.mData;
		self:Dispatch(mEvent.ON_ITEM_SELECT_MAIL,data);
	end
end

function MailItem:OnViewShow()
	
end

function MailItem:OnUpdateData()
	local  data = self.mData;
	self.mTextTitle.text = data.title;
	self.mTextDay.text = mTimeUtil:TransToYearMonthDay(data.create_time);
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local second = data.extend_time - currentTime;
	self.mSecond = second;
	if self.mTimerInterval ~= nil then
		self.mTimerInterval:Stop();
	end
	self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);

	self.mImgMailClose.gameObject:SetActive(data.read_status == 1);
	self.mImgMailOpen.gameObject:SetActive(data.read_status ~= 1);

	self.mImgBox.gameObject:SetActive(false);
	self.mImgBoxEmpty.gameObject:SetActive(false);
	if data.append_status == 0 then
		self.mImgBox.gameObject:SetActive(false);
		self.mImgBoxEmpty.gameObject:SetActive(false);
	else
		self.mImgBox.gameObject:SetActive(data.append_status == 1);
		self.mImgBoxEmpty.gameObject:SetActive(data.append_status ~= 1);
	end
end

function MailItem:OnTimerInterval()
    local second = self.mSecond;
    second = second - 1;
 --    if second >= 3600 then
	-- 	self.mTextTime.text = mTimeUtil:TransToDayHour(second);
	-- else
	-- 	self.mTextTime.text = mTimeUtil:TransToMin(second);
	-- end
	if second <= 0 then
        self.mTimerInterval:Stop();
        local mEvent = self.mEventEnum;
        local data = self.mData;
		self:Dispatch(mEvent.ON_ITEM_DELETE_MAIL,data);
    end
    self.mSecond = second;
end

function MailItem:Dispose()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return MailItem;