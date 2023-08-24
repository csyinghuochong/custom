local mLuaClass = require "Core/LuaClass"
local StoreGoodsView = require "Module/Store/StoreGoodsView"
local MansionStoreGoodsView = mLuaClass("MansionStoreGoodsView",StoreGoodsView);
local mSuper = nil;

function MansionStoreGoodsView:Init()
	mSuper = self:GetSuper(StoreGoodsView.LuaClassName);
    mSuper.Init(self); 

    self.mStoreType = 4;
    self.mObectLine3 = self:Find( 'line/Image (3)' ).gameObject;
    self.mBottomHua = self:Find( 'bottom' );
end

function MansionStoreGoodsView:ToggleButton( index, show )
	mSuper.ToggleButton( self, index, show );

	self.mObectLine3:SetActive( show );
	self.mBottomHua.localPosition = show and Vector3.New(-386, -117.54, 0) or Vector3.New(-386, -40.8, 0) ;
end

function MansionStoreGoodsView:UpdateCostUI( data )
end

return MansionStoreGoodsView;