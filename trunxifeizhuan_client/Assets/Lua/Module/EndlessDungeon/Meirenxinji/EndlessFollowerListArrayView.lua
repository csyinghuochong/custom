local mLuaClass = require "Core/LuaClass"
local mFollowerListArrayView = require "Module/Follower/FollowerListArrayView"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mEventEnum = require "Enum/EventEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local EndlessFollowerListArrayView = mLuaClass("EndlessFollowerListArrayView", mFollowerListArrayView);

function EndlessFollowerListArrayView:InitViewParam()
    return {
        ["viewPath"] = "ui/follower/",
        ["viewName"] = "follower_list_array_view",
        ["ParentLayer"] = mMainLayer2,
        ["viewBgEnum"] = mViewBgEnum.transparent,
    };
end

function EndlessFollowerListArrayView:Init()
	local parent = self:Find('scrollView/Grid');
	local gridEx = mLayoutController.LuaNew(parent, require "Module/EndlessDungeon/Meirenxinji/EndlessFollowerListArrayItemView");
	self.mGridEx = gridEx;
    local grid = self:FindComponent("scrollView/Grid","GridLayoutGroup");
    grid.cellSize = Vector2.New(80,90);

	local trans = self:Find("sortView");
	self.mSortView = trans.gameObject;
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);
    self.mToggleGroup:SetCanAlwaysReturn( );

    self.mButtonText = self:FindComponent( 'Button_sort/Text', 'Text' )
    self.mSelectText = self:FindComponent('SelectText','Text');

    self:FindAndAddClickListener("Button_sort", function() self:OnClickSortBtn() end);
    self:FindAndAddClickListener("BG/Button_close",function() self:ReturnPrevQueueWindow(); self:DoCallBack();end);
    self:RegisterEventListener(mEventEnum.ON_REFRESH_FOLLOWER_SELECT, function(followerData) self:SelectFollowerBack(followerData) end, true);
end

return EndlessFollowerListArrayView;