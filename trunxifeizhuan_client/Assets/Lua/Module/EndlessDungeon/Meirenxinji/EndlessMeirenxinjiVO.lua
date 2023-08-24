local mLuaClass = require "Core/LuaClass"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mConfigSysrobot = require "ConfigFiles/ConfigSysrobot"
local mRobotBaseVO = require "Module/Follower/RobotBaseVO"
local mSortTable = require "Common/SortTable"
local mEndlessMeirenxinjiItemVO = require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenxinjiItemVO"
local EndlessMeirenxinjiVO = mLuaClass("EndlessMeirenxinjiVO");

local MEIREN_FIRST = 1601000;

function EndlessMeirenxinjiVO:OnLuaNew(battleID,buffs,targetData,status)
   self.mBattleID = battleID;
   self.mBuffs = buffs;
   self.mStatus = status;
   self.mData_soure = mSortTable.LuaNew(nil,nil,true);
   self:SetTargetInfo(targetData);
end

function EndlessMeirenxinjiVO:GetConfig()
	return mConfigSysdungeon[self.mBattleID];
end

function EndlessMeirenxinjiVO:SetTargetInfo(targetData)
   local data_soure = self.mData_soure;
   if data_soure ~= nil then
      for k,v in ipairs(targetData) do
         local data;
         if v.id ~= nil and v.id ~= 0 then
            local robotConfig = mConfigSysrobot[v.id];
            data = mEndlessMeirenxinjiItemVO.LuaNew(k,robotConfig.name,mRobotBaseVO:GetRobotSex(v.id),mRobotBaseVO:GetRobotLevel(v.id),nil,v.id);
         else
            data = mEndlessMeirenxinjiItemVO.LuaNew(k,v.other_base.name,v.other_base.sex,v.other_base.level,v.defense,nil);
         end
         data_soure:AddOrUpdate(k,data);
      end
   end
end

function EndlessMeirenxinjiVO:CreateDefense()
   local data_soure = self.mData_soure;
   if data_soure ~= nil then
      local sortTable = data_soure.mSortTable;
      local id = self.mBattleID - MEIREN_FIRST;
      self.mDefense = sortTable[id].mDefense;
      self.mRobotId = sortTable[id].mRobotID;
   end
end

return EndlessMeirenxinjiVO;