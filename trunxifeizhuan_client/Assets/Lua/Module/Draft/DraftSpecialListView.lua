local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mDraftSpecialItemVO = require "Module/Draft/DraftSpecialItemVO"
local mGameModelManager = require "Manager/GameModelManager"
local mSortTable = require "Common/SortTable"
local mLanguage = require "Utils/LanguageUtil"
local mTitleName = {mLanguage.draft_now_follower,
                    mLanguage.draft_next_week_follower,
                    mLanguage.draft_two_week_follower,
                    mLanguage.draft_three_week_follower}

local DraftSpecialListView = mLuaClass("DraftSpecialListView", mBaseWindow);

function DraftSpecialListView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "draft_special_list_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function DraftSpecialListView:Init()
    local grid_parent = self:Find('specialScrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(grid_parent, require "Module/Draft/DraftSpecialItemView");
    self:FindAndAddClickListener("common/close",function() self:HideView(); end);
end

function DraftSpecialListView:OnViewShow(logicParams)
	local dataSoure = mSortTable.LuaNew()
    for i=1,4 do
    	local itemData = mDraftSpecialItemVO.LuaNew(mTitleName[i],mGameModelManager.DraftModel.mSpecialDraftList[i]);
    	dataSoure:AddOrUpdate(i,itemData);
    end
    self.mGridEx:UpdateDataSource(dataSoure);
end

function DraftSpecialListView:Dispose()
	self.mGridEx:Dispose();
end

return DraftSpecialListView