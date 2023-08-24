local mLuaClass = require "Core/LuaClass"
local mPromoteExamBaseVO = require "Module/Promote/PromoteExamBaseVO"
local PromoteExamFashionVO = mLuaClass("PromoteExamFashionVO", mPromoteExamBaseVO);
local mSuper;

--时装考试--
function PromoteExamFashionVO:OnLuaNew(vo, exam_index, exam_number)
	
	mSuper = self:GetSuper(mPromoteExamBaseVO.LuaClassName);
  	mSuper.OnLuaNew(self, vo, exam_index, exam_number);

end

return PromoteExamFashionVO;