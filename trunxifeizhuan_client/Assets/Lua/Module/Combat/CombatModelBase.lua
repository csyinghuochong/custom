local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local GameTimer = require "Core/Timer/GameTimer"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local mCombatActorGroup = require "Module/Combat/CombatActorGroup"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mCombatResultContrl = require "Module/Combat/CombatResultControl"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local BattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mConfigSysdungeon_play = require "ConfigFiles/ConfigSysdungeon_play"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local CombatModelBase = mLuaClass("CombatModelBase", mEventDispatcherInterface);
local mIpairs= ipairs;
local mMath  = math;
local mTable = table;

--玩法逻辑--
function CombatModelBase:OnLuaNew(dungeon)
	self.mDungeonId = dungeon;
	self.mDungeonVO = mConfigSysdungeon[dungeon];
	self.mShowReliveView = false;
end

function CombatModelBase:Init()
	self:AddListeners();
	self:InitComponent();
end

function CombatModelBase:AddListeners(  )	

	self.mCombatStart = function(  )
		self:OnCombatStart();
	end
	self.mOnActorDie = function(actor)
		self:OnActorDie(actor);
	end
	self.mActorRelive = function(actor)
		self:OnActorRelive(actor);
	end
	self.mSetCombatResult = function(result)
		self:SetCombatResult(result);
	end

	self.mMonsterBorn = function (actor)
		self:OnMonsterBorn(actor);
	end
	
	self.mBeforeBeginCombat = function ()
		self:BeforeBeginCombat();
	end

	self.mOnWaveAllDie = function (team)
		self:OnWaveAllDie(team);
	end

	self:AddEventListener(mEventEnum.ON_COMBAT_START,self.mCombatStart);
	self:AddEventListener(mEventEnum.ON_ACTOR_DEAD, self.mOnActorDie);
	self:AddEventListener(mEventEnum.ON_ACTOR_RELIVE, self.mActorRelive);
	self:AddEventListener(mEventEnum.SET_COMBAT_RESULT, self.mSetCombatResult);
	self:AddEventListener(mEventEnum.ON_ACTOR_BORN, self.mMonsterBorn);
	self:AddEventListener(mEventEnum.BEFORE_BEGIN_COMBAT,self.mBeforeBeginCombat);

	self:AddEventListener(mEventEnum.ON_WAVE_ALL_DIE,self.mOnWaveAllDie);
end

function CombatModelBase:RemoveListeners(  )

	self:RemoveEventListener(mEventEnum.ON_COMBAT_START,self.mCombatStart);
	self:RemoveEventListener(mEventEnum.ON_ACTOR_DEAD, self.mOnActorDie);
	self:RemoveEventListener(mEventEnum.ON_ACTOR_RELIVE, self.mActorRelive);
	self:RemoveEventListener(mEventEnum.SET_COMBAT_RESULT, self.mSetCombatResult);
	self:RemoveEventListener(mEventEnum.ON_ACTOR_BORN, self.mMonsterBorn);
	self:RemoveEventListener(mEventEnum.BEFORE_BEGIN_COMBAT,self.mBeforeBeginCombat);

	self:RemoveEventListener(mEventEnum.ON_WAVE_ALL_DIE, self.mOnWaveAllDie);
end

function CombatModelBase:InitComponent(  )
	
end

function CombatModelBase:BeforeBeginCombat(  )
	self.mCombatActorManager:BeforeBeginCombat();
end

--external func
function CombatModelBase:GetDungeonPlay(  )
	return self.mDungeonVO.play_type;
end

function CombatModelBase:GetDungeonPlayVO(  )
	return mConfigSysdungeon_play[self:GetDungeonPlay()];
end

function CombatModelBase:GetBattleActorVOList( )
	local actorTeam = self.mCombatActorManager.mTeams;
	return actorTeam[1].mAllActorVOList, actorTeam[2].mAllActorVOList;
end

function CombatModelBase:InitBattleActorVOList(  )
	local selfList, enemyList = self:GetBattleActors();
	local group = mCombatActorGroup.LuaNew();
	local list1 = group:InitFollowers(selfList, 1);
	local list2 = enemyList and group:InitFollowers(enemyList, 2) or group:InitMonsers(self.mDungeonVO.monster_node, 2);
	return list1 , list2;
end

function CombatModelBase:GetDungeonBattleHero(  )
	return BattleArrayViewVO:GetPlayTeam(self:GetDungeonPlay());
end

function CombatModelBase:GetDungeonBattleHeroUIDs(  )
	local ids = { };
	local heros = self:GetDungeonBattleHero( );
	for k, v in pairs( heros ) do
		mTable.insert( ids, v.mUID );
	end
	return ids;
