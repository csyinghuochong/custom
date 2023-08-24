local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mCameraController = require"Manager/CameraController"
local PreloadManager = mLuaClass("PreloadManager",mBaseLua);
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mConfigSysskill = require"ConfigFiles/ConfigSysskill"
local mConfigSysskill_action = require"ConfigFiles/ConfigSysskill_action"
local mConfigSysskill_buff = require"ConfigFiles/ConfigSysskill_buff"
local mConfigSyseffect = require"ConfigFiles/ConfigSyseffect"
local mAssetManager = require("AssetManager/AssetManager")
local mResourceUrl = require("AssetManager/ResourceUrl")
local mRolePath = mResourceUrl.GetRolePath();
local mRoleFashionPath = mRolePath .. "fashion/"
local mIconPath = mResourceUrl.skill_icon;
local mFxPath = mResourceUrl.GetFXPath("");
local mSceneMapPath = "ui/scene_map/";

function PreloadManager:OnEnterLoginScenePreload(callBack)
	mUIManager:HandleUI(mViewEnum.LoadingView,1);
	mAssetManager.PreLoadAsset("ui/login/","login_view");
	mAssetManager.SetLoadAllFinishCallBack(function()
		callBack();
		mUIManager:HandleUI(mViewEnum.LoadingView,0);
	end);
end

function PreloadManager:OnLoginEnterMainScenePreload(callBack)
	mUIManager:HandleUI(mViewEnum.LoadingView,1);
	local preloadAssetsSuccess = false;
	local requireDataSuccess = false;

	self.mGetDataCallBack = function()
		requireDataSuccess = true;
		self:CheckEnterMainScene(preloadAssetsSuccess,requireDataSuccess,callBack);
	end
	mEventDispatcher:AddEventListener(mEventEnum.ON_GET_DUNGEON_DATA,self.mGetDataCallBack);

	mAssetManager.PreLoadAsset("ui/main_interface/","main_scene_view");
	mAssetManager.PreLoadAsset("ui/main_interface/","main_interface_view");
	mAssetManager.PreLoadAsset("ui/scene_loading/","scene_loading_view");
	
	mAssetManager.SetLoadAllFinishCallBack(function()
		preloadAssetsSuccess = true;
		self:CheckEnterMainScene(preloadAssetsSuccess,requireDataSuccess,callBack);
	end);
end

function PreloadManager:CheckEnterMainScene(preloadAssetsSuccess,requireDataSuccess,callBack)
	if preloadAssetsSuccess and requireDataSuccess then
		mEventDispatcher:RemoveEventListener(mEventEnum.ON_GET_DUNGEON_DATA,self.mGetDataCallBack);
		self.mGetDataCallBack = nil;
		callBack();
		mUIManager:HandleUI(mViewEnum.LoadingView,0);
	end
end

function PreloadManager:OnBattlePreload()
	mCameraController:OnEnterMainScene();
	
	local currentModel = mCombatModelManager.mCurrentModel;
	local selfRoles,enemyRoles = currentModel:GetBattleActorVOList();
	self:PreloadActors(selfRoles,true);
	self:PreloadActors(enemyRoles);

	for i=1,6 do
		self:PreloadEffect(i);
	end

	for i=1,9 do
		self:PreloadEffect(1000+i);
	end

	local sceneMap = currentModel:GetSceneMap(1);
	if sceneMap then
		mAssetManager.PreLoadAsset(mSceneMapPath,sceneMap);
	end

	mAssetManager.PreLoadAsset("ui/combat/","combat_view");
	mAssetManager.PreLoadAsset("ui/combat/","combat_start_view");
	mAssetManager.PreLoadAsset("ui/combat/","text_word_view");
	mAssetManager.PreLoadAsset("ui/combat/","art_text_word_view");
	mAssetManager.PreLoadAsset("ui/combat/","blood_view");
	mAssetManager.PreLoadAsset("ui/combat/","buff_item");
	mAssetManager.PreLoadAsset("ui/combat/","image_word_view");
end

function PreloadManager:PreloadActors(actor_list,loadIcon)
	if actor_list == nil then
		return;
	end

	for k, v in pairs(actor_list) do
		for key, value in pairs(v) do
			self:PreloadActorModel(value.mModel);
			self:PreloadActorSkills(value,loadIcon);
		end
	end
end

function PreloadManager:PreloadActorModel(model)
	local modelPath = model.mFile;
	--print("modelPath:",modelPath);
	mAssetManager.PreLoadAssetExternal(mRolePath,modelPath);

	--preload fashions
	local fashions = model.mFashions;
	if fashions then
		for k,v in pairs(fashions) do
			mAssetManager.PreLoadAssetExternal(mRoleFashionPath,v.mConfig.asset);
		end
		--preload face
		mAssetManager.PreLoadAssetExternal(mRoleFashionPath,model.mFace.asset);
	end
end

function PreloadManager:PreloadActorSkills(actorVo,loadIcon)

	local skillList = actorVo.mSkills;
	local skillConfig = nil;
	local actionConfig = nil;
	for i,v in pairs(skillList) do
		skillConfig = v.mConfig;
		self:PreloadEffects(skillConfig.effect);
		self:PreloadEffects(skillConfig.hit_effect);
		--print("skillConfig.icon:",skillConfig.icon);
		local icon = v.mIcon;
		if loadIcon and icon then
			mAssetManager.PreLoadAsset(mIconPath,icon);
		end
		
	end
end


function PreloadManager:PreloadEffects(effects)

	if effects then
		for k,v in ipairs(effects) do
			self:PreloadEffect(v);
		end
	end
	
end

function PreloadManager:PreloadEffect(effectID)
	if effectID == 0 then
		return
	end

	local effectConfig = mConfigSyseffect[effectID]

	if effectConfig and string.len(effectConfig.asset) > 0 then
		--print("effectConfig.asset:",effectConfig.asset)
		mAssetManager.PreLoadAssetExternal(mFxPath,effectConfig.asset);
	else
		--print("effectConfig nil:",effectID);
	end
end

return PreloadManager.LuaNew();