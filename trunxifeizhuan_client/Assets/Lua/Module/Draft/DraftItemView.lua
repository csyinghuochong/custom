local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mGoodsConfig = require "ConfigFiles/ConfigSysgoods"
local mFollowerConfig = require "ConfigFiles/ConfigSysfollower_office_up"
local mActorConfig = require "ConfigFiles/ConfigSysactor"
local mDraftChipConfig = require "ConfigFiles/ConfigSysdraft_chip"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mRoleIconPath = mResourceUrl.role_icon;
local mGameModelManager = require "Manager/GameModelManager"
local mLanguage = require "Utils/LanguageUtil"
local mEventEnum = require "Enum/EventEnum"
local mColor = Color;
local DraftItemView = mLuaClass("DraftItemView", mLayoutItem);
local mSuper = nil;

function DraftItemView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "draft_item_view",
	};
end

function DraftItemView:Init()
	self.mNameStr = self:Find("name"):GetComponent('Text');
	self.mCountStr = self:Find("count"):GetComponent('Text');
  local callBack = function() self:OnClickItem() end;
  self:FindAndAddClickListener("", callBack,"ty_0204");
  self.mGoodsBgIcon = self:FindComponent("item/bg", 'Image');
  self.mGoodsKuang = self:FindComponent("item/kuang", 'Image');
	self.mGoodsIcon = self:FindComponent('item/icon', 'RawImage');
  self.mGoodsIcon.color = mColor.clear;
  self:RegisterEventListener(mEventEnum.ON_GOODS_UPDATE, function()
      self:RefreshGoodsNum();
  end, true);
	self.mLoadedIcon = function (icon)
		  self:OnLoadedIcon(icon);
	end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self); 
end

function DraftItemView:OnClickItem()
   self:SetSelected(true);
end

function  DraftItemView:OnSelected(select)
  if select then
       self:Dispatch(mEventEnum.ON_SELECT_DRAFT,self.mData);
  end
end

function DraftItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

function DraftItemView:RefreshGoodsNum()
	local data = self.mData;
  local bagModel = mGameModelManager.BagModel;
	if data.mType ~= 0 then
		local config = mGoodsConfig[data.mGoodsId];
    if data.mType == 8 then
   	  local needCount = data.mSysVO.goods_cost[1].goods_num;
      self.mCountStr.text = config.goods_name..":"..bagModel:GetGoodsNumberGoodsId(data.mGoodsId,bagModel.mTypeEnum.ConSumeType).."/"..needCount;
    elseif data.mType == 9 then
      self.mCountStr.text = mLanguage.draft_goods_count..mGameModelManager.RoleModel.mPlayerBase.gold;
    elseif data.mType == 10 then
      self.mCountStr.text = "";
    else
      self.mCountStr.text = mLanguage.draft_goods_count..bagModel:GetGoodsNumberGoodsId(data.mGoodsId,bagModel.mTypeEnum.ConSumeType);
    end
  end
end

function DraftItemView:ExternalUpdate(data)
    if data == nil then
		return;
	end
	local kuang = nil;
	local bg = nil;
  local bagModel = mGameModelManager.BagModel;
	if data.mType ~= 0 then
       local config = mGoodsConfig[data.mGoodsId];
       kuang = "common_bag_iconframe_"..config.quality;
       bg = "common_bag_iconframe_" .. config.quality.."s";
       mUITextureManager.LoadTexture(mGoodsIconPath, config.icon,self.mLoadedIcon);
       self.mNameStr.text = data.mSysVO.draft_name;
       self:RefreshGoodsNum();
	else
       local actorVO = mActorConfig[data.mGoodsId];
       local key = data.mGoodsId.."_"..actorVO.position;
       local config = mFollowerConfig[key];
       self.mNameStr.text = actorVO.name;
       local haveCount = bagModel:GetGoodsNumberGoodsId(data.mChipId,bagModel.mTypeEnum.DraftType);
       local needCount = mDraftChipConfig[data.mChipId].goods_num;
       if haveCount >= needCount then
          self.mCountStr.text = mLanguage.draft_goods_count..haveCount.."/"..needCount;
       else
          local wannengCount = needCount - haveCount;
          self.mCountStr.text = mLanguage.draft_goods_count..haveCount.."<color=#00FF00>+"..wannengCount.."</color>/"..needCount;
       end
       kuang = "common_bag_iconframe_"..actorVO.position;
       bg = "common_bag_iconframe_" .. actorVO.position.."s";
       mUITextureManager.LoadTexture(mRoleIconPath, config.mini_icon,self.mLoadedIcon);
	end
	self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,kuang);
  self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,bg);
end

function DraftItemView:OnLoadedIcon(icon)
	self.mGoodsIcon.texture = icon;
  self.mGoodsIcon.color = mColor.white;
end

return DraftItemView;