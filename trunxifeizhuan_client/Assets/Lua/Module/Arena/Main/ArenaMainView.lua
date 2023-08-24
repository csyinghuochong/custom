local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mTimeUtil = require "Utils/TimeUtil"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mArenaController = require "Module/Arena/ArenaController"
local mArenaPlayerItem = require "Module/Arena/Main/ArenaPlayerItem"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysarena_reward = require "ConfigFiles/ConfigSysarena_reward"
local MainArenaBalanceView = require "Module/MainInterface/MainArenaBalanceView"
local ArenaMainView = mLuaClass("ArenaMainView",mQueueWindow);
local GameObject = UnityEngine.GameObject;
local mString = string;
local mTable = table;
local mIpairs = ipairs;
local mPairs = pairs;

function ArenaMainView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_main_view",
		["ParentLayer"] = mMainLayer,
		["full_cost"] = {"arena_coin","energy"},
	};
end

function ArenaMainView:Init()
	self:InitSubView(  );
	self:AddListeners(  );
end

function ArenaMainView:InitSubView(  )
	local playerList = {};
	for i = 1, 5 do
		playerList[i] = mArenaPlayerItem.LuaNew(self:Find('group/player'..i).gameObject, i);
	end
	self.mPlayerItemList = playerList;

	self.mTextMyScore = self:FindComponent('Top/TopRight/Text_score', 'Text');
	self.mTextMyRank = self:FindComponent('Top/TopRight/Text_rank', 'Text');
	self.mTextFreshTime = self:FindComponent('cost/Text_time', 'Text');

	self:FindAndAddClickListener("Top/Button_close",function() self:ReturnPrevQueueWindow() end);
	self:FindAndAddClickListener("button_fresh",function() self:OnClickRefresh() end, nil, 1);
	self:FindAndAddClickListener("Top/TopLeft/Button_rule",function() self:OnOpenRuleView() end);
	self:FindAndAddClickListener("Top/TopLeft/Button_rank",function() self:OnOpenRankView() end);
	self:FindAndAddClickListener("Top/TopLeft/Button_team",function() self:OnOpenDefendSetView() end);
	self:FindAndAddClickListener("Top/TopLeft/Button_record",function() self:OnClickOpenEnemyView() end,nil, 1);

	self.mCost = self:Find('cost').gameObject;
	local textCost = self:FindComponent('cost/Text_cost', 'Text');
	textCost.text = mConfigSysglobal_value[mConfigGlobalConst.ARENA_REFRESH_COST];

	self.mGoTop = self:Find("Top").gameObject;
	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW, function()
		self:OnShowTop(true);
	end, true);
	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW, function()
		self:OnShowTop(false);
	end, true);
end

function ArenaMainView:OnShowTop(state)
	self.mGoTop:SetActive(state);
end

function ArenaMainView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_ARENA_INIT, function(data)
		self:OnRecvArenaInit( data );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_ARENA_UPDATE, function(data)
		self:OnRecvArenaUpdate( data );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_ENTER_MAINSCENE,   function() 
		mArenaController:SendReqOpenArena();
	end,true);

	self.mCheckFirstReward = function (  )
		mGameTimer.SetTimeout(0.1, function (  )
			self:CheckFirstReward();
		end)
	end
end

function ArenaMainView:CheckShow()
	local state, time = MainArenaBalanceView:GetArenaBalanceState( );
	if state == 1 then
		return true;
	else
		mUIManager:HandleUI( mViewEnum.ArenaBalanceWaitView, 1 )
		return false;
	end
end

function ArenaMainView:OnViewShow(  )
	mArenaController:SendReqOpenArena();
end

function ArenaMainView:OnOpenDefendSetView( )
	mArenaController:SendGetArenaDefend();
end

local mLanguage = require "Utils/LanguageUtil"
local mTip = mLanguage.arena_no_rank;
function ArenaMainView:IsMoneyEnough( )
	local cost = mConfigSysglobal_value[mConfigGlobalConst.ARENA_COST_ENERGY];
	return mGameModelManager.RoleModel.mPlayerBase.gold >= cost;
end

