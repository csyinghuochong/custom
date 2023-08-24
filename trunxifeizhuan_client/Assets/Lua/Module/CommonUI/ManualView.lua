local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mConfigSysmanual = require "ConfigFiles/ConfigSysmanual"
local ManualView = mLuaClass("ManualView", mBaseWindow);

function ManualView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "manual_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] =mViewBgEnum.gray_clickable,
	};
end

function ManualView:Init()
	self.mTextTitle = self:FindComponent("TextTitle","Text");
	self.mTextDesc1 = self:FindComponent("ScrollView/Text_desc","Text");
end

function ManualView:OnViewShow(logicParams)
	if logicParams == nil then
		return;
	end
	self:ShowManualDesc( logicParams );
end

function ManualView:ShowManualDesc( logicParams )
	local manual = mConfigSysmanual[logicParams];
	self.mTextTitle.text = manual.title;
	self.mTextDesc1.text = string.gsub(manual.desc,"\\n","\n");
end

return ManualView;