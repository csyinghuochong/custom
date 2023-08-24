local mLuaClass = require "Core/LuaClass"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local CommonEquipItemView = mLuaClass("CommonEquipItemView", mCommonGoodsItemView);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgLevel = mLanguageUtil.level;

function CommonEquipItemView:Init( )
	mSuper = self:GetSuper(mCommonGoodsItemView.LuaClassName);
	mSuper.Init(self);
end

function CommonEquipItemView:ShowGoodsNumber( number )
	local textNumber = self.mTextNumber;
	if textNumber ~= nil then
		textNumber.text = number..mLgLevel;
	end
end

return CommonEquipItemView;