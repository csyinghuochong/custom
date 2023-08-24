local mLuaClass = require "Core/LuaClass"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local CommonAnalyseGoodsInfo = mLuaClass("CommonAnalyseGoodsInfo");
local mGlobalUtil = require "Utils/GlobalUtil"
local mColorTable = mGlobalUtil.Colors;
local mString = string;
local mPairs = pairs;

function CommonAnalyseGoodsInfo:GetGoodsListNameAndNumber( goodsList )
	local str = '';
	for k, v in mPairs( goodsList ) do
		local goods_info = self:GetGoodsListNameAndNumber( v );
		info = info..goods_info;
	end

	return str;
end

function CommonAnalyseGoodsInfo:GetSingleGoodsNameAndNumber( goods )
	local goods_id = goods.goods_id;
	local goods_num = goods.goods_num;
	local goods_name = self:GetGoodsNameByGoodsId( goods_id );
	local goods_info = mString.format( '%sX%d', goods_name, goods_num )
	return goods_info;
end

function CommonAnalyseGoodsInfo:GetGoodsNameByGoodsId( goods_id  )
	local goods_vo = mConfigSysgoods[ goods_id ];
	return mString.format(mColorTable[goods_vo.quality], goods_vo.goods_name);
end

return CommonAnalyseGoodsInfo;