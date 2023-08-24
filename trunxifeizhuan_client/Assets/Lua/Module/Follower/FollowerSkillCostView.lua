local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local FollowerController = require "Module/Follower/FollowerController"
local FollowerSkillCostVO = require "Module/Follower/FollowerSkillCostVO"
local FollowerSkillCostView = mLuaClass("FollowerSkillCostView", mBaseVindow);
local mIpairs = ipairs;
local mPairs = pairs;

function FollowerSkillCostView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_break_cost_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function FollowerSkillCostView:Init()
	local goods_parent = self:Find('scrollView/Grid/');
	self.mGridEx = mLayoutController.LuaNew(goods_parent, require "Module/Follower/FollowerSkillCostItem");

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_IN_CAMP_FOLLOWER, function(vo)
   		self:OnRecvInCampFollower(vo);
   	end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_UP_SKILL_COST, function(vo)
   		self:OnClickCostItem(vo);
   	end, true);
end

function FollowerSkillCostView:OnViewShow(logicParams)
	self.mData = logicParams.data;
	self.mCallBack = logicParams.callBack;
	self.mCostData = nil;

	FollowerController:SendGetInCampFollower( );
end

function FollowerSkillCostView:OnRecvInCampFollower( ids )
	self.mInCampIds = ids;
	self.mGridEx:UpdateDataSource(self:GetDataSource(self.mData));
end

function FollowerSkillCostView:IsSelected( id )
	for k, v in mIpairs(self.mInCampIds) do
		if tonumber(v) == tonumber(id) then
			return true;
		end
	end
	return false;
end

--1消耗道具2消耗随从
function FollowerSkillCostView:GetDataSource( data )
	local dataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	local key = 1;
	local actorVo  = data.mActorVO;
	local skills_cost = actorVo.skills_cost;
	local bagModel = mGameModelManager.BagModel;
	for k, v in mPairs(skills_cost) do
		local goodsVo = bagModel:GetGoodsByGoodsId(v,bagModel.mTypeEnum.ConSumeType);
		if goodsVo ~= nil then
			dataSource:AddOrUpdate(key, FollowerSkillCostVO.LuaNew(1, v, key, mCommonGoodsVO.LuaNew(v, goodsVo.mNumber,nil,false)));
			key = key + 1;
		end
	end

	local actors = actorVo.actors;
	for k, v in mPairs(actors) do
		local followerVoList = mGameModelManager.FollowerModel:GetFollowerByActorID(v);
		if followerVoList ~= nil then
			for k2, followerVo in mPairs(followerVoList) do
				if followerVo.mUID ~= data.mUID and followerVo:CanBeBreakCost( 1 ) and not self:IsSelected(followerVo.mUID) then
					dataSource:AddOrUpdate(key, FollowerSkillCostVO.LuaNew(2, followerVo.mUID, key, followerVo));
					key = key + 1;
				end
			end
		end
	end

	return dataSource;
end

function FollowerSkillCostView:Sort(a, b)
	local aType = a.mCostType;
	local bType = b.mCostType;
	local aId = a.mID;
	local bId = b.mID;
	if aType == bType then
		return aId < bId;
	else
		return aType < bType;
	end
end

function FollowerSkillCostView:OnClickCostItem( data )
	self.mCostData = data;
	self:HideView( );
end

function FollowerSkillCostView:OnViewHide(  )
	local costData = self.mCostData;
	if costData ~= nil then
		self.mCallBack(costData);
	end
end

function FollowerSkillCostView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return FollowerSkillCostView;