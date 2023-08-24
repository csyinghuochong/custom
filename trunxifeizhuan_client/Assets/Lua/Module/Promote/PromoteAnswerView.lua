local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mPromoteAnswerItem = require "Module/Promote/PromoteAnswerItem"
local mPromoteController = require "Module/Promote/PromoteController"
local PromoteAnswerView = mLuaClass("PromoteAnswerView",mBaseView);
local mTable = require 'table'
local mVector3 = Vector3;
local mPairs = pairs;

function PromoteAnswerView:Init()	
	local callBack = function (  )
		self:UpdateButton();
	end
	local answerList = {};
	for i = 1, 5 do
		answerList[i] = mPromoteAnswerItem.LuaNew(self:Find('answer'..i).gameObject, callBack);
	end
	self.mAnswerItemList = answerList;
	self.mStarPos = self:Find( 'answer1' ).localPosition;
	self.mToggleGroup = self.mTransform:GetComponent('ToggleGroup');
	self.mTextProgress = self:FindComponent('Text_1', 'Text');
	self.mTextQuestion = self:FindComponent('Text_question', 'Text');
	self.mTextTime = self:FindComponent('time/Text_time', 'Text');
	self:FindAndAddClickListener("button_ok",function() self:OnClickSendAnswer() end);
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self:Find("button_ok").gameObject);

	self.mRight = self:Find('right').gameObject;
	self.mError = self:Find('error').gameObject;
end

function PromoteAnswerView:OnUpdateUI(vo)
	self:OnResetUI();
	self:ShowAnswerResult(vo);
	self:UpdateAnswerList(vo);
	self:OnUpdateProgress(vo);
end

function PromoteAnswerView:OnViewShow( vo )
	self:OnUpdateUI(vo);
	self:OnUpdateTime(vo);

	self.mExamResult = 0;
	self.mRight:SetActive(false);
	self.mError:SetActive(false);
end

function PromoteAnswerView:ShowAnswerResult( vo )
	local answer_right = vo.mExamResult ~= self.mExamResult;
	self.mRight:SetActive(answer_right);
	self.mError:SetActive(not answer_right);
	self.mExamResult = vo.mExamResult;
end

function PromoteAnswerView:OnViewHide( )
	self:DisposeTimer();
end

function PromoteAnswerView:DisposeTimer(  )
	local gameTime = self.mTimerInterval;
	if gameTime ~= nil then
		gameTime:Dispose();
	end
	self.mTimerInterval = nil;
end

function PromoteAnswerView:OnUpdateTime( vo )
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local remainTime = vo.mLeftTime - currentTime;
	self:DisposeTimer();
    if remainTime > 0 then
    	self.mRemainTime =  remainTime;
    	self:OnTimerInterval();
        self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
   	end
end

function PromoteAnswerView:OnUpdateProgress( vo )
	self.mTextProgress.text = vo:GetProgress();
end

function PromoteAnswerView:OnTimerInterval()
    local time = self.mRemainTime;
    time = time - 1;
    if time > 60*60*24 then
       self.mTextTime.text = mTimeUtil:TransToDayHour(time);
    else
       self.mTextTime.text = mTimeUtil:TransToHourMinSec(time);
    end
    if time <= 0 then
        self.mTimerInterval:Stop();
    end
    self.mRemainTime = time;
end

function PromoteAnswerView:OnResetUI(  )
	for k, v in mPairs(self.mAnswerItemList) do
		v:SetToggleGroup(nil);
		v:SetSelected(false);
	end

	self.mUIGray:SetGray(true);
end

function PromoteAnswerView:UpdateAnswerList( vo )
	local sysVO =  vo:GetAnswerVO();
	local answerVO = sysVO.options;
	local optionNumber = mTable.getn(answerVO);
	local toggle_group = vo.mSysVO.type == 1 and self.mToggleGroup or nil;
	local offset = optionNumber == 5 and -43 or -56;
	local mStarPos = self.mStarPos;
	for k, v in mPairs(self.mAnswerItemList) do
		local answer = answerVO[k];
		if answer ~= nil then
			v:ShowView();
			v:OnUpdateUI(answer);
			v:SetToggleGroup(toggle_group);
		else
			v:HideView();
		end

		v.mTransform.localPosition = mStarPos + mVector3(0, offset * (k - 1),0);
	end 
	self.mTextQuestion.text = sysVO.title;
end

function PromoteAnswerView:UpdateButton()
	local index = self:GetAnswerList();
	self.mUIGray:SetGray(mTable.getn(index) <= 0);
end

function PromoteAnswerView:GetAnswerList(  )
	local indexs  =  {};
	for k, v in mPairs(self.mAnswerItemList) do
		if v:GetSelected() then
			mTable.insert(indexs, v.mOptionId);
		end
	end
	return indexs;
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgNoSelectOption = mLanguageUtil.promote_no_select_option;
function PromoteAnswerView:OnClickSendAnswer(  )
	local index = self:GetAnswerList();
	if index ~= nil and mTable.getn(index) > 0 then
		mPromoteController:SendExamAnswer(index);
	else
		mCommonTipsView.Show(mLgNoSelectOption);
	end
end

return PromoteAnswerView;