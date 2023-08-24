local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mFriendVO = require "Module/Friend/FriendVO"
local mOtherPlayerVO = require "Module/Friend/OtherPlayerVO"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mSortTable = require "Common/SortTable"
local mTable = table;
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mFollowerVO = require "Module/Follower/FollowerVO"
local FriendModel = mLuaClass("FriendModel",mBaseModel);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgAddFriendSucceed = mLanguageUtil.friend_add_succeed;
local mLgGetEnergySucceed = mLanguageUtil.friend_info_get_succeed;
local mLgSendEnergySucceed = mLanguageUtil.friend_info_send_succeed;

local FRIEND = 1;
local ADD = 2;
local BLACKLIST = 3;

function FriendModel:OnLuaNew()
	self.mFriendData = nil;
	self.mDataTable = {};
	self.mDataSoureInfo = nil;
	self.mDataSoureSearch = nil;
	self.mDataSoureRequest = nil;
	self.mDataSoureRecommend = nil;
	self.mDataSoureBlackList = nil;
	self.mDataSoureEnemy = nil;

	self.mIsEverGetInfo = false;
	self.mIsEverGetRequest = false;
	self.mIsEverGetRecommend = false;
	self.mIsEverGetBlackList = false;
	self.mIsEverGetEnemy = false;

	self.mNowPage = 0;
	self.mFlags = {false,false,false};
end

function FriendModel:Sort(a,b)
	return a.id < b.id;
end

function FriendModel:OnRecvFriendList(pbFriendList)
	self.mFlags[FRIEND] = true;
	self:ChangeFlag(FRIEND);
	if not self.mIsEverGetInfo then
		return;
	end
	local friendList = pbFriendList.friend_list;
	if friendList ~= nil then
		local data_soure;
		if self.mDataSoureInfo ~= nil then 
			data_soure = self.mDataSoureInfo;
		else
			data_soure = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true);
		end
		for k,v in ipairs(friendList) do
			if v.id ~= nil then
				local friendData = mFriendVO.LuaNew(v,0);
				data_soure:AddOrUpdate(friendData.id,friendData);
			end
		end
		self.mDataSoureInfo = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_FRIEND_LIST);
	end
end

function FriendModel:OnRecvGetEnergy(pbResult)
	if self.mDataSoureInfo == nil or self.mFriendData == nil then
		return;
	end
	mCommonTipsView.Show(mLgGetEnergySucceed);
	local data_soure = self.mDataSoureInfo;
	self.mFriendData.receive_flag = 0;
	data_soure:AddOrUpdate(self.mFriendData.id,self.mFriendData);
end

function FriendModel:OnRecvSendEnergy(pbResult)
	if self.mDataSoureInfo == nil or self.mFriendData == nil then
		return;
	end
	mCommonTipsView.Show(mLgSendEnergySucceed);
	local data_soure = self.mDataSoureInfo;
	self.mFriendData.send_flag = 1;
	data_soure:AddOrUpdate(self.mFriendData.id,self.mFriendData);
end

function FriendModel:OnRecvFriendDelete(pbResult)
	local data_soure = self.mDataSoureInfo;
	if data_soure ~= nil then
		local id = pbResult.result;
		data_soure:RemoveKey(id);
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_DELETE_FRIEND);
	end
end

function FriendModel:OnRecvSearchList(pbFriendList)
	local searchList = pbFriendList.friend_list;
	if searchList ~= nil then
		local data_soure = mSortTable.LuaNew(nil,nil,true);
		for k,v in ipairs(searchList) do
			if v.id ~= nil then
				local searchData = mFriendVO.LuaNew(v,1);
				data_soure:AddOrUpdate(searchData.id,searchData);
			end
		end
		self.mDataSoureSearch = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_SEARCH_LIST);
	end
end

function FriendModel:OnRecvAddFriend(pbResult)
	local data = self.mFriendData;
	if data ~= nil then
		if data.type == 1 then
			local data_soure = self.mDataSoureSearch;
			if data_soure ~= nil then
				data_soure:RemoveKey(self.mFriendData.id);
				mCommonTipsView.Show(mLgAddFriendSucceed);
				mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_ADD_FRIEND,pbResult);
			end
		elseif data.type == 3 then
			local data_soure = self.mDataSoureRecommend;
			if data_soure ~= nil then
				data_soure:RemoveKey(self.mFriendData.id);
				mCommonTipsView.Show(mLgAddFriendSucceed);
				mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_ADD_FRIEND,pbResult);
			end
		end
	end
