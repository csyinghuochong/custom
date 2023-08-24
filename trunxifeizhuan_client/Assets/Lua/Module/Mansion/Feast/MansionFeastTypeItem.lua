local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local CommonCountDown = require "Module/CommonUI/CommonCountDown";
local MansionController = require "Module/Mansion/MansionController"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionFeastTypeItem = mLuaClass("MansionFeastTypeItem",mBaseView);

function MansionFeastTypeItem:Init()
	self.mView1 = self:Find( 'view1' ).gameObject;
	self.mView2 = self:Find( 'view2' ).gameObject;
	self.mView3 = self:Find( 'view3' ).gameObject;

	self.mTextFeastName = self:FindComponent( 'Text_1', 'Text' );
	self.mTextOpenTip = self:FindComponent( 'view1/Text_1', 'Text' );
	self.mTextGuestTotal = self:FindComponent( 'view2/Text_3', 'Text' );
	self.mTextReturnRate = self:FindComponent( 'view2/Text_5', 'Text' );
	self.mTextOpenCost = self:FindComponent( 'view2/Text_6', 'Text' );
	local goodsList = { };
	for i = 1, 3 do
		goodsList[ i ] = mCommonGoodsItemView.LuaNew( self:Find( 'view2/goods_item'..i ).gameObject );
	end
	self.mRewardList = goodsList;

	self.mTextGuestRate = self:FindComponent( 'view3/Text_3', 'Text' );
	self.mTextDynamicBoom = self:FindComponent( 'view3/Text_6', 'Text' );

	local textLastTime = self:FindComponent( 'view3/Text_7', 'Text' );
	self.mCountDown = CommonCountDown.LuaNew(  textLastTime, nil );
	
	self:FindAndAddClickListener("view2/button_open",function() self:OnClickOpenFeast(); end, nil, 1);
	self:FindAndAddClickListener("view3/button_enter",function() self:OnClickEnterFeast(); end, nil, 1);
end

function MansionFeastTypeItem:OnClickOpenFeast( )
	local data = self.mData;
	if data:IsHaveGuest( ) then
		print ( 'IsHaveGuest' )
	else
		MansionController:SendOpenFeast( data.mID );
	end
end

function MansionFeastTypeItem:OnClickEnterFeast( )
	mUIManager:HandleUI(mViewEnum.MansionFeastDetailView, 1);
end

function MansionFeastTypeItem:InitFeastVO( vo )
	self.mData = vo;

	local sysVo = vo.mSysVO;
	self.mTextOpenTip.text = vo:GetOpenTip( );
	self.mTextGuestTotal.text = sysVo.guest_number;
	self.mTextReturnRate.text = sysVo.return_gift.."%";
	self.mTextOpenCost.text = sysVo.cost[ 2 ];
	self.mTextFeastName.text = sysVo.name;
	for k, v in pairs( self.mRewardList ) do
		local vo = sysVo.reward[ k ];
		if vo then
			v:ShowView( );
			v:UpdateByIdAndNum( vo.goods_id, vo.goods_num, nil, true )
		else
			v:HideView( );
		end
	end
end

function MansionFeastTypeItem:OnUpdateUI( lv, pv_vo )
	local data = self.mData;
	data:UpdateFeastVO( lv, pv_vo );

	local lock = data:IsLock( );
	local open = data:IsOpen( );
	self.mView1:SetActive( lock );
	self.mView2:SetActive( not lock and not open);
	self.mView3:SetActive( open );
	if open then
		self.mTextDynamicBoom.text = data.mPbVO.boom;
		self.mTextGuestRate.text = data:GetGuestRate( );
		self.mCountDown:ShowView( data:GetRemainTime( ) );
	end
end

function MansionFeastTypeItem:OnViewHide(  )
	self.mCountDown:HideView();
end

function MansionFeastTypeItem:Dispose( )
	self.mCountDown:Dispose();
	self.mCountDown = nil;
end

return MansionFeastTypeItem;