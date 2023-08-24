local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mActorVO = require "Battle/ActorVO"
local mEventEnum = require "Enum/EventEnum"
local mMonsterVO = require "Module/Follower/MonsterVO"
local mCombatPosition = require "Module/Combat/CombatPosition"
local mEventDispatcher = require "Events/EventDispatcher"
local ActorTypeEnum = require "Module/Combat/ActorTypeEnum"
local CombatActorGroup = mLuaClass("CombatActorGroup",mBaseLua);
local mString = require 'string'
local mTable = require 'table'

local mFormations = mCombatPosition.mFormations;
local mBossIndices = mCombatPosition.mBossIndices;
local mLeadIndices = mCombatPosition.mLeadIndices;

function CombatActorGroup:OnLuaNew()
	
end

function CombatActorGroup:SetFormation(formation)
	local team = self.mTeam;
	if team == 1 then
		self.mPositionList = mFormations[formation].mLeft;
	else
		self.mPositionList = mFormations[formation].mRight;
	end
	
end

function CombatActorGroup:GetActorPosition( index )
	return self.mPositionList[index];
end

function CombatActorGroup:GetMonsterVO( id,level,monster_type ,actor_type, index )
	local actorVO = mActorVO.LuaNew();
	actorVO:InitActorVO(mMonsterVO.LuaNew(id,level,monster_type, actor_type), self:GetActorPosition(index), self.mTeam);
	return actorVO;
end

function CombatActorGroup:CreateMonsterWave(config)
	local wave = {};
	local boss = config.boss_id;
	local monster = config.monster_id;
	local totalNumber = math.min(4,config.monster_number);
	local bossIndex = -1;

	if boss then
		totalNumber = totalNumber + 1;
		bossIndex = mBossIndices[totalNumber];
	end

	self:SetFormation(totalNumber);

	if monster then
		local count = table.getn(monster);

		for i = 1,totalNumber do
			if i == bossIndex then
				wave[i] = self:GetMonsterVO(boss[1].monster_id,boss[1].lv,boss[1].type, ActorTypeEnum.ActorBoss, i);
			else
				local id = i;
				if i>count then
					id = math.random(1, count);
				end
				wave[i] = self:GetMonsterVO(monster[id].monster_id,monster[id].lv,monster[id].type, ActorTypeEnum.ActorMonster, i);
			end
		end
	end

	return wave;
end

function CombatActorGroup:InitMonsers(monsterGroup, team)
	self.mTeam = team or 2;
	local actorVOList = {};
	if monsterGroup then
		for k, v in pairs(monsterGroup) do
			actorVOList[k] = self:CreateMonsterWave(v);
		end
	end
	return actorVOList;
end

--随从
function CombatActorGroup:InitFollowers( actor_list, team )
	self.mTeam = team or 1;
	local actorVOList = {};
	for k, v in pairs(actor_list) do
		if table.getn(v) > 0 then
			actorVOList[k] = self:CreatePlayerWave(v);
		else
			actorVOList[k] = {};
		end
	end
	return actorVOList;
end

function CombatActorGroup:CreatePlayerWave(list)
	local team = self.mTeam;
	local wave = {};
	local leadIndex = nil;
	local totalNumber = table.getn(list);
	self:SetFormation(totalNumber);

	for i = 1,totalNumber do
		local actor = mActorVO.LuaNew();
		actor:InitActorVO(list[i],self:GetActorPosition(i), team);
		wave[i] = actor;
		if actor.mLead then
			leadIndex = i;
		end
	end

	if leadIndex then
		local leadPosition = mLeadIndices[totalNumber];
		if leadPosition ~= leadIndex then
			local lead = wave[leadIndex];
			local temp = wave[leadPosition];
			wave[leadIndex] = temp
			wave[leadPosition] = lead;
			lead:SetLocation(self:GetActorPosition(leadPosition));
			temp:SetLocation(self:GetActorPosition(leadIndex));
		end
	end

	return wave;
end

--爬塔野怪VO
function CombatActorGroup:InitEndlessDungeonMonsters( monsterGroup)
	self.mTeam = 2;
	local actorVOList = {};
    for i,v in ipairs(monsterGroup.list) do
    	actorVOList[i] = self:CreateEndlessWave(v);
    end
	return actorVOList;
end

function CombatActorGroup:CreateEndlessWave(monsterList)
	local wave = {};
	local totalNumber = table.getn(monsterList.list);
	self:SetFormation(totalNumber);
	for i,v in ipairs(monsterList.list) do
		wave[i] = self:GetMonsterEndlessVO(v,i);
	end
	return wave;
end

function CombatActorGroup:GetMonsterEndlessVO(v, index)
	local actorVO = mActorVO.LuaNew();
	actorVO:InitActorVO(mMonsterVO.LuaNew(v.id,v.level,v.type), self:GetActorPosition(index), self.mTeam);
	return actorVO;
end

return CombatActorGroup;