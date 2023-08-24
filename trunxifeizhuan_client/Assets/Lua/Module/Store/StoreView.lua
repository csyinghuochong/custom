local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mConfigSysshops = require "ConfigFiles/ConfigSysshops"
local StoreView = mLuaClass("StoreView", mQueueWindow);

function StoreView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["cost"] = {"silver","gold","strength"},
	};
end

function StoreView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	self:InitSubView();
end

function StoreView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Store/StoreGoodsView",cost={"silver","gold","strength"}},
		{luaClass="Module/Store/StoreDiamondView",cost={"silver","gold","strength"}},
		{luaClass="Module/Store/StorePackageView",cost={"silver","gold","strength"}},	
	}

	self.mViewList = view_vo_list;
	self.mTabView = mCommonTabView.LuaNew(self:Find('tabView'), view_vo_list, function(index)self:ChangeFirstType(index);end, nil);
end

function StoreView:ChangeFirstType(index)
	local model = mGameModelManager.StoreModel;
	model.mFirstType = index;
	self:HandleWindowCostUI(1,self.mViewList[index]);
end

function StoreView:OnViewShow(param)
	if param ~= nil then
		if param.jumpParams ~= nil then
			local shopItem = mConfigSysshops[param.jumpParams];
			local data;
			if shopItem ~= nil then
				data = {first = shopItem.first_type,second = shopItem.second_type};
			else
				data = {first = 1,second = 1};
			end
			self:OnGoto(data);
		else
			self:OnGoto(param);
		end
	end
end

function StoreView:OnGoto(data)
	self.mTabView:OnClickToggleButton(data.first or 1, true);
	if data.first == 1 then
		local model = mGameModelManager.StoreModel;
		model.mStoreVoList[1].mSecondType = data.second;
		self:Dispatch(self.mEventEnum.ON_CHANGE_STORE_PAGE,data.second);
	end
end

function StoreView:Dispose()
	self.mTabView:CloseView();
end

return StoreView;