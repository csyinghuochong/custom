local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local ArenaRuleAwardItem = mLuaClass("ArenaRuleAwardItem",mLayoutItem);
local mString = string;
local mSuper = nil;

function ArenaRuleAwardItem:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_rule_award_item",
	};
end

function ArenaRuleAwardItem:Init()
	self.mTextScore = self:FindComponent( 'Text_2', 'Text' );

	local rewardList = { };
	for i = 1, 3 do
		rewardList[ i ] = mCommonGoodsItemView.LuaNew( self:Find( 'item'..i ).gameObject );
	end
	self.mRewardList = rewardList;

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ArenaRuleAwardItem:OnUpdateData()
	local data = self.mData;
	
	self.mTextScore.text = data:GetScoreRegion(  );
	local rewardVo = data.mSysVO.reward;
	for k, v in pairs( self.mRewardList ) do
		local vo = rewardVo[ k ];
		if vo then
			v:UpdateByIdAndNum(  vo.goods_id, vo.goods_num );
		else
			v:HideView( );
		end
	end
end

return ArenaRuleAwardItem;