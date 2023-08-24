local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local ChildTaskView = mLuaClass("ChildTaskView", mQueueWindow);

function ChildTaskView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_task_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
	};
end

function ChildTaskView:Init()
	local trans = self:Find("tabView/buttonView");
	local callback = function(index)
		self:OnClickToggle(index);
	end
	self.mToggle = mCommonToggleGroup.LuaNew(trans,callback);
	self:OnClickToggle(1);

	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);

	-- local mEvent = self.mEventEnum;
	-- self:RegisterEventListener(mEvent.,function(index)self:(index);end, false);
end

function ChildTaskView:OnClickToggle(index)
	print(index);
end

function ChildTaskView:Dispose()

end

function ChildTaskView:OnViewHide()
	
end

return ChildTaskView;