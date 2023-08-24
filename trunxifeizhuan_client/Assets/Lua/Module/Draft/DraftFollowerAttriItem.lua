local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local mAttributeTypeToVO = require "Module/Talent/AttributeTypeToVO"

local DraftFollowerAttriItem = mLuaClass("DraftFollowerAttriItem", mLayoutItem);
local mSuper = nil;

function DraftFollowerAttriItem:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "attri_item_view",
	};
end

function DraftFollowerAttriItem:Init()
	self.mTextName = self:FindComponent("name",'Text');
	self.mTextValue = self:FindComponent("value",'Text');
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self); 
end

function DraftFollowerAttriItem:OnUpdateData()
    local data = self.mData;
    local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[data.key];
    self.mTextName.text = attri_vo.name;
    self.mTextValue.text = self:GetValue(data.key,data.value,data.actor);
end

function DraftFollowerAttriItem:GetValue(id, value, actor)
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	
	if attri_vo.rate == 0 then
		value = Mathf.Round(value)  + self:GetAddValue(id,actor);
	else
		value = value * 100 + self:GetAddValue(id,actor) * 100;
		value = Mathf.Round(value);
		value = value..'%';
	end

	return value;
end

function DraftFollowerAttriItem:GetAddValue(id,actor)
	local addValue = 0;
	local officeKey = actor.."_"..mConfigSysactor[actor].position;
	local configOffice = mConfigSysfollower_office_up[officeKey];
	local addData = nil;
	if id == 8 then
		addData = configOffice.addition_attri[4];
	else
		addData = configOffice.addition_attri[id];
	end
	if addData ~= nil then
		return Mathf.Round(addData.value);
	else
		return 0;
	end
end

return DraftFollowerAttriItem;