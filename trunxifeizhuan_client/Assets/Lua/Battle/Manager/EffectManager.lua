
local LuaClass = require "Core/LuaClass";
local EffectManager = LuaClass("EffectManager");
local ObjectPool = require "Common/ObjectPool";
local ActionManager = require"Battle/Manager/ActionManager";
local mDoFileUtil = require "Utils/DoFileUtil";
local mConfigSyseffect = require"ConfigFiles/ConfigSyseffect";
local DebugHelper = DebugHelper;
local mIsEditor = UnityEngine.Application.isEditor;

local function SyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Effect/"..config.cls).LuaNew(config);
end

local function ClearCallBack(object)
	object:Dispose();
end

local mCommonEffects = 
{
	mRecover = mConfigSyseffect[1];
	mDead = mConfigSyseffect[2];
	mShadow = mConfigSyseffect[3];
	mUnder = mConfigSyseffect[4];
	mSelectedTarget = mConfigSyseffect[5];
	mBorn = mConfigSyseffect[6];
};

function EffectManager:OnLuaNew()

	local pool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);
	self.mObjectPool = pool;
	self.mCommonEffects = mCommonEffects;

	local startCallback = function (effect,logicParams)
		effect:Show(logicParams);
	end

	local putCallback = function (effect)
		effect:Dispose();
		pool:Put(effect,effect.mConfig);
	end
	self.mActionManager = ActionManager.LuaNew(startCallback,putCallback);
end

function EffectManager:ShowEffect(effect,logicParams)
	if DebugHelper.sDisableEffect then
		return;
	end
	if mIsEditor then
		if effect:Assert(logicParams) == false then
			return;
		end
	end

	self.mActionManager:StartAction(effect,logicParams);
end

function EffectManager:HandleShowEffect(id,logicParams)
	local effect = self:GetEffectById(id);
	if effect then
		self:ShowEffect(effect,logicParams);
	end
end

function EffectManager:HideEffect(effect)
	self.mActionManager:EndAction(effect);
end

function EffectManager:GetEffect(config)
	return self.mObjectPool:Get(config);
end

function EffectManager:GetEffectById(id)

	local config = self:GetEffectConfig(id);

	if not config then
		return nil;
	end

	return self:GetEffect(config);
end

function EffectManager:GetEffectConfig(id)
	if id == 0 then
		return nil;
	end

	return mConfigSyseffect[id];
end

function EffectManager:Dispose()
	self.mObjectPool:ClearPool();
	self.mActionManager:Dispose();
end

return EffectManager.LuaNew();