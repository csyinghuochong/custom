local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mCampDungeonBossVO = require "Module/CampDungeon/CampDungeonBossVO"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mCampDungeonLevelVO = require "Module/CampDungeon/CampDungeonBossLevelVO"
local mSortTable = require "Common/SortTable"
local mEventEnum = require "Enum/EventEnum"
local mipairs = ipairs
local mCampDungeonController = require "Module/CampDungeon/CampDungeonController"
local CampDungeonModel = mLuaClass("CampDungeonModel",mBaseModel);

function CampDungeonModel:OnLuaNew()

end

function CampDungeonModel:RecvCampToDungeonData(pbDungeonList)
    local camp_list = mSortTable.LuaNew(function(a, b) return a.mSysVO.chapter_index < b.mSysVO.chapter_index end, nil, true)

	for k, v in mipairs(pbDungeonList.list) do
		local camp_id= v.dungeon_id;
		if  camp_id ~= nil then
			local camp_data = mCampDungeonBossVO.LuaNew(camp_id,v.top_id,v.timestamp);
			camp_list:AddOrUpdate(camp_id,camp_data);
		end
	end


    for i,v in mipairs(camp_list.mSortTable) do
    	local maxCount = v.mSysVO.dungeon_count;
    	local start_id = v.mSysVO.start_id;
    	local count = 0;
    	while count < maxCount do
    		local id = start_id + count;
    		local value = mConfigSysdungeon[id];
		    local top_id = v.mPassID;
		    local state = 0;
		    if top_id == value.prev_dungeon then
                 state = 2;
		    elseif top_id >= id then
                 state = 1;
		    elseif top_id < id and top_id ~= value.prev_dungeon then
                 state = 3;
            end
		    local data_item = mCampDungeonLevelVO.LuaNew(id,value,state);
		    v.mDungeonList:AddOrUpdate(id,data_item);
		    local passIndex = top_id == 0 and 0 or top_id - value.chapter_id * 1000;
		    local nextIndex = passIndex == maxCount and maxCount or passIndex + 1;
		    if nextIndex == value.index then
		       v.mSelectLevel = data_item;
		    end
		    count = count + 1;
    	end 
    end
	self.mCampList = camp_list;
end

function CampDungeonModel:RecvFollower(pbDungeonPartnerInfo)
	local id = pbDungeonPartnerInfo.past_id;
	local config = mConfigSysdungeon[id];
	local data = self:GetDungeonData(config.chapter_id,id);
	data:CreateFollower(pbDungeonPartnerInfo.partner_list);
	self:Dispatch(mEventEnum.ON_CAMP_DUNGEON_RESET_FOLLOWERLIST_SIZE,#pbDungeonPartnerInfo.partner_list);
end

function CampDungeonModel:GetSelectCamp(campID)
	local campList = self.mCampList;
	if campID ~= nil then
       return campList:GetValue(campID);
	else
       return campList.mSortTable[1];
	end
end

function CampDungeonModel:GetOpenLevel(campID,levelID)
	local campData = self.mCampList:GetValue(campID);
	if campData == nil then
		return nil;
	end
	local data = campData.mDungeonList:GetValue(levelID);
	if data.mState == 1 then
       return data;
	end
    return nil;
end

function CampDungeonModel:GetDungeonData(campID,levelID)
	local campData = self.mCampList:GetValue(campID);
	if campData == nil then
		return nil;
	end
	local data = campData.mDungeonList:GetValue(levelID);
	if not data.mIsGetFollower then
		data.mIsGetFollower = true;
		mCampDungeonController:SendGetDungeonFollower(data.mID);
	end
	return data;
end

function CampDungeonModel:GetMaxDungeonID(campID)
	local campData = self.mCampList:GetValue(campID);
	if campData == nil then
		return nil;
	end
	local data = nil;
	local sortTable = campData.mDungeonList.mSortTable;
	for k,v in ipairs(sortTable) do
		if v.mState == 2 then
			return v.mID;
		end
	end
	local count = #sortTable;
	return sortTable[count].mID;
end

function CampDungeonModel:RefreshPassLevel(campID,levelID)
	local campData = self.mCampList:GetValue(campID);
	local pass_id = levelID;
	if campData == nil then
		return;
	end
	local data = campData.mDungeonList:GetValue(pass_id);
	if campData.mPassID ~= data.mSysVO.prev_dungeon then
       return;
	end
	campData.mPassID = data.mID;
	data.mState = 1;
	campData.mDungeonList:AddOrUpdate(pass_id,data);
	local nextLevel = data.mSysVO.next_dungeon;
	if nextLevel ~= nil and nextLevel ~= 0 then
	   local nextLevelData = campData.mDungeonList:GetValue(nextLevel);
	   nextLevelData.mState = 2;
	   campData.mDungeonList:AddOrUpdate(nextLevel,nextLevelData);
       campData.mSelectLevel = campData.mDungeonList:GetValue(nextLevel);
	end
	self:Dispatch(mEventEnum.ON_CAMP_DUNGEON_PASS_LEVEL);
end

return CampDungeonModel;