local LuaClass = require "Core/LuaClass"
local CombatObserver = require"Battle/Combat/CombatObserver"
local PlayerController = LuaClass("PlayerController",CombatObserver);
local Input = UnityEngine.Input;
local ipairs = ipairs;
local Raycast = UnityEngine.Physics.Raycast;
local mCameraController = require "Manager/CameraController"
local mUpdateManager = require "Manager/UpdateManager"
local mEventEnum = require "Enum/EventEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local EventInterface = require "Events/EventInterface"

function PlayerController:AddEventListeners()
	local eventInterface = self.mEventInterface;
	eventInterface:RegisterEventListener(mEventEnum.ON_AUTO_COMBAT,function (autoAttack)
		self:OnSetAutoAttack(autoAttack);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_PLAYER_SELECT_SKILL,function (skill)
		self:OnPlayerSelectSkill(skill);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_ACTOR_DEAD,function (actor)
		self:OnActorDead(actor);
	end);
end

function PlayerController:RemoveEventListeners()
	self.mEventInterface:RemoveEventListeners();
end

function PlayerController:Awake()
	self.mEventInterface = EventInterface.LuaNew();
	self:AddEventListeners();
	mUpdateManager:AddUpdate(self);
end

function PlayerController:Dispose()
	self:RemoveEventListeners();
	mUpdateManager:RemoveUpdate(self);
end

function PlayerController:GetHitActor(actors,hitCollider)
	local result = nil;
	if actors then
		local callback = function (actor)
		   if actor:Raycast(hitCollider) then
		   	  result = actor;
		   	  return true;
		   end
		end
		actors:Foreach(callback);
	end
	return result;
end

function PlayerController:IsAutoAttack()
	return self.mAutoAttack;
end

function PlayerController:OnSetAutoAttack(autoAttack)
	self.mAutoAttack = autoAttack;
	self:SetSelectedTarget(nil);
	self:GetCombat():Notify(mBattleEventEnum.ON_PLAYER_SET_AUTO_COMBAT,autoAttack);
end

function PlayerController:OnPlayerSelectSkill(skill)
	self:GetCombat():Notify(mBattleEventEnum.ON_PLAYER_SELECT_SKILL,skill);
end

function PlayerController:PickActor(mousePosition)
	local combat = self:GetCombat();
	local actor = nil;
    local flag,hit = Raycast(mCameraController:ScreenPointToRay(mousePosition),nil);
    if flag then
    	local collider = hit.collider;
    	actor = self:GetHitActor(combat:GetAliveActors(),collider);
    	if not actor then
    		actor = self:GetHitActor(combat:GetDeadActors(),collider);
    	end
    end
    return actor;
end

function PlayerController:OnPickActor(actor)
	if actor and actor.mTeam ~= 1 and self.mAutoAttack then
		self:SetSelectedTarget(actor);
	end
	self:GetCombat():Notify(mBattleEventEnum.ON_PLAYER_PICK_ACTOR,actor);
end

function PlayerController:OnActorDead(actor)
	if actor and actor == self.mSelectedTarget then
		self:SetSelectedTarget(nil);
	end
end

function PlayerController:GetSelectedTarget()
	return self.mSelectedTarget;
end

function PlayerController:SetSelectedTarget(target)
	local current = self.mSelectedTarget;
	if not target and not current then
		return;
	end
	if target == current then
		current = nil;
	else
		current = target;
	end
	self.mSelectedTarget = current;
	self:GetCombat():Notify(mBattleEventEnum.ON_PLAYER_SET_SELECTED_TARGET,current);
end

function PlayerController:OnUpdate()

	if Input.GetMouseButtonDown(0) and not self.mDisable then
	    local actor = self:PickActor(Input.mousePosition);
	    if actor then
	    	self:OnPickActor(actor);
	    end
	end
end

return PlayerController;