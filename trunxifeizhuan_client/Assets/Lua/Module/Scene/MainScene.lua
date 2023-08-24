local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mBaseScene = require "Module/Scene/BaseScene"
local mAssetManager = require "AssetManager/AssetManager"
local mEventDispatcher = require "Events/EventDispatcher"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local MainScene = mLuaClass("MainScene",mBaseScene);
local CameraClearFlags = UnityEngine.CameraClearFlags;

function MainScene:LoadScene()
	local callBack = function()
		self:InternalLoadSceneCompleted();
	end

	mAssetManager.UnityLoadScene("Scene",callBack);
	--mAssetManager.LoadSceneExternal("city",callBack,nil);
end

function MainScene:OnEnterScene()
	if self:PrevSceneIsLoginScene() then
		mUIManager:HandleMainSceneViewVisible(1);
	end

	mUIManager:SetCameraClearFlags( CameraClearFlags.SolidColor );
	mEventDispatcher:Dispatch(mEventEnum.ON_ENTER_MAINSCENE);
end

function MainScene:OnBeforeExitScene()
	mUIManager:SetCameraClearFlags( CameraClearFlags.Depth );
end

function MainScene:GetSoundID()
	return mSoundConst.ty_0002;
end

return MainScene;