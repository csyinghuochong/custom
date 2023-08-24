local LuaClass = require "Core/LuaClass"
local EventInterface = require "Events/EventInterface"
local TestBattle = LuaClass("TestBattle",EventInterface);
local UnityEngine = UnityEngine;
local Input = UnityEngine.Input;
local KeyCode = UnityEngine.KeyCode;
local Physics = UnityEngine.Physics;
local pairs = pairs;
local ipairs = ipairs;
local mEventEnum = require "Enum/EventEnum"
local mIsEditor = UnityEngine.Application.isEditor;
local DebugHelper = DebugHelper;
local CombatActorInfoView = require "Module/Combat/CombatActorInfoView"
local mUpdateManager = require "Manager/UpdateManager"
local mEventDispatcher = require "Events/EventDispatcher"
local DebugTipsView = require "Battle/Test/DebugTipsView"

function TestBattle:OnLuaNew()
	if mIsEditor then
		self:SetEnable();
	end
end

function TestBattle:SetEnable()
	mEventDispatcher:AddEventListener(mEventEnum.ON_CREATE_COMBAT,function (combat)
		self:OnCreateCombat(combat);
	end);
	mEventDispatcher:AddEventListener(mEventEnum.ON_DESTROY_COMBAT,function (combat)
		self:OnDestroyCombat(combat);
	end)
end

function TestBattle:AddEventListeners()
	self:RegisterEventListener(mEventEnum.ON_START_ROUND,function (current)
		self:OnTurnRound(current);
	end);
	self:RegisterEventListener(mEventEnum.ON_ACTOR_USE_SKILL,function ()
		self:OnRoundDone();
	end);
end

function TestBattle:OnCreateCombat(combat)
	self.mCombat = combat;
	self.mActorInfoView = CombatActorInfoView.LuaNew();
	self.mActorInfoView.mCombat = combat;
	self:AddEventListeners();
	mUpdateManager:AddUpdate(self);
end

function TestBattle:OnDestroyCombat(combat)
	local actorInfoView = self.mActorInfoView;
	if actorInfoView then
		actorInfoView:CloseView();
		self.mActorInfoView = nil;
	end
	self:RemoveEventListeners();
	mUpdateManager:RemoveUpdate(self);
end

local CombatResultEnum = require "Module/Combat/CombatResultEnum"
function TestBattle:OnUpdate()
	local combat = self.mCombat;
	if Input.GetKeyDown(KeyCode.P) then
		mEventDispatcher:Dispatch(mEventEnum.SET_COMBAT_RESULT, CombatResultEnum.CombatWin);
		elseif Input.GetKeyDown(KeyCode.O) then
			mEventDispatcher:Dispatch(mEventEnum.SET_COMBAT_RESULT, CombatResultEnum.CombatFail);
		end
	
	self:UpdateTeam(combat);
	self:TabRound(combat);
	self:UpdateActorView(combat);
end

function TestBattle:UpdateActorView(combat)
	if Input.GetKeyDown(KeyCode.UpArrow) then
		self.mActorInfoView:ShowView(combat:GetCurrentActor());
	end
end

function TestBattle:UpdateTeam(combat)
	if Input.GetKeyDown(KeyCode.LeftArrow) then
		self:ResetTeam(combat,1);
		elseif Input.GetKeyDown(KeyCode.RightArrow) then
			self:ResetTeam(combat,2);
		end
end

function TestBattle:GetPositions(team,formation)
	local mCombatPosition = require "Module/Combat/CombatPosition"
	local mFormations = mCombatPosition.mFormations;
	if team == 1 then
		return mFormations[formation].mLeft;
	else
		return mFormations[formation].mRight;
	end
	
end

function TestBattle:ResetTeam(combat,team)
	if self:TestFollower() then
		combat:DisposeTeam(team);
		local vos = self:CreateTestFollowerWave(team);
		for k,v in pairs(vos) do
			combat:CreateActor(v);
		end
		combat:Start();
	end
end

function TestBattle:TabRound(combat)
	if Input.GetMouseButtonDown(1) then
	    local a = combat.mPlayerController:PickActor(Input.mousePosition);
	    if a then
	    	combat:ForceTurnToActor(a);
	    end
	 end
end

function TestBattle:TestFollower()
	return mIsEditor and DebugHelper.sTestFollower;
end

function TestBattle:GetTestFollowers(team)
	return team ==  1 and DebugHelper.sLeftFollowers or DebugHelper.sRightFollowers;
end

function TestBattle:CreateTestFollowerWave(team)
	local ActorVO = require "Battle/ActorVO"
	local wave = {};
	local followId = DebugHelper.sTestFollower;
	local team = team or 2;
	local follows = self:GetTestFollowers(team);
	if follows then
		local count = follows.Count;
		local positions = self:GetPositions(team,count);
		for i = 1,count do
			local vo = ActorVO.LuaNew();
			local id = follows[i - 1];
			vo:InitTestFollowerVo(id, positions[i], team);
			wave[i] = vo;
		end
	end
	return wave;
end
function TestBattle:InitTestFollowers(team)

	local actorVOList = {};
	for i = 1, 3 do
		actorVOList[i] = self:CreateTestFollowerWave(team);
	end
	return actorVOList;
end

function TestBattle:OnTurnRound(current)
end

function TestBattle:OnRoundDone()
end

function TestBattle:ShowAffectResult(msg)
	DebugTipsView.ShowAffectResult(msg);
end

function TestBattle:GetAddAffectProbability()
	local addAffectProbability = 0;
	if mIsEditor then
		addAffectProbability = DebugHelper.sAddAffectProbability;
	end
	return addAffectProbability;
end

function TestBattle:ShowDebugTips()
	return mIsEditor and DebugHelper.sShowAffectResult;
end

return TestBattle.LuaNew();