local mLuaClass = require "Core/LuaClass"
local CommonBaseItemView = require"Module/Fashion/Common/CommonBaseItemView"
local FashionSuitComponentView = mLuaClass("FashionSuitComponentView", CommonBaseItemView);
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"

function FashionSuitComponentView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "s_fashion_item",
	};
end

function FashionSuitComponentView:OnAwake()
	
	local clickCallback = function ()
		self:OnClick();
	end

	local transform = self.mTransform;
	self:AddBtnClickListener(transform,clickCallback);
	self.mFashionView = FashionBaseItemView.CreateAt(transform);
end


function FashionSuitComponentView:OnClick()
	if self.mData then
		self:Dispatch(self.mEventEnum.ON_SELECT_SUIT_COMPONENT,self);
	end
end

function FashionSuitComponentView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionSuitComponentView:OnUpdateData(data)
	self.mFashionView:ForceShowView(data);
end

function FashionSuitComponentView:Dispose()
	self.mFashionView:CloseView();
	self.mFashionView = nil;
end

return FashionSuitComponentView;