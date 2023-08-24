
local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Queue = require"Common/Queue"
local LoadTask = LuaClass("LoadTask",BaseLua);
local mipairs = ipairs
local mpairs = pairs

function LoadTask:OnLuaNew(mainBundle, dependBundles)
	self.mMainBundle = mainBundle;
	self.mDependBundles = dependBundles;
	self.mLoadCount = 0;
	self.mParamsList = Queue:New();
end

function LoadTask:AddParams(objectName,loadObjectFunc,loadedCallBack)
	self.mParamsList:Enqueue({[1]=objectName,[2]=loadObjectFunc,[3]=loadedCallBack});
end

function LoadTask:LoadParams(objectName,loadObjectFunc,loadedCallBack)
	self.mMainBundle:LoadParams(objectName,loadObjectFunc,loadedCallBack);
end

function LoadTask:LoadComplete()
	local paramList = self.mParamsList.mData;
	for i,paramObject in mipairs(paramList) do
		self:LoadParams(paramObject[1],paramObject[2],paramObject[3]);
	end
end

function LoadTask:StartLoad()
	local count = 0;
	local dependBundles = self.mDependBundles;
	if dependBundles then
		for k,v in mpairs(dependBundles) do
			local startStatus = v:StartLoad();
			count = count + startStatus;
		end
	end
	count = count + self.mMainBundle:StartLoad();
	self.mLoadCount = count;

	return count;
end

function LoadTask:CheckLoad()
	local mainBundle = self.mMainBundle;
	if not mainBundle:CheckLoad() then
		return false;
	end

	local dependBundles = self.mDependBundles;
	if dependBundles then
		for k,v in mpairs(dependBundles) do
			if v:CheckLoad() == false then
				return false;
			end
		end
	end

	return mainBundle:CheckBundlePreloadAsset();
end

return LoadTask;