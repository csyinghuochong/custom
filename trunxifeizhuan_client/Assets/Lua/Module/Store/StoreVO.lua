local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysshops = require "ConfigFiles/ConfigSysshops"
local mConfigSysgifts = require "ConfigFiles/ConfigSysgifts"
local StoreVO = mLuaClass("StoreVO", BaseLua);

function StoreVO:OnLuaNew(data)
	self.id = data.id;
	self.price = data.price;
	self.remain_count = data.remain_count;		--剩余数量
	self.sell_start_time = data.sell_start_time;--上架时间戳
	self.sell_end_time = data.sell_end_time;	--下架时间戳
	self.refresh_time = data.refresh_time;		--刷新时间
	self.remain_day = data.remain_day;			--剩余天数
	self.itemData = mConfigSysshops[data.id];	--普通商品数据
	self.giftData = self:GetGiftData(self.itemData.good_id);	--礼包商品数据
end

function StoreVO:GetGiftData(id)
	return mConfigSysgifts[id];
end

return StoreVO;