local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffShield = LuaClass("BuffShield",Buff);
local mNotifyEnum = require"Enum/NotifyEnum"

function BuffShield:OnStart()
	self:RegisterListener(mNotifyEnum.OnShieldReduceHurt,function (result)
		self:OnRedcue(result);
	end);

	if self.mOtherParams[1] == 1 then
		self.mReduce = self.mOwner:GetHealthLimit() * self:GetValue();
	else
		self.mReduce = self.mOwner:GetLevel() * self:GetValue();
	end
	
end

function BuffShield:OnRedcue(result)
	local hurt = result.hurt;
	local reduce = self.mReduce;
	local remainHurt = hurt - reduce;
	if remainHurt > 0 then
		result.reduce = reduce;
		self.mReduce = 0;
		self:SendFinish();
	else
		result.reduce = hurt;
		self.mReduce = -remainHurt;
	end
end


return BuffShield;