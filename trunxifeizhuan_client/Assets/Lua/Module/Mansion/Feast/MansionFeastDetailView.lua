local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local CommonCountDown = require "Module/CommonUI/CommonCountDown";
local MansionController = require "Module/Mansion/MansionController"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local ConfigSysmansion_feast = require "ConfigFiles/ConfigSysmansion_feast"
local MansionFeastDetailVO = require "Module/Mansion/Feast/MansionFeastDetailVO"
local ConfigSysmansion_operation_event = require "ConfigFiles/ConfigSysmansion_operation_event"
local MansionFeastDetailView = mLuaClass("MansionFeastDetailView", mQueueWindow);

function MansionFeastDetailView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_feast_detail_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionFeastDetailView:Init()
	self:InitSubView( );
	self:AddEventListeners( );
end

function MansionFeastDetailView:InitSubView(  )
	self.mTextDynaBoom = self:FindComponent( 'Text_6', 'Text' );
	self.mTextGuestRate = self:FindComponent( 'Text_3', 'Text' );
	self.mTextGetGold = self:FindComponent( 'Text_7', 'Text' );
	self.mTextTongbao = self:FindComponent( 'Text_8', 'Text' );
	self.mTextEventDesc = self:FindComponent( 'sub_view/Text_10', 'Text' );

	local goodsList = { };
	for i = 1, 3 do
		goodsList[ i ] = mCommonGoodsItemView.LuaNew( self:Find( 'goods_item'..i ).gameObject );
	end
	self.mRewardList = goodsList;
	self.mKingReward = mCommonGoodsItemView.LuaNew( self:Find( 'sub_view/goods_item4' ).gameObject );
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("button_invite",function() self:SendInviteGuest(); end, nil, 1);

	local textLastTime = self:FindComponent( 'Text_13', 'Text' );
	self.mCountDown = CommonCountDown.LuaNew( textLastTime, nil );
	self.mEventView = self:Find( 'sub_view' ).gameObject;

	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mansion/Feast/MansionFeastDetailItem");
end

function MansionFeastDetailView:AddEventListeners(  )
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_RECV_MANSION_FEAST_DETAIL,function(data)self:OnRecvFeastDetail(data)end,true);
end

function MansionFeastDetailView:SendInviteGuest(  )
	MansionController:SendInviteGuest( );
end

function MansionFeastDetailView:OnViewShow(  )
	local data = mGameModelManager.MansionModel.mData;
	MansionController:SendGetFeastDetail( data:GetPlayerID( ) );
end

function MansionFeastDetailView:OnRecvFeastDetail( pbMansionFeastDetail )
	self:UpdateGuestList( pbMansionFeastDetail );
	self:UpdateRewardInfo( pbMansionFeastDetail );
	self:UpdateRemainTime( pbMansionFeastDetail );
end

function MansionFeastDetailView:UpdateGuestList( pv_vo )
	local data = mSortTable.LuaNew(function(a, b) return a.mPlayer.player_id < b.mPlayer.player_id end, nil, true);
	for k, v in ipairs( pv_vo.list ) do
		data:AddOrUpdate( k, MansionFeastDetailVO.LuaNew( v ) );
	end
	self.mGridEx:UpdateDataSource( data );
end

function MansionFeastDetailView:UpdateRewardInfo( pv_vo )
	self.mTextDynaBoom.text = pv_vo.main_boom;
	self.mTextGetGold.text = pv_vo.main_gold;
	self.mTextTongbao.text = pv_vo.main_house_coin;

	local feast_vo = ConfigSysmansion_feast[ pv_vo.id ];
	local rewards = feast_vo.reward;
	for k , v in pairs ( self.mRewardList ) do
		local vo = rewards[ k ];
		if vo then
			v:ShowView( );
			v:UpdateByIdAndNum( vo.goods_id, vo.goods_num, nil ,true );
		else
			v:HideView( );
		end
	end
	self.mTextGuestRate.text = string.format( '%d/%d', #pv_vo.list, feast_vo.guest_number);

	local event_vo = ConfigSysmansion_operation_event[ pv_vo.event_npc_id ];
	self.mEventView:SetActive( event_vo ~= nil )
	if event_vo then
		self.mTextEventDesc.text = event_vo.desc;
		self.mKingReward:UpdateByIdAndNum( event_vo.assets[1].key, event_vo.assets[1].value , nil, true );
	end
end

function MansionFeastDetailView:UpdateRemainTime( pv_vo )
	local remain_time = pv_vo.time_expire - mGameModelManager.LoginModel:GetCurrentTime();
	self.mCountDown:ShowView( remain_time );
end

function MansionFeastDetailView:OnViewHide( )
	self.mCountDown:HideView();
end

function MansionFeastDetailView:Dispose()
	self.mGridEx:Dispose();
	self.mGridEx = nil;
	self.mCountDown:Dispose();
	self.mCountDown = nil;
end

return MansionFeastDetailView;