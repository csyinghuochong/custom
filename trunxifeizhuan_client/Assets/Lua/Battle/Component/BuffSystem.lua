local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local Buff = require "Battle/Buff/Buff"
local List = require "Common/List"
local mNotifyEnum = require"Enum/NotifyEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mDoFileUtil = require "Utils/DoFileUtil";
local mBuffManager = require "Battle/Manager/BuffManager";
local BuffSystem = LuaClass("BuffSystem",ActorObserver);
local pairs = pairs;
local ipairs = ipairs;
local math = math;


function BuffSystem:Awake()
	self.mBuffs = {};
	self.mStates = {};
	self.mBuffsOfType = {};
	self.mImmuneStates = {};
	self.mImmuneStateTypes = {};
	self:AddObservers();
end

function BuffSystem:AddObservers()
	self:RegisterListener(mNotifyEnum.OnStartRound,function ()
		self:OnStartRound();
	end);
	self:RegisterListener(mNotifyEnum.OnEndRound,function ()
		self:OnEndRound();
	end);
	self:RegisterListener(mNotifyEnum.OnBeKilled,function ()
		self:RemoveAll();
	end);
	self:RegisterListener(mNotifyEnum.OnClearStage,function (params)
		self:OnClearStage(params);
	end);
	self:RegisterListener(mNotifyEnum.OnModifyBuffTime,function (params)
		self:ModifyBuffTime(params[1],params[2]);
	end);
	self:RegisterListener(mNotifyEnum.AddBuff,function (buff)
		self:AddBuff(buff);
	end);
	self:RegisterListener(mNotifyEnum.RemoveBuff,function (buff)
		self:RemoveBuff(buff);
	end);
end

function BuffSystem:OnClearStage(params)
	local remove_buff = params.remove_buff or 0;
	if remove_buff == 1 then
		local buffs = self.mBuffs;
		local owner = self:GetActor();
		for k,v in pairs(buffs) do
			if v:CanRemoveWhenClearStage() then
				self:RemoveBuff(v);
			end
		end
	end
end

function BuffSystem:RemoveAll()
	local buffs = self.mBuffs;
	local owner = self:GetActor();
	for k,v in pairs(buffs) do
		self:RemoveBuff(v);
	end
end

function BuffSystem:AddBuff(buff)
	
	self.mBuffs[buff] = buff;
	self:AddState(buff:GetStateType());
	self:AddBuffToType(buff:GetBuffType(),buff);

	buff:Start();

	self:GetActor():Notify(mNotifyEnum.OnAddBuff,buff);
end

function BuffSystem:RemoveBuff(buff)
	self.mBuffs[buff] = nil;
	self:RemoveState(buff:GetStateType());
	self:RemoveBuffFromType(buff:GetBuffType(),buff);

	buff:Finish();
	mBuffManager:PutBuff(buff);

	self:GetActor():Notify(mNotifyEnum.OnRemoveBuff,buff);
end

function BuffSystem:GetStateCount(stateType)
	return self.mStates[stateType] or 0;
end

function BuffSystem:ContainsOneOfStates(stateTypes)
	if stateTypes then
		local states = self.mStates;
		for k,v in pairs(stateTypes) do
			if states[v] then
				return true;
			end
		end
	end

	return false;
end

function BuffSystem:ModifyBuffTime(buffType,t)
	local buffsOfType = self:GetBuffsOfType(buffType);
	if buffsOfType then
		local callback = function (buff)
		    buff:ModifyTime(t);
		end
		buffsOfType:ReForeach(callback);
	end
end

function BuffSystem:GetBuffsOfType(buffType)
	return self.mBuffsOfType[buffType];
end

function BuffSystem:AddBuffsOfType(buffType,buffsOfType)
	self.mBuffsOfType[buffType] = buffsOfType;
end

function BuffSystem:AddBuffToType(buffType,buff)
	local buffsOfType = self:GetBuffsOfType(buffType);
	if not buffsOfType then
		buffsOfType = List.LuaNew();
		self:AddBuffsOfType(buffType,buffsOfType);
	end

	buffsOfType:Add(buff);
end

function BuffSystem:RemoveBuffFromType(buffType,buff)
	local buffsOfType = self:GetBuffsOfType(buffType);
	if buffsOfType then
		buffsOfType:Remove(buff);
	end
end

function BuffSystem:HaveBuffType(buffType)
	local buffsOfType = self:GetBuffsOfType(buffType);
	if buffsOfType then
		return buffsOfType.mLength > 0;
	end
	return false;
end

function BuffSystem:HaveBuffTypeMaskState(buffType,mask)
	local result = false;
	if buffsOfType then
		local callback = function (buff)
		   result = buff:IsState(mask);
		   return result;
		end
		buffsOfType:Foreach(callback);
	end
	return result;
end

function BuffSystem:AddState(stateType)

	if stateType < 1 then
		return;
	end
	local states = self.mStates;
	local state = states[stateType];
	if state then
		states[stateType] = state + 1;
	else
		states[stateType] = 1;
	end
end

function BuffSystem:RemoveState(stateType)

	if stateType < 1 then
		return;
	end
	local states = self.mStates;
	local state = states[stateType];
	if not state then
		return;
	end
	state = state - 1;
	if state < 1 then
		state = nil;
	end
	states[stateType] = state;
end

function BuffSystem:OnStartRound()
	local buffs = self.mBuffs;
	for k,v in pairs(buffs) do
		v:StartRound();
	end
end

function BuffSystem:OnEndRound()
	local buffs = self.mBuffs;
	for k,v in pairs(buffs) do
		v:EndRound();
	end
end

return BuffSystem;