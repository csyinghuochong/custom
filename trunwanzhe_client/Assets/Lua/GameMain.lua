local mGameTimerManager = require "Core/Timer/GameTimerManager"
local mNetManager = require "Net/NetManager"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;

--主入口函数。从这里开始lua逻辑
function GameMain()
	UpdateBeat:Add(Update);
	LateUpdateBeat:Add(LateUpdate);
	FixedUpdateBeat:Add(FixedUpdate);
	
	CSharpInterface.AddEventListener(EventConst.FIRST_GET_SERVER_DATA,function()
		InitiativeGetServerData();
	end);

	Start();
end

local mActivityController;
local mGrowFundController;
local mLandRewardController;
local mActivityOpenServerController;
function InitiativeGetServerData()
	mActivityController:SendActivityLoginInfo();
	mGrowFundController:SendGetGrowFundInfo();
	mLandRewardController:SendGetLandRewardInfo();
	mActivityOpenServerController:SendGetActiveOpenServerInfo();
end

function MainInterface(view)
	local mainInterfaceView = require "Module/MainInterface/MainInterfaceView"
	mainInterfaceView:Init(view);
end

function Start()
	InitController();
end

function Update(deltaTime,unscaledDeltaTime)
	mGameTimerManager:Execute();
end

function LateUpdate()
	
end

function FixedUpdate(fixedDeltaTime)
	
end

function InitController()
	mActivityController = require "Module/Activity/ActivityController"
	mGrowFundController = require "Module/GrowFund/GrowFundController"
	mLandRewardController = require "Module/LandReward/LandRewardController"
	mActivityOpenServerController = require "Module/ActivityOpenServer/ActivityOpenServerController"
end