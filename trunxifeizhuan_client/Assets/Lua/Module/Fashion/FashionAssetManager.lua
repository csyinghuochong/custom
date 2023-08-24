local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mAssetManager = require "AssetManager/AssetManager"
local mResourceUrl = require("AssetManager/ResourceUrl")
local FashionAssetManager = mLuaClass("FashionAssetManager",BaseLua);
local SkinnedMeshRendererType = typeof(UnityEngine.SkinnedMeshRenderer);
local mRoleFashionPath = mResourceUrl.GetRolePath() .."fashion/";

function FashionAssetManager:InternalLoadAsset(path,component,callback)

	local fileName = component.asset;
	local assets = self.mFashionAssets;
	if not assets then
		assets = {};
		self.mFashionAssets = assets;
	end

	local fashion = assets[fileName];

	if fashion then
		if callback then
			if fashion.mLoadCompleted then
				callback(fashion);
			else
				fashion.mCallbacks[callback] = callback;
			end
		end
	else
		fashion = {};
		fashion.mPosition = component.position;
		assets[fileName] = fashion;
		local callbacks = {}
		if callback then
			callbacks[callback] = callback;
		end
		fashion.mCallbacks = callbacks;
		local loaded_fashion = function (go)
			fashion.mAsset = go;
			fashion.mInfos = self:GetSkinnedMeshInfos(go);
			fashion.mLoadCompleted = true;
		    fashion.mCallbacks = nil;
		    for k,v in pairs(callbacks) do
		    	v(fashion);
		    end
		end
		mAssetManager.LoadTextureExternal(path,fileName, loaded_fashion);
	end
end

function FashionAssetManager:LoadFashionAsset(component,callback)
	self:InternalLoadAsset(mRoleFashionPath,component,callback);
end

function FashionAssetManager:GetBones(smr)
	
	local len = smr.bones.Length;
	local bones = {};
	if len > 0 then

		for i = 0, len - 1 do
			bones[i] = smr.bones[i].name;
	    end
	end
	return bones;
end

function FashionAssetManager:GetMaterials(smr)
	
	local len = smr.sharedMaterials.Length;
	local materials = {};
	if len > 0 then
		for i = 0, len - 1 do
			materials[i] = smr.sharedMaterials[i];
	    end
	end
	return materials;
end

function FashionAssetManager:GetSkinnedMeshInfos(go)
	
	local smrs = go:GetComponentsInChildren(SkinnedMeshRendererType,true);
	local len = smrs.Length;
	local infos = {};
	if len > 0 then	
		for i = 0, len - 1 do
	        local info = {};
	        local smr = smrs[i];
	        local mesh = smr.sharedMesh;
	        if mesh then
				info.mesh = mesh;
				info.subMeshCombineInstances = {};
				info.bones = self:GetBones(smr);
				info.materials = self:GetMaterials(smr);
				info.name = smr.name;
				info.uv = mesh.uv;
				infos[i] = info;
			else
				Debugger.LogError(string.format("时装资源[%s]中mesh为空,检查资源",smr.name));
			end
	    end
	end
	return infos;
end

function FashionAssetManager:Dispose()
	self.mFashionAssets = nil;
end

return FashionAssetManager.LuaNew();