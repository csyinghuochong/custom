local ObjectPool = require "Common/ObjectPool"
local mDoFileUtil = require "Utils/DoFileUtil";
local Actor = require "Battle/Actor"

local function SyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Skill/"..config.cls).LuaNew(config);
end

local function ClearCallBack(object)
	object:Dispose();
end


local function BulletSyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Bullet/"..config.cls).LuaNew(config);
end

local function BuffSyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Buff/"..config.cls).LuaNew(config);
end

local function EffectSyncCallBack(config)
	return mDoFileUtil:DoFile("Battle/Effect/"..config.cls).LuaNew(config);
end

local function ActorSyncCallBack(config)
	return Actor.LuaNew(config);
end

local SkillActionPool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);

local SkillEffectPool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);

local BulletPool = ObjectPool.LuaNew(BulletSyncCallBack,nil,ClearCallBack);

local BuffPool = ObjectPool.LuaNew(BuffSyncCallBack,nil,ClearCallBack);

local EffectPool = ObjectPool.LuaNew(EffectSyncCallBack,nil,ClearCallBack);

local ActorPool = ObjectPool.LuaNew(ActorSyncCallBack,nil,ClearCallBack);

local PoolManager = {
	mSkillActionPool = SkillActionPool;
	mSkillEffectPool = SkillEffectPool;
	mBulletPool = BulletPool;
	mEffectPool = EffectPool;
	mBuffPool = BuffPool;
	mActorPool = ActorPool;
}

return PoolManager;
