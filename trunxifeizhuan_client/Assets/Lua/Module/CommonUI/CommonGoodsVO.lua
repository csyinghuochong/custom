local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local CommonGoodsVO = mLuaClass("CommonGoodsVO",BaseLua);
local mResourceUrl = require "AssetManager/ResourceUrl"
local mGoodsIcon = mResourceUrl.goods_icon;

function CommonGoodsVO:OnLuaNew(id, number, color, showDetial, clickBack)
	self.mID = id;
	self.mNumber = number;         --number传0不显示数量

	if showDetial == nil then
		showDetial = true;
	end
	self.mShowDetial = showDetial; --显示描述

	local sys_vo = mConfigSysgoods[id];
	if sys_vo == nil  then
		if id == -1 then
			return;
		end
		
       print("找不到对应物品"..id);
    else
    	self.mSysVO = sys_vo;
    	local quality = color ~= nil and color or sys_vo.quality;
		if quality ~= nil then
			self.mBg = self:GetBgIcon(quality);
			self.mKuang = self:GetKuangIcon(quality);
		end

		self.mIcon = sys_vo.icon;
	end

end

function CommonGoodsVO:GetBgIcon( quality )
	return string.format('common_bag_iconframe_%ds', quality)
end

function CommonGoodsVO:GetKuangIcon( quality )
	return string.format('common_bag_iconframe_%d', quality)
end

function CommonGoodsVO:GetIconPath(  )
	return mGoodsIcon;
end

function CommonGoodsVO:GetGoodsName(  )
	return self.mSysVO.goods_name;
end

return CommonGoodsVO;