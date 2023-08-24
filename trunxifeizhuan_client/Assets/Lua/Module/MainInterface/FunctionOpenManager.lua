local LuaClass = require "Core/LuaClass"
local mEventDispatcher = require "Events/EventDispatcher"
local mBaseLua = require "Core/BaseLua"
local mEvent = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigsysfunction = require "ConfigFiles/ConfigSysfunction_open"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local mConfigsyspromote = require "ConfigFiles/ConfigSyspromote"
local mMansionRankInfo = require "Module/Mansion/Rank/MansionRankInfo"
local FunctionOpenManager = LuaClass("FunctionOpenManager",mBaseLua);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOpenTip = mLanguageUtil.function_open_level_tip;
local mLgTableOpen = {mLanguageUtil.function_open_level_tip,mLanguageUtil.function_open_position_tip,mLanguageUtil.function_open_mansion_tip}

function FunctionOpenManager:OnLuaNew()
	self:Init();
end

function FunctionOpenManager:Init()
	self.mButtonList = {};
	mEventDispatcher:AddEventListener(mEvent.ON_PLAYER_UPDATE_LEVEL,function(value)self:RefreshButtonStateForLevel(value);end);
	mEventDispatcher:AddEventListener(mEvent.ON_PLAYER_UPDATE_OFFICE,function(value)self:RefreshButtonStateForPosition(value);end);
	mEventDispatcher:AddEventListener(mEvent.ON_PLAYER_UPDATE_BOOM_COIN,function(value)self:RefreshButtonStateForBoom(value);end);
	mEventDispatcher:AddEventListener(mEvent.MEMORY_DISPOSE,function(dispose)
			if dispose then
				local list = self.mButtonList;
				for k,v in pairs(list) do
					list[k] = nil;
				end
			end
		end);
end

function FunctionOpenManager:RegisterFunctionGo(id,go,openCondition)
	openCondition = openCondition or mConfigsysfunction[id].open_condition;
	local data = {buttonObject = go,condition = openCondition};
	self.mButtonList[id] = data;
	go:SetActive(self:IsFunctionOpen(openCondition));
end

function FunctionOpenManager:IsFunctionOpen(openCondition,Level,Position,Boom)
	if openCondition == nil then
		return true;
	end
	local tableCompare = self:GetTableCompare(Level,Position,Boom)
	for k,v in ipairs(openCondition) do
		if  tableCompare[v.open_id] < v.value then
			return false;
		end
	end
	return true;
end

function FunctionOpenManager:GetTableCompare(Level,Position,Boom)
	local playerBase = mGameModelManager.RoleModel.mPlayerBase;
	local playerLevel = Level or playerBase.level;
	local position = Position or playerBase.position;
	local mansionLevel = Boom and mMansionRankInfo:GetLevelByBoom(Boom) or mMansionRankInfo:GetLevelByBoom(playerBase.boom);
	local tableCompare = {};
	tableCompare[1] = playerLevel;
	tableCompare[2] = position;
	tableCompare[3] = mansionLevel;
	tableCompare[4] = 0;
	tableCompare[5] = 0;
	tableCompare[6] = 0;
	tableCompare[7] = 0;
	return tableCompare;
end

function FunctionOpenManager:RefreshButtonStateForLevel(value)
	local buttonList = self.mButtonList;
	for k,v in pairs(buttonList) do
		if v.buttonObject ~= nil then
			v.buttonObject:SetActive(self:IsFunctionOpen(v.condition,value));
		end
	end
end

function FunctionOpenManager:RefreshButtonStateForPosition(value)
	local buttonList = self.mButtonList;
	for k,v in pairs(buttonList) do
		v.buttonObject:SetActive(self:IsFunctionOpen(v.condition,nil,value));
	end
end

function FunctionOpenManager:RefreshButtonStateForBoom(value)
	local buttonList = self.mButtonList;
	for k,v in pairs(buttonList) do
		v.buttonObject:SetActive(self:IsFunctionOpen(v.condition,nil,nil,value));
	end
end

function FunctionOpenManager:GetRoleOffice( )
	return mGameModelManager.RoleModel:GetOffice();
end

function FunctionOpenManager:GetFunctionState(id)
	local functionOpenData = mConfigsysfunction[id];
	return self:IsFunctionOpen(functionOpenData.open_condition);
end

function FunctionOpenManager:GetFunctionOpenLevelStr(id)
	local functionOpenData = mConfigsysfunction[id];
	local openCondition = functionOpenData.open_condition;
	return functionOpenData.path_name..self:GetFunctionOpenStrByCondition( openCondition );
end

function FunctionOpenManager:GetFunctionOpenStrByCondition( openCondition )
	local tableCompare = self:GetTableCompare();
	local value = 0;
	local open_id = 0;
	for k,v in ipairs(openCondition) do
		open_id = v.open_id;
		value = v.value;
		if  tableCompare[open_id] < value then
			if open_id == 2 then
				local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
				local posStr = sex == 1 and mConfigsyspromote[value].man_name or mConfigsyspromote[value].woman_name;
				return string.format(mLgTableOpen[open_id],posStr);
			else
				return string.format(mLgTableOpen[open_id],value);
			end
		end
	end
end

function FunctionOpenManager:GetButtonTransByID(id)
	local buttonList = self.mButtonList;
	return buttonList[id].buttonObject.transform;
end

return FunctionOpenManager.LuaNew();