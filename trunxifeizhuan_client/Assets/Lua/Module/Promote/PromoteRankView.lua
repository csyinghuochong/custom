local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mSortTable = require "Common/SortTable"
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteRankVO = require "Module/Promote/PromoteRankVO"
local mPromoteController = require "Module/Promote/PromoteController"
local mVerticalLayoutControllerLoop = require "Core/Layout/VerticalLayoutControllerLoop"
local PromoteRankView = mLuaClass("PromoteRankView",mQueueWindow);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgRankOutOf = mLanguageUtil.rank_out_of;
local mSuper = nil;

function PromoteRankView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_rank_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function PromoteRankView:Init()
	self:InitSubView(  );
	self:InitLayoutControl( );
end

function PromoteRankView:InitSubView()
	self.mTextSelfRank = self:FindComponent("MyRank","Text");
	self.mTextSelfValue = self:FindComponent("MyValue","Text");
	self.mTextSelfValue2 = self:FindComponent("MyValue2","Text");
	self.mDataSoure = mSortTable.LuaNew(function(a,b) return a.rank < b.rank end,nil,true);
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_PROMOTE_RANK, function(data)
		self:OnRecvRankData( data );
	end, true);
end

function PromoteRankView:InitLayoutControl(  )
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mVerticalLayoutControllerLoop.LuaNew(parent, require "Module/Promote/PromoteRankItemView");
	self.mGridEx:SetItemInfo(838,102,4,4);
end

function PromoteRankView:OnViewShow()
	mPromoteController:RequestPromoteRank( );
end

function PromoteRankView:UpdateMyInfo( pbRankRe )
	self.mTextSelfValue2.text = pbRankRe.score;
	self.mTextSelfRank.text = pbRankRe.rank ~= 0 and pbRankRe.rank or mLgRankOutOf;
	self.mTextSelfValue.text = mGameModelManager.FollowerModel:GetOfficeName( );
end

function PromoteRankView:UpdateListInfo( pbRankRe )
	local datsSource = self.mDataSoure;
	datsSource:ClearDatas(true);

	for k,v in ipairs(pbRankRe) do
		local rankVO = mPromoteRankVO.LuaNew( v );
		datsSource:AddOrUpdate(rankVO.rank,rankVO);
	end
	self.mGridEx:UpdateDataSource( datsSource );
end

function PromoteRankView:OnRecvRankData( pbRankRe )
	self:UpdateMyInfo( pbRankRe );
	self:UpdateListInfo( pbRankRe.rank_player );
end

function PromoteRankView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return PromoteRankView;