local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local RewardGoodsItemView = require "Module/Balance/RewardGoodsItemView"
local RewardMoneyItemView = mLuaClass("RewardMoneyItemView", RewardGoodsItemView);

function RewardMoneyItemView:OnAwake()
	self.mTextNumber = self:FindComponent('number','Text');
	self.mGoodsIcon = self:FindComponent('icon', 'Image');
end

function RewardMoneyItemView:OnViewShow(data)
	self.mTextNumber.text = data.mNumber;
	local icon = mGameModelManager.BagModel:GetSellIconByType( data.mGoodsId-1000000 );
	self.mGameObjectUtil:SetImageSprite(self.mGoodsIcon, icon);
end

return RewardMoneyItemView;