local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local Queue = mLuaClass("Queue",mBaseLua);

local table = table;
local pairs = pairs;

function Queue:OnLuaNew()
	self.mCount = 0;
	self.mData = {};
end

function Queue:New()
	return Queue.LuaNew();
end

function Queue:Enqueue(item)
	if not item then
		return;
	end

	table.insert(self.mData,item);
	self.mCount = self.mCount + 1;
end

function Queue:Dequeue()
	local item = nil;
	local selfCount = self.mCount;

	if selfCount > 0 then
		item = table.remove(self.mData,1);
		self.mCount = selfCount - 1;
	end

	return item;
end

function Queue:Peek()
	local item = nil;

	if self.mCount > 0 then
		item = self.mData[1];
	end

	return item;
end

function Queue:Clear( )
	local selfData = self.mData;
	if not selfData then
		return;
	end

	for k,v in pairs(selfData) do
		selfData[k] = nil;
	end
end

return Queue;
