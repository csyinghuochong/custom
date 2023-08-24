local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local CombatSetView = mLuaClass("CombatSetView",mBaseView);
local Time = Time;
local string = string;

function CombatSetView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "combat_set_view",
		["ParentLayer"] = mBattleLayer,
	};
end

local mSpeeds = {
	[0] = 1;
	[1] = 1.5;
	[2] = 2;
}

local mDefaultSettings = {
	["SpeedIndex"] = 0;
	["AutoAttack"] = 0;
}

function  CombatSetView:Init()
	--set--
	self.mSpeedGraphic = self:FindComponent("Button_speedup/ImageSpeed","GameGraphic");
	self.mAutoGraphic = self:FindComponent("Button_auto/ImageAuto","GameGraphic");

	--local callBack_set = function() self:OnClickSetButton() end;
	local callBack_speedUp = function() self:OnClickGameSpeedUp() end;
	local callBack_auto = function() self:OnClickAutoCombat() end;
	--self:FindAndAddClickListener('Button_set', callBack_set);
	self:FindAndAddClickListener('Button_speedup', callBack_speedUp);
	self:FindAndAddClickListener('Button_auto', callBack_auto);
	self:SetParent(self.mGoParent);
end

function CombatSetView:ReadSettings()

	local key = self:GetPlayerPrefsKey();
	local settings = {};
	for k,v in pairs(mDefaultSettings) do
		local fullKey = key..k;
		if mPlayerPrefs.HasKey(fullKey) then
			settings[k] = mPlayerPrefs.GetInt(fullKey);
		else
			settings[k] = v;
		end
	end

	self.mSettings = settings; 
end

function CombatSetView:SaveSettings()

	local key = self:GetPlayerPrefsKey();
	local settings = self.mSettings;

	for k,v in pairs(settings) do
		mPlayerPrefs.SetInt(key..k,v);
	end

end

function CombatSetView:GetPlayerPrefsKey()
	local currentModel = mCombatModelManager.mCurrentModel;
	local playId = mGameModelManager.RoleModel:GetPlayerID();
	return string.format('%d_%d_CombatSettings.', playId, currentModel:GetDungeonPlay())
end

function CombatSetView:OnClickSetButton()
end

function CombatSetView:OnClickGameSpeedUp()

	local settings = self.mSettings;
	local speed = (settings["SpeedIndex"] + 1)%3;
	settings["SpeedIndex"] = speed;
	self:SetSpeed(speed);
end

function CombatSetView:OnClickAutoCombat()
	
	local settings = self.mSettings;
	local auto = (settings["AutoAttack"] + 1)%2;
	settings["AutoAttack"] = auto;
	self:SetAuto(auto);
end

function CombatSetView:SetSpeed(index)
	self.mSpeedGraphic:SetSpriteByIndex(index,true);
	self:SetTimeScale(mSpeeds[index]);
end

function CombatSetView:SetAuto(index)
	self.mAutoGraphic:SetSpriteByIndex(index,false);
	self:Dispatch(mEventEnum.ON_AUTO_COMBAT, index > 0);
end

function CombatSetView:SetTimeScale(value)
	Time.timeScale = value or 1;
end

function CombatSetView:OnViewShow()
	self:ReadSettings();
	local settings = self.mSettings;
	self:SetSpeed(settings["SpeedIndex"]);
	self:SetAuto(settings["AutoAttack"]);
end

function CombatSetView:OnViewHide( )
	self:SaveSettings();
	self:Reset();
end

function CombatSetView:Dispose()
	
end

function CombatSetView:Reset()
	self:SetTimeScale(1);	
end

return CombatSetView;