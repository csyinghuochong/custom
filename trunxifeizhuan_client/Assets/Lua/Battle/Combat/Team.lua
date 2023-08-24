local LuaClass = require "Core/LuaClass"
local Team = LuaClass("Team");
local List = require "Common/List"
local mEventEnum = require "Enum/EventEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local pairs = pairs;
local ipairs = ipairs;
local table = table;

function Team:OnLuaNew(combat,index)
	self.mDeadActors = List.LuaNew();
	self.mAliveActors = List.LuaNew();
	self.mTotalActors = List.LuaNew();
	self.mCombat = combat;
	self.mIndex = index;
end

function Team:OnCreateActor(actor)
	self.mTotalActors:Insert(actor);
	self:AddAliveActor(actor);
end

function Team:OnDisposeActor(actor)
	self.mTotalActors:Remove(actor);
	self:RemoveAliveActor(actor);
	self:RemoveDeadActor(actor);
end

function Team:AddAliveActor(actor)
	self.mAliveActors:Insert(actor);
	self.mCombat:OnAddAliveActor(actor);
end

function Team:RemoveAliveActor(actor)
	self.mAliveActors:Remove(actor);
	self.mCombat:OnRemoveAliveActor(actor);
end

function Team:AddDeadActor(actor)
	self.mDeadActors:Insert(actor);
	self.mCombat:OnAddDeadActor(actor);
end

function Team:RemoveDeadActor(actor)
	self.mDeadActors:Remove(actor);
	self.mCombat:OnRemoveDeadActor(actor);
end

function Team:OnActorDie(actor)
	self:RemoveAliveActor(actor);
	self:AddDeadActor(actor);
end

function Team:IsAllDie()
	return self.mAliveActors.mLength == 0;
end

function Team:OnActorRelive(actor)
	self:RemoveDeadActor(actor);
	self:AddAliveActor(actor);
end

function Team:ReliveAll()
	local callback = function (actor)
		actor:Relive(true);
	end
	self.mDeadActors:ReForeach(callback);
end

function Team:DisposeActors(list)
	if list then
		local callback = function (actor)
		    self:OnDisposeActor(actor);
		    actor:Dispose();
		end
		list:ReForeach(callback);
	end
end

function Team:DisposeDeadActors()
	self:DisposeActors(self.mDeadActors);
end

function Team:DisposeAliveActors()
	self:DisposeActors(self.mAliveActors);
end

function Team:Dispose()
	self:DisposeAliveActors();
	self:DisposeDeadActors();
end
function Team:GetTotalActors()
	return self.mTotalActors;
end

function Team:GetDeadActors()
	return self.mDeadActors;
end

function Team:GetAliveActors()
	return self.mAliveActors;
end

return Team;