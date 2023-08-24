local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mTable = table;
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

function SortTable:Clear()
	self.mAddFunc = nil;
	self.mRemoveFunc = nil;
	self.mUpdateFunc = nil;
	self.mRefreshFunc = nil;
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

function SortTable:Sort()
	local sortFunc = self.mSortFunc;

	if sortFunc then
		mTable.sort(self.mSortTable,sortFunc);
		local refreshFunc = self.mRefreshFunc;
		if refreshFunc then
			refreshFunc();
		end
	end
end

function SortTable:UpdateValue(key,value)
	local sortTable = self.mSortTable;
	local keyName = self.mKeyName;

	for index,v in ipairs(sortTable) do
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

	if self.mAutoAddKey then
		value[self.mKeyName] = key;
	end

		--更新
	if rawTable[key] then
		rawTable[key] = value;
		self:UpdateValue(key,value);
		self:Sort();
	else
		--添加
		rawTable[key] = value;
		mTable.insert(sortTable,value);

		if not sortFunc then
			local addFunc = self.mAddFunc;
			if addFunc then
				addFunc(#sortTable,key,value);
			end
		else
			self:Sort();
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
	for index,v in ipairs(sortTable) do
		if v == removeTable then
			mTable.remove(sortTable,index);
			self:CallRemoveFunc(index,key,removeTable);
			return;
		end
	end
end

return SortTable;