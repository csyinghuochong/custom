local mLuaClass = require "Core/LuaClass"
local mPromoteExamBaseVO = require "Module/Promote/PromoteExamBaseVO"
local mConfigSyspromote_question_wen = require "ConfigFiles/ConfigSyspromote_question_wen"
local PromoteExamLetterVO = mLuaClass("PromoteExamLetterVO", mPromoteExamBaseVO);
local mSuper;

--文考--
function PromoteExamLetterVO:OnLuaNew(vo, exam_index, exam_number)
	
	mSuper = self:GetSuper(mPromoteExamBaseVO.LuaClassName);
  	mSuper.OnLuaNew(self, vo, exam_index, exam_number);

end

function PromoteExamLetterVO:GetAnswerVO(  )
	return mConfigSyspromote_question_wen[self.mQuestionID];
end

return PromoteExamLetterVO;