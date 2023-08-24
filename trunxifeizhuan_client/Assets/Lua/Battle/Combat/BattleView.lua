local LuaClass = require "Core/LuaClass"
local CombatObserver = require"Battle/Combat/CombatObserver"
local BattleView = LuaClass("BattleView",CombatObserver);
local mNotifyEnum = require"Enum/NotifyEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local ipairs = ipairs;
local table = table;
local mEffectManager = require "Battle/Manager/EffectManager"
local mCommonEffects = mEffectManager.mCommonEffects;

function BattleView:Awake()
	self:AddCombatListeners();
end

function BattleView:Dispose()
	self:RemoveCombatListeners();
	self:HideUnderEffect();
	self:HideSelectedEffect();
end

function BattleView:AddCombatListeners()

	self:RegisterListener(mBattleEventEnum.ON_ACTOR_SELECT_SKILL,function (skill)
		self:OnActorSelectSkill(skill);
	end);
	self:RegisterListener(mBattleEventEnum.ON_ACTOR_USE_SKILL,function (skill)
		self:OnActorUseSkill(skill);
	end);
	self:RegisterListener(mBattleEventEnum.ON_START_ROUND,function (actor)
		self:SetUnderEffect(actor);
	end);

	self:RegisterListener(mBattleEventEnum.ON_PLAYER_SET_SELECTED_TARGET,function (actor)
		self:SetSelectedEffect(actor);
	end);

end

function BattleView:OnActorSelectSkill(skill)
	self:HideModels();
	if skill:IsReliveSkill() then
		self:ShowModels(skill.mOwner:GetDeadTeamMates());
	end
end

function BattleView:OnActorUseSkill(skill)
	if skill:IsReliveSkill() then
		self:HideModels();
	end
end

function BattleView:ShowModels(list)
	if list and list.mLength > 0 then
		local actors = {};
		local callback = function (actor)
		    if actor:Reliveable() then
				actor:Notify(mNotifyEnum.OnToggleModel,true);
				table.insert(actors,actor);
			end
		end
		list:Foreach(callback);
		self.mActors = actors;
	end
end

function BattleView:HideModels()
	local actors = self.mActors;
	if actors then
		for i,v in ipairs(actors) do
			v:Notify(mNotifyEnum.OnToggleModel,false);
		end
		self.mActors = nil;
	end
end

function BattleView:HideUnderEffect()
	local effect = self.mUnderEffect;
	if effect then
		mEffectManager:HideEffect(effect);
		self.mUnderEffect = nil;
	end
end

function BattleView:SetUnderEffect(target)

	if not target or target.mUnReal then
		self:HideUnderEffect();
		return;
	end

	local effect = self.mUnderEffect;

	if not effect then
		effect = mEffectManager:GetEffect(mCommonEffects.mUnder);
		effect.mNeverExit = true;
		self.mUnderEffect = effect;
	end

	if effect.mShow then
		effect:SetBindTransform(target.mTransform);
	else
		mEffectManager:ShowEffect(effect,target);
	end
end


function BattleView:HideSelectedEffect()
	local effect = self.mSelectedEffect;
	if effect then
		mEffectManager:HideEffect(effect);
		self.mSelectedEffect = nil;
	end
end

function BattleView:SetSelectedEffect(target)
	if not target then
		self:HideSelectedEffect();
		return;
	end

	local effect = self.mSelectedEffect;
	if not effect then
		effect = mEffectManager:GetEffect(mCommonEffects.mSelectedTarget);
		effect.mNeverExit = true;
		self.mSelectedEffect = effect;
	end

	if effect.mShow then
		effect:SetBindTransform(target.mTransform);
	else
		mEffectManager:ShowEffect(effect,target);
	end
end

return BattleView;