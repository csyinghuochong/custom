local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local TransferHurt = LuaClass("TransferHurt",ActorObserver);
local mSkillResultEnum = require "Enum/SkillResultEnum"

function TransferHurt:SetTransfer(actor,reduce_rate)
	self.mTransfer = actor;
	self.mReduceRate = reduce_rate;
end

function TransferHurt:GetTransfer()
	return self.mTransfer;
end

function TransferHurt:GetReduceRate()
	return self.mReduceRate;
end

function TransferHurt:RemoveTransfer()
	self.mTransfer = nil;
end

return TransferHurt;