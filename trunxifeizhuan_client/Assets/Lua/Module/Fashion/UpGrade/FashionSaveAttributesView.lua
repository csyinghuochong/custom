local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local FashionSaveAttributesView = mLuaClass("FashionSaveAttributesView", mBaseWindow);
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local FashionAttributeItemView = require"Module/Fashion/FashionAttributeItemView"
local CommonItemsView = require"Module/Fashion/Common/CommonItemsView"
local mSuper = nil;
local ipairs = ipairs;

function FashionSaveAttributesView.Show(table)
	mUIManager:HandleUI(mViewEnum.FashionSaveAttributesView, 1, table);
end

function FashionSaveAttributesView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_save_attributes_view",
		["ParentLayer"] = mPopLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["ForbitSound"] = true
	};
end

function FashionSaveAttributesView:Init()
	self:FindAndAddClickListener("Button1",function() self:Save() end);
	self:FindAndAddClickListener("Button2",function() self:Cancel() end);

	self.mAttributeItemViews = CommonItemsView.InitItemViews(self:Find("combat_attributes/attributes"),"Module/Fashion/FashionAttributeItemView",5);
	self.mRandomAttributeItemViews = CommonItemsView.InitItemViews(self:Find("combat_attributes/randoms"),"Module/Fashion/FashionAttributeItemView",5);

	self.mFashionView = FashionBaseItemView.CreateAt(self:Find("fashion_view"));

	self.mBaseAttributeView = FashionAttributeItemView.LuaNew(self:Find("combat_attributes/base_attribute").gameObject);

	self:RegisterEventListener(self.mEventEnum.ON_UPDATE_FASHION_INFO, function(data) self:UpdateData(data); end,true);
end

function FashionSaveAttributesView:Dispose()
	self.mFashionView:CloseView();
	self.mBaseAttributeView:CloseView();
	self.mAttributeItemViews:Dispose();
	self.mRandomAttributeItemViews:Dispose();

	self.mFashionView = nil;
	self.mBaseAttributeView = nil;
	self.mAttributeItemViews = nil;
	self.mRandomAttributeItemViews = nil;
end

function FashionSaveAttributesView:Save()
	self:HideView();
	local btnCallback = self.mBtnCallback;
	if btnCallback then
		btnCallback(1);
	end
end

function FashionSaveAttributesView:Cancel()
	self:HideView();
	local btnCallback = self.mBtnCallback;
	if btnCallback then
		btnCallback(0);
	end
end

function FashionSaveAttributesView:UpdateData(data)
	self.mFashionView:ForceShowView(data);
	self.mAttributeItemViews:ShowView(data.mAdditionalAttributes);
	self.mRandomAttributeItemViews:ShowView(data.mTempAdditionalAttributes);
	self.mBaseAttributeView:ForceShowView(data.mBaseAttribute);
end

function FashionSaveAttributesView:OnViewShow(logicParams)
	
	self:UpdateData(logicParams.data);
	self.mBtnCallback = logicParams.btnCallback;
	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnViewShow(self,logicParams);
end

return FashionSaveAttributesView;