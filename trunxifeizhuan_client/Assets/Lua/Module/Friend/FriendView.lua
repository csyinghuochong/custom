local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mFriendInfoView = require "Module/Friend/FriendInfoView"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mCheckController = require "Module/Check/CheckController"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mCommonEmptyView = require "Module/CommonUI/CommonEmptyView"
local FriendView = mLuaClass("FriendView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgTable = {mLanguageUtil.friend_empty,mLanguageUtil.friend_empty_blacklist};

function FriendView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
	};
end

function FriendView:Init()
	self.mModelShowViewPlayer = mModelShowView.LuaNew(self:Find('Right/model'),true);
	self.mTextName = self:FindComponent("Right/name","Text");
	self.mGoRight = self:Find("Right").gameObject;
	self.mGoFlower = self:Find("Flower").gameObject;
	self.mObjTab = self:Find('tabView');
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("Right/Btn",function() self:OnCheckPlayer(); end);
	self:InitData();
	self:InitSubView();
	self:CreateFlag();
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_FRIEND_CHANGE_FLAG,function(index)self:OnChangeFlag(index);end, false);
	self:RegisterEventListener(mEvent.ON_SELECT_FRIEND,function(data)self:OnSelectFriend(data);end,true);
	self:RegisterEventListener(mEvent.ON_SET_FRIEND_EMPTY,function(data)self:OnSetEmpty(data);end,true);
	self:RegisterEventListener(mEvent.ON_SET_PLAYER_MODEL_STATE,function(state)self:OnSetPlayerState(state);end,true);
end

function FriendView:OnSetEmpty(data)
	self.mGoRight:SetActive(data.state);
	self.mGoFlower:SetActive(data.state);
	local commonEmptyView = self.mCommonEmptyView;
	if commonEmptyView == nil then
		commonEmptyView = mCommonEmptyView.LuaNew();
		commonEmptyView:SetExternalParams(self.mTransform);
		self.mCommonEmptyView = commonEmptyView;
	end

	if not data.state then
		local strEmpty = string.gsub(mLgTable[data.strIndex],"\\n","\n");
		local Data = {str = strEmpty};
		self.mCommonEmptyView:ForceShowView(Data);
	else
		self.mCommonEmptyView:HideView();
	end
end

function FriendView:OnSetPlayerState(state)
	self.mGoRight:SetActive(state);
end

function FriendView:OnSelectFriend(data)
	local model = mGameModelManager.FriendModel;
	self.mModelShowViewPlayer:OnUpdateLead(data.sex );
	self.mTextName.text = data.name;
	local active = self.mGoRight.activeSelf;
	if not active then
		self.mGoRight:SetActive(true);
	end
end

function FriendView:OnCheckPlayer()
	local selectData = self:GetSelectData();
	if selectData ~= nil then
		mCheckController:SendGetOtherPlayer(selectData.id);
	end
end

function FriendView:GetSelectData()
	local model = mGameModelManager.FriendModel;
	return model.mDataTable[model.mNowPage];
end

function FriendView:CreateFlag()
	local model = mGameModelManager.FriendModel;
	local flagTable = model.mFlags;
	for k,v in ipairs(flagTable) do
		self:OnSetFlag(k,v);
	end
end

function FriendView:InitData()
	self.mFriendModel = mGameModelManager.FriendModel;
end

function FriendView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Friend/FriendInfoView"},
		{luaClass="Module/Friend/FriendAddView"},
		{luaClass="Module/Friend/FriendBlacklistView"},	
	}

	local getDataBack = function()
		return self.mFriendModel;
	end

	local callBack = function(index)
		self:ChangeToggle(index);
	end

	self.mTabView = mCommonTabView.LuaNew(self.mObjTab, view_vo_list, callBack, getDataBack);
	self.mTabView:OnClickToggleButton(1, true);
end

function FriendView:ChangeToggle(index)
	local model = mGameModelManager.FriendModel;
	model.mNowPage = index;
	model.mFlags[index] = false;
	self:OnSetFlag(index,false);
	self:OnSetEmptyForToggle(index);
end

function FriendView:OnSetEmptyForToggle(index)
	if index == 2 then
		local data = {state = true};
		self:OnSetEmpty(data);
	end
	local selectData = self:GetSelectData();
	self:OnSetPlayerState(selectData ~= nil);
	if selectData ~= nil then
		self:OnSelectFriend(selectData);
	end
end

function FriendView:OnChangeFlag(index)
	local model = mGameModelManager.FriendModel;
	local state = model.mFlags[index];
	self:OnSetFlag(index,state);
end

function FriendView:OnSetFlag(index,state)
	self.mTabView:SetRedPointForIndex(index,state);
end

function FriendView:OnViewShow(data)
	self.mModelShowViewPlayer:ShowView();
	local mEvent = self.mEventEnum;
	self:Dispatch(self.mEventEnum.ON_CALL_CHANGE_FRIENDLIST_STATE,false);
	self:Dispatch(self.mEventEnum.ON_RESET_ADD_TIPS);
	self:CheckIsEmpty();
	local selectData = self:GetSelectData();
	if selectData ~= nil then
		self.mModelShowViewPlayer:ShowView();
	else
		self.mTextName.text = "";
		self.mGoRight:SetActive(false);
	end
end

function FriendView:CheckIsEmpty()
	local model = mGameModelManager.FriendModel;
	local nowPage = model.mNowPage;
	if nowPage == 1 then
		self:CheckDataSoure(model.mDataSoureInfo,1);
	elseif nowPage == 3 then
		self:CheckDataSoure(model.mDataSoureBlackList,2);
	end
end

function FriendView:CheckDataSoure(data_soure,index)
	if data_soure ~= nil then
		local num = #data_soure.mSortTable;
		local data = {};
		if num > 0 then
			data = {state = true};
			self:OnSetEmpty(data);
		else
			data = {state = false,strIndex = index};
			self:OnSetEmpty(data);
		end
	end
end

function FriendView:Dispose()
	self.mTabView:CloseView();
	self.mModelShowViewPlayer:Dispose();
end

function FriendView:OnViewHide()
	self.mModelShowViewPlayer:HideView();
	self.mCommonEmptyView:HideView();
end

return FriendView;