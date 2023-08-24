local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBaseController = require "Core/BaseController"
local mGameModelManager= require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mCommonRewardVO = require "Module/Arena/Balance/ArenaBalanceRewardVO"
local ArenaController = mLuaClass("ArenaController",mBaseController);
local mTable = table;

--协议处理--
function ArenaController:AddNetListeners()
	local s2c = self.mS2C;
	local mEventEnum = self.mEventEnum;
	
	s2c:PLAYER_ARENA(function(pbArena)
		mGameModelManager.ArenaModel:OnRecvArenaInfo(pbArena);
	end);

	s2c:PLAYER_ARENA_REFRESH(function(pbArena)
		mGameModelManager.ArenaModel:OnRefreshArena(pbArena);
	end);

	s2c:PLAYER_ARENA_DEFENSE_POS(function(pbArenaDefensePos)
		self:OnOpenArenaDedendView(pbArenaDefensePos);
	end);

	s2c:PLAYER_ARENA_DEFENSE_POS_SAVE(function(pbResult)
		
	end);

	s2c:PLAYER_ARENA_PREPARE_FIGHT(function(pbArenaVsPlayerDefense)
		self:OnOpenArenaBattleView(pbArenaVsPlayerDefense, false);
	end);

	s2c:PLAYER_ARENA_FIGHT(function(pbArenaResult)
		mCombatModelManager:CreateArenaCombatModel(mConfigSysglobal_value[mConfigGlobalConst.AREAN_DUNGEON_ID], self.mTeamVO)
	end);

	s2c:PLAYER_ARENA_FIGHT_RESULT(function(pbArenaReward)
		self:ShowResultView(pbArenaReward);
	end);

	s2c:PLAYER_ARENA_ENEMY(function(pbArenaEnemyList)
		self:Dispatch(mEventEnum.ON_RECV_ARENA_ENEMT, pbArenaEnemyList);
	end);

	s2c:PLAYER_ARENA_PREPARE_FIGHT_ENEMY(function(pbArenaVsPlayerDefense)
		self:OnOpenArenaBattleView(pbArenaVsPlayerDefense, true);
	end);

	s2c:PLAYER_ARENA_FIGHT_ENEMY(function(pbResult)
		mCombatModelManager:CreateArenaCombatModel(mConfigSysglobal_value[mConfigGlobalConst.AREAN_DUNGEON_ID], self.mTeamVO)
	end);

	s2c:PLAYER_ARENA_FIGHT_RESULT_ENEMY(function(pbArenaReward)
		self:ShowResultView(pbArenaReward);
	end);

	s2c:PLAYER_ARENA_RANK(function(pbArenaRankRe)
		self:Dispatch(mEventEnum.ON_RECV_ARENA_RANK, pbArenaRankRe);
	end);
end

function ArenaController:OnOpenCombatView( )
	mUIManager:HandleUI(mViewEnum.ArenaCombatView,1);
end

--事件处理--
function ArenaController:AddEventListeners()
	
end

--打开竞技场
function ArenaController:SendReqOpenArena( )
	self.mC2S:PLAYER_ARENA();
end

--刷新列表
function ArenaController:SendRefreshArena()
	self.mC2S:PLAYER_ARENA_REFRESH();
end

--防守整容
function ArenaController:SendGetArenaDefend(  )	
	self.mC2S:PLAYER_ARENA_DEFENSE_POS();
end

function ArenaController:GetPbArenaDefensePos( selfHeros )
	local parterList = {};
	for index, hero in pairs(selfHeros) do
		if hero:IsFollower() then
			local pbArenaPartnerPosList = {}
			pbArenaPartnerPosList.partner_id = tonumber(hero.mUID);
			pbArenaPartnerPosList.pos = index + 1;
			pbArenaPartnerPosList.team = 1;
			mTable.insert(parterList, pbArenaPartnerPosList);
		end
	end

	return parterList;
end

function ArenaController:OnOpenArenaDedendView( vo )
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( data )
		local partner_pos_list = self:GetPbArenaDefensePos( data.mSelfHeros ) 
		self:SendSaveArenaDefend(partner_pos_list);
	end

	data:InitArenaDefendTeam(mConfigSysglobal_value[mConfigGlobalConst.AREAN_DUNGEON_ID], vo, callBack);
	mUIManager:HandleUI(mViewEnum.ArenaArrayDefendView, 1, data);
end

--保存防守整容
function ArenaController:SendSaveArenaDefend( partner_pos_list )
	self.mC2S:PLAYER_ARENA_DEFENSE_POS_SAVE(partner_pos_list)
end

--挑战准备
function ArenaController:SendPrepareArenaBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_ARENA_PREPARE_FIGHT(player_id);
end

function ArenaController:OnOpenArenaBattleView( pbArenaVsPlayerDefense, revenge )
	local KingController = require "Module/King/KingController"
	self.mRevengeBattle = revenge;
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( data )
		self.mTeamVO = data;
		KingController:GetSkillListData( );
		if revenge then
			self:SendArenaRevengeBattle(self.mPlayerId);
		else
			self:SendArenaBattle(self.mPlayerId);
		end
	end
	data:InitArenaBattleTeam(self.mPlayerId, mConfigSysglobal_value[mConfigGlobalConst.AREAN_DUNGEON_ID], pbArenaVsPlayerDefense, callBack);
	mUIManager:HandleUI(mViewEnum.BattleArrayView, 1, data);
end

--开始挑战
function ArenaController:SendArenaBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_ARENA_FIGHT(player_id);
end

function ArenaController:ShowResultView( pbReward )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitPromoteArenaReward(pbReward, self.mBattleResult);

	if self.mBattleResult == 1 then
		mUIManager:HandleUI(mViewEnum.ArenaBalanceWinView, 1, reward);
	else
		mUIManager:HandleUI(mViewEnum.ArenaBalanceFailView,1, reward);
	end
end

--挑战结果
--复仇挑战结果
function ArenaController:SendArenaBattleResult(result, win_times, fail_times )
	self.mBattleResult = result;

	if self.mRevengeBattle then
		self.mC2S:PLAYER_ARENA_FIGHT_RESULT_ENEMY(self.mPlayerId, result, win_times, fail_times);
	else
		self.mC2S:PLAYER_ARENA_FIGHT_RESULT(self.mPlayerId, result, win_times, fail_times);
	end
end

--仇人列表
function ArenaController:SendGetArenaEnemy(  )
	self.mC2S:PLAYER_ARENA_ENEMY();
end

--复仇挑战准备
function ArenaController:SendPrepareArenaRevengeBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_ARENA_PREPARE_FIGHT_ENEMY(player_id)
end

--复仇挑战
function ArenaController:SendArenaRevengeBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_ARENA_FIGHT_ENEMY(player_id)
end

--排行榜
function ArenaController:RequestArenaRank(  )
	self.mC2S:PLAYER_ARENA_RANK( 1 );
end

local mmArenaControllerInstance = ArenaController.LuaNew();
return mmArenaControllerInstance;