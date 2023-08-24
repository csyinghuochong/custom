local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local EndlseeMeiyingBuffView = mLuaClass("EndlseeMeiyingBuffView", mBaseView);
local mConfigSkillBuff = require "ConfigFiles/ConfigSysskill_buff"

function EndlseeMeiyingBuffView:OnLuaNew(goParent)
	self.mGoParent = goParent;
end

function EndlseeMeiyingBuffView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_meiyingbuff_view",
	};
end

function EndlseeMeiyingBuffView:Init()
	self.mBuffLevel = self:FindComponent('buffLevel', 'Text');
    self:SetParent(self.mGoParent);
end

function EndlseeMeiyingBuffView:OnViewShow()
    local shengongmeiyingVO = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
    --self.mBuffLevel.text = mConfigSkillBuff[shengongmeiyingVO:GetBuffID()].desc;
end

return EndlseeMeiyingBuffView;