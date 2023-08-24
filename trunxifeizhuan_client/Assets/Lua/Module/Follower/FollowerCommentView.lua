local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local mFollowerVO = require "Module/Follower/FollowerVO"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mLayoutController = require "Core/Layout/LayoutController"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local mFollowerPowerVO = require "Module/Follower/FollowerPowerVO"
local mFollowerCommentVO = require "Module/Follower/FollowerCommentVO"
local FollowerController = require "Module/Follower/FollowerController"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local FollowerCommentView = mLuaClass("FollowerCommentView", mQueueWindow);
local mIpairs = ipairs;
local mPairs = pairs;
local mTable = table;

function FollowerCommentView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_comment_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function FollowerCommentView:Init()
	self:AddListener();
	self:InitSubView();
end

function FollowerCommentView:AddListener( )
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_COMMENT_LIST, function(vo)
		self:OnRecvCommentList(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_COMMENT_PRAISE, function(vo)
		self:OnRecvCommentPraise(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_LOOK_FOLLOWER, function(vo)
		self:OnRecvLookFollower(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_CLICK_COMMENT_ITEM, function(vo)
		self:OnClickLookFollower(vo);
	end, true);

	self.mFefresCallBack = function (  )
		self:ShowMoreComment();
	end
end

local mMaxPower = 5;
function FollowerCommentView:InitSubView()
	local parent = self:Find("scrollView/Grid");
	self.mRectTrance = self:FindComponent("scrollView/Grid","RectTransform");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerCommentItem");
	self.mMoreRecomment = self:Find('more_comment');

	local callBack = function( index )
		self:OnSwitchPower(index);
	end
	local go = self:Find('tabView/buttonView');
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,1);

	local powerBtns = {};
	local powerText = {};
	for i = 1, mMaxPower do
		powerBtns[i] = self:Find('tabView/buttonView/Button'..i).gameObject;
		powerText[i] = self:FindComponent(string.format('tabView/buttonView/Button%d/text', i), 'Text')
	end
	self.mPowerButtons = powerBtns;
	self.mPowerText = powerText;
	self.mBottomHua = self:Find( 'tabView/Line/hua' );

	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('follower_item').gameObject);

	self.mDataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);

	self.mInput = self:FindComponent('bottom/InputField','InputField');
	self:FindAndAddClickListener("bottom/btnSend",function() self:SendComment(); end,"ty_0203", 1);
end

function FollowerCommentView:Sort( a, b )
	return a.mIndex < b.mIndex;
end

function FollowerCommentView:OnViewShow(logicParams)
	if logicParams == nil then
		return;
	end

	self.mData = logicParams;
	self:UpdateToggleButton();
end

function FollowerCommentView:UpdateToggleButton(  )
	--找出该随从的有效势力
	local data = self.mData;
	local validPower = {};
	local powerBtns = self.mPowerButtons;
	local powerText = self.mPowerText;
	local actorInfo = mConfigSysactor[data.mID];
	local actorList = actorInfo.actors;

	for i = 1, mMaxPower do
		local actorId = actorList[i];
	
		if actorId ~= nil then
			local actorVo  = mConfigSysactor[actorId];

			mTable.insert(validPower, actorId);
			powerText[i].text = mFollowerPowerVO:GetPowerInfo(actorVo.camp);
			powerBtns[i].transform.localPosition = Vector3.New(-307.8, 153.2 + (#validPower - 1) * -91.4);
		end
		powerBtns[i]:SetActive(actorId ~= nil);
	end
	self.mValidPower = validPower;
	self.mBottomHua.localPosition = Vector3.New( -1.4, 21.9 + (#validPower - 1) * -91.4 );

	self:OnSwitchPower( actorInfo.camp );
	self.mToggleGroup:OnClickToggleButton( actorInfo.camp, false );
end

function FollowerCommentView:UpdateFollowerItem( id )
	local actor = mFollowerBaseVO.LuaNew();
	actor:InitConfigActorVO(mConfigSysactor[id]);
	self.mFollowerItem:ExternalUpdateData(actor);
end

function FollowerCommentView:OnSwitchPower( power )
	local id = self.mValidPower[power];
	self:UpdateFollowerItem(id);
	FollowerController:ReqCommentList(id);
	self.mFollowerID = id;
end

function FollowerCommentView:OnRecvCommentList( pbPartnerCommentList )
	local dataSource = self.mDataSource;
	dataSource:ClearDatas(true);

	local commentList = pbPartnerCommentList.list;
	for k, v in mIpairs(commentList) do
		dataSource:AddOrUpdate(v.id, mFollowerCommentVO.LuaNew(k, v));
	end

	self.mGridEx:UpdateDataSource(dataSource, self.mFefresCallBack);
end

function FollowerCommentView:RefreshList()
	local height = self.mRectTrance.sizeDelta.y;
	if height > 408 then
		self.mRectTrance.pivot = Vector2.New(0.5,0);
	else
		self.mRectTrance.pivot = Vector2.New(0.5,1);
	end
end

function FollowerCommentView:ShowMoreComment(  )
	local gridEx = self.mGridEx;
	local data = self.mDataSource.mSortTable[4];
	local selectId = data and data.mPbVO.id or 0;
	local moreComment = self.mMoreRecomment;

	if selectId ~= 0 then
		gridEx:GetChild(selectId):AttachMoreComment(moreComment);
	end

	moreComment.gameObject:SetActive(selectId ~= 0);

	mGameTimer.SetTimeout(0.1, function()
		self:RefreshList();
	end);
end

function FollowerCommentView:OnRecvCommentPraise( id )
	local item = self.mGridEx:GetChild(id);
	if item ~= nil then
		item:OnRecvCommentPraise();
	end
end

function FollowerCommentView:OnClickLookFollower( data )
	FollowerController:SendLookFollower(data:GetPlayerId(), self.mFollowerID);
end

function FollowerCommentView:OnRecvLookFollower( data )
	local followerVo = mFollowerVO.LuaNew();
	followerVo:InitFollowerData(data);
	mUIManager:HandleUI(mViewEnum.BattleFollowerInfoView, 1, followerVo);
end

function FollowerCommentView:SendComment(  )
	local text = self.mInput.text;
	if text ~= '' then
		FollowerController:SendAddComment(self.mFollowerID, text);
		self.mInput.text = '';
	end
end

function FollowerCommentView:OnViewHide()
	
end

function FollowerCommentView:Dispose()
	self.mGridEx:Dispose();
end

return FollowerCommentView;