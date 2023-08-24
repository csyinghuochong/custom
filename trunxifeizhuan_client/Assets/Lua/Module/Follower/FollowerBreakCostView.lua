local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local FollowerController = require "Module/Follower/FollowerController"
local FollowerBreakCostView = mLuaClass("FollowerBreakCostView", mBaseWindow);
local mIpairs = ipairs;
local mPairs = pairs;

function FollowerBreakCostView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_break_cost_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function FollowerBreakCostView:Init()
	local goods_parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(goods_parent, require "Module/Follower/FollowerBreakFollowerItem");

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_BREAK_FOLLOWER, function(vo)
   		self:OnSelectCostItem(vo);
   	end, true);

   	self:RegisterEventListener(mEventEnum.ON_CANCEL_BREAK_FOLLOWER, function(vo)
   		self:OnCancelCostItem(vo);
   	end, true);

   	self:RegisterEventListener(mEventEnum.ON_RECV_IN_CAMP_FOLLOWER, function(vo)
   		self:OnRecvInCampFollower(vo);
   	end, true);

   	self.mUpdateDataBack = function (  )
   		self:ShowSelectFollower( );
   	end
end

function FollowerBreakCostView:OnViewShow(logicParams)
	self.mFollowerVO = logicParams.followerVo;
	self.mNeedStar = logicParams.needStar;
	self.mSelectIds = logicParams.selectIds;
	self.mNeedNumber = logicParams.needNumber;
	self.mCurrentNum = #logicParams.selectIds;

	FollowerController:SendGetInCampFollower( );
end

function FollowerBreakCostView:OnRecvInCampFollower( inCampIds )
	self.mGridEx:UpdateDataSource(self:GetDataSource(self.mFollowerVO, self.mNeedStar, inCampIds ) , self.mUpdateDataBack );
end

function FollowerBreakCostView:ShowSelectFollower(  )
	local grid = self.mGridEx;
	for k, v in pairs( self.mSelectIds ) do
		grid:GetChild( v.mUID ):ShowSelectedFlag( true );
	end
end

function FollowerBreakCostView:IsInCamp( id, inCampIds )
	for k, v in mIpairs(inCampIds) do
		if tonumber(v) == tonumber(id) then
			return true;
		end
	end
	return false;
end

function FollowerBreakCostView:GetDataSource( followerVo, needStar, inCampIds )
	local dataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	for k, v in pairs(mGameModelManager.FollowerModel.mFolloweList1.mSortTable) do
		if v ~= followerVo and v:CanBeBreakCost( needStar ) and not self:IsInCamp(v.mUID, inCampIds) then
			dataSource:AddOrUpdate(v.mUID, v);
		end
	end

	return dataSource;
end

function FollowerBreakCostView:Sort(a, b)
	return  a.mID < b.mID;
end

function FollowerBreakCostView:OnSelectCostItem( data )
	local num = self.mCurrentNum + 1;
	if num <= self.mNeedNumber then
		self.mCurrentNum = num;
		self.mGridEx:GetChild( data.mUID ):ShowSelectedFlag( true );
	end
end

function FollowerBreakCostView:OnCancelCostItem( data )
	self.mCurrentNum = self.mCurrentNum - 1;
	self.mGridEx:GetChild( data.mUID ):ShowSelectedFlag( false );
end

function FollowerBreakCostView:OnViewHide( )
	for k, v in pairs( self.mGridEx.mViews ) do
		v:ShowSelectedFlag( false );
	end
end

function FollowerBreakCostView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return FollowerBreakCostView;