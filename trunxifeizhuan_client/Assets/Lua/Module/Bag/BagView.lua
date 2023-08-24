local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mBagController = require "Module/Bag/BagController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mBagSellSingleView = require "Module/Bag/BagSellSingleView"
local mLayoutController = require "Core/Layout/GridLayoutControllerLoop"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local mAttributeTypeToVO = require "Module/Talent/AttributeTypeToVO"
local mEventEnum = require "Enum/EventEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mSellTips = mLanguageUtil.goods_sell_tips;
local mNoUseTips = mLanguageUtil.goods_no_use_tips;
local mNoBatchSelect = mLanguageUtil.goods_no_batch_select_tips;
local mSellNum = mLanguageUtil.goods_sell_num;
local mSellSingle = mLanguageUtil.goods_sell_single;
local BagView = mLuaClass("BagView", mQueueWindow);

function BagView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "bag_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
    ["PlayAnimation"] = true,
    ["cost"] = {"gold","silver"},
	};
end

function BagView:Init()
	  local describe_item = self:Find("describe");
	  self.mGoodsName = describe_item:Find("name"):GetComponent('Text');
    self.mGoodsPrice = describe_item:Find("money/num"):GetComponent('Text');
    self.mGoodsUseText = describe_item:Find("use/Text"):GetComponent('Text');
    self.mUseDesc = describe_item:Find("useDesc").gameObject;
    self.mUseDescStr = describe_item:Find("useDesc"):GetComponent('Text');
    self.mSelectGoods = mCommonGoodsItemView.LuaNew(describe_item:Find('goods').gameObject);
    self.mTotalGoodsNum = self:Find("num"):GetComponent('Text');

    self:RegisterEventListener(mEventEnum.ON_SELECT_BAG_GOODS, function(data)
		   self:OnClickGoodsItem(data);
	  end, true);
	  self:RegisterEventListener(mEventEnum.ON_BAG_GOODS_REFRESH, function(params)
	     self:RefreshItem(params);
	  end, true);
    self:RegisterEventListener(mEventEnum.ON_BAG_SHOW_INFO, function(data)
       self:SetGoodsInfo(data);
    end, true);
    self:RegisterEventListener(mEventEnum.ON_GOODS_UPDATE, function()
       self:UpdateGoodsNumText();
    end, true);

    self.mGoBtnUse = self:Find("describe/use").gameObject;
    self.mGoBtnSell = self:Find("describe/sell").gameObject;
    self:FindAndAddClickListener("describe/use",function () self:OnClickUseButton() end);
    self:FindAndAddClickListener("describe/sell",function () self:OnClickSellButton() end);
    self:FindAndAddClickListener("describe/Get",function () self:OnClickGetButton() end);

    self.mGoBtnBatch = self:Find("BtnBatch").gameObject;
    self.mGoBtnBatchOK = self:Find("BtnBatchOK").gameObject;
    self.mGoBtnBatchCancel = self:Find("BtnBatchCancel").gameObject;
    self:FindAndAddClickListener("BtnBatch",function () self:OnClickBatchButton() end);
    self:FindAndAddClickListener("BtnBatchOK",function () self:OnClickBatchOKButton() end);
    self:FindAndAddClickListener("BtnBatchCancel",function () self:OnClickBatchCancelButton() end);

    self.mGoSelect = self:Find('goods/Content/setlect').gameObject;
	  self:FindAndAddClickListener("common_bg2/Button_close",function() self:ReturnPrevQueueWindow() end);
	  local goods_parent = self:Find('goods/Content');
    local grid = mLayoutController.LuaNew(goods_parent, require "Module/Bag/BagItemView");
	  self.mGoodsGridEx = grid;
    grid:SetSelectedViewTop(true);
    grid:SetItemInfo(86,86,0,0,6,5);
	  local callBack = function( index )
		   self:OnClickTypeButton(index);
	  end
    self.mUseGray = mUIGray.LuaNew():InitGoGraphics(self:Find('describe/use').gameObject);
    self.mSellIcon = self:FindComponent("describe/money/icon","Image");
	  self.mDescBg = describe_item;
	  self.mNogoodsBg = self:Find('nogoods');
    self.mGoDescBg = self:Find('LeftBack/ImageBg').gameObject;
	  local go = self:Find('TabView/buttonView');
	  self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,2);
    self.mSelectIndex = 1;
