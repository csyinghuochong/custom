local mLuaClass = require "Core/LuaClass"
local ArenaRuleAwardVO = mLuaClass("ArenaRuleAwardVO");

function ArenaRuleAwardVO:OnLuaNew(id , sysVO)
	self.mID = id;
	self.mSysVO = sysVO;
end

function ArenaRuleAwardVO:GetScoreRegion(  )
	local score = self.mSysVO.score
	return string.format( '%d-%d', score[1], score[2] )
end

return ArenaRuleAwardVO;