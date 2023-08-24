local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local CommonEmptyView = mLuaClass("CommonEmptyView", mBaseView);
local mSuper = nil;

function CommonEmptyView:SetExternalParams(parent)
	self.mViewParams.ParentLayer = parent;
end

function CommonEmptyView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_empty_view",
	};
end

function CommonEmptyView:Init()
	self.mText = self:FindComponent("text","Text");
end

function CommonEmptyView:OnViewShow(data)
	self.mText.text = data.str;
end

function CommonEmptyView:Dispose()
end

return CommonEmptyView;