local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mConfigSysdraftchip = require "ConfigFiles/ConfigSysdraft_chip"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local DraftChipItemView = mLuaClass("DraftChipItemView", mLayoutItem);
local mSuper = nil;

function DraftChipItemView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "chip_item_view",
	};
end

function DraftChipItemView:Init()
	self.mCountStr = self:Find("count"):GetComponent('Text');
    self.mGoodsIcon = self:FindComponent('icon', 'RawImage');
    self.mGoodsBgIcon = self:FindComponent("goodsbg", 'Image');
    self.mGoodsKuang = self:FindComponent("kuang", 'Image');
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self); 
end

function DraftChipItemView:OnUpdateData()
    local data = self.mData;

    local kuang = data.mKuang;
    if self.mKuang ~= kuang then
        self.mKuang = kuang;
        self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,kuang);
    end

    local bg = data.mBg;
    if self.mBg ~= bg then
        self.mBg = bg;
        self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,bg);
    end
    
    mUITextureManager.LoadTexture(mGoodsIconPath, data.mSysVO.icon,self.mLoadedIcon);
    local commonChipId = mConfigSysglobal_value[mConfigGlobalConst.COMMON_CHIP];
    if data.mID == commonChipId then
        self.mCountStr.text = data.mNumber;
    else
        local chipConfig = mConfigSysdraftchip[data.mID];
        self.mCountStr.text = data.mNumber.."/"..chipConfig.goods_num;
    end
end

function DraftChipItemView:OnLoadedIcon(icon)
	self.mGoodsIcon.texture = icon;
end

return DraftChipItemView;