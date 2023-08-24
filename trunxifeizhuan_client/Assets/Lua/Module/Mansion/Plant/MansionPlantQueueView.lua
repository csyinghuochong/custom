local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mSortTable = require "Common/SortTable"
local mBagGoodsVO = require"Module/Bag/BagGoodsVO"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLayoutController = require "Core/Layout/LayoutController"
local MansionController = require "Module/Mansion/MansionController"
local MansionPlantQueueItem = require "Module/Mansion/Plant/MansionPlantQueueItem"
local MansionPlantQueueView = mLuaClass("MansionPlantQueueView", mBaseVindow);
local mIpairs = ipairs;
local mPairs = pairs;

function MansionPlantQueueView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_plant_queue_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionPlantQueueView:Init()
	local goods_parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(goods_parent, require "Module/Mansion/Plant/MansionPlantQueueSeed");

	local callBack1 = function ( index )
		self:OnSelectPlantQueueItem( index );
	end
	local callBack2 = function ( goods_id )
		self:OnMinusPlantQueueItem( goods_id );
	end

	local queueList = {};
	for i = 1, 9 do
		queueList[ i ] = MansionPlantQueueItem.LuaNew( i, self:Find('queue'..i).gameObject , callBack1, callBack2);
	end
	self.mQueueList = queueList;

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_PLANT_QUEUE_SEED, function(vo)
   		self:OnClickQueueSeed( vo );
   	end, true);
   	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_PLANT_QUEUE, function(vo)
   		self:OnRecvPlantList( vo );
   	end, true);

   	self:FindAndAddClickListener('button_confirm',function() self:OnClickConfirm() end);

	self.mDataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
end

function MansionPlantQueueView:OnClickQueueSeed( vo )
	local goods_id = vo.mID;
	local valid_index = self:GetValidQueueItemIndex( goods_id );

	if valid_index ~= nil then
		self:OnRemoveSeedFromBag( vo );
		self.mQueueList[ valid_index ]:AddQueueSeed( goods_id );
	else
		mCommonTipsView.Show( mLanguageUtil.mansion_plant_queue_tip);
	end
	self:OnSelectPlantQueueItem( valid_index );
end

function MansionPlantQueueView:OnRemoveSeedFromBag( vo )
	local uid = vo.mGoodsUID ;
	local number = vo.mNumber - 1; 
	vo.mNumber = number;
	local dataSource = self.mDataSource;
	if number <= 0 then
		dataSource:RemoveKey( uid );
	else
		dataSource:AddOrUpdate( uid,vo);
	end
end

function MansionPlantQueueView:GetValidQueueItemIndex( goods_id )
	local queueList = self.mQueueList;
	local lastIndex = self.mLastIndex;

	if lastIndex ~= nil then
		local curQueue = queueList[  lastIndex ]
		if curQueue:IsValidGrid( goods_id ) then
			return lastIndex;
		end
	end
	
	for k, v in mPairs( queueList ) do
		if v:IsValidGrid( goods_id ) then
			return k;
		end
	end
	return nil;
end

function MansionPlantQueueView:OnSelectPlantQueueItem( index )
	local queueList = self.mQueueList;
	local lastIndex = self.mLastIndex;
	if lastIndex ~= nil then
		queueList[ lastIndex ]:ExternalSetSelect( false );
	end
	if index ~= nil then
		queueList[ index ]:ExternalSetSelect( true );
	end	
	self.mLastIndex = index;
end

function MansionPlantQueueView:OnMinusPlantQueueItem( goods_id )
	local sortTable = self.mDataSource;
	local vo = self:GetValidBagItemVO( goods_id );
	if vo ~= nil then
		vo.mNumber = vo.mNumber + 1;
		sortTable:AddOrUpdate( vo.mGoodsUID, vo);
	else
		local uid = self:GetValidBagItemUID( );
		sortTable:AddOrUpdate( uid, mBagGoodsVO.LuaNew(uid, goods_id, nil, 1));
	end
end

function MansionPlantQueueView:GetValidBagItemVO( goods_id  )
	local sortTable = self.mDataSource.mSortTable;
	for k, v in mPairs( sortTable ) do
		if v.mID == goods_id and not v:IsMaxNumber() then
			return v;
		end
	end
	return nil;
end

function MansionPlantQueueView:GetValidBagItemUID(  )
	local uid = 1;
	local sortTable = self.mDataSource.mSortTable;
	for k, v in mPairs( sortTable ) do
		if v.mGoodsUID >= uid then
			uid = v.mGoodsUID;
		end
	end
	return uid + 1;
end

function MansionPlantQueueView:OnViewShow(logicParams)
	self.mData = logicParams;
	
	self:UpdateGridDataSource( );
	self:OnSelectPlantQueueItem( 1 );
	self:UpdateQueueItemLockState( );
	MansionController:RequestPlantQueue( );
end

function MansionPlantQueueView:UpdateQueueItemLockState(  )
	local data = self.mData;
	for k, v in mPairs( self.mQueueList ) do
		v:SetOpenState( data:IsTypeLandOpen( math.ceil( k / 3 ) ) );
	end
end

function MansionPlantQueueView:OnClickConfirm(  )
	local queueData = {};
	for k, v in mPairs( self.mQueueList ) do
		local data = v:GetQueueData();
		if data ~= nil then
			table.insert( queueData, data);
		end 
	end
	MansionController:SendSetPlantQueue( queueData );
	self:HideView( );
end

function MansionPlantQueueView:OnRecvPlantList( pbMansionPlantPlanlist )
	local queueList = self.mQueueList;
	for k, v in mIpairs( pbMansionPlantPlanlist.list ) do
		queueList[ v.id ]:SetQueueData( v );
	end
end

function MansionPlantQueueView:UpdateGridDataSource(  )
	local bagModel = mGameModelManager.BagModel;
	local data = bagModel:GetValidGoodsListWithType(bagModel.mTypeEnum.Seed);
	local dataSource = self.mDataSource;
	dataSource:ClearDatas(true);
	for k, v in mPairs( data.mSortTable ) do
		local uid = v.mGoodsUID;
		local goods_data = mBagGoodsVO.LuaNew(uid, v.mID, v.mColor, v.mNumber);
		dataSource:AddOrUpdate(uid, goods_data);
	end
	self.mGridEx:UpdateDataSource( dataSource );
end

function MansionPlantQueueView:Sort(a, b)
	local aColor = a.mColor;
	local bColor = b.mColor;
	if aColor == bColor then
		return a.mGoodsUID < b.mGoodsUID;
	else
		return aColor > bColor
	end
end

function MansionPlantQueueView:OnViewHide( )
	for k, v in mPairs( self.mQueueList ) do
		v:Reset( );
	end
end

function MansionPlantQueueView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return MansionPlantQueueView;