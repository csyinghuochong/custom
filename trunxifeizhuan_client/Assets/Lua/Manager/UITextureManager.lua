local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mAssetManager = require "AssetManager/AssetManager"
local UITextureManager = {};
local mTextureAssets = {};

local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;
local mLoadUIAssetBundle = GameDebugConfig.loadUIAssetBundle;
local mLoadAsset = ResourceManager.LoadAsset;
local mTextureType = typeof(UnityEngine.Texture);

function UITextureManager.LoadTexture(path,file,callback)
	local fileName = path .. file;
	local assets = mTextureAssets;
	if not assets then
		assets = {};
		mTextureAssets = assets;
	end

	local texture = assets[fileName];

	if texture then
		callback(texture);
	else
		local loadCallBack = function(texture)
			assets[fileName] = texture;
			callback(texture);
		end

		if mIsEditor and mLoadUIAssetBundle == false then
			mLoadAsset(path,file .. ".png",mTextureType,loadCallBack);
		else
			mAssetManager.LoadTexture(path,file, loadCallBack);
		end
	end
end

return UITextureManager;