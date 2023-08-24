local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local ChildCheckView = mLuaClass("ChildCheckView", mQueueWindow);

function ChildCheckView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_check_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
	};
end

function ChildCheckView:Init()
	self:InitData();
	self:InitSubView();
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	-- local mEvent = self.mEventEnum;
	-- self:RegisterEventListener(mEvent.,function(index)self:(index);end, false);
end

function ChildCheckView:InitData()
	self.mChildModel = mGameModelManager.ChildModel;
end

function ChildCheckView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Child/ChildCheckNotView"},
		{luaClass="Module/Child/ChildCheckHaveView"},
	}

	local getDataBack = function()
		return self.mChildModel;
	end

	local callBack = function(index)
		self:ChangeToggle(index);
	end
	self.mObjTab = self:Find('tabView');
	self.mTabView = mCommonTabView.LuaNew(self.mObjTab, view_vo_list, callBack, getDataBack);
	self.mTabView:OnClickToggleButton(1, true);
end

function ChildCheckView:ChangeToggle(index)
	
end

function ChildCheckView:Dispose()
	self.mTabView:CloseView();
end

function ChildCheckView:OnViewHide()
	
end

return ChildCheckView;