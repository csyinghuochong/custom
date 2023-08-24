local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local SkillCheck = LuaClass("SkillCheck",BaseLua);

local pairs = pairs;
local function ExcuteList(list,callback,exceptTarget)
	if not list then
		return;
	end
	local foreachCallback = function (actor)
	    if actor ~= exceptTarget then
	    	callback(actor);
	    end
	end
	list:Foreach(foreachCallback);
end

local function Team(skill,callback)
	ExcuteList(skill.mTarget:GetTeamMates(),callback);
end

local function MyTeam(skill,callback)
	ExcuteList(skill.mOwner:GetTeamMates(),callback);
end

local function TeamExceptTarget(skill,callback)
	local target = skill.mTarget;
	ExcuteList(target:GetTeamMates(),callback,target);
end

local function Whole(skill,callback)
	ExcuteList(skill.mOwner:GetTotalAliveActors(),callback);
end

local function Part(skill,callback)
end

local function Single(skill,callback)
	callback(skill.mTarget);
end

local function RandomHurt(skill,callback)

	local list = skill.mTarget:GetTeamMates();
	if list then
		local actor = list:GetRandomValue();
		if actor then
			actor:AddBeRandomAttackCount();
			callback(actor);
		end
	end
end

local function CompareLessHealth(a,b)
	return a:GetHealthPersent() < b:GetHealthPersent();
end

local function LowerHealthOfMyTeam(skill,callback,params)
	local list = skill.mOwner:GetTeamMates();
	if list then
		local len = list.mLength;
		if len > 0 then
			list:Sort(CompareLessHealth);
			callback(list:GetValue(params[3] or 1));
		end
	end
end

local mChecks = {
	[1] = Team;
	[2] = Part;
	[3] = Single;
	[4] = RandomHurt;
	[5] = Whole;
	[6] = LowerHealthOfMyTeam;
	[7] = TeamExceptTarget;
	[8] = MyTeam;
}


function SkillCheck:DoCheck(skill,parameters,callback)
	local checkType = parameters[1];
	local func = mChecks[checkType];
	if func then
		func(skill,callback,parameters);
	end
end

return SkillCheck.LuaNew();