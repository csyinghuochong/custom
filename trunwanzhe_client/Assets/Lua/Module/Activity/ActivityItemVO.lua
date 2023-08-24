local mLuaClass = require "Core/LuaClass"
local ActivityType = require "Module/Activity/ActivityType";
local mActivityItemLevelVO = require "Module/Activity/ActivityItemLevelVO"
local mActivityItemPowerVO = require "Module/Activity/ActivityItemPowerVO"
local mActivityItemStageVO = require "Module/Activity/ActivityItemStageVO"
local ActivityItemVO = mLuaClass("ActivityItemVO");

function ActivityItemVO:OnLuaNew(activity_type, id, call_back)
    self.mID = id;
	self.mType = activity_type;
    self.mCallBack = call_back;

    local vo = nil;
    if activity_type == ActivityType.Level then
    	vo = mActivityItemLevelVO.LuaNew(id, activity_type);
    elseif activity_type == ActivityType.Power then
    	vo = mActivityItemPowerVO.LuaNew(id, activity_type);
    else
    	vo = mActivityItemStageVO.LuaNew(id, activity_type);
    end
    self.mVO = vo;
end

function ActivityItemVO:GetGoodsList()
    return self.mVO:GetGoodsList();
end

function ActivityItemVO:GetTextTitle()
    return self.mVO:GetTextTitle();
end

return ActivityItemVO;