local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mMemoryManager = require "Manager/MemoryManager"
local mDoFileUtil = require "Utils/DoFileUtil";
local GameTimer = require "Core/Timer/GameTimer"
local mEventEnum = require "Enum/EventEnum"
local SceneManager = mLuaClass("SceneManager",mEventDispatcherInterface);
local mPrevScene = nil;
local mCurScene = nil;

local mLoginSceneID = 0;
local mMainSceneID = 1;

function SceneManager:OnLuaNew()
	local SceneManagement = UnityEngine.SceneManagement.SceneManager;
	SceneManagement.sceneLoaded = SceneManagement.sceneLoaded + SceneManager.OnSceneLoaded;
    SceneManagement.sceneUnloaded = SceneManagement.sceneUnloaded + SceneManager.OnSceneUnloaded;
    SceneManagement.activeSceneChanged = SceneManagement.activeSceneChanged + SceneManager.OnActiveSceneChanged;

    self.mSceneLogic = {
    	[1] = 'Module/Scene/DungeonScene',
    	[2] = 'Module/Scene/CampDungeonScene',
    	[3] = 'Module/Scene/FollowerDungeonScene',
    	[4] = 'Module/Scene/ShengongmeiyingDungeonScene',
    	[5] = 'Module/Scene/GongshensihaiDungeonScene',
    	[6] = 'Module/Scene/MeirenxinjiDungeonScene',
    	[7] = 'Module/Scene/ArenaScene',
    	[8] = 'Module/Scene/PromoteArenaScene',
    	[9] = 'Module/Scene/EliteDungeonScene'
    };
end

function SceneManager.OnSceneLoaded(scene,mode)
	--print("OnSceneLoaded:",scene.name);
end

function SceneManager.OnSceneUnloaded(scene)
	--print("OnSceneUnloaded:",scene.name);
end

function SceneManager.OnActiveSceneChanged(preScene,curScene)
	--print("OnActiveSceneChanged:",preScene.name,curScene.name);
end

function SceneManager:AddEnterSceneCallBack(enterSceneCallBack)
	self.mEnterSceneCallBack = enterSceneCallBack;
end

function SceneManager:AskForEnterScene(sceneID, play_type)
	if mCurScene then
		mPrevScene = mCurScene;
		mPrevScene:BeforeExitScene();
	end

	if sceneID == mLoginSceneID then
		mCurScene = mDoFileUtil:DoFile("Module/Scene/LoginScene").LuaNew(sceneID);
	elseif sceneID == mMainSceneID then
		mCurScene = mDoFileUtil:DoFile("Module/Scene/MainScene").LuaNew(sceneID);
	else
		mCurScene = mDoFileUtil:DoFile(self.mSceneLogic[play_type]).LuaNew(sceneID);
	end

	local showSceneLoading = sceneID ~= mLoginSceneID and sceneID ~= mMainSceneID;
	if showSceneLoading then
		self:ShowLoadingView(play_type);

		GameTimer.SetTimeout(0.1,function()
			self:EnterScene(showSceneLoading);
			self:Dispatch(mEventEnum.SCENE_START_PRELOAD);
		end);
	else
		self:EnterScene(showSceneLoading);
	end
end

function SceneManager:EnterScene(showSceneLoading)
	mMemoryManager:Dispose(sceneID == mLoginSceneID,showSceneLoading);
	mCurScene:BeforeEnterScene();
	mCurScene:LoadScene();
end

function SceneManager:ShowLoadingView(play_type)
	mUIManager:HandleUI(mViewEnum.SceneLoadingView,1,play_type);
end

function SceneManager:GetCurScene()
	return mCurScene;
end

function SceneManager:GetPrevSceneID()
	if mPrevScene then
		return mPrevScene.mSceneID;
	end

	return nil;
end

function SceneManager:PrevSceneIsLoginScene()
	return self:GetPrevSceneID() == mLoginSceneID;
end

function SceneManager:LoadSceneCompleted()
	local prevScene = mPrevScene;
	local curScene = mCurScene;

	if prevScene ~= nil then
		prevScene:ExitScene();
	end

	curScene:EnterScene();

	local enterSceneCallBack = self.mEnterSceneCallBack;
	if enterSceneCallBack then
		enterSceneCallBack()
		self.mEnterSceneCallBack = nil;
	end
end

local instance = SceneManager.LuaNew();
return instance;