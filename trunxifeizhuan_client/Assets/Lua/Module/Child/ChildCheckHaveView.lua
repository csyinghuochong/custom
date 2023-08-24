local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local ChildCheckHaveView = mLuaClass("ChildCheckHaveView",mCommonTabBaseView);

function ChildCheckHaveView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_check_have_view",
	};
end

function ChildCheckHaveView:Init()
	-- local parent = self:Find('');
	-- self.mGridEx = mLayoutController.LuaNew(parent, require "");
	-- self.mGridEx:SetSelectedViewTop(true);

	-- local mEvent = self.mEventEnum;
	-- self:RegisterEventListener(mEvent.,function()self:;end,true);
end

function ChildCheckHaveView:OnUpdateUI(data)
	
end

function ChildCheckHaveView:Dispose( )
	-- self.mGridEx:Dispose();
end

return ChildCheckHaveView;