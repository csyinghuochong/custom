local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mRankView = require "Module/Rank/RankView"
local mGameModelManager = require "Manager/GameModelManager"
local mMansionRankInfo = require "Module/Mansion/Rank/MansionRankInfo"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local mVerticalLayoutControllerLoop = require "Core/Layout/VerticalLayoutControllerLoop"
local MansionRankView = mLuaClass("MansionRankView",mRankView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgRankOutOf = mLanguageUtil.rank_out_of;
local mSuper = nil;

function MansionRankView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_rank_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function MansionRankView:Init()
	self.mTextSelfValue2 = self:FindComponent("MyValue2","Text");
	self.mRankType = mGameModelManager.RankModel.mTypeEnum.MANSION;

	mSuper = self:GetSuper(mRankView.LuaClassName);
	mSuper.Init(self);
end

function MansionRankView:InitSubView()

end

function MansionRankView:InitLayoutController(  )
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mVerticalLayoutControllerLoop.LuaNew(parent, require "Module/Mansion/Rank/MansionRankItem");
	self.mGridEx:SetItemInfo(844,102,8,5);
end

function MansionRankView:ChangeValue(data)
	mSuper.ChangeValue(self, data);

	self.mTextSelfValue2.text = mMansionRankInfo:GetAwardByRank(self.mRankType, data.self_rank);

end

function MansionRankView:ClickBtn()
	mUIManager:HandleUI(mViewEnum.ManualView,1, mConfigSysmanualConst.MANSION_FANRONGDU);
end

function MansionRankView:OnViewShow()
	local model = mGameModelManager.RankModel;
	self.mGridEx:UpdateDataSource(model.mDataSoure);
	self:GetRankList(self.mRankType , model.mPageNum);
end

function MansionRankView:Dispose( )
	self.mGridEx:Dispose();
end

return MansionRankView;