local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local EndlseeSihaiBuffView = mLuaClass("EndlseeSihaiBuffView", mBaseView);
local mConfigSkillBuff = require "ConfigFiles/ConfigSysskill_buff"

function EndlseeSihaiBuffView:OnLuaNew(goParent)
	self.mGoParent = goParent;
end

function EndlseeSihaiBuffView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_sihaibuff_view",
	};
end

function EndlseeSihaiBuffView:Init()
	self.mBuffPalace = self:FindComponent('buffPalace', 'Text');
	self.mBuffLevel = self:FindComponent('buffLevel', 'Text');
    self:SetParent(self.mGoParent);
end

function EndlseeSihaiBuffView:OnViewShow()
    local gongshensihaiVO = mGameModelManager.EndlessDungeonModel.mGongshensihaiData;
    self.mBuffPalace.text = mConfigSkillBuff[gongshensihaiVO:GetPalaceBuffID()].desc;
    self.mBuffLevel.text = mConfigSkillBuff[gongshensihaiVO:GetLevelBuffID()].desc;
end


return EndlseeSihaiBuffView;