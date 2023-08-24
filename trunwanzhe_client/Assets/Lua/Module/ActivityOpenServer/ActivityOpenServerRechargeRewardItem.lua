local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local mSpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local mActivityOpenServerController = require "Module/ActivityOpenServer/ActivityOpenServerController"
local ActivityOpenServerRechargeRewardItem = mLuaClass("ActivityOpenServerRechargeRewardItem",mLayoutItem);
local mSuper = nil;
local mVector3 = Vector3;
local mMath = require "math"

function ActivityOpenServerRechargeRewardItem:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/ActivityOpenServerRechargeRewardItem",
		["viewName"] = "ActivityOpenServerRechargeRewardItem",
	};
end

function ActivityOpenServerRechargeRewardItem:Init( )
	self.mTextDesc = self:FindComponent('txt_1', 'UILabel');
	self.mTextDesc2 = self:FindComponent('txt_2', 'UILabel');
	self.mTextDesc3 = self:FindComponent('txt_3', 'UILabel');
	local text_btn = self:FindComponent('get_reward/Label', 'UILabel');
	self.mTextButton = text_btn;
	local btn_get = mSpecialButton.New(self:FindComponent('get_reward', 'UISprite'), text_btn);
	self.mButtonGet = btn_get;
	CSharpInterface.GameUIEventListenerGet(btn_get.gameObject,function ()
		self:OnClickGetButton();
	end,SysSoundConst.S_UI_OKBUTTON_BGM);
	self.mButtonGet = btn_get;
   	
	local btn_recharge =  self:FindChild('recharge_btn');
	CSharpInterface.GameUIEventListenerGet(btn_recharge,function ()
		self:OnClickGetButton();
	end,SysSoundConst.S_UI_OKBUTTON_BGM);
	self.mButtonRecharge = btn_recharge;

    local goods_list = {};
    for i = 1, 4 do
    	local path = string.format('item_%d', i - 1);
    	local item = mCommonGoodsItem.New();
    	item:InjectGameObject(self:FindChild(path));
    	goods_list[i] = item;
    end
    self.mItemList = goods_list;

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ActivityOpenServerRechargeRewardItem:OnClickGetButton()
	local data = self.mData;
	if data.mNeedRecharge then
        UIManager:OpenUIFromLua("VipView");
    elseif data.mCanGetReward then
        data:GetReward();
    end
end

function ActivityOpenServerRechargeRewardItem:UpdateButton( )
	local data = self.mData;
	local need_recharge = data.mNeedRecharge;
	self.mButtonRecharge:SetActive(need_recharge);
	local btn_get = self.mButtonGet;
	btn_get:SetActive(not need_recharge);
	btn_get.isEnabled = not data.mReceiveReward;
    self.mTextButton.text = data.mTextButton;
end

function ActivityOpenServerRechargeRewardItem:OnViewShow( )
	
end

function ActivityOpenServerRechargeRewardItem:OnUpdateData()
	local data = self.mData;
	local text_desc = self.mTextDesc;
	local text_desc2 = self.mTextDesc2;
	text_desc.text = data.mTextDesc;
    text_desc2.text = data.mSysVO.charge;

    local pos = text_desc2.transform.localPosition;
    text_desc.transform.localPosition = mVector3.New(pos.x - mMath.ceil(text_desc2.width / 2), 20, 0);
    self.mTextDesc3.transform.localPosition = mVector3.New(pos.x + mMath.ceil(text_desc2.width / 2), 20, 0);

    local vo_list = data:GetGoodsList();
    local goods_list = self.mItemList;
    for i = 1, 4 do
    	local item = goods_list[i];
    	if vo_list[i] ~= nil then
    		item:ShowView();
    		item:SetData(vo_list[i]);
    	else
			item:HideView();
    	end
    end

    self:UpdateButton();
end

return ActivityOpenServerRechargeRewardItem;