local EXTERNAL_PATH = "external/";
local SCENE_PATH = "scene/";
local FX_PATH = "fx/";
local ROLE_PATH = "role/";
local UI_ROLE_PATH = "ui_role/";
local TEXTURE_PATH = "texture/";
local SOUND_PATH = "sound/";
local Application = UnityEngine.Application;
local RuntimePlatform = UnityEngine.RuntimePlatform;
local mFile = System.IO.File;

local ResourceUrl = 
{
	buff_icon = TEXTURE_PATH .. "buff_icon/",
	camp_dungeon_icon = TEXTURE_PATH .. "camp_dungeon_icon/",
	face = TEXTURE_PATH .. "face/",
	goods_icon = TEXTURE_PATH .. "goods_icon/",
	role_icon = TEXTURE_PATH .. "role_icon/",
	skill_icon = TEXTURE_PATH .. "skill_icon/",
	seed_icon = TEXTURE_PATH .. "seed_icon/",
};

local FILE_FLAG = "file:///";
local mGameStreamingAssetsPath = nil;
local mGameStreamingAssetsRawPath = nil;
local mGameStreamingAssetsExternalPath = nil;

local mGamePersistentDataPath = nil;
local mGamePersistentDataRawPath = nil;
local mGamePersistentDataExternalPath = nil;

local mPersistentDataPath = Application.persistentDataPath;
local mPersistentDataRawPath = mPersistentDataPath .. "/StreamingAssets/";
local mPersistentDataExternalPath = mPersistentDataPath .. "/StreamingAssets/external/";

if Application.platform == RuntimePlatform.Android then
	mGameStreamingAssetsPath = Application.streamingAssetsPath;
	mGamePersistentDataPath = FILE_FLAG .. mPersistentDataPath;
else
	mGameStreamingAssetsPath = FILE_FLAG .. Application.streamingAssetsPath;
	mGamePersistentDataPath = FILE_FLAG .. mPersistentDataPath;
end

mGameStreamingAssetsRawPath = mGameStreamingAssetsPath.."/";
mGameStreamingAssetsExternalPath = mGameStreamingAssetsPath.."/external/";

mGamePersistentDataRawPath = mGamePersistentDataPath .. "/StreamingAssets/";
mGamePersistentDataExternalPath = mGamePersistentDataPath .. "/StreamingAssets/external/";

function ResourceUrl.GetExternalUrl(path)
	if mFile.Exists( mPersistentDataExternalPath .. path ) then
		return mGamePersistentDataExternalPath .. path;
	end
 	return mGameStreamingAssetsExternalPath .. path;
end

function ResourceUrl.GetUrl(path)
	if mFile.Exists( mPersistentDataRawPath .. path ) then
		return mGamePersistentDataRawPath .. path;
	end
 	return mGameStreamingAssetsRawPath .. path;
end


function ResourceUrl.GetExternalPath(assetName)
	return EXTERNAL_PATH..assetName;
end

function ResourceUrl.GetRolePath()
	return ROLE_PATH;
end

function ResourceUrl.GetUIRolePath()
	return UI_ROLE_PATH;
end

function ResourceUrl.GetScenePath()
	return SCENE_PATH;
end

function ResourceUrl.GetFXPath(assetName)
	return FX_PATH..assetName;
end

function ResourceUrl.GetSoundPath()
	return SOUND_PATH;
end

return ResourceUrl;

