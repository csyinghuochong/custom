local LuaClass = require "Core/LuaClass";
local SkillActionManager = LuaClass("SkillActionManager");
local ObjectPool = require "Common/ObjectPool";
local ActionManager = require"Battle/Manager/ActionManager";
local mDoFileUtil = require "Utils/DoFileUtil";
local mConfigSysskill_action = require"ConfigFiles/ConfigSysskill_action"

local function SyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Skill/Action/"..config.cls).LuaNew(config);
end

local function ClearCallBack(object)
	object:Dispose();
end

function SkillActionManager:OnLuaNew()
	local pool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);
	self.mObjectPool = pool;

	local startCallback = function (action,logicParams)
		action:Start(logicParams);
	end

	local putCallback = function (action)
		action:Dispose();
		pool:Put(action,action.mConfig);
	end
	self.mActionManager = ActionManager.LuaNew(startCallback,putCallback);
end



function SkillActionManager:StartAction(action,logicParams)
	self.mActionManager:StartAction(action,logicParams);
end

function SkillActionManager:EndAction(action)
	self.mActionManager:EndAction(action);
end

function SkillActionManager:GetAction(config)
	return self.mObjectPool:Get(config);
end

function SkillActionManager:GetActionById(id)

	local config = self:GetActionConfig(id);

	if not config then
		return nil;
	end

	return self:GetAction(config);
end

function SkillActionManager:GetActionConfig(id)
	if id == 0 then
		return nil;
	end

	return mConfigSysskill_action[id];
end

function SkillActionManager:Dispose()
	self.mObjectPool:ClearPool();
	self.mActionManager:Dispose();
end

return SkillActionManager.LuaNew();