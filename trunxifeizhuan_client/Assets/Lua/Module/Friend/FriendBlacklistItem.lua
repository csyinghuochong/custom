local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mTimeUtil = require "Utils/TimeUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mGameTimer = require "Core/Timer/GameTimer"
local mAssetManager = require "AssetManager/AssetManager"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendBlacklistItem = mLuaClass("FriendBlacklistItem",mLayoutItem);
local mSuper = nil;
local mColor = Color

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgPower = mLanguageUtil.friend_info_power;
local mLgLevel = mLanguageUtil.friend_info_level;
local mLgQian = mLanguageUtil.qian;

local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"

function FriendBlacklistItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_blacklist_item_view",
	};
end

function FriendBlacklistItem:Init( )
	self.mTextName = self:FindComponent('Middle/Name','Text');
	self.mTextTime = self:FindComponent('Middle/Time','Text');
	self.mImgSex = self:FindComponent('Middle/Sex','Image');
	local goPlayer = self:Find("Left/Player").gameObject;
	self.mPLayer = mCommonPlayerHeadView.LuaNew(goPlayer);

	local deleteCallBack = function() self:OnClickBtn(); end;
	local btn = self:Find('Right/Delete').gameObject;
	self:AddBtnClickListener(btn, deleteCallBack);

	self:FindAndAddClickListener("Back",function()self:OnSelectItem();end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end


function FriendBlacklistItem:OnClickBtn( )
	local detail = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_OPEN_BLACKLIST_DELETE_POPUP,detail);
end

function FriendBlacklistItem:OnSelectItem()
	self:SetSelected(true);
end

function FriendBlacklistItem:OnSelected(select)
	if select then
		local mEvent = self.mEventEnum;
		local data = self.mData;
		self:Dispatch(mEvent.ON_SELECT_FRIEND_BLACKLIST,data);
	end
end

function FriendBlacklistItem:OnViewShow(param)
	local  data = self.mData;
	self.mTextName.text = data.name;

	if data.online == 1 then
		self.mTextTime.gameObject:SetActive(false);
	else
		self.mTextTime.gameObject:SetActive(true);
		if self.mTimerInterval ~= nil then
			self.mTimerInterval:Stop();
		end
		self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	end
	
	local sex = self.mSex;
	if sex ~= data.sex then
		self.mSex = data.sex;
		if data.sex == 1 then
			self.mGameObjectUtil:SetImageSprite(self.mImgSex,"common_icon_sex1");
		else
			self.mGameObjectUtil:SetImageSprite(self.mImgSex,"common_icon_sex2");
		end
	end
	
	self.mPLayer:SetInfo(data.sex,data.position,data.level);
end

function FriendBlacklistItem:OnTimerInterval()
	local data = self.mData;
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local second = currentTime - data.last_online_time;
	if second >= 86400 then
		self.mTextTime.text = mTimeUtil:TransToDay(second)..mLgQian;
	elseif second >= 3600 then
		self.mTextTime.text = mTimeUtil:TransToHour(second)..mLgQian;
	else
		self.mTextTime.text = mTimeUtil:TransToMin(second)..mLgQian;
	end
end

function FriendBlacklistItem:OnViewHide()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return FriendBlacklistItem;