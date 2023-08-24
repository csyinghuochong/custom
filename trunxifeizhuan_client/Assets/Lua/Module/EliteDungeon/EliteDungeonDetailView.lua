local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum";
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mLayoutController = require "Core/Layout/LayoutController"
local mEliteDungeonVO = require "Module/EliteDungeon/EliteDungeonVO"
local mSortTable = require "Common/SortTable"
local mEliteDungeonController = require "Module/EliteDungeon/EliteDungeonController"
local mConfigSysdungeon_chapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local EliteDungeonDetailView = mLuaClass("EliteDungeonDetailView", mBaseView);
local mSuper = nil;

local SCROLL_HEIGHT = 475;
local ITEM_HEIGHT = 110;
local SPACE = 10;
local WINDOW_WIDTH = 352;
local AWARD_POS_TO_RIGHT = 38;

function EliteDungeonDetailView:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function EliteDungeonDetailView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGrid = mLayoutController.LuaNew(parent, require "Module/EliteDungeon/EliteDungeonDetailItemView");
	self.mTransGrid = parent;
	self:FindAndAddClickListener("BtnAward",function() self:OnClickAward() end);

    self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_ARRAY, function(data)
		self:OnShowArrayWindow(data);
	end, false);
	self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_DETAIL, function(data)
		self:OnSetWindowState(true);
	end, false);

	self.mSetArrayBack = function (  )
		self:OnSetArrayBack();
	end
end

function EliteDungeonDetailView:OnClickAward()
	local model = mGameModelManager.EliteDungeonModel;
	model.mIsOpenAwardWindow = true;
	local awards = mConfigSysdungeon_chapter[model.mSelectBuildID].award_show;
	local x = WINDOW_WIDTH/2 + AWARD_POS_TO_RIGHT - mUIManager:GetDeviceWidth()/2;
	local data = {goods=awards;posX=x};
	mUIManager:HandleUI(mViewEnum.CommonAwardShowView,1, data);
end

function EliteDungeonDetailView:OnClickClose(isCancelEffect)
	if not isCancelEffect then
		self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_CLOSE_DETAIL);
	end
	self:OnSetWindowState(false);
end

function EliteDungeonDetailView:OnShowArrayWindow(data)
	local dataVO = mBattleArrayViewVO.LuaNew();
	dataVO:InitPVETeam(data.mID, self.mSetArrayBack,3,5);
	mUIManager:HandleUIWithParent(mMainLayer1,mViewEnum.EliteDungeonArrayView,1, dataVO);
	self:OnSetWindowState(false);
	local model = mGameModelManager.EliteDungeonModel;
	model.mSelectDungeonID = data.mID;
end

function EliteDungeonDetailView:OnSetArrayBack()
	local model = mGameModelManager.EliteDungeonModel;
	mEliteDungeonController:FightEliteDungeon(model.mSelectDungeonID);
	self:OnSetWindowState(true);
end

function EliteDungeonDetailView:OnSetWindowState(state)
	self.mTransform.parent.gameObject:SetActive(state);
end

function EliteDungeonDetailView:OnSetInfo(logicParams)
    self:OnSetWindowState(true);
    self.mData = logicParams;
    local config = logicParams.mConfig;
    local startID = tonumber(config.start_id);
    local endID = tonumber(config.start_id + config.dungeon_count - 1);
    local data_soure = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true)
    for i = startID,endID do
    	local data = mEliteDungeonVO.LuaNew(i);
    	data_soure:AddOrUpdate(i,data);
	end
	self.mDataSoure = data_soure;
	self.mGrid:UpdateDataSource(data_soure);
	self:OnRollScroll();
end

function EliteDungeonDetailView:OnRollScroll()
	local data_soure = self.mDataSoure;
	local index = 0;
	local num = 0;
	local nowDungeonID = mGameModelManager.EliteDungeonModel.mNowDungeonID;
	if data_soure ~= nil then
		local sortTable = data_soure.mSortTable;
		for k,v in ipairs(sortTable) do
			if v.mID == nowDungeonID then
				index = v.mConfig.index;
			end
			num = num + 1;
		end
	end
	local posY;
	if index == 0 then
		posY = num * ITEM_HEIGHT - SCROLL_HEIGHT;
	else
		posY = index * ITEM_HEIGHT - SCROLL_HEIGHT;
	end
	if posY > 0 then
		self.mTransGrid.anchoredPosition = Vector2(0,posY - SPACE);
	else
		self.mTransGrid.anchoredPosition = Vector2.zero;
	end
end

function EliteDungeonDetailView:Sort(a,b)
	return a.mConfig.prev_dungeon < b.mConfig.prev_dungeon;
end

return EliteDungeonDetailView;