local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mGuideConfig = require "ConfigFiles/ConfigSysguide"
local DebugHelper = DebugHelper;
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mGuideStep = require "Module/Guide/GuideStep"
local mSortTable = require "Common/SortTable"
local mIpairs = ipairs
local GuideModel = mLuaClass("GuideModel",mBaseModel);

function GuideModel:OnLuaNew()
    self.mRunCount = 0;
    self.mGuideId = 1;
    self.mGuideDoneList = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true);
    self.mCheckGuideListener = function () self:CheckAllGuide() end;
    self:AddEventListener(mEventEnum.ON_PLAYER_UPDATE_LEVEL,self.mCheckGuideListener);
    self:AddEventListener(mEventEnum.ON_NEW_DUNGEON_PASS,self.mCheckGuideListener);
end

function GuideModel:Sort(a,b)
    return a.id < b.id;
end

function GuideModel:OnRecvGuideInfo(pbGuideInfo)
    self:CreateGuideDoneList(pbGuideInfo);
end

function GuideModel:CreateGuideDoneList(pbGuideInfo)
    local guideDoneList = self.mGuideDoneList;
    if guideDoneList ~= nil then
        for k,v in ipairs(pbGuideInfo.info) do
            local data = {id=v.id,step=v.step};
            guideDoneList:AddOrUpdate(v.id,data);
        end
        self:SetGuideID(guideDoneList);
    end
end

function GuideModel:SetGuideID(guideDoneList)
  if DebugHelper.sOpenGuide then
      local sortTable = guideDoneList.mSortTable;
      if #sortTable == 0 then
          self.mGuideId = 1;
          self:CheckGuide(self.mGuideId);
          return;
      end

      local guideID = 0;
      for i,v in mIpairs(sortTable) do
          local configGuide = mGuideConfig[v.id];
          if v.step ~= configGuide.last_step then
            guideID = v.id;
          end
      end
      if guideID == 0 then
          self.mGuideId = mGuideConfig[sortTable[#sortTable].id].next_step;
      else
          self.mGuideId = guideID;
      end
      if self.mGuideId ~= 0 then
          self:CheckGuide(self.mGuideId);
      end
  end
end


function GuideModel:OnRecvGuideNotice(pbGuide)
    --print(pbGuide.id,pbGuide.step);
end

function GuideModel:CheckAllGuide()
    if DebugHelper.sOpenGuide then
       for i,v in mIpairs(mGuideConfig) do
          self:CheckGuide(i);
       end
    end
end

function GuideModel:CheckGuide(guide_id)
    local guideCondition = mGuideConfig[guide_id].condition;
    if self:CheckGuideIsDone(guide_id) then
      if mGameModelManager.RoleModel.mPlayerBase.level >= guideCondition[1] then
         if guide_id == self.mGuideId then
            if mGameModelManager.DungeonModel.mLastPassLevel >= guideCondition[3] then
              self.mRunCount = self.mRunCount + 1;
              local step = self:GetStep(guide_id);
              local guideStep = mGuideStep.LuaNew(mGuideConfig[guide_id],guide_id,step,function ()
                  self:RunEndCallBack(guide_id);
              end);
            end
         end
  	  end
    end
end

function GuideModel:CheckGuideIsDone(guide_id)
    local guideDoneList = self.mGuideDoneList.mSortTable;
    if guideDoneList ~= nil then
      for k,v in ipairs(guideDoneList) do
        if v.id == guide_id then
          local configGuide = mGuideConfig[guide_id];
          if configGuide.last_step == v.step then
            return false;
          else
            return true;
          end
        end
      end
    end
    return true;
end

function GuideModel:GetStep(guide_id)
    local guideDoneList = self.mGuideDoneList.mSortTable;
    if guideDoneList ~= nil then
        for k,v in ipairs(guideDoneList) do
            if v.id == guide_id then
                return v.step + 1;
            end
        end
        return mGuideConfig[guide_id].first_step;
    end
end

function GuideModel:RunEndCallBack(guide_id)
    self.mRunCount = self.mRunCount - 1;
    local configGuide = mGuideConfig[guide_id];
    local data = {id=guide_id,step=configGuide.last_step};
    self.mGuideDoneList:AddOrUpdate(guide_id,data);
    self.mGuideId = configGuide.next_step;
    if configGuide.next_step ~= 0 then
        self:CheckGuide(configGuide.next_step);
    end
end

function GuideModel:OnDispose()
    self:RemoveEventListener(mEventEnum.ON_PLAYER_UPDATE_LEVEL,self.mCheckGuideListener);
    self:RemoveEventListener(mEventEnum.ON_NEW_DUNGEON_PASS,self.mCheckGuideListener);
end

return GuideModel;