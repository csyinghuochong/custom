local mLuaClass = require "Core/LuaClass"
local mMainCostView = require "Module/MainInterface/MainCostView"
local mGameModelManager = require "Manager/GameModelManager"
local GameTimer = require "Core/Timer/GameTimer"
local MainFullCostView = mLuaClass("MainFullCostView",mMainCostView);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mVetor3 = Vector3;

function MainFullCostView:InitViewParam()
	return {
		["viewPath"] = "ui/main_interface/",
		["viewName"] = "main_cost_full_view",
	};
end

function MainFullCostView:OnInit()
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.SET_FULL_COST_VIEW_VISIBLE, function(value) self:SetVisible(value) end,false);
end

function MainFullCostView:SetVisible(status)
	self.mGameObject:SetActive(status == 0);
end

function MainFullCostView:SetPosition(costParams)
	local pos = self.mTransform.localPosition;
	pos.x = mUIManager:GetDeviceWidth() / 2 - 65;
	pos.y = mUIManager:GetDeviceHeight() /2 - 30;
	self.mTransform.localPosition = pos;
end

function MainFullCostView:OnClickAdd()
	mUIManager:HandleUIWithParent(mMainLayer1,mViewEnum.StoreView,1);
end

return MainFullCostView;
