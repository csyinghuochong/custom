local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"

local LayoutItem = mLuaClass("LayoutItemLoop", mLayoutItem);

function LayoutItem:OnBeforeUpdateData(oldData,newData)
	local curDataSelected = newData.mLayoutItemSelected;
	if oldData.mLayoutItemSelected ~= curDataSelected then
		self:ShowSelectedView(curDataSelected);
	end
end

function LayoutItem:ShowSelectedView(value)
	self.mLayoutController:ShowSelectedView(self,value == true);
end

return LayoutItem;