function ArenaMainView:OnRecvArenaInit( data )
	local allDefeat = self:CheckAllDefeat( data );
	if allDefeat and self:IsMoneyEnough() then
		self:OnClickRefresh();
	else
		self:OnUpdateUI(data);
	end
	--self:ShowFirstRewardView( data );
end

function ArenaMainView:ShowFirstRewardView( data )
	local rewardList = self.mRewardList;
	if rewardList ~= nil then
		return;
	end
	local idList = {};
	local rankList = data.first_award_list;
	for k, v in mIpairs(rankList) do
		mTable.insert(idList, v.id)
	end
	mTable.sort(idList, function(a, b ) return a < b end);
	self.mRewardList = idList;
	self.mRewardIndex = 1;
	self:CheckFirstReward();
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgRewardTip = mLanguageUtil.arena_first_reward;
function ArenaMainView:CheckFirstReward( )
	local index = self.mRewardIndex;
	local rank = self.mRewardList[index];
	if rank  ~= nil then
		local mDesc = mString.format(mLgRewardTip, mConfigSysarena_reward[rank].score[2]);
	    mAlertView.Show({title=nil, desc1=mDesc, desc2=nil, btnName= nil,CallBack = self.mCheckFirstReward, btnNumber = 1});
	end
	self.mRewardIndex = index + 1;
end

function ArenaMainView:OnRecvArenaUpdate( data )
	self:OnUpdateUI(data);
end

function ArenaMainView:OnUpdateUI( data )
	self.mData = data;
	local voList = data.vs_list;
	for k, v in mPairs(self.mPlayerItemList) do
		local vo = voList[k];
		if vo ~= nil then
			v:ForceShowView( vo );
		else
			v:HideView();
		end
	end

	self.mTextMyScore.text = data.score;
	self.mTextMyRank.text = data.rank ~= 0 and data.rank or mTip;
	
	self:OnUpateFreshTime(  );
end

function ArenaMainView:CheckAllDefeat( data )
	local voList = data.vs_list;
	local allDefeat = true;
	for k, v in mPairs(voList) do
		if v.defeated == 0 then
			allDefeat = false;
			break;
		end
	end

	return allDefeat;
end

function ArenaMainView:OnOpenRuleView(  )
	mUIManager:HandleUI(mViewEnum.ArenaRuleView,1);
end

function ArenaMainView:OnOpenRankView(  )
	mUIManager:HandleUI(mViewEnum.ArenaRankView,1);
end

function ArenaMainView:OnClickRefresh( )
	mArenaController:SendRefreshArena();
end

function ArenaMainView:GetLastCD(  )
	return self.mData.last_refresh + mConfigSysglobal_value[mConfigGlobalConst.ARENA_REFRESH_CD]
	 - mGameModelManager.LoginModel:GetCurrentTime();
end

function ArenaMainView:OnUpateFreshTime(  )
	local remainTime = self:GetLastCD();
	self:DisposeTimer();
    if remainTime > 0 then
    	self.mRemainTime =  remainTime;
    	self:OnTimerInterval();
        self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
        self.mCost:SetActive(true);
    else
    	self.mTextFreshTime.text = "";
    	self.mCost:SetActive(false);
   	end
end

function ArenaMainView:OnTimerInterval()
    local time = self.mRemainTime;
    time = time - 1;
    if time >= 0 then
       self.mTextFreshTime.text = mTimeUtil:TransToMinSec(time);
    else
       self:DisposeTimer();
       self.mCost:SetActive(false);
       self.mTextFreshTime.text = "";
    end
    self.mRemainTime = time;
end

function ArenaMainView:OnClickOpenEnemyView( )
	mUIManager:HandleUI(mViewEnum.ArenaRecordView,1);
end

function ArenaMainView:OnViewHide( )
	self.mRewardList = nil;
	self:DisposeTimer();

	for k, v in mPairs(self.mPlayerItemList) do
		v:HideView();
	end
end

function ArenaMainView:Dispose(  )
	for k, v in mPairs(self.mPlayerItemList) do
		v:CloseView();
	end
end

function ArenaMainView:DisposeTimer(  )
	local gameTime = self.mTimerInterval;
	if gameTime ~= nil then
		gameTime:Dispose();
	end
	self.mTimerInterval = nil;
end

return ArenaMainView;