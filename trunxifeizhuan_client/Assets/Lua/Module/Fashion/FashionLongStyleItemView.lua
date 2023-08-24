local mLuaClass = require "Core/LuaClass"
local FashionStyleItemView = require"Module/Fashion/FashionStyleItemView"
local FashionLongStyleItemView = mLuaClass("FashionLongStyleItemView", FashionStyleItemView);
local Vector3 = Vector3;
local mPositions = {
	[1] = Vector3.New(0,0,0);
	[2] = Vector3.New(0,-30,0);
	[3] = Vector3.New(0,-60,0);
	[4] = Vector3.New(0,-90,0);
}
function FashionLongStyleItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "long_style_attribute_item_view",
	};
end

function FashionLongStyleItemView:GetPosition()
	return mPositions[self.mIndex or 1];
end

return FashionLongStyleItemView;