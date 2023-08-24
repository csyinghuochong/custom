local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mUIGray = require "Utils/UIGray"
local mLanguageUtil = require "Utils/LanguageUtil"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mGameModelManager = require "Manager/GameModelManager"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local ItemPathView = mLuaClass("ItemPathView", mLayoutItem);
local mSuper = nil;

function ItemPathView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "item_path_view",
	};
end

function ItemPathView:Init()
	self.mTextNumber = self:FindComponent('name', 'Text');
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self.mGameObject);
	self.mGoBlack = self:Find("black").gameObject;
    local callBack = function() self:OnClickPtahItem() end;
    self:AddBtnClickListener(self.mGameObject, callBack);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ItemPathView:OnClickPtahItem()
    --print('点击获取物品路径');
    if self.mOpen then
	   self:Dispatch(mEventEnum.ON_GET_GOODS_PATH,self.mData);
	else
       mCommonTipsView.Show(mFunctionOpenManager:GetFunctionOpenLevelStr(self.mData.id));
	end
end

function ItemPathView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function ItemPathView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	self.mData = data;
	self.mTextNumber.text = data.mSysVO.path_name;
	self.mOpen = mFunctionOpenManager:IsFunctionOpen(data.mSysVO.open_condition);
	self.mUIGray:SetGray(not self.mOpen);
	self.mGoBlack:SetActive(not self.mOpen);
end

return ItemPathView;