local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mAttributeTypeToVO = require "Module/Talent/AttributeTypeToVO"
local TalentAttributeItem = mLuaClass("TalentAttributeItem",mBaseView);

function TalentAttributeItem:Init()
	self.mTextValue = self:FindComponent('Text_value', 'Text');								  
	self.mTextName =  self:FindComponent('Text_attri_name', 'Text');

	local text_add = self:Find(  'Text_add' );
	if text_add ~= nil then
		self.mTextAdd = text_add:GetComponent('Text')
	end
end

function TalentAttributeItem:GetValue(id, value)
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	
	if attri_vo.rate == 0 then
		value = Mathf.Round(value);
	else
		value = value * 100;
		value = Mathf.Round(value);
		value = value..'%';
	end

	return value;
end

function TalentAttributeItem:GetName( id )
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	return attri_vo.name;
end

function TalentAttributeItem:GetIcon( id )
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	return attri_vo.icon;
end

--value
function TalentAttributeItem:UpdateUI(id, value)
	self.mTextName.text = self:GetName(id);
	self.mTextValue.text = self:GetValue(id, value);
end

--+value
function TalentAttributeItem:UpdateAddValue(id, value)
	self.mTextName.text = self:GetName(id);
	self.mTextValue.text = '+'..self:GetValue(id, value);
end

function TalentAttributeItem:UpdateAttriStr( name, value )
	self.mTextName.text = name;
	self.mTextValue.text = value;
end

--value1  value2
function TalentAttributeItem:UpdateUITo(id, value, to)
	self.mTextAdd.text = self:GetValue(id, to);
	self:UpdateUI(id, value);
end

--value1 + value2
function TalentAttributeItem:UpdateUIAdd(id, value, add)
	local textAdd = self.mTextAdd;
	if add == 0 then
		textAdd.text = '';
	else
		textAdd.text = '+ '..self:GetValue(id, add);
	end
	self:UpdateUI(id, value);
end

return TalentAttributeItem;