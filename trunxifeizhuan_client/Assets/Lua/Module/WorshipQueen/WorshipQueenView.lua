local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigSysworship_queen = require "ConfigFiles/ConfigSysworship_queen"
local mVector2 = Vector2
local mVector3 = Vector3
local mColor = Color
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mWorshipQueenController = require "Module/WorshipQueen/WorshipQueenController"
local mWorshipQueenAwardView = require "Module/WorshipQueen/WorshipQueenAwardView"
local mCommonMoveToggleGroup = require "Module/CommonUI/TabView/CommonMoveToggleGroup"
local mSortTable = require "Common/SortTable"
local mCommonAllAwardVO = require "Module/CommonUI/CommonAllAwardVO"
local mCommonGetAwardView = require "Module/CommonUI/CommonGetAwardView"
local WorshipQueenView = mLuaClass("WorshipQueenView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgMaxTimes = mLanguageUtil.worshipqueen_maxtimes;
local mLgStateTable = {mLanguageUtil.worshipqueen_state1,mLanguageUtil.worshipqueen_state2};
local mLgTipsTable = {mLanguageUtil.worshipqueen_tips1,mLanguageUtil.worshipqueen_tips2};

local mGameTimer = require "Core/Timer/GameTimer"
local TIME_START = 0.3;
local TIME_NORMAL = 0.05;
local TIME_ADD = 0.05;
local TIME_MINUS = 0.1;
local STEP_ADD = 5;
local STEP_MINUS = 6;
local TIME_END = 1.0;
local TIME_SCALE = 0.01;

local MAX_PLAY_TIMES = 10;
local WISH = 1;
local GIFT = 2;

function WorshipQueenView:InitViewParam()
	return {
		["viewPath"] = "ui/worship_queen/",
		["viewName"] = "worship_queen_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["full_cost"] = {"gold","silver","strength","energy"},
		["ChangeSceneDispose"] = true,
	};
end

function WorshipQueenView:Init()
    self.mModelShowViewQueen = mModelShowView.LuaNew(self:Find('queenModel'));

    self.mGoBtnWishFlag = self:Find("Roll/BtnGroup/Btn1/redPoint").gameObject;
    self.mGoCost = self:Find("Roll/Bottom/cost").gameObject;
    self.mGoFree = self:Find("Roll/Bottom/free").gameObject;
	self.mGoBtnGift = self:Find("Roll/BtnGroup/Btn2").gameObject;
	self.mTextCost = self:FindComponent("Roll/Bottom/cost","Text");
	self.mTextBtn = self:FindComponent("Roll/Bottom/Btn/text","Text");
	self.mTextTips = self:FindComponent("Roll/Tips","Text");
	self.mTransLight = self:Find("Roll/AwardGroup/light");
	self.mTransQueen = self:Find("queenModel");
	self.mTransRoll = self:Find("Roll");
	local width = mUIManager:GetDeviceWidth()/4;
	self.mTransQueen.localPosition = mVector3(-width,-240,-10);
	self.mTransRoll.localPosition = mVector3(208,-20,0);
	self:ResetLight(1);

	self.mAwardList = {};
	local reward = mConfigSysworship_queen[1].reward;
	for i=1,12 do
		local go = self:Find("Roll/AwardGroup/goods"..i).gameObject;
		local award = mCommonGoodsItemView.LuaNew(go);
		self.mAwardList[i] = award;
	end

	local callBack = function(index)self:ChangeToggle(index);end
    local trans = self:Find("Roll/BtnGroup");
    self.mToggleGroup = mCommonMoveToggleGroup.LuaNew(trans,callBack);
    self:ChangeToggle(1,true);

	self:FindAndAddClickListener("Button_return",function() self:OnClickClose(); end);
	self:FindAndAddClickListener("Roll/Bottom/Btn",function() self:OnClickRoll(); end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_WORSHIP_QUEEN_GET_INFO,function(data)self:OnSetInfo(data);end,false);
	self:RegisterEventListener(mEvent.ON_WORSHIP_QUEEN_GET_AWARD,function(data)self:OnStartRoll(data);end,true);
end

function WorshipQueenView:OnSetInfo(data)
	local model = mGameModelManager.WorshipQueenModel;
	local wishTimes = model.mTimesWish;
	local endTime = model.mTimeEnd;
	if endTime ~= 0 then
		local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
		local second = endTime - nowTime;
		if second > 0 then
			self.mTimerResetInfo = mGameTimer.HandSetTimeout(second, function() self.mGoBtnGift:SetActive(false); end);
		else
			self.mGoBtnGift:SetActive(false);
		end
	else
		self.mGoBtnGift:SetActive(false);
	end
	self:SetCost();
end

function WorshipQueenView:ChangeToggle(state,isFirst)
	self.mNowState = state;
	local config = mConfigSysworship_queen[state];
	local awardList = self.mAwardList;
	for k,v in ipairs(awardList) do
		local data = mCommonGoodsVO.LuaNew(config.reward[k].goods_id,config.reward[k].goods_num);
		v:ExternalUpdate(data);
	end
	self.mTextCost.text = config.gold_cost;
	self:ResetLight(1);
	if not isFirst then
		self:SetCost();
	end
	self:SetText(state);
end

function WorshipQueenView:SetText(state)
	self.mTextBtn.text = mLgStateTable[state];
	self.mTextTips.text = mLgTipsTable[state];
end

function WorshipQueenView:SetCost()
	local model = mGameModelManager.WorshipQueenModel;
	if model.mTimesTable[WISH] == 0 and self.mNowState == WISH then
		self.mGoFree:SetActive(true);
		self.mGoCost:SetActive(false);
	else
		self.mGoFree:SetActive(false);
		self.mGoCost:SetActive(true);
	end
end

function WorshipQueenView:OnClickClose()
	if self.mIsRolling then
		self.mIsRolling = false;
		self:ShowAward();
	end
	self:ReturnPrevQueueWindow();
end

function WorshipQueenView:ResetLight(pos)
	local transLight = self.mTransLight;
	local transFirstAward = self:Find("Roll/AwardGroup/goods"..pos);
	mGameObjectUtil:SetParent(transLight,transFirstAward);
	transLight:SetSiblingIndex(3);
end

function WorshipQueenView:OnClickRoll()
	if self.mIsRolling then
		return;
	end
	local model = mGameModelManager.WorshipQueenModel;
	local state = self.mNowState;
	if model.mTimesTable[state] >= model.mMaxTimes then
		mCommonTipsView.Show(mLgMaxTimes);
	else
		self.mIsRolling = true;
		mWorshipQueenController:OnSendWish(state);
	end
end

function WorshipQueenView:OnStartRoll(data)
	self:SetCost();
	self.mAwardData = data;
	self.mRunStep = 0;
	local awardPos = self:GetPos(data.id,data.num);
	local step = 47 + awardPos - self.mNowStep;
	self.mAllStep = step;
	self:RunToNext(TIME_START);
end

function WorshipQueenView:GetPos(id,num)
	local state = self.mNowState;
	local awards = mConfigSysworship_queen[state].reward;
	for k,v in ipairs(awards) do
		if v.goods_id == id and v.goods_num == num then
			return k;
		end
	end
end

function WorshipQueenView:RunToNext(time)
	self.mTimerOut = mGameTimer.HandSetTimeout(time, function() self:OnTimerOut() end);
end

function WorshipQueenView:OnTimerOut()
	local nowStep = self.mNowStep + 1;
	local runStep = self.mRunStep + 1;
	local allStep = self.mAllStep;
	if runStep > allStep then
		self.mIsRolling = false;
		self:ShowAward();
	else
		local nextTime = self:CreateNextTime(runStep);
		self:RunToNext(nextTime);
		local pos = nowStep%12 + 1;
		self:ResetLight(pos);
		self.mNowStep = pos - 1;
	end
	self.mRunStep = runStep;
end

function WorshipQueenView:ShowAward()
	local data = self.mAwardData;
	if data ~= nil then
		local data_soure = mSortTable.LuaNew(nil,nil,true);
		local itemVO = mCommonAllAwardVO.LuaNew(data.id,data.num,false);
		data_soure:AddOrUpdate(itemVO.mID,itemVO);
		mCommonGetAwardView.Show(data_soure);
	end
end

function WorshipQueenView:CreateNextTime(nowStep)
	local time;
	local allStep = self.mAllStep;
	if nowStep <= STEP_ADD then
		time = TIME_START - TIME_ADD*nowStep - self:GetScaleTimes(nowStep)*TIME_SCALE; 
	elseif nowStep > STEP_ADD and nowStep <= allStep - STEP_MINUS then
		time = TIME_NORMAL;
	else
		local step = nowStep - (allStep - STEP_MINUS);
		time = TIME_NORMAL + step*TIME_MINUS + self:GetScaleTimes(step)*TIME_SCALE;
	end
	if time < TIME_NORMAL then
		time = TIME_NORMAL;
	end
	if time > TIME_END then
		time = TIME_END;
	end
	return time;
end

function WorshipQueenView:GetScaleTimes(steps)
	local scaleTimes = 0;
	for i=1,steps do
		scaleTimes = scaleTimes + i;
	end
	return scaleTimes;
end

function WorshipQueenView:OnViewShow(logicParams)
	self:ResetLight(1);
	self.mNowStep = 0;

    local bustIcon1 = mConfigSysnpc[31].model;
    self.mModelShowViewQueen:ShowView();
    self.mModelShowViewQueen:OnUpdateUI(bustIcon1, true);

    local model = mGameModelManager.WorshipQueenModel;
    if not model.mIsEverGetInfo then
    	mWorshipQueenController:OnGetQueenInfo();
    end
end

function WorshipQueenView:Dispose()
	self.mModelShowViewQueen:Dispose();
	self:OnTimeDispose();
end

function WorshipQueenView:OnViewHide()
	self.mModelShowViewQueen:HideView();
	self:OnTimeDispose();
end

function WorshipQueenView:OnTimeDispose()
	if self.mTimerOut ~= nil then
		self.mTimerOut:Dispose();
		self.mTimerOut = nil;
	end
	if self.mTimerResetInfo ~= nil then
		self.mTimerResetInfo:Dispose();
		self.mTimerResetInfo = nil;
	end
end

return WorshipQueenView;