end

function BagView:SetBatchBtnState(state)
    local model = mGameModelManager.BagModel;
    local batchTable = model.mBatchTable;
    for k,v in pairs(batchTable) do
      v.mBatchSelected = nil;
      batchTable[k] = nil;
    end

    model.mLastBatchData = nil;
    model.mIsBatch = state;
    self.mGoBtnBatch:SetActive(not state);
    self.mGoBtnSell:SetActive(not state);
    self.mGoBtnUse:SetActive(not state);
    self.mGoBtnBatchOK:SetActive(state);
    self.mGoBtnBatchCancel:SetActive(state);
    if not state then
        self:Dispatch(mEventEnum.ON_CANCEL_BAG_BATCH,nil);
    end
end

function BagView:OnClickBatchButton()
    self:SetBatchBtnState(true);
    local selectData = self.mSelectData;
    if selectData ~= nil then
        self.mGoSelect:SetActive(false);
        self:Dispatch(mEventEnum.ON_CHANGE_BAG_SELECT_TO_BATCH,selectData);
    end
end

function BagView:OnClickBatchOKButton()
    local model = mGameModelManager.BagModel;
    local batchTable = model.mBatchTable;
    local num = model:GetBatchNum();
    if num == 0 then
        mCommonTipsView.Show(mNoBatchSelect);
    else
        local allPrice = model:GetBatchPrice();
        local CallBack = function()
          for k,v in pairs(batchTable) do
            local tableSell = {};
            local data = {id=v.mGoodsUID,num=v.mNumber};
            table.insert(tableSell,data);
            mBagController:SendSellBatchGoods(tableSell);
          end
          self:SetBatchBtnState(false);
        end
        local data = {desc = string.format(mSellNum,num),price=allPrice,callback = CallBack}
        mBagSellSingleView.Show(data);
    end
end

function BagView:OnClickBatchCancelButton()
    local lastBatchData = mGameModelManager.BagModel.mLastBatchData;
    if lastBatchData ~= nil then
        self:SelectGoods(lastBatchData);
        self.mGoodsGridEx:SetViewSelectedByKey(lastBatchData.mGoodsUID,true);
    end
    self:SetBatchBtnState(false);
end

function BagView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    self.mToggleGroup:SwitchToogle(self.mSelectIndex);
end

function BagView:GetNowType()
    local index = self.mSelectIndex;
    if index == 1 then
        return 3;
    else
        return 5;
    end
end

function BagView:RefreshItem(params)
  local goodsData = params.mData;
  local changeType = params.mType;

  --新增道具或者变化道具不是当前选择类型不用变化
  local goodsType = self:GetNowType();
  
  if changeType == 3 or goodsType ~= goodsData.mSysVO.type then
    return;
  end
  
  if self.mSelectGoodsData.mGoodsUID == goodsData.mGoodsUID then
     if changeType == 2 then --删除
        local newSelectData = self.mGoodsGridEx.mSortTable.mSortTable[1];
        newSelectData = self:CheckBlankGoods(newSelectData);
        self:SelectGoods(newSelectData);
        if newSelectData ~= nil then
          self.mGoodsGridEx:SetViewSelectedByKey(newSelectData.mGoodsUID,true);
        end
     elseif changeType == 1 then --变化
        self:SetGoodsInfo(goodsData);
     end
  end
end

function BagView:SelectGoods(data)
    self.mSelectData = data;
    self.mGoSelect:SetActive(data ~= nil);
    self.mDescBg.gameObject:SetActive(data ~= nil);
    self.mNogoodsBg.gameObject:SetActive(data == nil);
    self.mGoDescBg:SetActive(data ~= nil);
    self.mGoBtnBatch:SetActive(data ~= nil);
    if data ~= nil then
      self:SetGoodsInfo(data);
    end
end

