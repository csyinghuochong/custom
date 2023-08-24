local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGlobalUtil = require "Utils/GlobalUtil"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local PromoteController = mLuaClass("PromoteController",mBaseController);

function PromoteController:AddNetListeners()
	local mS2C = self.mS2C;
	local mEventEnum = self.mEventEnum;

	mS2C:PLAYER_PROMOTE_INFO(function(pbSignInfo)
		local PromoteModel = mGameModelManager.PromoteModel;
		local firstOpen    = PromoteModel.mPbSignInfo == nil;
		PromoteModel:OnUpdateExamInfo(pbSignInfo);
		if firstOpen then 
			if pbSignInfo.status == 2 then
				self:SendReqNpcResult();
			else
				self:Dispatch(mEventEnum.ON_RECV_INFO_FIRST);
			end
		end
	end);
	
	mS2C:PLAYER_PROMOTE_SIGN(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvJoinExam();
	end);

	mS2C:PLAYER_PROMOTE_START(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvExamBegin();
	end);

	mS2C:PLAYER_PROMOTE_ANSWER(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvExamAnswer();
	end);

	mS2C:PLAYER_PROMOTE_RESTART(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvExamRestart();
	end);

	mS2C:PLAYER_PROMOTE_NEXT(function(pbResult)
		mGameModelManager.PromoteModel:OnRecvNextExam();
	end);
	
	mS2C:PLAYER_PROMOTE_RESULT(function(pbNpcResultList)
		mGameModelManager.PromoteModel:OnRecvNpcResult(pbNpcResultList);
	end);

	mS2C:PLAYER_PROMOTE_RESET(function(pbResult)
		self:Dispatch(mEventEnum.ON_GIVE_UP_EXAM);
	end);

	mS2C:PLAYER_PROMOTE_FRIEND(function(pbNpcFreind)
		self:Dispatch(mEventEnum.ON_FRIENDLY_INIT, pbNpcFreind);
	end);

	mS2C:PLAYER_PROMOTE_FRIEND_TO_CHANGE(function(pbResult)
		self:Dispatch(mEventEnum.ON_FRIENDLY_RESULT, pbResult.result);
	end);

	mS2C:PLAYER_PROMOTE_PROMOTE(function(pbResult)
		self:Dispatch(mEventEnum.ON_ROLE_PROMOTE);
	end);
	
	mS2C:PLAYER_PROMOTE_STOP(function(pbResult)
		
	end);

	mS2C:PLAYER_PROMOTE_FIGHT_PLAYER(function(pbVsPlayer)
		--判断是否是机器人
		--[[self.mPlayerId = pbVsPlayer.player_id;
		local player_id = tonumber(pbVsPlayer.player_id);
		print('武考开始: ', player_id)
		if player_id < mGlobalUtil.RobotMaxId then
			print('机器人')
			self:OnOpenPVPBattleView(player_id, nil);
		else
			print('准备武考')
			self:SendPreparePVPBattle(player_id);
		end--]]
	end);

	mS2C:PLAYER_PROMOTE_FIGHT_PREPARE(function(pbVsPlayerDefense)
		---self:OnOpenPVPBattleView(self.mPlayerId, pbVsPlayerDefense);
	end);

	mS2C:PLAYER_PROMOTE_FIGHT_START(function(pbResult)
		mCombatModelManager:CreatePromotePVPCombatModel(mConfigSysglobal_value[mConfigGlobalConst.PROMOTE_PVP_DUNGEON], self.mTeamVO);
	end);

	mS2C:PLAYER_PROMOTE_FIGHT_RESULT(function(pbResult)
		
	end);

	mS2C:PLAYER_PROMOTE_ARENA_RANK(function(pbRankRe)
		self:Dispatch(mEventEnum.ON_RECV_PROMOTE_RANK, pbRankRe);
	end);
end

function PromoteController:AddEventListeners()

end

function PromoteController:OnOpenCombatView()
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

--时装考试
function PromoteController:OnFashionReturn(  )
	mGameModelManager.PromoteModel:OnFashionReturn();
end

--武斗考试
function PromoteController:OnPVPReturn(  )
	mGameModelManager.PromoteModel:OnPVPReturn();
end

--查看考试
function PromoteController:SendReqSignInfo( office_id )
	self.mC2S:PLAYER_PROMOTE_INFO(office_id,true);
end

--报名考试
function PromoteController:SendJoinExam(  )
	self.mC2S:PLAYER_PROMOTE_SIGN(true);
end

--开始考试
function PromoteController:SendBeginExam( exam_type )
	if exam_type ==  4 then
		--晋封武考直接用机器人
		local player_id = mGameModelManager.PromoteModel:GetPVPRobot();
		self:OnOpenPVPBattleView(player_id);
	else
		self.mC2S:PLAYER_PROMOTE_START(true);
	end
end

--考试答案
function PromoteController:SendExamAnswer( ids )
	self.mC2S:PLAYER_PROMOTE_ANSWER(ids,true);
end

--重新当前
function PromoteController:SendAgainCurrent(  )
	self.mC2S:PLAYER_PROMOTE_RESTART(true);
end

--下一关
function PromoteController:SendBeginNextExam(  )
	self.mC2S:PLAYER_PROMOTE_NEXT(true);
end

--考试结果
function PromoteController:SendReqNpcResult(  )
	self.mC2S:PLAYER_PROMOTE_RESULT(true);
end

--放弃重考
function PromoteController:SendGiveUpExam( )
	self.mC2S:PLAYER_PROMOTE_RESET(true);
end

--友好界面
function PromoteController:SendOpenFriendlyView(  npc_id )
	self.mC2S:PLAYER_PROMOTE_FRIEND(npc_id,true);
end

--友好考官
function PromoteController:SendNpcFriendly( npc_id )
	self.mC2S:PLAYER_PROMOTE_FRIEND_TO_CHANGE( npc_id ,true);
end

--晋封
function PromoteController:SendRolePromote(  )
	self.mC2S:PLAYER_PROMOTE_PROMOTE(true);
end

--提前结束
function PromoteController:SendStopExam(  )
	self.mC2S:PLAYER_PROMOTE_STOP(true);
end

--晋封战斗考试准备
function PromoteController:OnOpenPVPBattleView(player_id)
	local data = mBattleArrayViewVO.LuaNew();
	local callBack = function ( data )
		self.mTeamVO = data;
		self.mC2S:PLAYER_PROMOTE_START();
		self:SendPromotePVPBattle(player_id);
	end
	data:InitArenaBattleTeam(player_id, mConfigSysglobal_value[mConfigGlobalConst.PROMOTE_PVP_DUNGEON], nil, callBack, true);
	mUIManager:HandleUI(mViewEnum.BattleArrayView, 1, data);
end
--晋封战斗考试
function PromoteController:SendPromotePVPBattle( player_id )
	self.mPlayerId = player_id;
	self.mC2S:PLAYER_PROMOTE_FIGHT_START( player_id );
end

--晋封战斗考试结果
function PromoteController:SendPVPBattleResult(  result, left_num, total_num )
	self.mC2S:PLAYER_PROMOTE_FIGHT_RESULT(self.mPlayerId, result, left_num, total_num)
end

--积分排行榜
function PromoteController:RequestPromoteRank(  )
	self.mC2S:PLAYER_PROMOTE_ARENA_RANK( 1 );
end

local mPromoteControllerInstance = PromoteController.LuaNew();
return mPromoteControllerInstance;
