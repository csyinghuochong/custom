local mLuaClass = require "Core/LuaClass"
local mGlobalUtil = require "Utils/GlobalUtil"
local mRobotBaseVO = require "Module/Follower/RobotBaseVO"
local mConfigSysrobot = require "ConfigFiles/ConfigSysrobot"
local ConfigSysarena_division = require "ConfigFiles/ConfigSysarena_division";
local ArenaRankItemVO = mLuaClass("ArenaRankItemVO");
local mPairs = pairs;

function ArenaRankItemVO:OnLuaNew(data)
	self.rank = data.rank;
	self.id = data.player_id;
	self.name = data.name;
	self.sex = data.sex;
	self.position = data.position;
	self.score = data.score;
	self.lv = data.lv;
	self.mRobot = false;
	self:InitRobotVo( data );
end

function ArenaRankItemVO:InitRobotVo( vo )
	local player_id = vo.player_id;
	if self:IsRobotPlayer( player_id ) then
		local robot = mConfigSysrobot[player_id];
		self.sex = mRobotBaseVO:GetRobotSex(player_id);
		self.lv = mRobotBaseVO:GetRobotLevel(player_id);
		self.name = robot.name;
		self.position = 1;
		self.mRobot = true;
	end
end

function ArenaRankItemVO:IsRobotPlayer( player_id )
	return player_id < mGlobalUtil.RobotMaxId;
end

function ArenaRankItemVO:GetDivisionVoByScore( score )
	for k, v in mPairs ( ConfigSysarena_division ) do
		if score >= v.score[1] and score <= v.score[2] then
			return v;
		end
	end
	local number = #ConfigSysarena_division;
	return ConfigSysarena_division[ number ];
end

return ArenaRankItemVO;