function BagView:GetGoodsTypeByIndex()
    local index = self.mSelectIndex;
    if index == 1 then
      return 3;
    elseif index == 2 then
      return 5;
    end
end

function BagView:CheckBlankGoods(data)
    if data and data.mGoodsUID < 0 then
        return nil;
    end

    return data;
end

function BagView:ShowGoodsList()
    local bagModel = mGameModelManager.BagModel;
    local data_soure = bagModel:GetGoodsListWithType( self:GetGoodsTypeByIndex() );
  
    local firstData = data_soure.mSortTable[1];
    firstData = self:CheckBlankGoods(firstData);

    self:SelectGoods(firstData);
    
    local gridEx = self.mGoodsGridEx;
	  gridEx:UpdateDataSource(data_soure,function ()
       if firstData ~= nil then
          gridEx:SetViewSelectedByKey(firstData.mGoodsUID,true);
       end
    end);

    self:UpdateGoodsNumText();
end

function BagView:UpdateGoodsNumText()
    local bagModel = mGameModelManager.BagModel;
    local data_soure = bagModel:GetGoodsListWithType( self:GetGoodsTypeByIndex() );
    local validGoodsNum = bagModel:GetValidGoodsNum(data_soure);
    self.mTotalGoodsNum.text = tostring(validGoodsNum) .. "/" .. bagModel.mMaxGoodsNum;
end

function BagView:OnClickGoodsItem(data)
    self.mSelectData = data;
	  self:SetGoodsInfo(data);
end

function BagView:SetGoodsInfo(data)
	  self.mSelectGoodsData = data;
	  local configData = data.mSysVO;
    self.mUseGray:SetGray(configData.use == 0);
    self.mGoodsName.text = configData.goods_name;
    self.mGoodsPrice.text = configData.sell_price;
    self.mSelectGoods:ExternalUpdate(data);
    self.mGameObjectUtil:SetImageSprite(self.mSellIcon,mGameModelManager.BagModel:GetSellIconByType( configData.currency ) );
  	self.mUseDescStr.text = configData.desc;
end

function BagView:GetValue(id, value)
  local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
  
  if attri_vo.rate == 0 then
    value = Mathf.Round(value);
  else
    value = value * 100;
    value = Mathf.Round(value);
    value = value..'%';
  end

  return value;
end

function BagView:OnClickTypeButton(op_type)
	self.mSelectIndex = op_type;
  self:SetBatchBtnState(false);
  self:ShowGoodsList();
end

function BagView:OnClickUseButton()
	local goodsData = self.mSelectGoodsData
	if(goodsData ~= nil) then
	--根据道具类型使用，装备或者打开
      local useType = goodsData.mSysVO.use;
      if useType == 0 then
         mCommonTipsView.Show(mNoUseTips);
      else
         mBagController:GoodsUse(useType,goodsData.mGoodsUID);
      end
	end
end

function BagView:OnClickSellButton()
	local goodsData = self.mSelectGoodsData
	if(goodsData ~= nil) then
        if goodsData.mSysVO.sell_price ~= 0 then
          --弹出出售界面
          if goodsData.mSysVO.stack == 1 then
              local CallBack = function()
                mBagController:SendSellGoods(goodsData.mSysVO.type,goodsData.mGoodsUID,1);
              end
              local data = {desc=mSellSingle,price=goodsData.mSysVO.sell_price,callback=CallBack};
              mBagSellSingleView.Show(data);
          else
              mBagController:OpenSellView(goodsData);
          end
        else
          mCommonTipsView.Show(mSellTips);
        end
	
	end
end

function BagView:OnClickGetButton()
	local goodsData = self.mSelectGoodsData
	if(goodsData ~= nil) then
        --弹出获取界面
        mBagController:OpenGetView(goodsData);
	end
end

function BagView:Dispose()
	local grid_ex = self.mGoodsGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
    self.mGoodsGridEx = nil;
	end
end

function BagView:OnViewHide()
  self.mToggleGroup.mSelectIndex = nil;

  self.mGoodsGridEx:RemoveLateUpdate();
end

return BagView;