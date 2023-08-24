local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mGetURL = mResourceUrl.GetUrl;
local Bundle = LuaClass("Bundle",BaseLua);
local WWW = UnityEngine.WWW;
local Pairs = pairs;
local mIsEditor = UnityEngine.Application.isEditor;
function Bundle:OnLuaNew(path)
	self.mPath = path;
	self.mLoadCompleted = false;
	self.mRefCount = 0;
	self.mHostBundles = {};
end

function Bundle:StartLoad()
	local www = self.mWWW;
	if www == nil then
		www = WWW(mGetURL(self.mPath));
		self.mWWW = www;
		return 1;
	end

	return 0;
end

function Bundle:CheckLoad()
	if self.mLoadCompleted then
		return true;
	end

	local www = self.mWWW;
	if www and www.isDone then
		if www.error == nil then
			self.mBundle = www.assetBundle;
			--print("-------------------download success:",self.mPath,www.url,www.bytes.Length / (1024 * 1024));
		else
			print("------------------download error:",self.mPath)
			
			if mIsEditor then
				error(www.error);
			end
		end
		
		self.mLoadCompleted = true;
		self.mWWW = nil;
		www:Dispose();
		return true;
	end
	return false;
end

function Bundle:AddRef(hostBundle)
	self.mRefCount = self.mRefCount + 1;
	self.mHostBundles[hostBundle] = hostBundle;
end

function Bundle:ReduceRef(hostBundle)
	self.mRefCount = self.mRefCount - 1;
	self.mHostBundles[hostBundle] = nil;
end

function Bundle:CheckUnload()
	if self.mBundle == nil then
		return;
	end
	
	if self.mRefCount == 0 then
		self:Dispose(true);
		--print("CheckUnload Bundle--------------Dispose",self.mPath);
	else
		--[[ 
		
		local hostPaths = "";
		for k,v in pairs(self.mHostBundles) do
			hostPaths = hostPaths .. "###" .. k.mPath;
		end
		print("CheckUnload Bundle",self.mPath,self.mRefCount,hostPaths);

		--]]
	end
end

function Bundle:Dispose(unloadAllLoadedObjects)
	local bundle = self.mBundle;
	if bundle == nil then
		return;
	end

	bundle:Unload(unloadAllLoadedObjects);
	self.mLoadCompleted = false;
	self.mBundle = nil;
	self.mWWW = nil;
	self.mRefCount = 0;
end

return Bundle;
