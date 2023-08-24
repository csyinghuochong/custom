local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mEventEnum = require "Enum/EventEnum"
local mVector3 = Vector3;
local mGameModelManager = require "Manager/GameModelManager"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local CampDungeonBossItemView = mLuaClass("CampDungeonBossItemView", mLayoutItem);
local mSuper = nil;
local mCampDungeonIcon = mResourceUrl.camp_dungeon_icon;

function CampDungeonBossItemView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_boss_item",
	};
end

function CampDungeonBossItemView:Init()
	self.mTransName = self:Find("Name");
	self.mNameStr = self.mTransName:GetComponent('Text');
	self.mTimeStr = self:Find("time"):GetComponent('Text');
    local callBack = function() self:OnClickItem() end;
    self:FindAndAddClickListener("bg", callBack,"ty_0204");
    self.mImgIcon = self:FindComponent("icon","RawImage");
	self.mImgIcon.color = Color.clear;
    self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CampDungeonBossItemView:OnClickItem()
	self:SetSelected(true);
end

function  CampDungeonBossItemView:OnSelected(select)
	if select then
       self:Dispatch(mEventEnum.ON_SELECT_CAMPBOSS_ITEM,self.mData);
	end
end

function CampDungeonBossItemView:OnViewShow(logicParam)
	local data = self.mData;
	if data == nil then
		return;
	end
	local config = data.mSysVO;
	self.mNameStr.text = config.chapter_name;
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
    if data.mTime ~= nil and data.mTime - currentTime > 0 then
        self:OnTimerInterval();
        local timerInterval = self.mTimerInterval;
	    if timerInterval == nil then
	       self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	    end
	    self:SetTextPos(true);
	else
		self:SetTextPos(false);
    end
    mUITextureManager.LoadTexture(mCampDungeonIcon, config.map,self.mLoadedIcon);
end

function CampDungeonBossItemView:SetTextPos(state)
	self.mTimeStr.gameObject:SetActive(state);
	if state then
		self.mTransName.localPosition = mVector3(70,8,0);
	else
		self.mTransName.localPosition = mVector3(70,0,0);
	end
end

function CampDungeonBossItemView:OnTimerInterval()
    local time = self.mData.mTime - mGameModelManager.LoginModel:GetCurrentTime();
    if time > 60*60*24 then
       self.mTimeStr.text = mTimeUtil:TransToDayHour(time);
    else
       self.mTimeStr.text = mTimeUtil:TransToHourMinSec(time);
    end
    if time <= 0 and self.mTimerInterval ~= nil then
    	self:SetTextPos(false);
        self:OnViewHide();
    end
end

function CampDungeonBossItemView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function CampDungeonBossItemView:OnViewHide()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return CampDungeonBossItemView;