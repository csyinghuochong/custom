local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mArchiveVO = require "Module/Archive/ArchiveVO"
local ArchiveModel = mLuaClass("ArchiveModel",mBaseModel);

function ArchiveModel:OnLuaNew()
	self.mTypeTable = {};
	self.mNumTable = {0,0,0,0,0};
	self.mNowIndex = 1;
	self:CreateTable();
end

function ArchiveModel:CreateTable()
	for i=1,5 do
		local data_soure = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true)
		self.mTypeTable[i] = data_soure;
	end
end

function ArchiveModel:Sort(a,b)
	if a.mConfig.star == b.mConfig.star then	
		return a.id < b.id;
	else
		return a.mConfig.star < b.mConfig.star
	end
end

function ArchiveModel:CreateList(follower_list)
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in ipairs(follower_list) do
		local follower = data_soure.mRawTable[v.mID];
		if follower ~= nil then
			follower:OnAdd();
			data_soure:AddOrUpdate(follower.id,follower);
		else
			local newFollower = mArchiveVO.LuaNew(v.mID,1)
			data_soure:AddOrUpdate(newFollower.id,newFollower);
		end
	end
	self.mFollowerDataSoure = data_soure;
	self.mIsEverCreateList = true;
end

function ArchiveModel:RecvDraftShowList(pbDraftShow)
	local data_soure = self.mFollowerDataSoure;
	for k,v in ipairs(pbDraftShow.partner_id) do
		local follower = data_soure.mRawTable[v];
		if follower ~= nil then
			follower:OnAdd();
			data_soure:AddOrUpdate(follower.id,follower);
		else
			local newFollower = mArchiveVO.LuaNew(v,1)
			data_soure:AddOrUpdate(newFollower.id,newFollower);
		end
	end
	self:CreateData(data_soure.mRawTable);
	self:Dispatch(self.mEventEnum.ON_GET_ARCHIVE_LIST);
end

function ArchiveModel:CreateData(rawTable)
	local typeTable = self.mTypeTable;
	for k,v in pairs(mConfigSysactor) do
		if v.camp ~= 0 and v.career >= 5 and v.isopen == 1 then
			local follower = rawTable[v.actor];
			local data;
			if follower ~= nil then
				data = mArchiveVO.LuaNew(follower.id,follower.num);
				self.mNumTable[v.camp] = self.mNumTable[v.camp] + 1;
			else
				data = mArchiveVO.LuaNew(v.actor,0)
			end
			typeTable[v.camp]:AddOrUpdate(data.id,data)
		end
	end
end

function ArchiveModel:AddFollower(follower_vo)
	if not self.mIsEverCreateList then
		self:CreateList({});
	end
	local camp = follower_vo.mPowerID;
	local typeTable = self.mTypeTable;
	local rawTable = typeTable[camp].mRawTable;
	local data = rawTable[follower_vo.mID];
	if data ~= nil then
		if data.num <= 0 then
			self.mNumTable[camp] = self.mNumTable[camp] + 1;
		end
		data:OnAdd();
		typeTable[camp]:AddOrUpdate(data.id,data);
	end
end

-- function ArchiveModel:DeleteFollower(follower_id)
-- 	local camp = mConfigSysactor[follower_id].camp;
-- 	local typeTable = self.mTypeTable;
-- 	local rawTable = typeTable[camp].mRawTable;
-- 	local data = rawTable[follower_id];
-- 	data:OnMinus();
-- 	if data.num <= 0 then
-- 		self.mNumTable[camp] = self.mNumTable[camp] - 1;
-- 	end
-- 	typeTable[camp]:AddOrUpdate(data.id,data);
-- end

function ArchiveModel:GetPageNum(index)
	local sortTable = self.mTypeTable[index].mSortTable;
	return self.mNumTable[index],#sortTable;
end

function ArchiveModel:GetAllNum()
	local num = 0;
	local allNum = 0;
	for i=1,5 do
		local num1,num2 = self:GetPageNum(i);
		num = num + num1;
		allNum = allNum + num2;
	end
	return num,allNum;
end

function ArchiveModel:GetLastID(selectIndex)
	local sortTable = self.mTypeTable[selectIndex].mSortTable;
	local index = self.mNowIndex - 1;
	if index <= 0 then
		index = #sortTable;
	end
	self.mNowIndex = index;
	return sortTable[index].id;
end

function ArchiveModel:GetNextID(selectIndex)
	local sortTable = self.mTypeTable[selectIndex].mSortTable;
	local index = self.mNowIndex + 1;
	if index > #sortTable then
		index = 1;
	end
	self.mNowIndex = index;
	return sortTable[index].id;
end

function ArchiveModel:SetNowIndex(data)
	local camp = data.mPowerID;
	local id = data.mID;
	local sortTable = self.mTypeTable[camp].mSortTable;
	for k,v in ipairs(sortTable) do
		if v.id == id then
			self.mNowIndex = k;
			return;
		end
	end
end

return ArchiveModel;