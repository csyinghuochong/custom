local mLuaClass = require "Core/LuaClass"
local mTimeUtil = require "Utils/TimeUtil"
local DianfenggongdouEnemyVO = mLuaClass("DianfenggongdouEnemyVO");
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgBattleRecord = mLanguageUtil.promote_battle_record

function DianfenggongdouEnemyVO:OnLuaNew(pbEnemy)
	self.mPlayerId = pbEnemy.player_id;
	self.mName = pbEnemy.name;
	self.mTime = pbEnemy.time;
	self.mLoseScore = pbEnemy.lose_score;
end

function DianfenggongdouEnemyVO:GetContent()
	return string.format(mLgBattleRecord, mTimeUtil:TransToYearMonthDayHMS(self.mTime), self.mLoseScore);
end

return DianfenggongdouEnemyVO;
