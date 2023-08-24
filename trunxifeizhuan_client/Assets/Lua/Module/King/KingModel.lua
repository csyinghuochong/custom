local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mKingMonarchVO = require "Module/King/KingMonarchVO"
local mGraceSkillVO = require "Module/King/GraceSkillVO"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mGraceConfig = require "ConfigFiles/ConfigSysgrace_skill"
local mSortTable = require "Common/SortTable"
local mIpairs = ipairs
local KingModel = mLuaClass("KingModel",mBaseModel);

function KingModel:OnLuaNew()
   self:InitSkillList();
end

function KingModel:InitSkillList()
   local inviteSkillList = mSortTable.LuaNew(function(a, b) return a.mSkillID < b.mSkillID end, nil, true);
   local graceSkillList = mSortTable.LuaNew(function(a, b) return a.mSkillID < b.mSkillID end, nil, true);
   for i,v in pairs(mGraceConfig) do
      local skillType = v.skill_type;
      if skillType == 1 then
         inviteSkillList:AddOrUpdate(v.skill,mGraceSkillVO.LuaNew(v.skill,0,0));
      elseif skillType == 2 then
         graceSkillList:AddOrUpdate(v.skill,mGraceSkillVO.LuaNew(v.skill,0,0));
      end
   end
   self.mInviteSkillList = inviteSkillList;
   self.mGraceSkillList = graceSkillList;
end

function KingModel:RecvMonarchUpdate(pbMoarchAudience)
   local monarchVO = self.mMonarchVO;
   if monarchVO == nil then
      monarchVO = mKingMonarchVO.LuaNew(pbMoarchAudience.id,pbMoarchAudience.mood);
   else
      monarchVO.mMonarchID = pbMoarchAudience.id;
      monarchVO.mMood = pbMoarchAudience.mood;
   end
end

function KingModel:RecvMonarchOpen(id)
	local monarchVO = mKingMonarchVO.LuaNew();
	monarchVO.mMonarchID = id;
	self.mMonarchVO = monarchVO;
end

function KingModel:RecvMonarchReward(pbMonarchAudienceResult)
   local reward = mSortTable.LuaNew();
   for i,v in mIpairs(pbMonarchAudienceResult.list) do
      reward:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v.id,v.count,nil,false));
   end
   self.mMonarchReward = reward;
end

function KingModel:GetTotalAttribute( )
    local skillList = self.mInviteSkillList;
    local totalAttri = { };
    for i = 1, 11 do
      totalAttri[ i ] = 0;
    end
    for k, v in pairs ( skillList.mSortTable ) do
        if v.mLevel > 0 then
          local king_attri = v:GetLevelConfig( ).king_attri;
          if king_attri then
            for kk, vv in pairs ( king_attri ) do
              local key = vv.key;
              if key > 0 and key < 12 then
                totalAttri[ key ] = totalAttri[ key ] + vv.value;
              end
            end
          end
        end
    end

    return totalAttri;
end

function KingModel:RecvSkillData(pbMonarchGetSkills)
   local skillType = pbMonarchGetSkills.type;
   local skillSortTable = nil;
   if skillType == 1 then
      self.mInviteRecv = true;
      skillSortTable = self.mInviteSkillList;
   elseif skillType == 2 then
      self.mGraceRecv = true;
      skillSortTable = self.mGraceSkillList;
   end
   for i,v in mIpairs(pbMonarchGetSkills.list) do
       local skillData = skillSortTable:GetValue(v.id);
       if skillData ~= nil then
          skillData.mLevel = v.level;
          skillData.mExp = v.exp;
          skillSortTable:AddOrUpdate(v.id,skillData);
       end
   end
end

return KingModel;