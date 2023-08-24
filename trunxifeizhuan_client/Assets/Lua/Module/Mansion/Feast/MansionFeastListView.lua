local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local MansionController = require "Module/Mansion/MansionController"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionFeastCostItem = require "Module/Mansion/Feast/MansionFeastCostItem"
local MansionFeastListItemVO = require "Module/Mansion/Feast/MansionFeastListItemVO"
local MansionFeastListView = mLuaClass("MansionFeastListView", mQueueWindow);
local mIpairs = ipairs;

function MansionFeastListView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_feast_list_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionFeastListView:Init()
	self:InitSubView( );
	self:AddEventListeners( );
end

function MansionFeastListView:InitSubView(  )
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mansion/Feast/MansionFeastListItem");
	self.mDataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);
	self.mGridEx:SetSelectedViewTop( true );
	
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow(); end);

	self.mSubView = self:Find( 'sub_view' ).gameObject;
	self.mObjectSelect = self:Find( 'sub_view/Image_select' );

	local costList = { };
	local rewardList = { };
	for i = 1, 3 do
		costList[ i ] = MansionFeastCostItem.LuaNew(  self:Find( 'sub_view/cost_item'..i ).gameObject );
		rewardList[ i ] = mCommonGoodsItemView.LuaNew( self:Find( 'sub_view/goods_item'..i ).gameObject );
	end	
	self.mCostList = costList;
	self.mRewardList = rewardList;
	self.mButtonJoin = self:Find( 'sub_view/button_join' ).gameObject;
	self:AddBtnClickListener(self.mButtonJoin,function() self:OnClickJoinFeast(); end, nil, 1);
	self.mLoadItemComplete = function (  )
		self:OnLoadItemComplete( );
	end
end

function MansionFeastListView:Sort( a,b )
	return a.mPlayerId < b.mPlayerId;
end

function MansionFeastListView:OnClickJoinFeast(  )
	MansionController:SendJoinFeast( self.mFeastData.mPlayerId, self.mGiftId );
end

function MansionFeastListView:AddEventListeners(  )
	local mEvent = self.mEventEnum;
	
	self:RegisterEventListener(mEvent.ON_RECV_MANSION_FEAST_LIST,function(data)self:OnRecvFeastList(data)end,true);
	self:RegisterEventListener(mEvent.ON_SELECT_FEAST_LIST_ITEM,function(data)self:OnSelectFeastItem(data)end,true);
	self:RegisterEventListener(mEvent.ON_SELECT_FEAST_COST_ITEM,function(data)self:OnSelectCostItem(data)end,true);
	self:RegisterEventListener(mEvent.ON_RECV_MANSION_FEAST_JOIN,function(data)self:OnRecvFeastJoin(data)end,true);
	self:RegisterEventListener(mEvent.ON_RECV_MANSION_FEAST_DETAIL,function(data)self:OnRecvFeastDetail(data)end,true);
end

function MansionFeastListView:OnViewShow( logicParams  )
	self.mTargetId = logicParams;
	self.mData = mGameModelManager.MansionModel.mData;
	MansionController:SendGetFeastList( );
end

function MansionFeastListView:OnRecvFeastList( pv_vo )
	local dataSource = self.mDataSource;
	dataSource:ClearDatas(true);

	for k, v in mIpairs(pv_vo.list) do
		local player_id = v.base.player_id;
		dataSource:AddOrUpdate(player_id, MansionFeastListItemVO.LuaNew(v));
	end

	self.mGridEx:UpdateDataSource(dataSource, self.mLoadItemComplete);
end

function MansionFeastListView:OnLoadItemComplete( )
	local t_id = self.mTargetId;
	local dataSource = self.mDataSource;
	local data = nil;
	if t_id then
	 	data = dataSource:GetValue( t_id );
	end
	if not data then
		data = dataSource.mSortTable[ 1 ];
	end
	self:OnSelectFeastItem( data );
end

function MansionFeastListView:OnSelectFeastItem( data )
	self.mFeastData = data;
	if data then
		self:InitCostListView( data );
		self.mGridEx:SetViewSelectedByKey( data.mPlayerId, true );
		MansionController:SendGetFeastDetail( data.mPlayerId );
	end
	self.mSubView:SetActive( data ~= nil );
end

function MansionFeastListView:OnRecvFeastJoin( main_id )
	local data = self.mFeastData;
	if main_id ~= data.mPlayerId then
		return;
	end
	data:OnRecvJoinFeast(  );
	self.mDataSource:AddOrUpdate( main_id, data );
	self.mButtonJoin:SetActive( data:IsCanJoinFeast( ) );
end

function MansionFeastListView:OnRecvFeastDetail( pbMansionFeastDetail )
	local data = self.mFeastData;
	data:OnRecvFeastDetail( pbMansionFeastDetail );
	self.mDataSource:AddOrUpdate( data.mPlayerId, data );
	self.mButtonJoin:SetActive( data:IsCanJoinFeast( ) )
end

function MansionFeastListView:InitCostListView( data )
	local costVos = data:GetCostVoList( );
	for k, v in pairs ( self.mCostList ) do
		local vo = costVos[ k ];
		if vo then
			v:ShowView( );
			v:SetData( vo );
		else
			v:HideView( );
		end
	end
	self:OnSelectCostItem( costVos[1] );
end

function MansionFeastListView:OnSelectCostItem( data )
	self.mGiftId = data.mID;

	local item = self.mCostList[ data.mIndex ];
	local i_select = self.mObjectSelect;
	mGameObjectUtil:SetParent(i_select, item.mTransform);
	i_select:SetAsLastSibling();

	local rewardVos = data:GetRewardVoList( );
	for k, v in mIpairs( self.mRewardList ) do
		local vo = rewardVos[ k ];
		if vo then
			v:ShowView( );
			v:UpdateByIdAndNum( vo.goods_id, vo.goods_num, nil, true );
		else
			v:HideView( );
		end
	end
end

function MansionFeastListView:OnViewHide( )
	
end

function MansionFeastListView:Dispose()
	self.mGridEx:Dispose( );
	self.mGridEx = nil;
end

return MansionFeastListView;