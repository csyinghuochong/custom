require "Common/CSharpInterface"
local mMath = require "math"
local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;
local mAssetManager = require "AssetManager/AssetManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameTimerManager = require "Core/Timer/GameTimerManager"
local mUpdateManager = require "Manager/UpdateManager"
local mUIManager = require "Manager/UIManager"
local mSoundManager = require "Module/Sound/SoundManager"
--主入口函数。从这里开始lua逻辑
function GameMain()
	--非编辑器下置空DebugHelper,避免影响热更新
	if mIsEditor == false then
		local t = {};
		local varName = "DebugHelper";
		_G[varName] = t;
		package.loaded[varName] = t;
	end

	Application.targetFrameRate = 30;

	--统一设置随机种子
	mMath.randomseed(os.clock() * os.time());

	UpdateBeat:Add(Update);
	LateUpdateBeat:Add(LateUpdate);
	FixedUpdateBeat:Add(FixedUpdate);
	
	mAssetManager.Init(function()
		mUIManager:Init(Start);
	end);
end

function Start()
	InitController();
	mSceneManager:AskForEnterScene(0);
end

function Update(deltaTime,unscaledDeltaTime)
	mAssetManager.Update();
	mGameTimerManager:Execute();
	mUpdateManager:OnUpdate();
end

function LateUpdate()
	mUpdateManager:OnLateUpdate();
end

function FixedUpdate(fixedDeltaTime)
	mUpdateManager:OnFixedUpdate();
end

function InitController()
	require "Manager/CameraController"
	require "Module/Role/RoleController"
	require "Module/Game/GameController"
	require "Module/Login/LoginController"
	require "Module/Dungeon/DungeonController"
	require "Module/Follower/FollowerController"
end