local mResourceUrl = require("AssetManager/ResourceUrl")
local mAssetLoaderManager = require("AssetManager/AssetLoaderManager")
local AssetManager = {};
local SceneManager = UnityEngine.SceneManagement.SceneManager;
local mExternalManifest = nil;--美术工程资源目录
local mManifest = nil;--游戏工程资源目录
local mInitCallback = nil;

local Yield = Yield;
local StartCoroutine = StartCoroutine;

local mAudioClipType = 0;
local mUIType = 1;
local mUIFxType = 2;
local mUITexture = 3;
local mExternalGo = 4;
local mExternalTexture = 5;
local mExternalRole = 6;

function AssetManager.Init(callback)
	mInitCallback = callback;

	StartCoroutine(AssetManager.LoadManifest);
end

function AssetManager.LoadManifest()
	local streamingAssetsStr = "StreamingAssets";
	local assetBundleManifestStr = "AssetBundleManifest"
	local AssetBundleManifestType = typeof(UnityEngine.AssetBundleManifest);
	local WWW = UnityEngine.WWW;

    local www = WWW(mResourceUrl.GetUrl(streamingAssetsStr))
    Yield(www)
    local manifestBundle = www.assetBundle;
    mManifest = manifestBundle:LoadAsset(assetBundleManifestStr,AssetBundleManifestType);
    manifestBundle:Unload(false);
    www:Dispose();

    local www1 = WWW(mResourceUrl.GetExternalUrl(streamingAssetsStr))
    Yield(www1)
    local manifestBundle1 = www1.assetBundle;
    mExternalManifest = manifestBundle1:LoadAsset(assetBundleManifestStr,AssetBundleManifestType);
    manifestBundle1:Unload(false);
    www1:Dispose();

    mInitCallback();
    mInitCallback = nil;
end

function AssetManager.GetAllDependencies(assetBundleName)
    return mManifest:GetAllDependencies(assetBundleName);
end

function AssetManager.GetAllDependenciesExternal(assetBundleName)
    return mExternalManifest:GetAllDependencies(assetBundleName);
end

function AssetManager.GetPath(assetName)
	return assetName;
end

function AssetManager.InternalLoadScene(file,callback,GetPathFunc,GetDependenciesFunc)
	mAssetLoaderManager:LoadAsset(mResourceUrl.GetScenePath(),file,callback,GetPathFunc,GetDependenciesFunc,AssetManager.LoadSceneFunc);
end

function AssetManager.InternalLoadAsset( path,file,callback,GetPathFunc,GetDependenciesFunc,loadAssetFunc)
	mAssetLoaderManager:LoadAsset(path,file,callback,GetPathFunc,GetDependenciesFunc,loadAssetFunc);
end

function AssetManager.PreLoadAssetExternal(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal,nil);
end

function AssetManager.PreLoadAsset(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,nil,AssetManager.GetPath,AssetManager.GetAllDependencies,callback);
end

function AssetManager.SetLoadAllFinishCallBack(callback)
	mAssetLoaderManager:SetLoadAllFinishCallBack(callback);
end

--加载游戏工程中的场景
function AssetManager.LoadScene(sceneName,callback)
	AssetManager.InternalLoadScene(sceneName,callback,AssetManager.GetPath,AssetManager.GetAllDependencies);
end
--加载美术工程中的场景
function AssetManager.LoadSceneExternal(sceneName,callback)
	AssetManager.InternalLoadScene(sceneName,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal);
end
--加载美术工程资源
function AssetManager.LoadObjectExternal(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal,AssetManager.LoadExternalGoFunc);
end

function AssetManager.LoadRoleExternal(file,callback)
	AssetManager.InternalLoadAsset(mResourceUrl.GetRolePath(),file,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal,AssetManager.LoadExternalRoleFunc);
end

--加载贴图资源
function AssetManager.LoadTextureExternal(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal,AssetManager.LoadExternalTextureFunc);
end

local mUIFxPath = mResourceUrl.GetFXPath("ui_fx/");
function AssetManager.LoadUIFXExternal(file,callback)
	AssetManager.InternalLoadAsset(mUIFxPath,file,callback,mResourceUrl.GetExternalPath,AssetManager.GetAllDependenciesExternal,AssetManager.LoadUIFxObjectFunc);
end

function AssetManager.LoadUI(path,file,callback )
	AssetManager.InternalLoadAsset(path,file,callback,AssetManager.GetPath,AssetManager.GetAllDependencies,AssetManager.LoadUIObjectFunc);
end

--加载贴图资源
function AssetManager.LoadTexture(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,callback,AssetManager.GetPath,AssetManager.GetAllDependencies,AssetManager.LoadUIIconObjectFunc);
end

--加载音效
function AssetManager.LoadAudioClip(path,file,callback)
	AssetManager.InternalLoadAsset(path,file,callback,AssetManager.GetPath,AssetManager.GetAllDependencies,AssetManager.LoadAudioClipObjectFunc);
end

function AssetManager.UnityLoadScene(sceneName,callback)
	AssetManager.LoadScene(sceneName,callback);
	
	-- local unityLoadScene = function ()
	-- 	AssetManager.LoadSceneAsync(sceneName,callback);
	-- end
	-- StartCoroutine(unityLoadScene);
end

function AssetManager.LoadSceneAsync(sceneName,callback)
	local async = SceneManager.LoadSceneAsync(sceneName);
	Yield(async);

	if callback ~= nil then
		callback();
	end
end

function AssetManager.LoadScene(sceneName,callback)
	SceneManager.LoadScene(sceneName);

	if callback ~= nil then
		callback();
	end
end

function AssetManager.LoadSceneFunc(bundle,objectName,callback)
	AssetManager.UnityLoadScene(objectName,callback);
end

function AssetManager.LoadExternalRoleFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,true,mExternalRole);
end

function AssetManager.LoadExternalGoFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,true,mExternalGo);
end

function AssetManager.LoadExternalTextureFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,false,mExternalTexture);
end

function AssetManager.LoadUIIconObjectFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,false,mUITexture);
end

function AssetManager.LoadUIFxObjectFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,true,mUIFxType);
end

function AssetManager.LoadUIObjectFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,true,mUIType);
end

function AssetManager.LoadAudioClipObjectFunc(bundle,objectName,callback)
	bundle:LoadObject(objectName,callback,false,mAudioClipType);
end

function AssetManager.Update()
	mAssetLoaderManager:Update();
end

return AssetManager;