local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local ViewEnum = Assets.Scripts.Com.Game.Enum.ViewEnum;
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local ActivityItemView = mLuaClass("ActivityItemView",mLayoutItem);
local ItemRewardInfo = Assets.Scripts.Com.Game.Module.Reward.ItemRewardInfo;
local mSuper = nil;

function ActivityItemView:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/ActivityItemView",
		["viewName"] = "ActivityItemView",
	};
end

function ActivityItemView:Init( )
	self.mTitle = self:FindComponent("Title", 'UILabel');
	self.mGetObj = self:FindChild("Get");
   	local btn_get = self:FindComponent("Button_Get", 'UIButton');
    CSharpInterface.GameUIEventListenerGet(btn_get.gameObject,function ()
		local data = self.mData;
		local callBack = data.mCallBack;
		if callBack ~= nil then
			callBack(data.mID);
		end
	end,SysSoundConst.S_UI_OKBUTTON_BGM);
	self.mButtonGet = btn_get;

    local goods_list = {};
    for i = 1, 5 do
    	local path = string.format('Item%d', i);
    	local item = mCommonGoodsItem.New();
    	item:InjectGameObject(self:FindChild(path));
    	goods_list[i] = item;
    end
    self.mGoodsList = goods_list;

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ActivityItemView:OnClickGetButton()
	local data = self.mData;
	local callBack = data.mCallBack;
	if callBack ~= nil then
		callBack(data.mID);
	end
end

function ActivityItemView:ItemOperateBack( )
	self.mGetObj:SetActive(true);
	self.mButtonGet.gameObject:SetActive(false);

    local list = self.mData:GetGoodsList();
	local info = ItemRewardInfo.New();
	for k, v in pairs(list) do
		info:AddGoodsVO(v);
	end
	UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
end

function ActivityItemView:OnViewShow( )
	
end

function ActivityItemView:OnUpdateData()
	local data = self.mData;
	
	local goods_vo = data:GetGoodsList();
	local goods_list = self.mGoodsList;
	for i = 1, 5 do
		local item = goods_list[i];
		if goods_vo[i] ~= nil then
			item:ShowView();
			item:SetData(goods_vo[i]);
		else
			item:HideView();
		end
	end

	local data_vo = data.mVO;
	local is_get = data_vo:IsGet();
	self.mGetObj:SetActive(is_get);
	local btn_get = self.mButtonGet;
	btn_get.gameObject:SetActive(not is_get);
	btn_get.isEnabled = data_vo:CanGet();
	self.mTitle.text = data:GetTextTitle();
end

return ActivityItemView;