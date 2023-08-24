local mLuaClass = require "Core/LuaClass"
local mTimeUtil = require "Utils/TimeUtil"
local ArenaRecordVO = mLuaClass("ArenaRecordVO");
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgBattleRecord = mLanguageUtil.arena_battle_record

function ArenaRecordVO:OnLuaNew(pbEnemy)
	self.mPlayerId = pbEnemy.player_id;
	self.mName = pbEnemy.name;
	self.mTime = pbEnemy.time;
	self.mLoseScore = pbEnemy.lose_score;
	self.mRevengeResult = pbEnemy.vs_result;
end

function ArenaRecordVO:GetContent()
	return string.format(mLgBattleRecord, mTimeUtil:TransToYearMonthDayHMS(self.mTime), self.mLoseScore);
end

return ArenaRecordVO;