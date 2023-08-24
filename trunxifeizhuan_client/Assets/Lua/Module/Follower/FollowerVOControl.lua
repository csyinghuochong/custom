local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mConfigSysrobot = require "ConfigFiles/ConfigSysrobot"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local mConfigSysmonster_ratio = require "ConfigFiles/ConfigSysmonster_ratio"
local FollowerVOControl = mLuaClass("FollowerVOControl");
local mTable = table;
local mParis = pairs;

function FollowerVOControl:OnLuaNew()
	
end

--敌方玩家或者随从数据最好统一用这个结构
function FollowerVOControl:CreatePromoteArenaActor( pbArenaVsPlayerPartner,  fashion_list)
	local actor;
	if pbArenaVsPlayerPartner.is_main == 1 then
		actor = mLeadBaseVO.LuaNew();
		actor:InitFashionList( pbArenaVsPlayerPartner.fashion_list );
	else
		actor = mFollowerBaseVO.LuaNew();
	end
	actor:InitPromoteArenaData(pbArenaVsPlayerPartner);
	return actor;
end

--默认随从数据，招贤用来显示的
function FollowerVOControl:CreateConfigFollowerVO(id)
	local actor = mFollowerBaseVO.LuaNew();
	actor:InitConfigActorVO(mConfigSysactor[id]);
    return actor;
end

--机器人数据
function FollowerVOControl:CreateRobotVO(player_id)
	local followerList = {};
	local robot = mConfigSysrobot[player_id];
	if robot ~= nil then
		for k, v in mParis(robot.partner_list) do
			local item = self:CreateRobotActor( k, robot, v );
			mTable.insert(followerList, item);
		end
	else
		print('ConfigSysarene_robot == nil.....', player_id);
	end

	return followerList;
end
function FollowerVOControl:CreateRobotActor( k, robot, partnerVo )
	local actor;
	if k == 1 then
		actor = require('Module/Arena/ArenaLeadVO').LuaNew();
	else
		actor = require('Module/Follower/RobotBaseVO').LuaNew();
	end
	actor:InitRobotActorVO( k == 1, robot, partnerVo);
	return actor;
end

return FollowerVOControl;