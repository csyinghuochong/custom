local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local CommonAwardShowView = mLuaClass("CommonAwardShowView", mBaseWindow);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mVector2 = Vector2
local mLayoutController = require "Core/Layout/LayoutController"
local mSortTable = require "Common/SortTable"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonAwardVO = require "Module/CommonUI/CommonAwardVO"
local mGameModelManager = require "Manager/GameModelManager"
local mSuper = nil;

function CommonAwardShowView.Show(table)
	mUIManager:HandleUI(mViewEnum.CommonAwardShowView, 1, table);
end

function CommonAwardShowView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_award_show_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
		["ForbitSound"] = true
	};
end

function CommonAwardShowView:Init()
	self.mTransNode = self:Find("Node");
	local parentGoods = self:Find("Node/scrollRect/Grid");
	self.mGridGoods = mLayoutController.LuaNew(parentGoods, require "Module/CommonUI/CommonAwardShowItemView");

	self:FindAndAddClickListener("Node/bg/button_close",function()
		self:OnClickClose();
		end);
end

function CommonAwardShowView:OnClickClose()
	self:HideView();
	self:PlayHideSound();
end

function CommonAwardShowView:OnViewShow(logicParam)
	local goods = logicParam.goods;
	local posX = logicParam.posX;
	local trans = self.mTransNode;
	if posX ~= nil then
		trans.anchoredPosition = mVector2(posX,0);
	else
		trans.anchoredPosition = mVector2.zero;
	end
	if goods ~= nil then
		local soure_goods = mSortTable.LuaNew(nil,nil,true);
		for k,v in ipairs(goods) do
			local configGood = mConfigSysgoods[v];
			local awardVO = mCommonAwardVO.LuaNew(v);
			soure_goods:AddOrUpdate(v,awardVO);
		end
		self.mGridGoods:UpdateDataSource(soure_goods);
	end
	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnViewShow(self,Data);
end

function CommonAwardShowView:OnViewHide()
	local model = mGameModelManager.EliteDungeonModel;
	if model.mIsOpenAwardWindow then
		model.mIsOpenAwardWindow = false;
	end
end

function CommonAwardShowView:Dispose()
	self.mGridGoods:Dispose();
end

return CommonAwardShowView;