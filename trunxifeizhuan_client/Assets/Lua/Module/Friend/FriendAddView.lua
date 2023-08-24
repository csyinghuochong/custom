local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mFriendVO = require "Module/Friend/FriendVO"
local mVector2 = Vector2;
local mTable = require "table"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mFriendController = require "Module/Friend/FriendController"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendAddView = mLuaClass("FriendAddView",mCommonTabBaseView);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_info_delete_ok;
local mLgAgree = mLanguageUtil.friend_info_delete_agree;

local mLgDeleteApplyTitle = mLanguageUtil.friend_add_delete_apply_title;
local mLgDeleteApplyDesc1 = mLanguageUtil.friend_add_delete_apply_desc1;
local mLgDeleteApplyDesc2 = mLanguageUtil.friend_add_delete_apply_desc2;

local mLgAgreeTitle = mLanguageUtil.friend_add_agree_title;
local mLgAgreeDesc1 = mLanguageUtil.friend_add_agree_desc1;
local mLgAgreeDesc2 = mLanguageUtil.friend_add_agree_desc2;

local mLgSeverNotFound = mLanguageUtil.friend_add_server_notfound;
local mLgAllOver = mLanguageUtil.friend_add_all_over;

function FriendAddView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_add_view",
	};
end

function FriendAddView:Init()
	local parent = self:Find('ScrollRect/Grid/scrollView1/Grid');
	self.mGridExSearch = mLayoutController.LuaNew(parent, require "Module/Friend/FriendAddItem");
	local parent2 = self:Find('ScrollRect/Grid/scrollView2/Grid');
	self.mGridExRequest = mLayoutController.LuaNew(parent2, require "Module/Friend/FriendAddItem");
	local parent3 = self:Find('ScrollRect/Grid/scrollView3/Grid');
	self.mGridExRecommend = mLayoutController.LuaNew(parent3, require "Module/Friend/FriendAddItem");
	self.rectTransform = self:FindComponent('ScrollRect/Grid/scrollView1','RectTransform')
	self.rectTransform2 = self:FindComponent('ScrollRect/Grid/scrollView2','RectTransform')
	self.rectTransform3 = self:FindComponent('ScrollRect/Grid/scrollView3','RectTransform')
	self.mGoText1 = self:Find('ScrollRect/Grid/Text1').gameObject;
	self.mGoText2 = self:Find('ScrollRect/Grid/Text2').gameObject;
	self.mGoText3 = self:Find('ScrollRect/Grid/Text3').gameObject;
	self.mTransLight = self:Find("light");
	self.mTextFindNull = self:FindComponent('ScrollRect/Grid/TextFindNull','Text');
	self.mIsFinding = false;
	self.mIsDeleteSearch = false;
	self.mInput = self:FindComponent('InputField', 'InputField');
	self:FindAndAddClickListener("Button",function()self:OnClickFind();end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_RECIVE_SEARCH_LIST,function(searchList) self:ReciveSearchList(searchList); end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_REQUEST_LIST,function(requestList) self:OnUpdateUI(requestList); end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_RECOMMEND_LIST,function(recommendList) self:OnSetRecommendData(recommendList); end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_ADD_FRIEND,function(result) self:ReciveAddFriend(result); end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_REQUEST_HANDLE,function(result) self:ReciveAddFriend(result); end,true);
	self:RegisterEventListener(mEvent.ON_RESET_ADD_TIPS,function() self:ResetTips(); end,true);
	self:RegisterEventListener(mEvent.ON_SELECT_FRIEND_ADD,function(param)self:OnSelectFriend(param);end,true);

	self:RegisterEventListener(mEvent.ON_FRIENDADD_DELETE_FIND,function(data) self:OnDeleteFind(data); end,true);
	self:RegisterEventListener(mEvent.ON_FRIENDADD_DELETE_APPLY,function(data) self:OnOpenDeleteAgreeAlert(data); end,true);
	self:RegisterEventListener(mEvent.ON_FRIENDADD_ADD,function(data) self:OnAddFriend(data); end,true);
	self:RegisterEventListener(mEvent.ON_FRIENDADD_AGREE,function(data) self:OnOpenAgreeFriendAlert(data); end,true);
end

