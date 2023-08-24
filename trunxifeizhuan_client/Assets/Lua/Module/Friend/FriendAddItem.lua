local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mTimeUtil = require "Utils/TimeUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mColor = Color
local mVector3 = Vector3
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mFriendController = require "Module/Friend/FriendController"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendAddItem = mLuaClass("FriendAddItem",mLayoutItem);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgPower = mLanguageUtil.friend_info_power;
local mLgLevel = mLanguageUtil.friend_info_level;
local mLgQian = mLanguageUtil.qian;

local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"

function FriendAddItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_add_item_view",
	};
end

function FriendAddItem:Init( )
	self.mTextName = self:FindComponent('Middle/Name','Text');
	self.mTextTime = self:FindComponent('Middle/Time','Text');
	self.mImgSex = self:FindComponent('Middle/Sex','Image');
	local goPlayer = self:Find("Left/Player").gameObject;
	self.mPLayer = mCommonPlayerHeadView.LuaNew(goPlayer);

	self.mImgAddBack = self:FindComponent('Right/Add/Back',"Image");

	self.mBtnAdd = self:FindComponent('Right/Add','Button');

	local deleteCallBack = function() self:OnClickBtnDelete(); end
	self.btnDelete = self:Find('Right/Delete').gameObject;
	self:AddBtnClickListener(self.btnDelete, deleteCallBack);

	local addCallBack = function() self:OnClickBtnAdd(); end
	self.btnAdd = self:Find('Right/Add').gameObject;
	self:AddBtnClickListener(self.btnAdd, addCallBack);

	local okCallBack = function() self:OnClickBtnOk(); end
	self.btnOk = self:Find('Right/OK').gameObject;
	self:AddBtnClickListener(self.btnOk, okCallBack);

	self:FindAndAddClickListener("Back",function()self:OnClickItem();end);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendAddItem:OnClickItem()
	local mEvent = self.mEventEnum;
	local param = {data = self.mData,trans = self.mTransform};
	self:Dispatch(mEvent.ON_SELECT_FRIEND_ADD,param);
end

function FriendAddItem:OnClickBtnDelete( )
	local data = self.mData;
	local mEvent = self.mEventEnum;
	if data.type == 1 then
		self:Dispatch(mEvent.ON_FRIENDADD_DELETE_FIND,data);
	elseif data.type == 2 then
		self:Dispatch(mEvent.ON_FRIENDADD_DELETE_APPLY,data);
	end

end

function FriendAddItem:OnClickBtnAdd( )
	self.mImgAddBack.color = mColor.New(0.45,0.45,0.45,1);
	self.mBtnAdd.enabled = false;
	local data = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_FRIENDADD_ADD,data);
end

function FriendAddItem:OnClickBtnOk( )
	local data = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_FRIENDADD_AGREE,data);
end

function FriendAddItem:OnViewHide( )
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

function FriendAddItem:OnViewShow()
	local  data = self.mData;
	if data.online == 1 then
		self.mTextTime.gameObject:SetActive(false);
	else
		self.mTextTime.gameObject:SetActive(true);
		if self.mTimerInterval ~= nil then
			self.mTimerInterval:Stop();
		end
		-- self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
		-- self:OnTimerInterval();
	end
end

function FriendAddItem:OnUpdateData()
	local  data = self.mData;
	self.mTextName.text = data.name;
	self:OnViewShow();

	self.mPLayer:SetInfo(data.sex,data.position,data.level);

	self.btnOk:SetActive(data.type == 2);
	self.btnAdd:SetActive(data.type ~= 2);
	self.btnDelete:SetActive(data.type == 2);
	self.mImgAddBack.color = mColor.New(1,1,1,1);
	self.mBtnAdd.enabled = true;

	if data.type ~= 2 then
		self.btnAdd.transform.localPosition = mVector3(0,-9,0);
	else
		self.btnAdd.transform.localPosition = mVector3(35.5,-9,0);
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
end

function FriendAddItem:OnTimerInterval()
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

return FriendAddItem;