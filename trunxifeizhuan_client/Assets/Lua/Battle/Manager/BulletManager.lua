local LuaClass = require "Core/LuaClass";
local BulletManager = LuaClass("BulletManager");
local ObjectPool = require "Common/ObjectPool";
local ActionManager = require"Battle/Manager/ActionManager";
local mDoFileUtil = require "Utils/DoFileUtil";
local mConfigSysskill_bullet = require"ConfigFiles/ConfigSysskill_bullet"

local function SyncCallBack(config)
	--config.cls = "ParaBullet";
	return mDoFileUtil:DoFile("Battle/Bullet/"..config.cls).LuaNew(config);
end

local function ClearCallBack(object)
	object:Dispose();
end

function BulletManager:OnLuaNew()
	local pool = ObjectPool.LuaNew(SyncCallBack,nil,ClearCallBack);
	self.mObjectPool = pool;

	local startCallback = function (bullet,logicParams)
		bullet:Start(logicParams);
	end

	local putCallback = function (bullet)
		bullet:Dispose();
		pool:Put(bullet,bullet.mConfig);
	end
	self.mActionManager = ActionManager.LuaNew(startCallback,putCallback);
end



function BulletManager:FireBullet(bullet,logicParams)
	self.mActionManager:StartAction(bullet,logicParams);
end

function BulletManager:GetBullet(config)
	return self.mObjectPool:Get(config);
end

function BulletManager:GetBulletById(id)

	local config = self:GetBulletConfig(id);

	if not config then
		return nil;
	end

	return self:GetBullet(config);
end

function BulletManager:GetBulletConfig(id)
	if id == 0 then
		return nil;
	end

	return mConfigSysskill_bullet[id];
end

function BulletManager:Dispose()
	self.mObjectPool:ClearPool();
	self.mActionManager:Dispose();
end

return BulletManager.LuaNew();