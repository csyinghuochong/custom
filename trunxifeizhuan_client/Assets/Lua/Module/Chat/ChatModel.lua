local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mTable = table;
local mEventDispatcher = require "Events/EventDispatcher"
local mSortTable = require "Common/SortTable"
local mChatVO = require "Module/Chat/ChatVO"
local mChatPrivateVO = require "Module/Chat/ChatPrivateVO"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysbroadcast = require "ConfigFiles/ConfigSysbroadcast"
local mConfigSysmansion_feast = require "ConfigFiles/ConfigSysmansion_feast"
local mString = require "string"
local mRollLightView = require "Module/Chat/RollLightView"
local mTimeUtil = require "Utils/TimeUtil"
local ChatModel = mLuaClass("ChatModel",mBaseModel);

local mipairs = ipairs;
local mpairs = pairs;
local mtonumber = tonumber;
local munpack = unpack;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgSystem = mLanguageUtil.chat_system;

local mGlobalUtil = require "Utils/GlobalUtil"
local mColorTable = mGlobalUtil.Colors;

local EQUIP = "$e";
local TIME = "$t";
local FEAST = "$f";
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"

local WORLD = 1;
local SYSTEM = 2;
local FAMILY = 3;
local TEAM = 4;
local PRIVATE = 5;
local ROLL = 6;
local MAIN_SYSTEM = 7;
function ChatModel:OnLuaNew()
	local sortTemp = function(a,b)return self:SortTime(a,b) end
	self.mWorldDataSoure = mSortTable.LuaNew(sortTemp,nil,true);
	self.mWorldDataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_CONTACT_PERSON_LIMIT],true);
	self.mSystemDataSoure = mSortTable.LuaNew(sortTemp,nil,true);
	self.mSystemDataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_CONTACT_PERSON_LIMIT],true);
	self.mFamilyDataSoure = mSortTable.LuaNew(sortTemp,nil,true);
	self.mFamilyDataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_CONTACT_PERSON_LIMIT],true);
	self.mTeamDataSoure = mSortTable.LuaNew(sortTemp,nil,true);
	self.mTeamDataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_CONTACT_PERSON_LIMIT],true);
	self.mPrivateDataSoure = mSortTable.LuaNew(sortTemp,nil,true);
	self.mPrivatePlayerDataSoure = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true);
	self.mMainSystemDataSoure = mSortTable.LuaNew(function(a,b)return self:SortRoll(a,b)end,nil,true);
	self.mMainSystemDataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_MAIN_SYSTEM_NUM],true);
	self.mMainSystemHeight = 0;
	self.mIsEverGetPlayer = false;

	self.mSelectData = nil;
	self.mChannel = 0;
	self.mFlags = {false,false,false,false,false};

	self.mRollDataSoure = mSortTable.LuaNew(function(a,b)return self:SortRoll(a,b) end,nil,true);
	self.mRollID = 1;
	self.mChatID = 0;
	self.mMainSystemID = 1;
	self.mIsOpenByBattle = false;
end

function ChatModel:SortMainSystem(a,b)
	return a.id < b.id;
end

function ChatModel:SortRoll(a,b)
	return a.create_time < b.create_time;
end

function ChatModel:SortTime(a,b)
	if a.create_time == b.create_time then
		if a.player_id ~= nil and b.player_id ~= nil then
			return a.player_id < b.player_id;
		else
			return a.mSysID < b.mSysID;
		end
	else
		return a.create_time < b.create_time;
	end
end

function ChatModel:Sort(a,b)
	if a.time == b.time then
		return a.count > b.count;
	else
		return a.time > b.time;
	end
end

function ChatModel:OnRecvChat(pbReturnChat)
	local chat = pbReturnChat;
	if chat ~= nil then
		if chat.channel == ROLL then
			self:PushRoll(chat);
		else
			self:PushChat(chat);
		end
		self.mChatID = self.mChatID + 1;
	end
end

function ChatModel:OnRecvChatContactPerson(pbContactPersons)
	local persons = pbContactPersons.list;
	if persons ~= nil then
		self.mIsEverGetPlayer = true;
		local data_soure = self.mPrivatePlayerDataSoure;
		for k,v in mipairs(persons) do
			local personData = mChatPrivateVO.LuaNew(v);
			data_soure:AddOrUpdate(personData.base.player_id,personData);
		end
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_CHAT_PLAYER);
	end
end

function ChatModel:OnRecvChatPersonPrivate(pbReturnChats)
	local chats = pbReturnChats.list;
	local id = pbReturnChats.target_id;
	if chats ~= nil then
		local rawTable = self.mPrivatePlayerDataSoure.mRawTable;
		local privateData = rawTable[id];
		privateData.isEverGetTable = true;
		privateData:CreateSoure(chats);
		self.mPrivateDataSoure = privateData.dataSoure;
		self.mPrivatePlayerDataSoure:AddOrUpdate(privateData.base.player_id,privateData);
		self:SendToRefreshPrivateChat();
	end
