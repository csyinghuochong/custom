local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mAlertView = require "Module/CommonUI/AlertBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteController = require "Module/Promote/PromoteController"
local PromoteScoreView = mLuaClass("PromoteScoreView",mBaseView);
local mVecto3 = Vector3;

function PromoteScoreView:Init()
	self.mTextTitle = self:FindComponent('Text_title1', 'Text');
	self.mTextScore = self:FindComponent('Text_result1', 'Text');
	self.mTextgrade = self:FindComponent('Text_result2', 'Text');
	self.mTextAgainCost = self:FindComponent('button_again/Text_cost', 'Text');
	self.mButtonNext = self:Find('button_next').gameObject;
	self.mButtonOver = self:Find('button_over').gameObject;
	self.mButtonAgain = self:Find('button_again').gameObject;

	self:AddBtnClickListener(self.mButtonNext,function() self:OnClickBeginNextExam() end);
	self:AddBtnClickListener(self.mButtonOver,function() self:OnClickSendOverExam() end);
	self:AddBtnClickListener(self.mButtonAgain,function() self:OnClickAgainCurrent() end);
end

function PromoteScoreView:OnViewShow( logicParams )
	self:OnUpdateUI(logicParams);
end

function PromoteScoreView:OnUpdateUI(vo)
	self.mData = vo;
	
	self:UpdateExamState( vo );
	self:UpdateButtonPos( vo );
end

function PromoteScoreView:UpdateExamState( vo )
	local result1, result2 = vo:GetExamResult();
	self.mTextScore.text = result1;
	self.mTextgrade.text = result2;
	self.mTextTitle.text = vo:GetScoreTitle();
	self.mTextAgainCost.text = vo:GetAgainCost();
end

local mVector_1  = Vector3.New(187, -224, 0);
local mVector_2  = Vector3.New(95.6, -224, 0);
local mVector_3  =  Vector3.New(273.1, -224, 0);
function PromoteScoreView:UpdateButtonPos( vo )
	local finalExam = vo:IsFinalExam();
	local result = vo:GetGradeLevel();

	local btnOver = self.mButtonOver;
	local btnNext = self.mButtonNext;
	local btnAgain = self.mButtonAgain;
	if result == 1 then
		btnOver.transform.localPosition = mVector_1;
		btnNext.transform.localPosition = mVector_1;
	else
		btnAgain.transform.localPosition = mVector_2;
		btnOver.transform.localPosition = mVector_3;
		btnNext.transform.localPosition = mVector_3;
	end

	btnOver:SetActive(finalExam);
	btnNext:SetActive(not finalExam);
	btnAgain:SetActive(result ~= 1);
end

function PromoteScoreView:OnClickBeginNextExam(  )
	mPromoteController:SendBeginNextExam();
end

function PromoteScoreView:OnClickSendOverExam(  )
	mPromoteController:SendReqNpcResult();
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgAgExamTitle = mLanguageUtil.promote_again_exam_title
local mLgAgExamDesc = mLanguageUtil.promote_again_exam_desc;
local mLgAgExamDesc3 = mLanguageUtil.promote_again_exam_desc2;
function PromoteScoreView:OnClickAgainCurrent(  )
	local callBack = function(  )
		mPromoteController:SendAgainCurrent();
	end
	
	local mDesc = string.format(mLgAgExamDesc, self.mData:GetAgainCost());
	mAlertView.Show({title=mLgAgExamTitle, desc1=mDesc, btnName= nil,CallBack = callBack});
end

return PromoteScoreView;