local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionComposeGoodsItem = mLuaClass("MansionComposeGoodsItem",mCommonGoodsItemView);
local mSuper = nil;

function MansionComposeGoodsItem:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_compose_goods_item",
	};
end

function MansionComposeGoodsItem:Init()
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self.mGameObject);

	mSuper = self:GetSuper(mCommonGoodsItemView.LuaClassName);
	mSuper.Init(self);
end

function MansionComposeGoodsItem:OnUpdateData()
	mSuper.OnUpdateData( self );

	self.mUIGray:SetGray( self.mData:IsGoodsGray( ) );
end

function MansionComposeGoodsItem:OnClickIcon()
	self:Dispatch(self.mEventEnum.ON_SELECT_COMPOSE_GOODS, self.mData);
end

return MansionComposeGoodsItem;