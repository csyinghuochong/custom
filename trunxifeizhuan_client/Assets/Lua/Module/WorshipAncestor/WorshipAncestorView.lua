local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mWorshipAncestorBtn = require "Module/WorshipAncestor/WorshipAncestorBtn"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local mConfigSysAncestor = require "ConfigFiles/ConfigSysworship_ancestor"
local mSortTable = require "Common/SortTable"
local mCommonAllAwardVO = require "Module/CommonUI/CommonAllAwardVO"
local mCommonGetAwardView = require "Module/CommonUI/CommonGetAwardView"
local mLayoutController = require "Core/Layout/LayoutController"
local mDGTween = DG.Tweening.ShortcutExtensions;
local mLoopType = DG.Tweening.LoopType
local mWorshipAncestorController = require "Module/WorshipAncestor/WorshipAncestorController"
local mWorshipQueenAwardView = require "Module/WorshipQueen/WorshipQueenAwardView"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local WorshipAncestorView = mLuaClass("WorshipAncestorView", mQueueWindow);

local mGameTimer = require "Core/Timer/GameTimer"
local TIME_START = 0.3;
local TIME_NORMAL = 0.05;
local TIME_ADD = 0.05;
local TIME_MINUS = 0.1;
local STEP_ADD = 5;
local STEP_MINUS = 6;
local TIME_END = 1.0;
local TIME_SCALE = 0.01;

function WorshipAncestorView:InitViewParam()
	return {
		["viewPath"] = "ui/worship_ancestor/",
		["viewName"] = "worship_ancestor_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["full_cost"] = {"gold","silver","strength","energy"},
		["ChangeSceneDispose"] = true,
	};
end

function WorshipAncestorView:Init()
	self:FindAndAddClickListener("Button_return",function() self:OnClickReturn(); end);
	self:FindAndAddClickListener("Button_rule",function() self:OnClickRule(); end);

	local btnGroup = {};
	for i=1,3 do
		local go = self:Find("BtnGroup/Btn"..i).gameObject;
		local btn = mWorshipAncestorBtn.LuaNew(go,function(value)self:OnClickBtn(value);end);
		btnGroup[i] = btn;
	end
	self.mBtnGroup = btnGroup;

	self.mGoItem = self:Find("Item").gameObject;
	self.mItem = mCommonGoodsItemView.LuaNew(self.mGoItem);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_WORSHIP_ANCESTOR_GET_INFO,function(data)self:OnSetInfo(data);end,true);
	self:RegisterEventListener(mEvent.ON_WORSHIP_ANCESTOR_GET_AWARD,function(data)self:OnStartRoll(data);end,true);
end

function WorshipAncestorView:OnClickReturn()
	if self.mIsRolling then
		self.mIsRolling = false;
		self:OnShowAward();
		self.mGoItem:SetActive(false);
	end
	self:ReturnPrevQueueWindow();
end

function WorshipAncestorView:OnSetInfo(data)
	local model = mGameModelManager.WorshipAncestorModel;
	if model.mTimes >= model.mMaxTimes then
		self.mBtnGroup[1]:SetInfo(1,1,0);
		self.mBtnGroup[2]:SetInfo(2,1,0);
		self.mBtnGroup[3]:SetInfo(3,1,0);
		return;
	end
	local times = model.mTimes + 1;
	local end_time = model.mEndTime;
	local timesTable = model.mTimesTable;
	local index = timesTable[times];
	local btnGroup = self.mBtnGroup;
	for k,v in ipairs(btnGroup) do
		if k == index then
			if end_time <= 0 then
				v:SetInfo(k,2,0);
			else
				v:SetInfo(k,3,end_time);
			end
		elseif k < index then
			v:SetInfo(k,1,0);
		elseif k > index then
			v:SetInfo(k,4,0);
		end
	end
end

function WorshipAncestorView:CreateAward(times)
	local index = times;
	local config = mConfigSysAncestor[index];
	self.mAwardNum = #config.reward;
	self.mAwardTable = config.reward;
end

