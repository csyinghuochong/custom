local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local CampDungeonResurgenceView = mLuaClass("CampDungeonResurgenceView", mBaseWindow);

local COST = mConfigSysglobal_value[mConfigGlobalConst.DUNGEON_REBORN];
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgCost = mLanguageUtil.battle_relife_cost;

function CampDungeonResurgenceView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_resurgence_view",
		["ParentLayer"] = mPopLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function CampDungeonResurgenceView:Init()
    self:FindAndAddClickListener("Btn/BtnOk",function () self:OnResurgence() end);
    self:FindAndAddClickListener("Btn/BtnCancel",function () self:OnCancel() end);

    self.mTextCost = self:FindComponent("Text/TextDesc2","Text");
    self.mTextCost.text = mLgCost..COST;
end

function CampDungeonResurgenceView:OnViewShow(logicParams)
    self.mCallback = logicParams;
end

function CampDungeonResurgenceView:OnResurgence()
	local callback = self.mCallback;
	if callback ~= nil then
		callback(1);
	end
	self:HideView();
end

function CampDungeonResurgenceView:OnCancel()
	local callback = self.mCallback;
	if callback ~= nil then
		callback(2);
	end
	self:HideView();
end

return CampDungeonResurgenceView;