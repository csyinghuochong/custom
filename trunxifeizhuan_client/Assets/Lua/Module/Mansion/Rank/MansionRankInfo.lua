local mLuaClass = require "Core/LuaClass"
local mConfigSysrank = require "ConfigFiles/ConfigSysrank"
local ConfigSysmansion_level = require "ConfigFiles/ConfigSysmansion_level"
local MansionRankInfo = mLuaClass("MansionRankInfo");
local mPairs = pairs;

--繁荣度->府邸等级
function MansionRankInfo:GetLevelByBoom( boom )
	local level = 1;
	local number = #ConfigSysmansion_level;
	for i = 1, number do
		if boom >= ConfigSysmansion_level[ i ].boom_need then
			level = i;
		end
	end
	return level;
end

--排名->奖励
function MansionRankInfo:GetAwardByRank( op_type, rank )
	local rank_vo = mConfigSysrank[ op_type ].rank_award;

	for k, v in mPairs( rank_vo ) do
		local region = v.rank;
		if ( rank >= region[1] and rank <= region[2] ) or region[2] == -1 then
			return v.award_goods[1].goods_number;
		end
	end 

	return 0;
end

return MansionRankInfo;