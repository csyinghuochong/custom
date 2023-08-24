local mLuaClass = require "Core/LuaClass"
local TalentItemGoodsView = require "Module/Talent/TalentItemGoodsView"
local TalentItemSellView = mLuaClass("TalentItemSellView", TalentItemGoodsView);

function TalentItemSellView:Init( )
	self.mObjectSelect = self:Find( 'on_select' ).gameObject;

    mSuper = self:GetSuper(TalentItemGoodsView.LuaClassName);
	mSuper.Init(self);
end

function TalentItemSellView:OnClickIcon()
	self:Dispatch(self.mEventEnum.ON_SELECT_SELL_ITEM, self.mData);
end

function TalentItemSellView:OnRemove( )
	self:ShowSelectedFlag( false );
end

function TalentItemSellView:ShowSelectedFlag(selected)
	self.mShowSelectd = selected;
	self.mObjectSelect:SetActive(selected);
end

return TalentItemSellView;