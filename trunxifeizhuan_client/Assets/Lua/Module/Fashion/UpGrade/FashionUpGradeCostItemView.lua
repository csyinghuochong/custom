local mLuaClass = require "Core/LuaClass"
local CommonBaseItemView = require"Module/Fashion/Common/CommonBaseItemView"
local FashionUpGradeCostItemView = mLuaClass("FashionUpGradeCostItemView", CommonBaseItemView);
local mGameModelManager = require "Manager/GameModelManager"
local mRightDir = Vector3.right;
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mIconPath = mResourceUrl.goods_icon;

function FashionUpGradeCostItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_cost_item_view",
	};
end

function FashionUpGradeCostItemView:OnAwake()

	self.mNumberText = self:FindComponent("number","Text");
	self.mIconImage = self:FindComponent("icon","RawImage");
	local index = self.mIndex;
	if index then
		self:SetItemRoot(self.mItemRoot,index);
	end

	self.mLoadedIcon = function (tex)
		self:OnLoadedIcon(tex);
	end
end

function FashionUpGradeCostItemView:GetPosition()
	return mRightDir*100*(self.mIndex - 1)
end

function FashionUpGradeCostItemView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionUpGradeCostItemView:UpdateIcon(icon)
	if icon then
		mUITextureManager.LoadTexture(mIconPath, icon,self.mLoadedIcon);
	end
end

function FashionUpGradeCostItemView:OnLoadedIcon(tex)
	self.mIconImage.texture = tex;
end

function FashionUpGradeCostItemView:OnUpdateData(data)
	local bag = mGameModelManager.BagModel;
	local id = data.goods;

	local goodsVo = bag:GetGoodsByGoodsId(id);
	local totalGoodsNumber = 0;
	local icon = nil;
	if goodsVo then
		totalGoodsNumber = goodsVo.mNumber;
		icon = goodsVo.mIcon;
	end

	if not icon then
		local goods = mConfigSysgoods[id];
		if goods then
			icon = goods.icon;
		end
	end

	self:UpdateIcon(icon);
	self.mNumberText.text = data.number.."/"..totalGoodsNumber;

end

return FashionUpGradeCostItemView;