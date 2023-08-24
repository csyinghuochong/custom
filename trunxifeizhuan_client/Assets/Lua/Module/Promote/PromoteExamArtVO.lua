local mLuaClass = require "Core/LuaClass"
local mPromoteExamBaseVO = require "Module/Promote/PromoteExamBaseVO"
local mConfigSyspromote_question_yi = require "ConfigFiles/ConfigSyspromote_question_yi"
local PromoteExamArtVO = mLuaClass("PromoteExamArtVO", mPromoteExamBaseVO);
local mSuper;

--艺考--
function PromoteExamArtVO:OnLuaNew(vo, exam_index, exam_number)
	
	mSuper = self:GetSuper(mPromoteExamBaseVO.LuaClassName);
  	mSuper.OnLuaNew(self, vo, exam_index, exam_number);

end

function PromoteExamArtVO:GetAnswerVO(  )
	return mConfigSyspromote_question_yi[self.mQuestionID]; 
end

return PromoteExamArtVO;