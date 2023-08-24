local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mTable = table;
local mipairs = ipairs;
local mpairs = pairs;
local mUpdateManager = require "Manager/UpdateManager"
local SortTable = mLuaClass("SortTable",mBaseLua);

--sortFunc:排序方法
--keyName：数据的key名字，默认为SortTableKey
--autoAddKey:值为true表示会给数据增加key，通常数据更新时会依赖数据的key去做判断
function SortTable:OnLuaNew(sortFunc,keyName,autoAddKey)
	self.mSortFunc = sortFunc;
	self.mKeyName = keyName or "SortTableKey";
	self.mAutoAddKey = autoAddKey;

	self.mRawTable = {}; --未排序的table
	self.mSortTable = {}; --排序的table，相当于数组
end

function SortTable:SetMax(num,removeFirst)
	self.mMaxNum = num;
	self.mRemoveFirst = removeFirst;
end

function SortTable:UpdateSortFunction(sortFunction)
	if sortFunction == nil then
		return;
	end

	self.mSortFunc = sortFunction;
	self:TriggerSort();
end

function SortTable:Clear()
	self.mAddFunc = nil;
	self.mRemoveFunc = nil;
	self.mUpdateFunc = nil;
	self.mRefreshFunc = nil;

	self:RemoveTriggerSort();
end


--addFunc:没有添加排序方法下，增加数据会调用
--removeFunc：移除数据时会调用
--upateFunc：没有添加排序方法下，更新数据会调用
--refreshFunc：添加了排序方法下，增加，更新数据会调用
function SortTable:Init(addFunc,removeFunc,updateFunc,refreshFunc)
	self.mAddFunc = addFunc;
	self.mRemoveFunc = removeFunc;
	self.mUpdateFunc = updateFunc;
	self.mRefreshFunc = refreshFunc;
end

function SortTable:CallRemoveFunc(index,key,value)
	local removeFunc = self.mRemoveFunc;

	if removeFunc then
		removeFunc(index,key,value);
	end
end

function SortTable:CheckTriggerSort()
	if self.mWaitForUpdate then
		self:Sort();
	end
end

function SortTable:RemoveTriggerSort()
	if self.mWaitForUpdate then
		self.mWaitForUpdate = nil;
		mUpdateManager:RemoveLateUpdate(self);
	end
end

--延迟刷新，避免同一时刻多次刷新
function SortTable:TriggerSort()
	if not self.mWaitForUpdate then
		self.mWaitForUpdate = true;
		mUpdateManager:AddLateUpdate(self);
	end
end

function SortTable:OnLateUpdate()
	self:Sort();
end

function SortTable:Sort()
	self:RemoveTriggerSort();

	local sortFunc = self.mSortFunc;

	if sortFunc then
		local sortTable = self.mSortTable;
		mTable.sort(sortTable,sortFunc);

		local maxNum = self.mMaxNum;
		if maxNum ~= nil then
			local num = #sortTable;
			if num > maxNum then
				local rawTable = self.mRawTable;
				local keyName = self.mKeyName;
				local removeFirst = self.mRemoveFirst;
				local removeData = nil;
				for i=num - 1,maxNum,-1 do
					if removeFirst then
						removeData = mTable.remove(sortTable,1);
					else
						removeData = mTable.remove(sortTable);
					end
					
					rawTable[removeData[keyName]] = nil;
				end

			end
		end

		local refreshFunc = self.mRefreshFunc;
		if refreshFunc then
			refreshFunc();
		end
	end
end

function SortTable:GetValue(key)
	return self.mRawTable[key];
end

--仅限内部调用，外部统一调用AddOrUpdate
function SortTable:UpdateValue(key,value)
	local sortTable = self.mSortTable;
	local keyName = self.mKeyName;

	for index,v in mipairs(sortTable) do
		if v[keyName] == key then
			sortTable[index] = value;

			local sortFunc = self.mSortFunc;
			local updateFunc = self.mUpdateFunc;

			if not sortFunc and updateFunc then
				updateFunc(index,key,value);
			end
			return;
		end
	end
end

function SortTable:AddOrUpdate(key,value)
	local rawTable = self.mRawTable;
	local sortTable = self.mSortTable;
	local sortFunc = self.mSortFunc;

	local rawValue = rawTable[key];
	value.SortTableDirtyFlag = true;
		--更新
	if rawValue then
		if rawValue ~= value then
			if self.mAutoAddKey then
				value[self.mKeyName] = key;
			end

			rawTable[key] = value;
			self:UpdateValue(key,value);
		end

		if not sortFunc then
			self:UpdateValue(key,value);
		end

		self:TriggerSort();
		
	else
		--添加
		if self.mAutoAddKey then
			value[self.mKeyName] = key;
		end

		rawTable[key] = value;
		mTable.insert(sortTable,value);

		if not sortFunc then
			local addFunc = self.mAddFunc;
			if addFunc then
				addFunc(#sortTable,key,value);
			end
		else
			self:TriggerSort();
		end
	end
end

function SortTable:RemoveValue(value)
	local key = value[self.mKeyName];

	self:RemoveKey(key);
end

function SortTable:RemoveKey(key)
	if not key then
		return;
	end

	local rawTable = self.mRawTable;
	local removeTable = rawTable[key];
	if not removeTable then
		return;
	end

	local sortTable = self.mSortTable;
	rawTable[key] = nil;
	for index,v in mipairs(sortTable) do
		if v == removeTable then
			mTable.remove(sortTable,index);
			self:CallRemoveFunc(index,key,removeTable);
			return;
		end
	end
end

function SortTable:SetDatasDirty()
	local sortTable = self.mSortTable;
	for index,v in mipairs(sortTable) do
		v.SortTableDirtyFlag = true;
	end
end

function SortTable:ClearDatas(refresh)
	local rawTable = self.mRawTable;
	local sortTable = self.mSortTable;

	for k,v in mpairs(rawTable) do 
		rawTable[k] = nil;
		mTable.remove(sortTable);
	end

	if refresh then
		local refreshFunc = self.mRefreshFunc;
		if refreshFunc then
			refreshFunc();
		end
	end
end

return SortTable;