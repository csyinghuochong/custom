local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Queue = require "Common/Queue"

local mAssetManager = require("AssetManager/AssetManager")
local GameObjectPool = LuaClass("GameObjectPool",BaseLua);
local Pairs = pairs;
local GameObject = UnityEngine.GameObject;

function GameObjectPool:OnLuaNew()
	self.mExternalReferences = {};

	self.mLoadExternal = function (path,file,callback)
		local internalCallback = function (go)
	        if callback then
	        	callback(go);
	        end
	        --GameObject.DontDestroyOnLoad(go);
	    end
		mAssetManager.LoadObjectExternal(path,file,internalCallback);
	end
end

function GameObjectPool:GetExternal(path,file,callback)
	self:InternalGet(self.mExternalReferences,path,file,callback,self.mLoadExternal);
end

function GameObjectPool:PutExternal(path,file,go)
	self:InternalPut(self.mExternalReferences,path,file,go);
end

function GameObjectPool:InternalGet(references,path,file,callback,loadFunc)
	 local objectPath = references[path];
	 if objectPath == nil then
	 	loadFunc(path,file,callback);
	 	return;
	 end

	 local objects = objectPath[file];

	 if objects == nil or objects.mCount == 0 then
	 	loadFunc(path,file,callback);
	 	return;
	 end

	 local go = objects:Dequeue();

	 if callback then
	 	callback(go);
	 end
end
function GameObjectPool:InternalPut(references,path,file,go)

	if go == nil or go:Equals(nil) then
		error("can't put a null object in pool")
		return;
	end

	 local objectPath = references[path];

	 if objectPath == nil then
	 	objectPath = {};
	 	references[path] = objectPath;
	 end

	 local objects = objectPath[file];

	 if objects == nil then
	 	objects = Queue:New();
	 	objectPath[file] = objects;
	 end

	 objects:Enqueue(go);
end

function GameObjectPool:ClearQueue(queue)
	for k,v in Pairs(queue.mData) do
		GameObject.DestroyImmediate(v);
	end
end
function GameObjectPool:ClearPath(path)
	for k,v in Pairs(path) do
		self:ClearQueue(v);
	end
end

function GameObjectPool:ClearPool()
	for k,v in Pairs(self.mExternalReferences) do
		self:ClearPath(v);
	end

	self.mExternalReferences = {};
end
return GameObjectPool.LuaNew();