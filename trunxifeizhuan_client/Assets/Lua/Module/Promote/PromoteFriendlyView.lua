local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc";
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mPromoteController = require "Module/Promote/PromoteController"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mConfigSyspromote_friendly = require "ConfigFiles/ConfigSyspromote_friendly"
local PromoteFriendlyView = mLuaClass("PromoteFriendlyView",mQueueWindow);

function PromoteFriendlyView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_friendly_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function PromoteFriendlyView:Init()
	self:InitSubView(  );
	self:AddListeners( );
end

function PromoteFriendlyView:InitSubView()
	local goods_list = {};
	for i = 1, 3 do
		goods_list[i] = mCommonGoodsItemView.LuaNew(self:Find('goods_item'..i).gameObject);
	end
	self.mGoodsItemList = goods_list;

	self:FindAndAddClickListener("button_ok", function() self:OnClickFriendly() end);
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);
	self.mTextNpcName  = self:FindComponent('Text_1', 'Text');
	self.mTextFriendlyRate = self:FindComponent('Text_4', 'Text');
	self.mPromoteExamNpcView = ModelRenderTexture.LuaNew(self:Find('model'));
	self.mPromoteExamNpcView:OnUpdateUI('r_200111' );
end

function PromoteFriendlyView:AddListeners()
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_FRIENDLY_INIT, function(pbNpcFreind)
		self:OnRecvFriendlyInit(pbNpcFreind);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FRIENDLY_RESULT, function(result)
		self:OnRecvFriendlyResult(result);
	end, true);
end

function PromoteFriendlyView:ShowCostGoods(  )
	local cost = mConfigSyspromote_friendly[self.mNpcID].cost;
	local goods_list = self.mGoodsItemList;
	for k, v in pairs(goods_list) do
		local vo = cost[k];
		if vo ~= nil then
			v:ShowView();
			v:ExternalUpdate(mCommonGoodsVO.LuaNew(vo.goods_id, vo.goods_number));
		else
			v:HideView();
		end
	end
	self.mTextNpcName.text = mConfigSysnpc[self.mNpcID].name;
end

function PromoteFriendlyView:OnRecvFriendlyInit(pbNpcFreind)
	self.mTextFriendlyRate.text = pbNpcFreind.friend_percent.."%";
end

function PromoteFriendlyView:OnRecvFriendlyResult(result)
	if result == 2 then
		self:ReturnPrevQueueWindow();
	end
end

function PromoteFriendlyView:OnClickFriendly()
	mPromoteController:SendNpcFriendly(self.mNpcID);
end

function PromoteFriendlyView:OnViewShow(logicParams)
	self.mNpcID = logicParams;

	self:ShowCostGoods(  );
	self.mPromoteExamNpcView:ShowView();
	mPromoteController:SendOpenFriendlyView(logicParams);
end

function PromoteFriendlyView:OnViewHide()
	self.mPromoteExamNpcView:HideView();
end

return PromoteFriendlyView;