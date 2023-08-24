local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffPoisoned = LuaClass("BuffPoisoned",Buff);
local PoisonHit = require "Battle/Skill/SkillHit/PoisonHit"

function BuffPoisoned:OnStart()
	self.mSkillHit = PoisonHit.LuaNew(self.mSkill,self.mConfig.value);
end

function BuffPoisoned:OnStartRound()
	self.mSkillHit:Excute(self.mOwner);
	if self:GetRemainRound() < 1 then
		self:SendFinish();
	end
end 

return BuffPoisoned;