local mLuaClass = require "Core/LuaClass"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentItemGoodsView = mLuaClass("TalentItemGoodsView", TalentItemBaseView);

function TalentItemGoodsView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_item_goods_view",
	};
end

function TalentItemGoodsView:Init( )
    mSuper = self:GetSuper(TalentItemBaseView.LuaClassName);
	mSuper.Init(self);
end

function TalentItemGoodsView:InitGameImage( )
	self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
 	self.mGoodsColor = self:FindComponent("color", 'Image');
	self.mGoodsKuang = self:FindComponent("kuang", 'Image');
end

function TalentItemGoodsView:UpdateGameImage( data )
    local bg = data:GetBgIcon( );
	if self.mBg ~= bg then
		self.mBg = bg;
		self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon, bg);
	end

	local color = data:GetColorIcon( );
	if self.mColor ~= color then
		self.mColor = color;
		self.mGameObjectUtil:SetImageSprite(self.mGoodsColor, color);
	end

	local kuang = data:GetKuangIcon( );
	if self.mKuang ~= kuang then
		self.mKuang = kuang;
		self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang, kuang);
	end

end

function TalentItemGoodsView:OnClickIcon()
	self:PlaySoundName("ty_0203");
	self:Dispatch(self.mEventEnum.ON_SELECT_TALENT_ITEM, self.mData);
end

return TalentItemGoodsView;