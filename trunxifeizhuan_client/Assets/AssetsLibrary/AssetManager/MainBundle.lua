local LuaClass = require "Core/LuaClass"
local Bundle = require "AssetManager/Bundle"
local mpairs = pairs;
local Object = UnityEngine.Object;
local mTableRemove = table.remove;
local MainBundle = LuaClass("MainBundle",Bundle);
local super = nil;

local mAudioClipType = 0;
local mUIType = 1;
local mUIFxType = 2;
local mUITexture = 3;
local mExternalGo = 4;
local mExternalTexture = 5;
local mExternalRole = 6;

function MainBundle:OnLuaNew(path)
	self.mAssets = {};
	self.mInstanceReferences = {};
	super = self:GetSuper(Bundle.LuaClassName);
	super.OnLuaNew(self,path);
end

function MainBundle:CheckBundlePreloadAsset()
	local bundle = self.mBundle;
	if bundle then
		if self.mPreloadAssetName then
			local async = self.mLoadAssetAsync;
			if async then
				if async.isDone then
				    self.mAssets[self.mPreloadAssetName] = async.asset;
					return true;
				end
			else
				self.mLoadAssetAsync = bundle:LoadAssetAsync(self.mPreloadAssetName);
			end
		else
			return true;
		end
	end

	return false;
end

function MainBundle:SetDependBundles(dependBundles)
	if not self.mDependBundles then
		self.mDependBundles = dependBundles;
		self:AddDependBundlesRef();
	end
end

function MainBundle:AddDependBundlesRef()
	local dependBundles = self.mDependBundles;
    if dependBundles == nil then
       return;
    end
    
   	for k, v in mpairs(dependBundles) do
   	   v:AddRef(self);
	end
end

function MainBundle:ReduceDependBundlesRef()
	local dependBundles = self.mDependBundles;
    if dependBundles == nil then
       return;
    end
    
   	for k, v in mpairs(dependBundles) do
   	   v:ReduceRef(self);
	end
end

function MainBundle:LoadParams(objectName,loadObjectFunc,loadedCallBack)
	if loadObjectFunc then
		loadObjectFunc(self,objectName,loadedCallBack);
	end
end

function MainBundle:LoadObject(assetName,callBack,instantiate,assetType)
	if assetType ~= nil and curAssetType ~= nil and curAssetType ~= assetType then
		--error( self.mPath .. " curAssetType:" .. curAssetType .. "  assetType:" .. assetType);
	end

	self.mAssetType = assetType;

	--print(self.mPath,assetType);

	local selfAssets = self.mAssets;
	local asset = selfAssets[assetName];
	if asset == nil then
		if not self.mBundle then
			print("Bundle is null----------------------------------------------------",assetName);
		end
		asset = self.mBundle:LoadAsset(assetName);
		selfAssets[assetName] = asset;
	end

	if instantiate then
		local assetInstance = Object.Instantiate(asset);

		local references = self.mInstanceReferences;
		references[ #references + 1 ] = assetInstance;

		callBack(assetInstance);
		
	else
		callBack(asset);
	end
end

function MainBundle:CheckUnload()
	local assetType = self.mAssetType;
	if assetType == nil then
		--print("assetType == nil CheckUnload MainBundle CheckUnload",self.mPath);
		return;
	end
	
	--assetType == mUIFxType
	if assetType == mUIType or assetType == mExternalGo then
		local references = self.mInstanceReferences;
		local count = #references;
		if count > 0 then
			for i=count,1,-1 do
				local instance = references[i];
				if instance:Equals(nil) then
					mTableRemove(references,i);
					count = count - 1;
				end
			end

			if count <= 0 then
				self:Dispose(true);
			else   	
				--print("CheckUnload MainBundle",self.mPath,count);
			end
		end
	elseif assetType == mAudioClipType then
		self:Dispose(false);
	elseif assetType == mUITexture then
		self:Dispose(false);
	end
end

function MainBundle:Dispose(unloadAllLoadedObjects)
	--print("CheckUnload MainBundle--------------Dispose",self.mPath);

	super.Dispose(self,unloadAllLoadedObjects);

	local selfAssets = self.mAssets;
	for k,v in mpairs(selfAssets) do
		selfAssets[k] = nil;
	end

	self:ReduceDependBundlesRef();
	self.mDependBundles = nil;
	self.mAssetType = nil;
end

return MainBundle;