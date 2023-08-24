local mLayoutItem = require "Core/Layout/LayoutItemLoop"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local BagItemView = mLuaClass("BagItemView", mLayoutItem);
local mEventEnum = require "Enum/EventEnum"
local mColor = Color;
local mSuper = nil;
local mGameModelManager = require "Manager/GameModelManager"
local mGoodsIconPath = mResourceUrl.goods_icon;

function BagItemView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "bag_item_view",
	};
end

function BagItemView:Init( )
	self.mTextNumber = self:FindComponent('Text', 'Text');

	local goodsIcon = self:FindComponent('icon', 'RawImage');
	self.mGoodsIcon = goodsIcon;
	self.mGoodsIconGo = goodsIcon.gameObject;

	local goodsBgIcon = self:FindComponent("goodsbg", 'Image');
    self.mGoodsBgIcon = goodsBgIcon;
    self.mGoodsBgIconGo = goodsBgIcon.gameObject;

    self.mGoodsKuang = self:FindComponent("kuang", 'Image');
    self.mGoBatchIcon = self:Find("gou").gameObject;
    self.mGoodsIcon.color = mColor.clear;
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end

    local callBack = function()
    	self:PlaySoundName("ty_0203");
   		self:OnClickGoodsItem();
     end;
    self:AddBtnClickListener(self.mGameObject, callBack);

    self:RegisterEventListener(self.mEventEnum.ON_CANCEL_BAG_BATCH, function(data)
		   self:OnCancelBatch(data);
	  end, true);

    self:RegisterEventListener(self.mEventEnum.ON_CHANGE_BAG_SELECT_TO_BATCH, function(data)
		   self:OnChangeSelectToBatch(data);
	  end, true);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function BagItemView:OnBeforeUpdateData(oldData,newData)
	mSuper.OnBeforeUpdateData(self,oldData,newData);

	local curDataBatchSelected = newData.mBatchSelected;
	if oldData.mBatchSelected ~= curDataBatchSelected then
		self.mGoBatchIcon:SetActive(curDataBatchSelected == true);
	end
end

function BagItemView:OnChangeSelectToBatch(data)
	local Data = self.mData;
	if Data.mGoodsUID == data.mGoodsUID then
		self:OnClickGoodsItem();
	end
end

function BagItemView:OnViewShow( )
	
end

function BagItemView:OnClickGoodsItem()
	local model = mGameModelManager.BagModel;
	local data = self.mData;
    if data.mSysVO ~= nil then
    	if model.mIsBatch then
    		local batchSelected = not data.mBatchSelected;
    		data.mBatchSelected = batchSelected;

    		self.mGoBatchIcon:SetActive(batchSelected);
    		model:ChangeBatchTable(data,batchSelected);
    	else
       		self:SetSelected(true);
       	end
    end
end

function BagItemView:OnCancelBatch(data)
	self.mData.mBatchSelected = nil;
	self.mGoBatchIcon:SetActive(false);
end

function  BagItemView:OnSelected(select)
	if select then
       self:Dispatch(mEventEnum.ON_SELECT_BAG_GOODS,self.mData);
	end
end

function BagItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function BagItemView:ExternalUpdate(data)
	if data == nil then
		return;
	end;
	local textNumber = self.mTextNumber;
	local goodsIcon = self.mGoodsIcon;

	local num = nil;
	if data.mNumber == 0 then
       num = "";
	else
	   num = data.mNumber;
	end

	if self.mNum ~= num then
		self.mNum = num;
		textNumber.text = num;
	end

	local kuang = data.mKuang;
	if self.mKuang ~= kuang then
		self.mKuang = kuang;
		self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,kuang);
	end
	
	local showIcon = data.mID ~= nil and data.mID > 0;
	if showIcon then

		local bg = data.mBg;
		if self.mBg ~= bg then
			self.mBg = bg;
			self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,bg);
		end
		
	    mUITextureManager.LoadTexture(mGoodsIconPath, data.mSysVO.icon,self.mLoadedIcon);
	else
        goodsIcon.color = mColor.New(1,1,1, 0);
	end

	if self.mShowIcon ~= showIcon then
		self.mShowIcon = showIcon;
		self.mGoodsIconGo:SetActive(showIcon);
		self.mGoodsBgIconGo:SetActive(showIcon);
	end
end

function BagItemView:OnLoadedIcon(icon)
	self.mGoodsIcon.texture = icon;
	self.mGoodsIcon.color = mColor.white;
end

return BagItemView;