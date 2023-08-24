local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mLayoutController = require "Core/Layout/LayoutController"
local mSortTable = require "Common/SortTable"
local RankAwardItem = mLuaClass("RankAwardItem",mLayoutItem);
local mSuper = nil;

function RankAwardItem:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_award_item_view",
	};
end

function RankAwardItem:Init( )
	self.mTextTitle = self:FindComponent("Title","Text");

	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Rank/RankAwardItemItem");
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function RankAwardItem:OnViewShow( )
	local data = self.mData;
	self.mTextTitle.text = data.name;
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in ipairs(data.rank_award) do
		data_soure:AddOrUpdate(k,v);
	end
	self.mGridEx:UpdateDataSource(data_soure);
end

function RankAwardItem:OnUpdateData()
	
end

function RankAwardItem:Dispose()
	self.mGridEx:Dispose();
end

return RankAwardItem;