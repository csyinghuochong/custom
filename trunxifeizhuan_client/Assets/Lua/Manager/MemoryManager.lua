local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mAssetLoaderManager = require "AssetManager/AssetLoaderManager"
local mPoolManager = require "Common/PoolManager"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local MemoryManager = mLuaClass("MemoryManager",mEventDispatcherInterface);
local mFashionAssetManager = require"Module/Fashion/FashionAssetManager"
local mGameTimerManager = require "Core/Timer/GameTimerManager"
local mEffectManager = require "Battle/Manager/EffectManager"
local mBulletManager = require "Battle/Manager/BulletManager"
local mSkillActionManager = require "Battle/Manager/SkillActionManager"
local mDebugTimer = GameDebugConfig.debugTimer;

function MemoryManager:Dispose(reLogin,showSceneLoading)
	mGameTimerManager:StopTimerOnChangeScene();
	
	mUIManager:DisposeUI(reLogin);
	mPoolManager:Dispose();
	mFashionAssetManager:Dispose();

	mEffectManager:Dispose();
	mBulletManager:Dispose();
	mSkillActionManager:Dispose();

	if showSceneLoading then
		mAssetLoaderManager:UnloadBundles();
	end
	
	self:Dispatch(mEventEnum.MEMORY_DISPOSE,reLogin);

	if reLogin and mDebugTimer then
		mGameTimerManager:DebugTimer();
		mEventDispatcher:DebugEvents();
	end
end

return MemoryManager.LuaNew();