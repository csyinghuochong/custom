local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mConfigSysrank = require "ConfigFiles/ConfigSysrank"
local mSortTable = require "Common/SortTable"
local RankAwardView = mLuaClass("RankAwardView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgDesc1 = mLanguageUtil.rank_award_desc1
local mLgDesc2 = mLanguageUtil.rank_award_desc2

function RankAwardView.Show()
	mUIManager:HandleUI(mViewEnum.RankAwardView, 1);
end

function RankAwardView:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_award_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray,
		["ForbitSound"] = true
	};
end

function RankAwardView:Init()
	self.mTextDesc1 = self:FindComponent("Text/TextDesc1","Text");
	self.mTextDesc1.text = mLgDesc1;
	self.mTextDesc2 = self:FindComponent("Text/TextDesc2","Text");
	self.mTextDesc2.text = mLgDesc2;
	self:FindAndAddClickListener("Back/Button_close",function()self:OnClickHideView();end);

	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Rank/RankAwardItem");
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in ipairs(mConfigSysrank) do
		data_soure:AddOrUpdate(v.type,v);
	end
	self.mGridEx:UpdateDataSource(data_soure);
end

function RankAwardView:Dispose()
	self.mGridEx:Dispose();
end

return RankAwardView;