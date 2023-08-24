local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local ChildCheckNotView = mLuaClass("ChildCheckNotView",mCommonTabBaseView);

function ChildCheckNotView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_check_not_view",
	};
end

function ChildCheckNotView:Init()
	-- local parent = self:Find('');
	-- self.mGridEx = mLayoutController.LuaNew(parent, require "");
	-- self.mGridEx:SetSelectedViewTop(true);

	-- local mEvent = self.mEventEnum;
	-- self:RegisterEventListener(mEvent.,function()self:;end,true);
end

function ChildCheckNotView:OnUpdateUI(data)
	
end

function ChildCheckNotView:Dispose( )
	-- self.mGridEx:Dispose();
end

return ChildCheckNotView;