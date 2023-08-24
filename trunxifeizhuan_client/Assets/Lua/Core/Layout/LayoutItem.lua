local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"

local LayoutItem = mLuaClass("LayoutItem", mBaseView);

function LayoutItem:SetData(data,callback,layoutController)
	local oldData = self.mData;
	self.mData = data;
 
	if self.mGameObject then
		if oldData ~= data or data.SortTableDirtyFlag then
			self:OnBeforeUpdateData(oldData,data);
			self:UpdateData(data);
		end
		
		self:ShowView();
		callback();
	else
		self.mLayoutController = layoutController;
		self:SetExternalData(layoutController.mExternalItemsData);
		self:InjectParams( nil, {OnLoadViewComplete = callback} );
		self:ShowView();
	end

	if data then
		data.SortTableDirtyFlag = false;
	end
end

function LayoutItem:OnBeforeUpdateData(oldData,newData)
	
end

function LayoutItem:SetExternalData(data)
	
end

function LayoutItem:Init()
	self:UpdateData(self.mData);
end

function LayoutItem:UpdateData(data)
	if self.mGameObject then
		self:OnUpdateData();
	end
end

function LayoutItem:OnUpdateData()
	
end

function LayoutItem:OnUpdateSiblingIndex(index)
	
end

function LayoutItem:SetSelected(value)
	self.mLayoutController:SetViewSelected(self,value);
end

function LayoutItem:OnSelected(value)
	
end

function LayoutItem:OnRemove( )
	
end

return LayoutItem;