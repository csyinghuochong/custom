local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local CommonRewardVO = require "Module/CommonUI/CommonRewardVO";
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local ArenaBalanceRewardVO = mLuaClass("ArenaBalanceRewardVO",CommonRewardVO);

function ArenaBalanceRewardVO:GetSelfPlayerVO(  )
	return mGameModelManager.FollowerModel:GetLeadVO();
end

function ArenaBalanceRewardVO:GetEnemyPlayerVO(  )
	local enemyList = mCombatModelManager.mCurrentModel.mTeamVO.mEnemyHeros;
	for key, vo in pairs ( enemyList ) do
		if vo:IsLead( ) then
			return vo;
		end
	end
end

function ArenaBalanceRewardVO:GetSelfScoreVO(  )
	local result = self.mBattleResult;
	return mGameModelManager.ArenaModel.mArenaInfo.score, self.mPbReward.score* ( result == 1 and 1 or - 1 );
end

function ArenaBalanceRewardVO:GetSelfMoneyVO(  )
	local arena_add = self.mPbReward.arena_coin;
	local arena_coin = mGameModelManager.RoleModel.mPlayerBase.arena_coin;
	return arena_coin - arena_add, arena_add;
end

function ArenaBalanceRewardVO:GetEnemyScoreVO(  )
	local p_reward = self.mPbReward;
	local result = self.mBattleResult;
	return p_reward.vs_player_score, p_reward.lose_score * ( result == 1 and -1 or 1 );
end

return ArenaBalanceRewardVO;