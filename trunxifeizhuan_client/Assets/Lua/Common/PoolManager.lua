local ObjectPool = require "Common/ObjectPool"
local mDoFileUtil = require "Utils/DoFileUtil";
local GameObject = UnityEngine.GameObject;
local RenderTexture = UnityEngine.RenderTexture;

local function ClearCallBack(object)
	object:Dispose();
end

local function ClearViewCallBack(object)
	object:CloseView();
end

local function SyncCallback(cls)
	return mDoFileUtil:DoFile(cls).LuaNew();
end

local function GetRenderTexture()
	--print("---------GetRenderTexture");
	local renderTexture = RenderTexture.New(1024, 1024, 24);
	if mIsEditor then
		renderTexture.antiAliasing = 8;
	else
		renderTexture.antiAliasing = 2;
	end

	return renderTexture;
end

local function ClearRenderTexture(rt)
	--print("---------ClearRenderTexture");
	GameObject.DestroyImmediate(rt);
end

local BaseViewPool = ObjectPool.LuaNew(SyncCallback,nil,ClearViewCallBack);
local BaseObjectPool = ObjectPool.LuaNew(SyncCallback,nil,nil);
local MaterialPool = ObjectPool.LuaNew(MaterialCallback,nil,ClearMaterial);
local RenderTexturePool = ObjectPool.LuaNew(GetRenderTexture,nil,ClearRenderTexture);

local PoolManager = {
	mBaseObjectPool = BaseObjectPool,
	mBaseViewPool = BaseViewPool,
	mGameObjectPool = require "AssetManager/GameObjectPool",
	mRenderTexturePool = RenderTexturePool,
}

function PoolManager:Dispose()
	self.mBaseViewPool:ClearPool();
	self.mGameObjectPool:ClearPool();
	self.mRenderTexturePool:ClearPool();
end

return PoolManager;
