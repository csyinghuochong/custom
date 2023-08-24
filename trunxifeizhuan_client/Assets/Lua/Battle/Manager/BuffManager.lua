local LuaClass = require "Core/LuaClass";
local BuffManager = LuaClass("BuffManager");
local ObjectPool = require "Common/ObjectPool";
local mDoFileUtil = require "Utils/DoFileUtil";
local mConfigSysskill_buff = require"ConfigFiles/ConfigSysskill_buff"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mMaxStateCount = {
	[mBuffStateEnum.State2013] = 5;
};

local function SyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Buff/"..config.cls).LuaNew(config);
end

local function ClearCallBack(object)
	object:Dispose();
end

function BuffManager:OnLuaNew()
	self.mObjectPool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);
end

function BuffManager:GetBuff(config)
	return self.mObjectPool:Get(config);
end

function BuffManager:PutBuff(buff)
	self.mObjectPool:Put(buff,buff.mConfig);
end

function BuffManager:GetBuffById(id)

	local config = self:GetBuffConfig(id);

	if not config then
		return nil;
	end

	return self:GetBuff(config);
end

function BuffManager:GetBuffConfig(id)
	if id == 0 then
		return nil;
	end

	return mConfigSysskill_buff[id];
end

function BuffManager:Dispose()
	self.mObjectPool:ClearPool();
end

function BuffManager:CanAddBuffToActor(actor,id)
	if not id then
		return false;
	end
	
	if actor.mDisposed then
		return false;
	end

	local config = mConfigSysskill_buff[id];
	local buffType = config.buff_type;
	local buffState = config.state;

	if actor:GetImmuneStateTypes()[buffType] or actor:GetImmuneStates()[buffState] then
		return false;
	end
	
	local stateCount = actor:GetStateCount(buffState);
	local maxStateCount = mMaxStateCount[buffState];
	if maxStateCount and stateCount > maxStateCount then
		return false;
	end

	return true;
end

function BuffManager:AddBuffsToActor(actor,buffs,skill)
	for k,v in pairs(buffs) do
		if self:CanAddBuffToActor(actor,v) then
			self:AddBuffToActor(actor,v,skill);
		end
	end
end

function BuffManager:AddBuffToActor(actor,id,skill)
	local buff = self:GetBuffById(id);
	buff:SetParams(id,skill);
	actor:Notify(mNotifyEnum.AddBuff,buff);
end

return BuffManager.LuaNew();