end

--获取被克制的怪
function CombatModelBase:GetCampMonster()
	local combat = self.mCombatActorManager.mCombat;
	local skill = combat:GetCurrentActor():GetSelectedSkill();
	local enemyActors = combat.mTeams[2].mData;
	for i,v in ipairs(enemyActors) do
		local camp = skill:Restrain(v);
		if camp == 1 then
           return v;
		end
	end
	return enemyActors[1];
end
--external func

--event handle
function CombatModelBase:OnActorDie(actor)
	self.mCombatActorManager:OnActorDie(actor);
end

function CombatModelBase:OnActorRelive(actor)
	self.mCombatActorManager:OnActorRelive(actor);
end

--x队伍当前波全死时
function CombatModelBase:OnWaveAllDie(team)
	local nextWave = self.mCombatActorManager:OnWaveAllDie(team);
	local result = self.mCombatResultContrl:OnWaveAllDie(team);
	if result then
		if self.mShowReliveView  and result == CombatResultEnum.CombatFail then
			self:OpenResurgenceView(result);
		else
			self:OnCombatOver(result);
		end
	else
		self:OnBeginNextWave(team,nextWave);
	end
end

function CombatModelBase:OnBeginNextWave(team,wave)

	local actorMgr = self.mCombatActorManager;
	local combat = actorMgr.mCombat;
	local dungeon_play = mConfigSysdungeon_play[self:GetDungeonPlay()];
	combat:ClearStage(dungeon_play.combat_setting,wave,team,actorMgr.mAutoMode);

	local screen_black = function ()
	    mUIManager:HandleUI(mViewEnum.CombatBlankScreenView, 1);
	end

	local next_map = function ()
	    self:Dispatch(mEventEnum.ON_SHOW_NEXT_COMBAT_SCENE, self:GetSceneMap(wave));
	end

	local next_wave = function ()
	    actorMgr:OnBeginNextWave(team, wave );
	end

	local start_combat = function ()
		combat:Start();
	end

	GameTimer.SetTimeout(1.3,screen_black,true,true);
	GameTimer.SetTimeout(2.1,next_map,true,true);
	GameTimer.SetTimeout(2.9,next_wave,true,true);
	GameTimer.SetTimeout(4.5,start_combat,true,true);
end

--战斗开始
function CombatModelBase:OnCombatStart()

end

function CombatModelBase:GetBattleActors()
	error("需要在子类重写GetBattleActors");
end

function CombatModelBase:OnCombatOver(result)
	self:RemoveListeners();
	self:Dispatch(mEventEnum.ON_COMBAT_OVER, result);

	self.mCombatActorManager:OnCombatOver();
end

function CombatModelBase:SetCombatResult(result)
	self.mCombatResultContrl:SetResult(result);
	self:OnCombatOver(result);
end

function CombatModelBase:OnMonsterBorn(actor)
	-- body
end

function CombatModelBase:ShowResultView(actor)
	
end

function CombatModelBase:OnCombatReturn(result)
	
end

function CombatModelBase:GetCombatReward()
	
end

function CombatModelBase:GetFaildReward( rewards )
	local rate = self.mCombatActorManager:GetKillMonsterRate( );
	local new_rewards = { };
	for k, v in mIpairs( rewards ) do
		local goodsNum = v.goods_num;
		goodsNum = mMath.ceil( goodsNum * rate);
		mTable.insert( new_rewards, { goods_id = v.goods_id, goods_num = goodsNum } )
	end
	return new_rewards;
end

function CombatModelBase:GetSceneMap( wave )
	local map = {'map_003', 'map_008'};
	return map[wave] and map[wave] or nil;
end

function CombatModelBase:OpenResurgenceView( result )

end

--event handle

--component ..
--mode 0 不自动下一波  1 阵亡方下一波  2 全部下一波
function CombatModelBase:InitActorManger( mode )
	local actorMgr = mCombatActorManager.LuaNew(self.mDungeonVO, mode);
	actorMgr:OnInitActors(self:InitBattleActorVOList());
	self.mCombatActorManager = actorMgr;
end

--胜负检测
function CombatModelBase:InitResultComponent()
	self.mCombatResultContrl = mCombatResultContrl.LuaNew(self.mDungeonVO.win_rules, self);
end
--component

function CombatModelBase:Dispose()
	self:RemoveListeners();
	local actorMgr = self.mCombatActorManager;
	if actorMgr ~= nil then
		actorMgr:Dispose();
		self.mCombatActorManager = nil;
	end
end

return CombatModelBase;