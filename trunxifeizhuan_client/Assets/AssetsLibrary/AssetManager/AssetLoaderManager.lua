local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Bundle = require("AssetManager/Bundle")
local MainBundle = require("AssetManager/MainBundle")
local LoadTask = require "AssetManager/LoadTask"
local AssetLoaderManager = LuaClass("AssetLoaderManager",BaseLua);
local mpairs = pairs;
local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;
local mIsMobilePlatform = not mIsEditor;
local mipairs = ipairs
local tableInsert = table.insert;
local tableRemove = table.remove;

function AssetLoaderManager:OnLuaNew()
	self.mMaxLoadCount = 30;
	self.mCurLoadCount = 0;
	self.mTasks = {};
	self.mAllBundles = {};
	self.mMainBundles = {};
	self.mDependBundles = {};
	self.mBundleLoadTaskList = {};
end

function AssetLoaderManager:UnloadBundles(reLogin)
	for k,v in mpairs(self.mMainBundles) do
		v:CheckUnload(reLogin);
	end

	for k,v in mpairs(self.mDependBundles) do
		v:CheckUnload();
	end
end

function AssetLoaderManager:GetBundle(bundlePath,isMainBundle)
	local bundles = self.mAllBundles;
    local bundle = bundles[bundlePath];

	if bundle == nil then
		if isMainBundle then
			bundle = MainBundle.LuaNew(bundlePath);
			self.mMainBundles[bundlePath] = bundle;
		else
			bundle = Bundle.LuaNew(bundlePath);
			self.mDependBundles[bundlePath] = bundle;
		end
	    
	    bundles[bundlePath] = bundle;
	end

	return bundle;
end

function AssetLoaderManager:SetLoadAllFinishCallBack(callback)
	if #self.mTasks == 0 then
		callback();
		return;
	end
	
	self.mLoadAllFinishCallBack = callback;
end

function AssetLoaderManager:GetDependBundles(assetBundleName,getPathFunc,getDependenciesFunc)
	local dependencies = getDependenciesFunc(assetBundleName);
	local dependBundles = {};

	local len = dependencies.Length;
	if len > 0 then
		for i = 0, len - 1 do
	        dependBundles[i] = self:GetBundle(getPathFunc(dependencies[i]));
	    end
	end

	return dependBundles;
end

function AssetLoaderManager:LoadAsset(path,fileName,callback,getPathFunc,getDependenciesFunc,loadAssetFunc)
	if mIsEditor == true then
		if fileName ~= string.lower(fileName) then
			error(fileName .. " 名字不能包含大写字母")
		end
	end

	local assetBundleName = path..fileName;
	local assetBundlePath = getPathFunc(assetBundleName);
	local mainBundle = self:GetBundle(assetBundlePath,true);

	local runningLoadTask = self.mBundleLoadTaskList[mainBundle];
	if runningLoadTask then
		runningLoadTask:AddParams(fileName,loadAssetFunc,callback);
		return;
	end

	if mainBundle.mLoadCompleted then
		mainBundle:LoadParams(fileName,loadAssetFunc,callback);
		return;
	end

	if mIsMobilePlatform and callback then
		mainBundle.mPreloadAssetName = fileName;
	end

	local dependBundles = self:GetDependBundles(assetBundleName,getPathFunc,getDependenciesFunc);
    mainBundle:SetDependBundles(dependBundles);

	local  loadTask = LoadTask.LuaNew(mainBundle,dependBundles);
	loadTask:AddParams(fileName,loadAssetFunc,callback);

	self.mBundleLoadTaskList[mainBundle] = loadTask;
	tableInsert(self.mTasks,1,loadTask);
	self:StartLoadTask();
end

function AssetLoaderManager:Update()
	local tasks = self.mTasks;
	local taskCount = #tasks;
	if taskCount > 0 then
		local startLoad = false;
		local loadTask = nil;
		for i=taskCount,1,-1 do
			loadTask = tasks[i];
			if loadTask:CheckLoad() then
				startLoad = true;
				self.mCurLoadCount = self.mCurLoadCount - loadTask.mLoadCount;
				tableRemove(tasks,i);
				self.mBundleLoadTaskList[loadTask.mMainBundle] = nil;
				loadTask:LoadComplete();
			else
				if startLoad then
					self:StartLoadTask();
				end
				return;
			end
		end

		if startLoad then
			self:StartLoadTask();
		end
	end
end

function AssetLoaderManager:StartLoadTask()
	local tasks = self.mTasks;
	local taskCount = #tasks;
	local maxCount = self.mMaxLoadCount;
	local curCount = self.mCurLoadCount;
	if taskCount > 0 then
		if curCount < maxCount then
			local loadTask = nil;
			for i=taskCount,1,-1 do
				loadTask = tasks[i];
				if loadTask.mLoadCount == 0 then
					curCount = curCount + loadTask:StartLoad();

					if curCount >= maxCount then
						self.mCurLoadCount = curCount;
						return;
					end
				end
			end

			self.mCurLoadCount = curCount;
		end
	else
		local callback = self.mLoadAllFinishCallBack;
		if callback then
			self.mLoadAllFinishCallBack = nil;
			callback();
		end
	end
end

return AssetLoaderManager.LuaNew();