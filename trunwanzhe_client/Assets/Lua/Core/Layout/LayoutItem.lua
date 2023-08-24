local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"

local LayoutItem = mLuaClass("LayoutItem", mBaseView);

function LayoutItem:SetData(data,callback,layoutController)
	self.mData = data;
 
	if self.mGameObject then
		self:UpdateData(data);
		self:ShowView();
		callback();
	else
		self.mLayoutController = layoutController;
		self:InjectParams( nil, {OnLoadViewComplete = callback} );
		self:ShowView();
	end
end

function LayoutItem:Init()
	self:UpdateData(self.mData);
end

function LayoutItem:UpdateData(data)
	self.mData = data;

	if self.mGameObject then
		self:OnUpdateData();
	end
end

function LayoutItem:OnUpdateData()
	
end

function LayoutItem:SetSelected(value)
	local selfSelected = self.mSelected;
	if selfSelected ~= value then
		self.mSelected = value;
		self:OnSelected(value);

		if value then
			self.mLayoutController:SetViewSelected(self);
		end
	end
end

function LayoutItem:OnSelected(value)
	
end

function LayoutItem:OnRemove( )
	
end

return LayoutItem;