end

function ChatModel:OnRecvUpdatePerson(pbContactPerson)
	if not self.mIsEverGetPlayer then
		return;
	end
	local person = pbContactPerson;
	if person ~= nil then
		local personVO = self:FindPrivate(person.base.player_id,person.target_id);
		if personVO ~= nil then
			personVO.is_online = person.is_online;
			self.mPrivatePlayerDataSoure:AddOrUpdate(personVO.base.player_id,personVO);
		end
	end
end

function ChatModel:OnRecvNotice(pbBroadcastNotice)
	if pbBroadcastNotice ~= nil then
		local channelTable = mConfigSysbroadcast[pbBroadcastNotice.id].channel;
		local isUp = mConfigSysbroadcast[pbBroadcastNotice.id].isUp;
		for k,v in mipairs(channelTable) do
			self:SendNotice(v,pbBroadcastNotice,isUp);
		end
	end
end

function ChatModel:SendNotice(channelData,chatData,isUp)
	local chatValue = self:GetStringForNotice(chatData);
	local noticeMsg = mString.format(mConfigSysbroadcast[chatData.id].msg,munpack(chatValue));
	local chat = {player_name = mLgSystem,msg = noticeMsg,channel = channelData,create_time = mGameModelManager.LoginModel:GetCurrentTime(),
				value = chatData.value,equips = chatData.equips,time = chatData.time,feast_id = chatData.feast_id};
	self:OnRecvChat(chat);
	if isUp == 1 then
		self:PushMainSystem(chat);
	end
end

function ChatModel:GetCreatedString(str,data)
	local chatValue = self:GetStringForNotice(data);
	return mString.format(str,munpack(chatValue));
end

function ChatModel:GetStringForNotice(chatData)
	local strTable = {};
	local equipIndex = 1;
	local timeIndex = 1;
	for k,v in mipairs(chatData.value) do
		local typeStr = mString.sub(v,1,2);
		if typeStr == EQUIP then
			local equip = chatData.equips[equipIndex];
			if equip ~= nil then
				local strEquip = mString.format(mColorTable[equip.color],mConfigSysgoods[equip.good_id].goods_name);
				mTable.insert(strTable,strEquip);
			else
				mTable.insert(strTable,v);
			end
			equipIndex = equipIndex + 1;
		elseif typeStr == TIME then
			local time = chatData.time[timeIndex];
			local timeStr =  mTimeUtil:TransToYearMonthDayHMS(time);
			mTable.insert(strTable,timeStr);
			timeIndex = timeIndex + 1;
		elseif typeStr == FEAST then
			local feast = chatData.feast_id;
			local feastStr = mConfigSysmansion_feast[feast].name;
			mTable.insert(strTable,feastStr);
		else
			mTable.insert(strTable,v);
		end
	end
	return strTable;
end

function ChatModel:GetPlayerInList(player_id)
	local rawTable = self.mPrivatePlayerDataSoure.mRawTable;
	return rawTable[player_id];
end

function ChatModel:PushChat(chat)
	if chat ~= nil then
		local data = nil;
		if chat.channel == WORLD or chat.channel == FAMILY or chat.channel == TEAM then
			self:CreateChatData(chat);
		elseif chat.channel == SYSTEM then
			local data = mChatVO.LuaNew(chat);
			data.mSysID = self.mChatID;
			self.mSystemDataSoure:AddOrUpdate(self.mChatID,data);
			mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_SYSTEM_CHAT,data);
		elseif chat.channel == PRIVATE then
			self:CreatePrivateChat(chat);
		end
		self:RefreshFlag(chat);
	end
end

--红点更新
function ChatModel:RefreshFlag(chat)
	if chat.channel == self.mChannel then
		return;
	end
	self.mFlags[chat.channel] = true;
	mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_CHAT_FLAG,chat.channel);
end

--收到世界，组队，工会消息时的处理
function ChatModel:CreateChatData(chat)
	local data = nil;
	local data = mChatVO.LuaNew(chat);
	if chat.channel == WORLD then
		self.mWorldDataSoure:AddOrUpdate(self.mChatID,data);
		mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_WORLD_CHAT,data);
	end
	if chat.channel == FAMILY then 
		self.mFamilyDataSoure:AddOrUpdate(self.mChatID,data);
		mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_FAMILY_CHAT,data);
	end
	if chat.channel == TEAM then 
		self.mTeamDataSoure:AddOrUpdate(self.mChatID,data);
		mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_TEAM_CHAT,data);
	end
end

