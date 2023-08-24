local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mKingController = require "Module/King/KingController"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLayoutController = require "Core/Layout/LayoutController"
local mLanguage = require "Utils/LanguageUtil"
local mEventEnum = require "Enum/EventEnum"
local mSortTable = require "Common/SortTable"
local KingMonarchView = mLuaClass("KingMonarchView",mCommonTabBaseView);

function KingMonarchView:InitViewParam()
	return {
		["viewPath"] = "ui/king/",
		["viewName"] = "monarch_info_view",
	};
end

function KingMonarchView:Init()
    self.mDesc = self:FindComponent("desc","Text");
    self.mUIGray = mUIGray.LuaNew():InitGoGraphic(self:Find('monarchBtn').gameObject);
    self:FindAndAddClickListener("monarchBtn",function() self:OnClickMonarch(); end,nil,0.5);
    self.mGoodsGridEx = mLayoutController.LuaNew(self:Find("Grid"), require "Module/CommonUI/CommonGoodsNeedItemView");
	self:RegisterEventListener(mEventEnum.ON_GET_MONARCH_DATA, function()
         self:InitData();
    end, true);
end

function KingMonarchView:OnUpdateUI(data)
	local model = mGameModelManager.KingModel;
	if model.mMonarchVO then
       self:InitData();
	else
       mKingController:SendMonrachGetOpen();
	end
end

function KingMonarchView:InitData()
	local monarchVO = mGameModelManager.KingModel.mMonarchVO;
	self.mMonarchVO = monarchVO;
	local monarchConfig = monarchVO:GetConfig();
	self.mDesc.text = monarchConfig.des;
	local enougthGoods = true;
	if monarchConfig.need_goods ~= nil then
		local goods_data = mSortTable.LuaNew();
       	for i,v in ipairs(monarchConfig.need_goods) do
		   goods_data:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v.goods_id,v.goods_num));
	    end
	    self.mGoodsGridEx:UpdateDataSource(goods_data);
	    enougthGoods = mGameModelManager.BagModel:CheckGoodsIsEnough(monarchConfig.need_goods);
	end
    self.mUIGray:SetGray(not enougthGoods);
    self.mEnougthGoods = enougthGoods;
end

function KingMonarchView:OnClickMonarch()
	if not self.mEnougthGoods then
       mCommonTipsView.Show(mLanguage.common_goods_no_enough);
       return;
	end
	mKingController:SendMonrachUpdate(self.mMonarchVO.mMonarchID);
end

function KingMonarchView:Dispose( )
	self.mGoodsGridEx:Dispose();
end

return KingMonarchView;