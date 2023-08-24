local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local MansionServantItem = mLuaClass("MansionServantItem",mLayoutItem);
local mSuper = nil;

function MansionServantItem:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_servant_item",
	};
end

function MansionServantItem:Init( )
	self.mModelShowView = ModelRenderTexture.LuaNew(self:Find('model'));

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MansionServantItem:OnUpdateData()
	local data = self.mData;

	local modelView = self.mModelShowView;
	modelView:OnUpdateUI(data.mSysVO.model, true);
end

function MansionServantItem:OnViewShow()
	self.mModelShowView:ShowView();
end

function MansionServantItem:OnViewHide()
	self.mModelShowView:HideView();
end

function MansionServantItem:Dispose( )
	self.mModelShowView:Dispose();
end

return MansionServantItem;