local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mGameModelManager = require "Manager/GameModelManager"
local mColor = Color
local mTimeUtil = require "Utils/TimeUtil"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendItem = mLuaClass("FriendItem",mLayoutItem);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgPower = mLanguageUtil.friend_info_power;
local mLgLevel = mLanguageUtil.friend_info_level;
local mLgQian = mLanguageUtil.qian;

local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"

function FriendItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_item_view",
	};
end

function FriendItem:Init( )
	self.mTextName = self:FindComponent('Middle/Name','Text');
	self.mTextTime = self:FindComponent('Middle/Time','Text');
	self.mImgSex = self:FindComponent('Middle/Sex','Image');
	local goPlayer = self:Find("Left/Player").gameObject;
	self.mPLayer = mCommonPlayerHeadView.LuaNew(goPlayer);
	
	self.mImgGet = self:FindComponent('Right/Get/Back','Image');
	self.mImgSend = self:FindComponent('Right/Give/Back','Image');

	local leftCallBack = function() self:OnClickLeft(); end;
	self.btn_get = self:Find('Right/Get').gameObject;
	self:AddBtnClickListener(self.btn_get, leftCallBack);

	local rightCallBack = function() self:OnClickRight(); end;
	self.btn_give = self:Find('Right/Give').gameObject;
	self:AddBtnClickListener(self.btn_give, rightCallBack);

	local deleteCallBack = function() self:OnClickDelete(); end;
	self.btn_delete = self:Find('Right/Delete').gameObject;
	self:AddBtnClickListener(self.btn_delete, deleteCallBack);

	local chatCallBack = function() self:OnClickChat(); end;
	self.btn_chat = self:Find('Right/Chat').gameObject;
	self:AddBtnClickListener(self.btn_chat, chatCallBack);

	self:FindAndAddClickListener("Back",function()self:OnSelectItem()end);
	self:FindAndAddClickListener("Right/Chat",function()self:OnClickChat()end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_CHANGE_FRIENDLIST_STATE,function(state)self:OnChangeBtnState(state);end,true);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendItem:OnClickChat()
	local model = mGameModelManager.ChatModel;
	local data = self.mData;
	local selfID = mGameModelManager.RoleModel.mPlayerBase.player_id;
	local playerData = {player_id = data.id,target_id = selfID,player_name = data.name,sex = data.sex,position = data.position,level = data.level};
	local Data = {param=playerData,isChatToFriend = true};
	model.mIsOpenByBattle = false;
	mUIManager:HandleUIWithParent(mMainLayer,mViewEnum.ChatView,1,Data);
end

function FriendItem:OnSelectItem()
	self:SetSelected(true);
end

function FriendItem:OnSelected(select)
	if select then
		local mEvent = self.mEventEnum;
		local data = self.mData;
		self:Dispatch(mEvent.ON_SELECT_FRIEND,data);
	end
end

function FriendItem:OnChangeBtnState(state)
	local data = self.mData;
	self.btn_get:SetActive(data.receive_flag ~= 0);
	self.btn_give:SetActive(data.send_flag == 0);
	
	self.btn_delete:SetActive(state);
	self.btn_get:SetActive(not state);
	self.btn_give:SetActive(not state);
	self.btn_chat:SetActive(not state);
end

function FriendItem:OnClickLeft( )
	local enegyData = self.mData;
	local mEvent = self.mEventEnum;
	if enegyData.receive_flag == 1 then
		self:Dispatch(mEvent.ON_GET_ENERGY,enegyData);
	end
end

function FriendItem:OnClickRight( )
	local enegyData = self.mData;
	local mEvent = self.mEventEnum;
	if enegyData.send_flag == 0 then
		self:Dispatch(mEvent.ON_GIVE_ENERGY,enegyData);
	end
end

function FriendItem:OnClickDelete( )
	local deleteData = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_OPEN_FRIEND_DELETE_POPUP,deleteData);
end

function FriendItem:OnViewShow(param)
	self:OnUpdateData();
end

function FriendItem:OnUpdateData()
	local data = self.mData;
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

	self.btn_delete:SetActive(data.isDelete);
	self.btn_get:SetActive(not data.isDelete);
	self.btn_give:SetActive(not data.isDelete);
	self.btn_chat:SetActive(not data.isDelete);

	self.btn_get:SetActive(data.receive_flag ~= 0);
	self.btn_give:SetActive(data.send_flag == 0);
end

function FriendItem:OnTimerInterval()
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

function FriendItem:OnViewHide()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return FriendItem;