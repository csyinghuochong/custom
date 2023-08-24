local mLuaClass = require "Core/LuaClass"
local RankItem = require "Module/Rank/RankItem"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mCheckController = require "Module/Check/CheckController"
local PromoteRankItemView = mLuaClass("PromoteRankItemView",RankItem);
local mSuper = nil;

function PromoteRankItemView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_rank_item_view",
	};
end

function PromoteRankItemView:Init( )
	self.mTextValue2 = self:FindComponent("Value2","Text");
	
    mSuper = self:GetSuper(RankItem.LuaClassName);
	mSuper.Init(self);
end

function PromoteRankItemView:UpdateSubUI( data )
	self.mTextValue.text = mLeadBaseVO:GetOfficeName( data.position, data.sex);
	self.mTextValue2.text = data.score;
end

function PromoteRankItemView:OnClickItem()
	local data = self.mData;
	mCheckController:SendGetOtherPlayer(data.player_id);
end

return PromoteRankItemView;