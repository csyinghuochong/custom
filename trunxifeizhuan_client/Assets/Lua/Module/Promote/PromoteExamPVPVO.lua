local mLuaClass = require "Core/LuaClass"
local mPromoteExamBaseVO = require "Module/Promote/PromoteExamBaseVO"
local PromoteExamPVPVO = mLuaClass("PromoteExamPVPVO", mPromoteExamBaseVO);
local mSuper;

--武考--
function PromoteExamPVPVO:OnLuaNew(vo, exam_index, exam_number)
	
	mSuper = self:GetSuper(mPromoteExamBaseVO.LuaClassName);
  	mSuper.OnLuaNew(self, vo, exam_index, exam_number);

end

return PromoteExamPVPVO;