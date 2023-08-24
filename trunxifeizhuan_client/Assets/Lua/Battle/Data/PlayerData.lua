local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysactor = require"ConfigFiles/ConfigSysactor"
local PlayerData = LuaClass("PlayerData",BaseLua);
local FollowerData = require "Battle/Data/FollowerData"
local SkillData = require "Battle/Data/SkillData";
local DebugHelper = DebugHelper;
function PlayerData:OnLuaNew()
	self.mSkills = {};
	self.mFollowers = {};
	self.mCamp = 1;
	self.mLevel = 1;
	self.mSex = 1;--性别
end

function PlayerData:SetLevel(lv)
	self.mLevel = lv;
end

--阵营
function PlayerData:SetCamp(camp)
	self.mCamp = camp;
	self.mConfig = mConfigSysactor[camp];
end

function PlayerData:SetSex(sex)
	self.mSex = sex;
	self.mModel = sex;
end
function PlayerData:GetModel()
	return self.mModel;
end

function PlayerData:GetSkills()
	return self.mSkills;
end

local mTestFollowers = {21000,22000,23000,24000,25000};
function PlayerData:DemoInit()

	local testId = DebugHelper.sTestFollower;
	--local actors = {21001,22001,23001,24001,25001};
	local followers = {};
	local follower = nil;
	for i = 1,5 do
		follower = FollowerData.LuaNew(mTestFollowers[i]+testId);
		follower:SetOffice(3);
		followers[i] = follower;
	end

	self.mFollowers = followers;
end

function PlayerData:CalculateAttributes()
end

return PlayerData;