--收到私聊消息时的处理（未打开过私聊界面，已打开过界面并且私聊列表中（存在/不存在）该对象）
function ChatModel:CreatePrivateChat(chat)
	local data_soure = self.mPrivatePlayerDataSoure;
	if self.mIsEverGetPlayer then
		local data = self:FindPrivate(chat.player_id,chat.target_id);
		if data ~= nil then
			data.time = chat.create_time;
			local selectData = self.mSelectData;
			if selectData ~= nil and (selectData.base.player_id == chat.player_id or selectData.base.player_id == chat.target_id) then
				data.count = 0;
			else
				data.count = data.count + 1;
			end
			data.isReal = true;
			data:AddChat(chat);
			data_soure:AddOrUpdate(data.base.player_id,data);
			self:SendToRefreshPrivateChat();
		else
			local Base = {player_id = chat.player_id,name = chat.player_name,sex = chat.sex,level = chat.level};
			local privateData = {base = Base,is_online = 1,time = chat.create_time,count = 1};
			local privateVO = mChatPrivateVO.LuaNew(privateData);
			privateVO:AddChat(chat);
			data_soure:AddOrUpdate(privateVO.base.player_id,privateVO);
		end
	end
end

--查找该玩家是否已存在私聊列表中
function ChatModel:FindPrivate(player_id,target_id)
	local rawTable = self.mPrivatePlayerDataSoure.mRawTable;
	for k,v in mpairs(rawTable) do
		if v.base.player_id == player_id or v.base.player_id == target_id then
			return v;
		end
	end
	return nil;
end

function ChatModel:SendToRefreshPrivateChat()
	mEventDispatcher:Dispatch(mEventEnum.ON_REFRESH_PRIVATE_CHAT);
end

--修改选中的私聊对象
function ChatModel:ChangeSelect(data)
	self.mSelectData = data;
	self.mPrivateDataSoure = data.dataSoure;
	if data.isReal then
		if data.isEverGetTable then
			self:SendToRefreshPrivateChat();
		else
			mEventDispatcher:Dispatch(mEventEnum.ON_GET_PLAYER_PRIVATE,data.base.player_id);
		end
	else
		self:SendToRefreshPrivateChat();
	end
end

--检测是否存在临时聊天对象，有的话删除
function ChatModel:CheckDelete()
	local data_soure = self.mPrivatePlayerDataSoure;
	if self.mIsEverGetPlayer then
		local rawTable = data_soure.mRawTable;
		for k,v in mpairs(rawTable) do
			if not v.isReal then
				data_soure:RemoveKey(v.player_id);
			end
		end
	end
end

--与玩家私聊，判断是否打开过私聊界面，再判断该玩家是否存在于私聊玩家列表中
function ChatModel:ChatToPlayer(data)
	if self.mIsEverGetPlayer then
		local privateData = self:FindPrivate(data.player_id,data.target_id);
		if privateData ~= nil then
			mEventDispatcher:Dispatch(mEventEnum.ON_CHANGE_PRIVATE_LIST_SELECT,privateData);
		else
			self:PushNotRealPlayer(data);
		end
	else
		self:PushNotRealPlayer(data);
	end
end

--在私聊成员列表查询不到该玩家，前端生成一个临时成员（关闭私聊界面时会自动删除该成员）
function ChatModel:PushNotRealPlayer(data)
	local Base = {player_id = data.player_id,name = data.player_name,sex = data.sex,level = data.level,position = data.position};
	local privateData = {base = Base,is_online = 1,time = mGameModelManager.LoginModel:GetCurrentTime(),count = 0};
	local privateVO = mChatPrivateVO.LuaNew(privateData);
	privateVO.isReal = false;
	privateVO.isEverGetTable = false;
	self.mPrivatePlayerDataSoure:AddOrUpdate(privateVO.base.player_id,privateVO);
	self.mPrivateDataSoure = privateVO.dataSoure;
	mEventDispatcher:Dispatch(mEventEnum.ON_CHANGE_PRIVATE_LIST_SELECT_NOTREAL,privateVO);
end

--收到跑马灯消息
function ChatModel:PushRoll(chat)
	local data_soure = self.mRollDataSoure;
	local chatVO = mChatVO.LuaNew(chat);
	chatVO.id = self.mRollID;
	data_soure:AddOrUpdate(chatVO.id,chatVO);
	mRollLightView.Show(chatVO);
	self.mRollID = self.mRollID + 1;
end

function ChatModel:PushMainSystem(chat)
	local data_soure = self.mMainSystemDataSoure;
	--local chatVO = mChatVO.LuaNew(chat);
	chat.id = self.mMainSystemID;
	data_soure:AddOrUpdate(chat.id,chat);
	self.mMainSystemID = self.mMainSystemID + 1;
	mEventDispatcher:Dispatch(mEventEnum.ON_CHAT_MAIN_SYSTEM_ADD);
end

return ChatModel;