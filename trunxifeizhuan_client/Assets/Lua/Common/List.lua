local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local List = mLuaClass("List",mBaseLua);
local table = table;
local pairs = pairs;
local math = math;

function List:OnLuaNew()
	self.mLength = 0;
	self.mData = {};
end

function List:Clear()
	self.mLength = 0;
	self.mData = {};
end

function List:GetLen()
	return self.mLength;
end

function List:Add(item)
	local data = self.mData;
	table.insert(data,item);
	self.mLength = self.mLength + 1;
end

function List:Insert(item)
	if self:Contains(item) then
		return false;
	end
	self:Add(item);
	return true;
end

function List:Contains(item)
	return self:IndexOf(item) > 0;
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

function List:GetValue(index)
	return self.mData[index];
end

function List:GetRandomValue()
	local len = self.mLength;
	if len > 0 then
		return self.mData[math.random(1,len)];
	end
end

function List:Remove(item)
	return self:RemoveAt(self:IndexOf(item));
end

function List:RemoveAt(index)
	local len = self.mLength;
	if index > 0 and index <= len then
		local data = self.mData;
		table.remove(data,index);
		self.mLength = len - 1;
		return true;
	end
	return false;
end

function List:Sort(compare)
	if compare then
		table.sort( self.mData, compare );
	end
end

function List:Foreach(callback)
	local len = self.mLength;
	if len > 0 then
		local data = self.mData;
		for i=1,len do
			local item = data[i];
			assert(item,"如果要从 List 循环中移除元素，请使用 ReForeach 代替 Foreach");
			if callback(item,i) then
				return;
			end
		end
	end
end

function List:ReForeach(callback)
	local len = self.mLength;
	if len > 0 then
		local data = self.mData;
		for i=len,1,-1 do
			if callback(data[i],i) then
				return;
			end
		end
	end
end
return List;