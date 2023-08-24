local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffRecover = LuaClass("BuffRecover",Buff);
local RecoverHealthHit = require "Battle/Skill/SkillHit/RecoverHealthHit"

function BuffRecover:OnStart()
	self.mSkillHit = RecoverHealthHit.LuaNew(self.mSkill,self.mConfig.value);
end

function BuffRecover:OnStartRound()
	self.mSkillHit:Excute(self.mOwner);
end 

return BuffRecover;