function FriendAddView:OnSelectFriend(param)
	local data = param.data;
	local trans = param.trans;
	local transLight = self.mTransLight;
	transLight.gameObject:SetActive(true);
	mGameObjectUtil:SetParent(transLight, trans);
	transLight:SetAsLastSibling();
	local model = mGameModelManager.FriendModel;
	model.mDataTable[2] = data;
	self:Dispatch(self.mEventEnum.ON_SELECT_FRIEND,data);
	if data.type == 1 then
		self.mIsSelectFind = true;
	else
		self.mIsSelectFind = false;
	end
end

function FriendAddView:ReciveSearchList(searchList)
	local model = mGameModelManager.FriendModel;
	local searchSource = model.mDataSoureSearch;
	if searchSource ~= nil then
		self.mGridExSearch:UpdateDataSource(searchSource);
	end
	self:SetPos();
	if self.mIsSelectFind then
		model.mDataTable[2] = nil;
		self.mTransLight.gameObject:SetActive(false);
		self:Dispatch(self.mEventEnum.ON_SET_PLAYER_MODEL_STATE,false);
	end
end

function FriendAddView:ReciveAddFriend(result)
	self:SetPos();
	local data = mGameModelManager.FriendModel.mFriendData;
	self:CheckIsSelectData(data);
end

function FriendAddView:OnClickFind()
	self.mIsFinding = true;
	self.mIsDeleteSearch = false;
	local name = self.mInput.text;
	self.mInput.text = "";
	if name ~= "" then
		mFriendController:SendFindFriend(name);
		self.mInput.text = "";
	end
end

function FriendAddView:OnDeleteFind(data)
	self.mIsDeleteSearch = true;
	local model = mGameModelManager.FriendModel;
	local data_soure = model.mDataSoureSearch;
	data_soure:RemoveKey(data.id);
	self:SetPos();
	self:CheckIsSelectData(data);
end

function FriendAddView:CheckIsSelectData(data)
	local model = mGameModelManager.FriendModel;
	local selectData = model.mDataTable[2];
	if selectData ~= nil then
		if selectData.id == data.id then
			self.mTransLight.gameObject:SetActive(false);
			model.mDataTable[2] = nil;
			self:Dispatch(self.mEventEnum.ON_SET_PLAYER_MODEL_STATE,false);
		end
	end
end

function FriendAddView:OnOpenDeleteAgreeAlert(data)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = data;
	mAlertView.Show({title=mLgDeleteApplyTitle,desc1=mLgDeleteApplyDesc1,desc2=data.name,btnName=mLgOK,showMidLine=true,CallBack=function(enemyData)self:OnDeleteAgree(data);end});
end

function FriendAddView:OnDeleteAgree(data)
	mFriendController:SendRequestHandle(data.id,0);
end

function FriendAddView:OnAddFriend(data)
	self.mIsDeleteSearch = true;
	local model = mGameModelManager.FriendModel;
	model.mFriendData = data;
	mFriendController:SendAddFriend(data.id);
end

function FriendAddView:OnOpenAgreeFriendAlert(data)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = data;
	mAlertView.Show({title=mLgAgreeTitle,desc1=data.name,desc2=mLgAgreeDesc1,btnName=mLgAgree,showMidLine=true,isTopLine=true,CallBack=function(enemyData)self:OnAgreeFriend(data);end});
end

function FriendAddView:OnAgreeFriend(data)
	mFriendController:SendRequestHandle(data.id,1);
end

