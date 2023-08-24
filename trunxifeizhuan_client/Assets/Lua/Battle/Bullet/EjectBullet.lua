local LuaClass = require "Core/LuaClass"
local Bullet = require "Battle/Bullet/Bullet"
local List = require "Common/List"
local EjectBullet = LuaClass("EjectBullet",Bullet);
local math = math;

local function RandomSort(a,b)
	return a.mRandomSort < b.mRandomSort;
end

function EjectBullet:SetParams(skill,target,affect)
	self.mSkill = skill;
	self.mAffect = affect;
	self:SetTarget(target,self:GetFirePoint(skill.mOwner));
	self:InitTargets(target);
end

function EjectBullet:InitTargets(target)
	local targets = List.LuaNew();
	local teamMates = target:GetTeamMates();
	teamMates:Foreach(function (actor)
		if actor ~= target then
			actor.mRandomSort = math.random(0,100);
			targets:Add(actor);
		end
	end);
	targets:Sort(RandomSort);
	self.mTargets = targets;
end

function EjectBullet:GetNextTarget()
	local targets = self.mTargets;
	if targets:GetLen() > 0 then
		local target = targets:GetValue(1);
		targets:RemoveAt(1);
		return target;
	end
end

function EjectBullet:OnArrived(position)
	local nextTarget = self:GetNextTarget();
	if nextTarget then
		self:SetTarget(nextTarget,position);
	else
		self.mArrived = true;
	end
end

return EjectBullet;