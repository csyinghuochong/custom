local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mAlertBaseView = require "Module/CommonUI/AlertBaseView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local FashionBuyTipView = mLuaClass("FashionBuyTipView", mAlertBaseView);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSuper = nil;
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgDefaultTitle = mLanguageUtil.alert_default_title

function FashionBuyTipView.Show(table)
	mUIManager:HandleUI(mViewEnum.FashionBuyTipView, 1, table);
end

function FashionBuyTipView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_buy_tip_view",
		["ParentLayer"] = mPopLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["ForbitSound"] = true
	};
end

function FashionBuyTipView:Init()
	self.mTextName = self:FindComponent("Text/TextName","Text");
	self.mFashionView = FashionBaseItemView.CreateAt(self:Find('goods_view'));
	mSuper = self:GetSuper(mAlertBaseView.LuaClassName);
	mSuper.Init(self);
end


function FashionBuyTipView:OnViewShow(logicParams)
	mSuper = self:GetSuper(mAlertBaseView.LuaClassName);
	mSuper.OnViewShow(self,logicParams);
	self.mTextName.text = logicParams.desc2;
	self.mFashionView:ForceShowView(logicParams.goods);
end
function FashionBuyTipView:Dispose()
	self.mFashionView:CloseView();
	self.mFashionView = nil;
end

return FashionBuyTipView;