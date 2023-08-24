local mLuaClass = require "Core/LuaClass"
local mBaseScene = require "Module/Scene/BaseScene"
local mAssetManager = require "AssetManager/AssetManager"
local mCameraController = require"Manager/CameraController"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysdungeon = require"ConfigFiles/ConfigSysdungeon"
local mDungeonController = require "Module/Dungeon/DungeonController"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local DungeonScene = mLuaClass("DungeonScene",mBaseScene);
local mSuper;
local mEventEnum = require "Enum/EventEnum"

function DungeonScene:OnLuaNew(sceneID)
	mSuper = self:GetSuper(mBaseScene.LuaClassName);
    mSuper.OnLuaNew(self,sceneID);

    self:SetSceneConfig(sceneID);
    self.mOnSceneLoadingHide = function()
    	self:OnSceneLoadingHide();
    end
end

function DungeonScene:SetSceneConfig(sceneID)
	local config = mConfigSysdungeon[ sceneID ];
	if config == nil then
		config = mGameModelManager.DungeonModel:GetDungeonVO( sceneID ).mSysVO;
	end
	self.mSceneConfig = config;
end

function DungeonScene:LoadScene()
	local callBack = function()
		self:InternalLoadSceneCompleted();
	end

	mAssetManager.UnityLoadScene("Combat",callBack);
end

function DungeonScene:GetSoundID()
	return mSoundConst[self.mSceneConfig.sound];
end

function DungeonScene:OnBeforeEnterScene()
	--print("---------DungeonScene:OnBeforeEnterScene")
	self:AddEventListener(mEventEnum.SCENE_LOADING_HIDE,self.mOnSceneLoadingHide);
	
	self.mCurrentModel = mCombatModelManager.mCurrentModel;
	self.mCurrentModel:Init();
end

function DungeonScene:OnSceneLoadingHide()
	--print("---------DungeonScene:OnSceneLoadingHide")
	self:OpenCombatView();
end

function DungeonScene:OnEnterScene()
	mCameraController:OnEnterBattleScene(self.mSceneConfig);
end

function DungeonScene:OpenCombatView()
	mDungeonController:OnOpenCombatView();
end

function DungeonScene:OnBeforeExitScene()
	self:RemoveEventListener(mEventEnum.SCENE_LOADING_HIDE,self.mOnSceneLoadingHide);
	self:DisposeCombat();
	mCameraController:OnExitBattleScene();
	mSuper.OnBeforeExitScene(self);
	
end

function DungeonScene:DisposeCombat()
	local model = self.mCurrentModel;
	if model ~= nil then
		model:Dispose();
		self.mCurrentModel = nil;
	end
end

return DungeonScene;