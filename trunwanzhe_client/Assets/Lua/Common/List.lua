local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local List = mLuaClass("List",mBaseLua);
local table = table;
local ipairs = ipairs;

function List:OnLuaNew()
	self.mLength = 0;
	self.mData = {};
end

function List:Clear()
	self.mLength = 0;
	self.mData = {};
end

function List:Add(item)
	table.insert(self.mData,item);
	self.mLength = self.mLength + 1;
end

function List:Contains(item)
	local data = self.mData;
	for i,v in ipairs(data) do
		if v == item then
			return true;
		end
	end
	return false;
end

function List:IndexOf(item)
	local data = self.mData;
	for i,v in ipairs(data) do
		if v == item then
			return i;
		end
	end
	return -1;
end

function List:Remove(item)

	local data = self.mData;
	for i,v in ipairs(data) do
		if v == item then
			table.remove(self.mData,i);
			self.mLength = self.mLength - 1;
			return;
		end
	end
end

function List:RemoveAt(index)
	local length = self.mLength;
	local item = nil;
	if length >= index then
		item = table.remove(self.mData,index);
		self.mLength = length - 1;
	end

	return item;
end

return List;