local mLuaClass = require "Core/LuaClass";
local mQueueWindow = require "Core/QueueWindow";
local mGmController = require "Module/Gm/GmController";
local mUIManager = require "Manager/UIManager";
local mGameModelManger = require "Manager/GameModelManager";
local mLayoutController = require "Core/Layout/LayoutController";
local mViewBgEnum = require "Enum/ViewBgEnum";
local mStoryManager = require "Module/Story/StoryManager";
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup";
local mHrl = require "Module/Gm/GmHrl";

local GmView = mLuaClass("GmView", mQueueWindow);

function GmView:InitViewParam()
	return {
		["viewPath"] = "ui/gm/"
		,["viewName"] = "gm_view"
		,["ParentLayer"] = mMainLayer
		,["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function GmView:Init()
	-- 初始化变量
	self.mType = mHrl.mType1;
	local ParentContentGroup = self:Find("ContentGroup/Viewport/Content");
	local ButtonView = self:Find('TabView/ButtonView');

	-- 初始化其他
	self.mGridGmItem = mLayoutController.LuaNew(ParentContentGroup, require "Module/Gm/GmItemView");
	self.mGridGmItem:SetSelectedViewTop(true);
	self.mToggleGroup = mCommonToggleGroup.LuaNew(ButtonView, function(type) self:OnClickButton(type); end, 1);

	self:RegisterEventListener(self.mEventEnum.ON_GM_GET_LIST, function(data) self:OnViewShow(data); end, true);

	self:FindAndAddClickListener("BackGroup/ButtonClose", function() self:ClickClose(); end );

end

function GmView:OnClickButton(type)
	self.mType = type;
	self.mGridGmItem:Reset();
	self:ShowGmItem(type);
end

function GmView:ShowGmItem(type)
	local dataSource = mGameModelManger.GmModel.mCmdTypeList;
	self.mGridGmItem:UpdateDataSource(dataSource[type]);
end

function GmView:ClickClose()
	self:ReturnPrevQueueWindow();
end

function GmView:OnViewShow(data)
	local dataSource = mGameModelManger.GmModel.mCmdTypeList;
	if #dataSource == 0 then
		mGmController:getServerGmList();
		-- mStoryManager:OnPlayStory(2016); -- 这里播放个剧情玩玩。
		return;
	end
	self.mGridGmItem:UpdateDataSource(dataSource[self.mType]);
end

function GmView:Dispose()
	local GridGmItem = self.mGridGmItem;
	if GridGmItem ~= nil then
		GridGmItem:Dispose();
		self.mGridGmItem = nil;
	end
end

return GmView;