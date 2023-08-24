local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mMansionStoreGoodsView = require "Module/Mansion/Store/MansionStoreGoodsView"
local MansionStoreView = mLuaClass("MansionStoreView", mQueueWindow);

function MansionStoreView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_store_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"silver","gold","mansion_cion"},
	};
end

function MansionStoreView:Init()
	self.mGoodsView = mMansionStoreGoodsView.LuaNew(self:Find('goods_view').gameObject);

	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
end

function MansionStoreView:OnViewShow( logicParmas )
	local goodsView = self.mGoodsView;
	local npcStore = logicParmas:IsHaveNpcStore( );
	if npcStore then
		goodsView:ChangePage( 4 );
	else
		goodsView:OnUpdateUI( );
		goodsView:ChangePage( 1 );
	end
	goodsView:ToggleButton( 4, npcStore or false );
end

function MansionStoreView:Dispose(  )
	self.mGoodsView:CloseView();
	self.mGoodsView = nil;
end

return MansionStoreView;