local mLuaClass = require "Core/LuaClass"
local mBowlderAttributeItem = require "Module/Talent/TalentAttributeItem"
local KingAttributeItem = mLuaClass("KingAttributeItem",mBowlderAttributeItem);

function KingAttributeItem:Init()
	self.mTextValue = self:FindComponent('value', 'Text');								  
	-- local image_icon = self:Find('icon');
	-- self.mImageIcon = image_icon:GetComponent('GameImage');
end

function KingAttributeItem:UpdateUI(id, value)
	local colorStr = "<color=#55AE57>+%s</color>"
	local num = string.format(colorStr,self:GetValue(id, value));
	self.mTextValue.text = self:GetName(id).." "..num;

	-- self.mImageIcon:SetSprite(self:GetIcon(id));
end

return KingAttributeItem;