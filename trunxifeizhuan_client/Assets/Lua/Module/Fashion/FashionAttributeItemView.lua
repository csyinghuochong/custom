local mLuaClass = require "Core/LuaClass"
local CommonBaseItemView = require"Module/Fashion/Common/CommonBaseItemView"
local FashionAttributeItemView = mLuaClass("FashionAttributeItemView", CommonBaseItemView);

function FashionAttributeItemView:OnAwake()

	self.mAttributeTypeText = self:FindComponent("type","Text");
	self.mAttributeValueText = self:FindComponent("value","Text");
end

function FashionAttributeItemView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionAttributeItemView:OnUpdateData(data)
	if data then
		self.mAttributeTypeText.text = data:GetName();
		self.mAttributeValueText.text = data:ValueToString();
	end
end

return FashionAttributeItemView;