end

function FriendModel:OnRecvRequestList(pbFriendList)
	if #pbFriendList.friend_list > 0 then
		if self.mDataSoureRequest ~= nil then
			local sortTable = self.mDataSoureRequest.mSortTable;
			if #pbFriendList.friend_list > #sortTable then
				self.mFlags[ADD] = true;
			end
		else
			self.mFlags[ADD] = true;
		end
	else
		self.mFlags[ADD] = false;
	end
	self:ChangeFlag(ADD);
	if not self.mIsEverGetRequest then
		return;
	end
	local requestList = pbFriendList.friend_list;
	if requestList ~= nil then
		local data_soure;
		if self.mDataSoureRequest ~= nil then
			data_soure = self.mDataSoureRequest;
		else
			data_soure = mSortTable.LuaNew(nil,nil,true);
		end
		data_soure:ClearDatas(true);
		for k,v in ipairs(requestList) do
			if v.id ~= nil then
				local requestData = mFriendVO.LuaNew(v,2);
				data_soure:AddOrUpdate(requestData.id,requestData);
			end
		end
		self.mDataSoureRequest = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_REQUEST_LIST);
	end
end

function FriendModel:OnRecvRequestHandle(pbResult)
	local data_soure = self.mDataSoureRequest;
	data_soure:RemoveKey(self.mFriendData.id);
	mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_ADD_FRIEND,pbResult);
end

function FriendModel:OnRecvBlackList(pbFriendList)
	self.mFlags[BLACKLIST] = true;
	self:ChangeFlag(BLACKLIST);
	if not self.mIsEverGetBlackList then
		return;
	end
	local blackList = pbFriendList.friend_list;
	if blackList ~= nil then
		local data_soure;
		if self.mDataSoureBlackList ~= nil then
			data_soure = self.mDataSoureBlackList;
		else
			data_soure = mSortTable.LuaNew(nil,nil,true);
		end
		for k,v in ipairs(blackList) do
			if v.id ~= nil then
				local blackListData = mFriendVO.LuaNew(v,0);
				data_soure:AddOrUpdate(blackListData.id,blackListData);
			end
		end
		self.mDataSoureBlackList =data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_BLACKLIST);
	end
end

function FriendModel:OnRecvBlackListDelete(pbResult)
	local data_soure = self.mDataSoureBlackList;
	data_soure:RemoveKey(self.mFriendData.id);
	mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_DELETE_BLACKLIST,pbResult);
end

function FriendModel:OnRecvEnemyList(pbFriendList)
	self.mFlags[ENEMY] = true;
	self:ChangeFlag(ENEMY);
	if not self.mIsEverGetEnemy then
		return;
	end
	local enemyList = pbFriendList.friend_list;
	if enemyList ~= nil then
		local data_soure;
		if self.mDataSoureEnemy ~= nil then
			data_soure = self.mDataSoureEnemy;
		else
			data_soure = mSortTable.LuaNew(nil,nil,true);
		end
		for k,v in ipairs(enemyList) do
			if v.id ~= nil then
				local enemyData = mFriendVO.LuaNew(v,0);
				data_soure:AddOrUpdate(enemyData.id,enemyData);
			end
		end
		self.mDataSoureEnemy = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_ENEMYLIST);
	end
end

function FriendModel:OnRecvEnemyListDelete(pbResult)
	local data_soure = self.mDataSoureEnemy;
	data_soure:RemoveKey(self.mFriendData.id);
end

function FriendModel:OnRecvRecommendList(pbFriendList)
	if not self.mIsEverGetRecommend then
		return;
	end
	local recommendList = pbFriendList.friend_list;
	if recommendList ~= nil then
		local data_soure;
		if self.mDataSoureRecommend ~= nil then
			data_soure = self.mDataSoureRecommend;
			data_soure:ClearDatas(true);
		else
			data_soure = mSortTable.LuaNew(nil,nil,true);
		end
		for k,v in ipairs(recommendList) do
			if v.id ~= nil then
				local recommendData = mFriendVO.LuaNew(v,3);
				data_soure:AddOrUpdate(recommendData.id,recommendData);
			end
		end
		self.mDataSoureRecommend = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_RECIVE_RECOMMEND_LIST);
	end
end

function FriendModel:ChangeFlag(index)
	if index == self.mNowPage or self.mNowPage == 0 then
		return;
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_FRIEND_CHANGE_FLAG,index);
end

return FriendModel;