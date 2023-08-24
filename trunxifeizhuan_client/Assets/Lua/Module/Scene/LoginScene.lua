local mLuaClass = require "Core/LuaClass"
local mBaseScene = require "Module/Scene/BaseScene"
local mLoginController = require "Module/Login/LoginController"
local mAssetManager = require "AssetManager/AssetManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mGameModelManager = require "Manager/GameModelManager"

local LoginScene = mLuaClass("LoginScene",mBaseScene);
local mSkipLoad = true;--第一次不加载场景
function LoginScene:LoadScene()
	if mSkipLoad then
		mSkipLoad = false;
		self:InternalLoadSceneCompleted();
		return;
	end

	local callBack = function()
		self:InternalLoadSceneCompleted();
	end

	mAssetManager.UnityLoadScene("Scene",callBack);
end

function LoginScene:OnEnterScene()
	mGameModelManager.ClearModels();
	mLoginController:OpenLoginView();
end

function LoginScene:GetSoundID()
	return mSoundConst.ty_0001;
end

return LoginScene;