local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mArenaController = require "Module/Arena/ArenaController"
local mArenaRankItemVO = require "Module/Arena/Rank/ArenaRankItemVO"
local mVerticalLayoutControllerLoop = require "Core/Layout/VerticalLayoutControllerLoop"
local ArenaRankView = mLuaClass("ArenaRankView",mQueueWindow);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgRankOutOf = mLanguageUtil.rank_out_of;
local mSuper = nil;

function ArenaRankView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_rank_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function ArenaRankView:Init()
	self:InitSubView(  );
	self:InitLayoutControl( );
end

function ArenaRankView:InitSubView()
	self.mTextSelfRank = self:FindComponent("MyRank","Text");
	self.mTextSelfValue = self:FindComponent("MyValue","Text");
	self.mTextSelfValue2 = self:FindComponent("MyValue2","Text");
	self.mDataSoure = mSortTable.LuaNew(function(a,b) return a.rank < b.rank end,nil,true);
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_ARENA_RANK, function(data)
		self:OnRecvRankData( data );
	end, true);
end

function ArenaRankView:InitLayoutControl(  )
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mVerticalLayoutControllerLoop.LuaNew(parent, require "Module/Arena/Rank/ArenaRankItemView");
	self.mGridEx:SetItemInfo(838,102,4,4);
end

function ArenaRankView:OnViewShow()
	mArenaController:RequestArenaRank( );
end

function ArenaRankView:UpdateMyInfo( pbRankRe )
	self.mTextSelfValue2.text = pbRankRe.score;
	self.mTextSelfRank.text = pbRankRe.rank ~= 0 and pbRankRe.rank or mLgRankOutOf;
	self.mTextSelfValue.text = mArenaRankItemVO:GetDivisionVoByScore( pbRankRe.score ).name
end

function ArenaRankView:UpdateListInfo( pbRankRe )
	local datsSource = self.mDataSoure;
	datsSource:ClearDatas(true);

	for k,v in ipairs(pbRankRe) do
		local rankVO = mArenaRankItemVO.LuaNew( v );
		datsSource:AddOrUpdate(rankVO.rank,rankVO);
	end
	self.mGridEx:UpdateDataSource( datsSource );
end

function ArenaRankView:OnRecvRankData( pbRankRe )
	self:UpdateMyInfo( pbRankRe );
	self:UpdateListInfo( pbRankRe.rank_player );
end

function ArenaRankView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return ArenaRankView;