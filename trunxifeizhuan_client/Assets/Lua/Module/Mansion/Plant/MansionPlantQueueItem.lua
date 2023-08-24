local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionPlantQueueItem = mLuaClass("MansionPlantQueueItem", mBaseView);
local mSuper;

function MansionPlantQueueItem:OnLuaNew(index, go, select_callback, minus_callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
   	mSuper.OnLuaNew(self,go);

   	self.mIndex = index;
   	self.mSelectCallBack = select_callback;
   	self.mMinusCallBack  = minus_callback;
end

function MansionPlantQueueItem:Init()
	self.mLockObj = self:Find( 'lock' ).gameObject; 
	self.mSelectObj = self:Find( 'iamge_add' ).gameObject;
	
	self.mSelectObj:SetActive( false );
	self:FindAndAddClickListener("image_bg",function() self:OnClickSelectButton() end,nil, 0.2);
	self:FindAndAddClickListener("goods_item/minusBtn",function() self:OnClickMinusButton() end);

	self.mGoodsItem = mCommonGoodsItemView.LuaNew(self:Find('goods_item').gameObject);
	self.mTextGoodsNum = self:FindComponent( 'goods_item/Text', 'Text' );

	self:Reset( );
	self:SetOpenState ( false );
end

function MansionPlantQueueItem:ExternalSetSelect( show )
	self.mSelectObj:SetActive( show );
end

function MansionPlantQueueItem:OnClickSelectButton(  )
	if not self.mOpenState then
		return false;
	end 
	self.mSelectCallBack ( self.mIndex );
end

function MansionPlantQueueItem:OnClickMinusButton(  )
	local number = self.mGoodsNum - 1;
	self.mGoodsNum = number;
	self.mTextGoodsNum.text = number;
	self.mMinusCallBack ( self.mGoodsId );
	if number <= 0 then
		self:Reset( );
	end
end

function MansionPlantQueueItem:AddQueueSeed(goods_id)
	local goodsId = self.mGoodsId;
	local goodsNum = self.mGoodsNum;
	if goodsId ~= goods_id then
		self:InitGoodsItem( goods_id, 1 );
	else
		goodsNum = 	self.mGoodsNum + 1;
		self.mGoodsNum = goodsNum;
		self.mTextGoodsNum.text = goodsNum;
	end
end

function MansionPlantQueueItem:InitGoodsItem( goods_id, goodsNum )
	self.mGoodsId = goods_id;
	self.mGoodsNum = goodsNum;
	self.mSysGoodsVO = mConfigSysgoods[ goods_id ];
	self.mGoodsItem:ShowView( );
	self.mGoodsItem:ExternalUpdate( mCommonGoodsVO.LuaNew(goods_id, goodsNum) );
end

function MansionPlantQueueItem:Reset(  )
	self.mGoodsId = 0;
	self.mGoodsNum = 0;
	self.mGoodsItem:HideView( );
end

function MansionPlantQueueItem:SetOpenState( state )
	self.mOpenState = state;
	self.mLockObj:SetActive( not state );
end

function MansionPlantQueueItem:IsValidGrid( goods_id )
	if not self.mOpenState then
		return false;
	end 
	local goodsId = self.mGoodsId;
	if goodsId == 0 or ( goodsId == goods_id and self.mGoodsNum < self.mSysGoodsVO.stack ) then
		return true;
	end
	return false;
end

function MansionPlantQueueItem:GetQueueData(  )
	local goodsId = self.mGoodsId;
	if goodsId == 0 then
		return nil;
	else
		return { id = self.mIndex, item_id = goodsId, item_count = self.mGoodsNum };
	end
end

function MansionPlantQueueItem:SetQueueData( data )
	self:InitGoodsItem( data.item_id, data.item_count );
end

return MansionPlantQueueItem;