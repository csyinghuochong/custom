local mCommonGoodsItem = require "Module/CommonUI/CommonGoodsItemView"
local mLuaClass = require "Core/LuaClass"
local mCommonPressButton = require "Module/CommonUI/CommonPressButton"
local mCommonGoodsDetial = require "Module/CommonUI/CommonGoodsDetialView"
local mGameTimer = require "Core/Timer/GameTimer"
local mBagController = require "Module/Bag/BagController"
local mUIGray = require "Utils/UIGray"
local CommonGoodsUseItemView = mLuaClass("CommonGoodsUseItemView", mCommonGoodsItem);
local mSuper = nil;

function CommonGoodsUseItemView:Init( )
    self.mIconGray = mUIGray.LuaNew():InitGoGraphic(self:Find('icon').gameObject);
    self.mBgGray = mUIGray.LuaNew():InitGoGraphic(self:Find('bg').gameObject);
    self.mKuangGray = mUIGray.LuaNew():InitGoGraphic(self:Find('kuang').gameObject);

	local minusBtn = self:Find('minusBtn');
	if minusBtn ~= nil then
		self.mMinusBtn = minusBtn.gameObject;
		self.mMinusImage = self:Find('minus').gameObject;
		self:FindAndAddClickListener("minusBtn",function() self:OnClickMinus(); end);
	end

	mSuper = self:GetSuper(mCommonGoodsItem.LuaClassName);
	mSuper.Init(self);
end

--外部调用
function CommonGoodsUseItemView:ExternalUpdate(data)
    mSuper.ExternalUpdate(self,data);
    if data == nil then
		return;
	end
    local callBack = function (flag)
       self:OnPressBack(flag);
    end
    local minusBack = function (minusFlag)
       self:OnPressMinusBack(minusFlag)
    end
    self.mSelectNum = 0;
    self.mMinusBtn:SetActive(false);
    self.mMinusImage:SetActive(false);
    self.mPressBtn = mCommonPressButton.LuaNew(self.mIconBtn.gameObject,1,callBack);
    --mCommonPressButton.LuaNew(self.mMinusBtn,1,minusBack);
    self:ShowGoodsSelectNumber(self.mSelectNum,data.mNumber);
    self.mIconGray:SetGray(data.mNumber == 0);
    self.mBgGray:SetGray(data.mNumber == 0);
    self.mKuangGray:SetGray(data.mNumber == 0);
end

function CommonGoodsUseItemView:OnClickIcon()
	local data = self.mData;
	if data.mNumber > 0 then
        self:AddSelect(1);
	else
        --mBagController:OpenGetView(data);
	end
end

function CommonGoodsUseItemView:AddSelect(count)
	local data = self.mData;
	local selectNum = self.mSelectNum;
    selectNum = selectNum + count > data.mNumber and data.mNumber or selectNum + count;
    selectNum = selectNum < 0 and 0 or selectNum;
    self.mMinusBtn:SetActive(selectNum > 0);
    self.mMinusImage:SetActive(selectNum > 0);
    self:ShowGoodsSelectNumber(selectNum,data.mNumber);
    self.mSelectNum = selectNum;
end

function CommonGoodsUseItemView:OnPressBack(flag)
	if flag then
       if self.mData.mNumber > 0 then
          self:AddSelect(self.mData.mChangeCount);
       else
          self:ShowDetial(self.mData.mID);
          self.mShow = flag;
       end
  else
       if self.mShow then
          mCommonGoodsDetial.hide();
          self.mShow = flag;
       end
	end
end

function CommonGoodsUseItemView:ShowDetial(id)
    local table = {mTransform = self.mIconBtn.transform,mConfigID = id,mType = 2};
    mCommonGoodsDetial.Show(table);
end

function CommonGoodsUseItemView:OnPressMinusBack(flag)
	if flag then
       self:AddSelect(-self.mData.mChangeCount);
	end
end

function CommonGoodsUseItemView:OnClickMinus()
	local data = self.mData;
	local selectNum = self.mSelectNum;
    selectNum = selectNum - 1 > 0 and selectNum - 1 or 0;
    self:ShowGoodsSelectNumber(selectNum,data.mNumber);
    self.mMinusBtn:SetActive(selectNum > 0);
    self.mMinusImage:SetActive(selectNum > 0);
    self.mSelectNum = selectNum;
end

function CommonGoodsUseItemView:ShowGoodsNumber( number )

end

function CommonGoodsUseItemView:ShowGoodsSelectNumber(number1,number2)
	local textNumber = self.mTextNumber;
	if textNumber ~= nil then
		textNumber.text = number1.."/"..number2;
	end
    self.mPressBtn.mDelay = number2 == 0 and 0.2 or 1;
	local call_back = self.mData.mSelectBack;
	call_back(number1);
end

return CommonGoodsUseItemView;