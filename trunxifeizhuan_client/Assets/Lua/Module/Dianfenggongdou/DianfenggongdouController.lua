local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGlobalUtil = require "Utils/GlobalUtil"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mCommonRewardVO = require "Module/Dianfenggongdou/DianfengBalanceRewardVO"
local DianfenggongdouController = mLuaClass("DianfenggongdouController",mBaseController);

function DianfenggongdouController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function DianfenggongdouController:AddNetListeners()
	local mS2C = self.mS2C;
	local mEventEnum = self.mEventEnum;

	mS2C:PLAYER_PROMOTE_ARENA(function(pbPromoteArena)
		mGameModelManager.PromoteModel:OnRecvArenaInfo(pbPromoteArena);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_REFRESH(function(pbPromoteArena)
		mGameModelManager.PromoteModel:OnRecvArenaRefresh(pbPromoteArena);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_BUY_TIMES(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvBuyArenaTime();
	end);

	mS2C:PLAYER_PROMOTE_ARENA_DEFENSE_POS(function(pbDefensePos)
		local PromoteModel = mGameModelManager.PromoteModel;
		local defendTeam = PromoteModel.mPromoteArenaDefendTeam;
		if defendTeam == nil  then 
			self:OnOpenArenaDedendView(pbDefensePos);
		end
		PromoteModel.mPromoteArenaDefendTeam = pbDefensePos;
	end);

	mS2C:PLAYER_PROMOTE_ARENA_DEFENSE_SAVE(function(pbResult)
		
	end);

	mS2C:PLAYER_PROMOTE_ARENA_PREPARE(function(pbVsPlayerDefense)
		self.mPbVsPlayerDefense = pbVsPlayerDefense;
		self:OnOpenArenaBattleView(pbVsPlayerDefense);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_FIGHT(function(pbResult)
		mCombatModelManager:CreateDianfenggongdouCombatModel( mConfigSysglobal_value[mConfigGlobalConst.DIANFENG_DUNGEON_ID], self.mTeamVO)
	end);

	mS2C:PLAYER_PROMOTE_ARENA_RESULT(function(pbReward)
		self:ShowResultView(pbReward);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_ENEMY_LIST(function(pbEnemyList)
		self:Dispatch(mEventEnum.ON_RECV_PROMOTE_ENEMT, pbEnemyList);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_ENEMY_PREPARE(function(pbVsPlayerDefense)
		self.mPbVsPlayerDefense = pbVsPlayerDefense;
		self:OnOpenArenaRevengeView(pbVsPlayerDefense);
	end);

	mS2C:PLAYER_PROMOTE_ARENA_ENEMY_FIGHT(function(pbResult)
		mCombatModelManager:CreateDianfenggongdouCombatModel( mConfigSysglobal_value[mConfigGlobalConst.DIANFENG_DUNGEON_ID], self.mTeamVO)
	end);

	mS2C:PLAYER_PROMOTE_ARENA_ENEMY_RESULT(function(pbReward)
		self:ShowResultView(pbReward);
	end);
end

function DianfenggongdouController:AddEventListeners()

end

--巅峰宫斗
function DianfenggongdouController:SendReqOpenArena(  )
	self.mC2S:PLAYER_PROMOTE_ARENA();
end

--刷新列表
function DianfenggongdouController:SendArenaRefresh(  )
	self.mC2S:PLAYER_PROMOTE_ARENA_REFRESH();
end

--购买次数
function DianfenggongdouController:SendBuyArenaTimes(  )
	self.mC2S:PLAYER_PROMOTE_ARENA_BUY_TIMES();
end

--获取防守阵容
function DianfenggongdouController:SendGetArenaDefend(  )
	local defendTeam = mGameModelManager.PromoteModel.mPromoteArenaDefendTeam;
	if defendTeam == nil  then 
		self.mC2S:PLAYER_PROMOTE_ARENA_DEFENSE_POS();
	else
		self:OnOpenArenaDedendView(defendTeam);
	end
end

function DianfenggongdouController:OnOpenArenaDedendView( vo )
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( pbDefensePos )
		self:SendSaveArenaDefend(pbDefensePos);
		mGameModelManager.PromoteModel.mPromoteArenaDefendTeam = pbDefensePos;
	end

	data:InitPromoteArenaDefendTeam(vo, callBack);
	mUIManager:HandleUI(mViewEnum.DianfengArrayDefendView, 1, data);
end

--保存防守阵容
function DianfenggongdouController:SendSaveArenaDefend( pbDefensePos )
	self.mC2S:PLAYER_PROMOTE_ARENA_DEFENSE_SAVE(pbDefensePos.partner_pos_list);
end

--准备挑战
function DianfenggongdouController:SendPrepareArenaBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_PROMOTE_ARENA_PREPARE(player_id);
end

function DianfenggongdouController:OnOpenArenaBattleView( pbVsPlayerDefense )
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( data )
		self.mTeamVO = data;
		self.mRevengeBattle = false;
		self:SendArenaBattle(self.mPlayerId);
	end
	data:InitPromoteArenaBattleTeam(mConfigSysglobal_value[mConfigGlobalConst.DIANFENG_DUNGEON_ID], pbVsPlayerDefense, callBack);
	mUIManager:HandleUI(mViewEnum.DianfengArrayBattleView, 1, data);
end

--开始挑战
function DianfenggongdouController:SendArenaBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_PROMOTE_ARENA_FIGHT(player_id);
end

function DianfenggongdouController:SendArenaBattleResult( result, win_times, fail_times )
	self.mBattleResult = result;
	local player_id = self.mPlayerId;

	--复仇挑战结果
	--挑战结果
	if self.mRevengeBattle then
		self.mC2S:PLAYER_PROMOTE_ARENA_ENEMY_RESULT(player_id, result, win_times, fail_times)
	else
		mGameModelManager.PromoteModel:OnRecvBattleResult(player_id, result);
		self.mC2S:PLAYER_PROMOTE_ARENA_RESULT(player_id, result, win_times, fail_times);
	end
end

function DianfenggongdouController:ShowResultView( pbReward )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitPromoteArenaReward(pbReward, self.mBattleResult);

	if self.mBattleResult == 1 then
		mUIManager:HandleUI(mViewEnum.ArenaBalanceWinView, 1, reward);
	else
		mUIManager:HandleUI(mViewEnum.ArenaBalanceFailView,1, reward);
	end
end

--仇人列表
function DianfenggongdouController:SendGetArenaEnemy(  )
	self.mC2S:PLAYER_PROMOTE_ARENA_ENEMY_LIST()
end

--准备复仇挑战
function DianfenggongdouController:SendPrepareArenaRevengeBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_PROMOTE_ARENA_ENEMY_PREPARE(player_id)
end

function DianfenggongdouController:OnOpenArenaRevengeView( pbVsPlayerDefense )
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( data )
		self.mTeamVO = data;
		self.mRevengeBattle = true;
		self:SendArenaRevengeBattle(self.mPlayerId);
	end
	data:InitPromoteArenaBattleTeam(mConfigSysglobal_value[mConfigGlobalConst.DIANFENG_DUNGEON_ID], pbVsPlayerDefense, callBack);
	mUIManager:HandleUI(mViewEnum.DianfengArrayBattleView, 1, data);
end

--复仇挑战
function DianfenggongdouController:SendArenaRevengeBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_PROMOTE_ARENA_ENEMY_FIGHT(player_id)
end

local mDianfenggongdouControllerInstance = DianfenggongdouController.LuaNew();
return mDianfenggongdouControllerInstance;