function FriendAddView:SetPos()
	local model = mGameModelManager.FriendModel;

	local searchSource = model.mDataSoureSearch;
	if searchSource ~= nil then
		local length1 = mTable.getn(searchSource.mSortTable);
		if length1 > 0 then
			self.mGoText1:SetActive(length1 > 0 or self.mIsFinding);
			self.rectTransform.gameObject:SetActive(length1 > 0);
			local vector2 = mVector2(405,105*length1-5);
			self.rectTransform.sizeDelta = vector2;
			self.mTextFindNull.gameObject:SetActive(self.mIsFinding and length1 <= 0);
		else
			self.mGoText1:SetActive(self.mIsFinding);
			self.mTextFindNull.gameObject:SetActive(self.mIsFinding);
			if self.mIsDeleteSearch then
				self.mTextFindNull.text = mLgAllOver;
			else
				self.mTextFindNull.text = mLgSeverNotFound;
			end
			local vector2 = mVector2(405,0);
			self.rectTransform.sizeDelta = vector2;
		end
	end

	local requestSource = model.mDataSoureRequest;
	if requestSource ~= nil then
		local length2 = mTable.getn(requestSource.mSortTable);
		if length2 > 0 then
			self.mGoText2:SetActive(true);
			self.rectTransform2.gameObject:SetActive(true);
			local vector2_2 = mVector2(405,105*length2-5);
			self.rectTransform2.sizeDelta = vector2_2;
		else
			self.mGoText2:SetActive(false);
			self.rectTransform2.gameObject:SetActive(false);
			local vector2 = mVector2(405,0);
			self.rectTransform2.sizeDelta = vector2;
		end
	end

	local recommendSource = model.mDataSoureRecommend;
	if recommendSource ~= nil then
		local length3 = mTable.getn(recommendSource.mSortTable);
		if length3 > 0 then
			self.mGoText3:SetActive(true);
			self.rectTransform3.gameObject:SetActive(true);
			local vector2_3 = mVector2(405,105*length3-5);
			self.rectTransform3.sizeDelta = vector2_3;
		else
			self.mGoText3:SetActive(false);
			self.rectTransform3.gameObject:SetActive(false);
			local vector2 = mVector2(405,0);
			self.rectTransform3.sizeDelta = vector2;
		end
	end
end

function FriendAddView:OnUpdateUI(data)
	local model = mGameModelManager.FriendModel;
	self:OnSetRecommendData(nil);
	if model.mIsEverGetRequest then
		self.mGridExRequest:UpdateDataSource(model.mDataSoureRequest);
		self:SetPos();
		if not self.mIsEverOpen then
			mGameTimer.SetTimeout(0.2,function()self:SetSelectTopItem();end);
			self.mIsEverOpen = true;
		end
	else
		model.mIsEverGetRequest = true;
		mFriendController:SendGetRequestList();
	end
end

function FriendAddView:SetSelectTopItem()
	local trans,data = self:GetTopTransAndData();
	if trans ~= nil and data ~= nil then
		local model = mGameModelManager.FriendModel;
		model.mDataTable[2] = data;
		local transLight = self.mTransLight;
		transLight.gameObject:SetActive(true);
		mGameObjectUtil:SetParent(transLight, trans);
		local active = self.mGameObject.activeSelf;
		if active then
			self:Dispatch(self.mEventEnum.ON_SELECT_FRIEND,data);
		end
	end
end

function FriendAddView:GetTopTransAndData()
	local trans = nil;
	local data = nil;
	local model = mGameModelManager.FriendModel;
	local searchSource = model.mDataSoureRequest;
	local recommendSource = model.mDataSoureRecommend;
	if searchSource ~= nil and #searchSource.mSortTable > 0 then
		data = searchSource.mSortTable[1];
		trans = self:Find("ScrollRect/Grid/scrollView2/Grid/"..data.id);
	else
		data = recommendSource.mSortTable[1];
		if data ~= nil then
			trans = self:Find("ScrollRect/Grid/scrollView3/Grid/"..data.id);
		end
	end
	return trans,data;
end

function FriendAddView:OnSetRecommendData(data)
	local model = mGameModelManager.FriendModel;
	if model.mIsEverGetRecommend then
		self.mGridExRecommend:UpdateDataSource(model.mDataSoureRecommend);
		self:SetPos();
	else
		model.mIsEverGetRecommend = true;
		mFriendController:SendGetRecommendList();
	end
end

function FriendAddView:OnViewHide(data)
	self:ResetTips();
end

function FriendAddView:ResetTips()
	local searchNum = 0;
	local searchSoure = mGameModelManager.FriendModel.mDataSoureSearch;
	if searchSoure ~= nil then
		searchNum = mTable.getn(searchSoure.mSortTable);
	end
	if not self.mIsFinding or searchNum > 0 then
		return;
	end
	self.mIsFinding = false;
	self.mIsDeleteSearch = false;
	self:SetPos();
end

function FriendAddView:Dispose( )
	self.mGridExSearch:Dispose();
	self.mGridExRequest:Dispose();
	self.mGridExRecommend:Dispose();
end

return FriendAddView;