function WorshipAncestorView:OnClickBtn(value)
	if self.mIsRolling then
		return;
	end
	self.mIsRolling = true;
	mWorshipAncestorController:OnGetAward();
end

-- function WorshipAncestorView:ResetTweener()
-- 	local tweener = self.mTweener;
-- 	if tweener ~= nil then
-- 		tweener:Pause();
-- 		local transform = self.mTransSelect.parent;
-- 		transform.anchoredPosition = Vector2(transform.anchoredPosition.x,-35);
-- 		self.mTweener = nil;
-- 	end
-- end

function WorshipAncestorView:OnStartRoll(data)
	self.mAwardData = data;
	self:CreateAward(mGameModelManager.WorshipAncestorModel.mTimes + 1);
	local awardNum = self.mAwardNum;
	local awardPos = self:GetPos(data.id);
	local step = awardNum*9 - 1 + awardPos;
	self.mAllStep = step;
	self.mNowStep = -1;
	self.mGoItem:SetActive(true);
	self:ResetItem(1);
	self:RunToNext(TIME_START);
end

function WorshipAncestorView:GetPos(id)
	local model = mGameModelManager.WorshipAncestorModel;
	local times = model.mTimes + 1;
	local awards = mConfigSysAncestor[times].reward;
	for k,v in ipairs(awards) do
		if v.goods_id == id then
			return k;
		end
	end
end

function WorshipAncestorView:RunToNext(time)
	self.mTimerOut = mGameTimer.HandSetTimeout(time, function() self:OnTimerOut() end);
end

function WorshipAncestorView:OnTimerOut()
	local nowStep = self.mNowStep + 1;
	local allStep = self.mAllStep;
	local awardNum = self.mAwardNum;
	if nowStep > allStep then
		self.mIsRolling = false;
		self:OnShowAward();
		return;
	else
		local nextTime = self:CreateNextTime(nowStep);
		self:RunToNext(nextTime);
		local pos = nowStep%awardNum + 1;
		self:ResetItem(pos);
		self.mNowStep = nowStep;
	end
end

function WorshipAncestorView:ResetItem(pos)
	local awards = self.mAwardTable;
	local award = awards[pos];
	if award ~= nil then
		local itemVO = mCommonGoodsVO.LuaNew(award.goods_id,nil,nil,false);
		self.mItem:ExternalUpdate(itemVO);
	end
end

function WorshipAncestorView:OnShowAward()
	local data = self.mAwardData;
	if data ~= nil then
		local data_soure = mSortTable.LuaNew(nil,nil,true);
		local itemVO = mCommonAllAwardVO.LuaNew(data.id,data.num,false);
		data_soure:AddOrUpdate(itemVO.mID,itemVO);
		mCommonGetAwardView.Show(data_soure);
		self.mGoItem:SetActive(false);
	end
end

function WorshipAncestorView:CreateNextTime(nowStep)
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

function WorshipAncestorView:GetScaleTimes(steps)
	local scaleTimes = 0;
	for i=1,steps do
		scaleTimes = scaleTimes + i;
	end
	return scaleTimes;
end

function WorshipAncestorView:OnClickRule()
	mUIManager:HandleUI(mViewEnum.ManualView,1, mConfigSysmanualConst.WORSHIP_ANCESTOR);
end

function WorshipAncestorView:OnViewShow(logicParams)
	local model = mGameModelManager.WorshipAncestorModel;
	if not model.mIsEverGetInfo then
		model.mIsEverGetInfo = true;
		mWorshipAncestorController:OnGetInfo();
	else
		self:OnSetInfo(nil);
	end
end

function WorshipAncestorView:Dispose()
	if self.mTimerOut ~= nil then
		self.mTimerOut:Dispose();
		self.mTimerOut = nil;
	end
	-- self:ResetTweener();
end

function WorshipAncestorView:OnViewHide()
	self:Dispose();
	local btnList = self.mBtnGroup;
	for k,v in ipairs(btnList) do
		v:OnViewHide();
	end
end

return WorshipAncestorView;