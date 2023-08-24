local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Queue = require "Common/Queue"

local ObjectPool = LuaClass("ObjectPool",BaseLua);
local Pairs = pairs;

function ObjectPool:OnLuaNew(syncCallBack,asyncCallBack,ClearCallBack)
	self.mReferences = {};
	self.mSyncCallBack = syncCallBack;
	self.mAsyncCallBack = asyncCallBack;
	self.mClearCallBack = ClearCallBack;
end

function ObjectPool:Get(v,callBack)
	local key = v or self;
	local references = self.mReferences;
	local objects = references[key];
	if objects == nil or objects.mCount == 0 then
		if callBack ~= nil then
			self.mAsyncCallBack(key,callBack);
		else
			return self.mSyncCallBack(key);
		end
	end

	return objects:Dequeue();
end

function ObjectPool:Put(object,v)
	local key = v or self;
	local references = self.mReferences;
	local objects = references[key];

	 if objects == nil then
	 	objects = Queue:New();
	 	references[key] = objects;
	 end

	 objects:Enqueue(object);
end

function ObjectPool:ClearPool()
	local references = self.mReferences;
	local clearCallBack = self.mClearCallBack;

	for k,queue in Pairs(references) do

		if clearCallBack then
			for _,v in Pairs(queue.mData) do
				clearCallBack(v);
			end
		end

		references[k] = nil;
	end
end

return ObjectPool;