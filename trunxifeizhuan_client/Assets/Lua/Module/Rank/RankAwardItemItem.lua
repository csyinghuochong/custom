local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local RankAwardItemItem = mLuaClass("RankAwardItemItem",mLayoutItem);
local mSuper = nil;

function RankAwardItemItem:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_award_item_item_view",
	};
end

function RankAwardItemItem:Init( )
	self.mTextRank = self:FindComponent("Rank","Text");
	self.mTextAward = self:FindComponent("Award","Text");
	
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function RankAwardItemItem:OnViewShow( )
	local data = self.mData;
	if data.rank[2] == -1 then
		if data.rank[1] > 1 then
			self.mTextRank.text = ">"..(data.rank[1] - 1);
		else
			self.mTextRank.text = ">"..data.rank[1];
		end
	else
		self.mTextRank.text = data.rank[1].."-"..data.rank[2];
	end
	self.mTextAward.text = self:GetAwardStr(data.award_goods);
end

function RankAwardItemItem:GetAwardStr(awards)
	local str = "";
	for k,v in ipairs(awards) do
		local name = mConfigSysgoods[v.goods_id].goods_name;
		str = str..name.."  "..v.goods_number.."   ";
	end
	return str;
end

function RankAwardItemItem:OnUpdateData()
	
end

return RankAwardItemItem;