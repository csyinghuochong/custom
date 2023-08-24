local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mStringUtils= require "Utils/StringUtil"
local mLanguageUtil = require "Utils/LanguageUtil"
local mConfigSyspromote_examine_type = require "ConfigFiles/ConfigSyspromote_examine_type"
local PromoteExamBaseVO = mLuaClass("PromoteExamBaseVO", BaseLua);
local mLGResult = mLanguageUtil.promote_exam_result;
local mLGEvaluate1 = mLanguageUtil.promote_exam_evaluate1;
local mLGEvaluate2 = mLanguageUtil.promote_exam_evaluate2;
local mLGEvaluate3 = mLanguageUtil.promote_exam_evaluate3;

--考试基类--
function PromoteExamBaseVO:OnLuaNew(vo, exam_index, exam_number)
	self.mSysVO = vo;

	self.mPhaseStatus = 0;
	self.mLeftTime = 0;
	self.mCurrentNumber = 0;
	self.mTotalNumber = 0;
	self.mQuestionID = 1;
	self.mRightNumber = 0;
	self.mExamResult = 0;
	self.mExamIndex = exam_index;
	self.mExamNumber = exam_number;
end

function PromoteExamBaseVO:GetExamView(  )
	return "PromoteExamBaseView";
end

function PromoteExamBaseVO:GetAnswerVO(  )
	
end

function PromoteExamBaseVO:GetExamTypeInfo(  )
	return mConfigSyspromote_examine_type[self.mSysVO.type];
end

function PromoteExamBaseVO:GetCurrentView(  )
	local exam_type = self.mSysVO.type;
	local phase_status = self.mPhaseStatus;
	if phase_status == 0 then
		return "promote_begin_view", "PromoteBeginView";
	elseif phase_status == 1 and (exam_type == 1 or exam_type == 2)then
		return "promote_answer_view", "PromoteAnswerView";
	elseif phase_status == 2 then
		return "promote_score_view", "PromoteScoreView";
	end
end

function PromoteExamBaseVO:UpdateExamInfo( pbSignInfo )
	self.mPhaseStatus = pbSignInfo.phase_status;
	self.mLeftTime = pbSignInfo.left_time + self.mSysVO.time;
	self.mCurrentNumber = pbSignInfo.current_num;
	self.mTotalNumber = pbSignInfo.total_num;
	self.mQuestionID = pbSignInfo.qustion_id;
	self.mExamResult = pbSignInfo.result;
end

function PromoteExamBaseVO:GetProgress(  )
	return string.format('%d/%d', self.mCurrentNumber, self.mSysVO.question_number);
end

function PromoteExamBaseVO:IsExamOver(  )
	return self.mPhaseStatus == 2;
end

function PromoteExamBaseVO:IsFinalExam( )
	return self.mExamIndex >= self.mExamNumber;
end

function PromoteExamBaseVO:GetScoreTitle( )
	local exam_type = self.mSysVO.type;
	if exam_type == 3 then
		return mLGEvaluate1;
	elseif exam_type == 4 then
		return mLGEvaluate2;
	else
		return mLGEvaluate3;
	end
end

function PromoteExamBaseVO:GetAgainCost(  )
	return self.mSysVO.again_cost;
end

function PromoteExamBaseVO:GetGradeScore(  )
	local exam_type = self.mSysVO.type;
	if exam_type == 1 or exam_type == 2 then
		return self.mExamResult * 100 / self.mTotalNumber;
	else
		return self.mExamResult;
	end 
end

function PromoteExamBaseVO:GetGradeLevel(  )
	local grades = self:GetExamTypeInfo().grade_level;
	local result = self:GetGradeScore();

	for k, v in pairs(grades) do
		if result >= v then
			return k;
		end
	end
	return 4;
end

function PromoteExamBaseVO:GetExamResult(  )
	return self.mExamResult, mStringUtils:Utf8sub(mLGResult, self:GetGradeLevel(), 1);
end

return PromoteExamBaseVO;