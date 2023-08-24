local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mLayoutController = require "Core/Layout/LayoutController"
local mCampDungeonBossVO = require "Module/CampDungeon/CampDungeonBossVO"
local mCampDungeonBossLevelVO = require "Module/CampDungeon/CampDungeonBossLevelVO"
local mGameModelManager = require "Manager/GameModelManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mCampDungeonController = require "Module/CampDungeon/CampDungeonController"
local mConfigMonster = require "ConfigFiles/ConfigSysmonster"
local mSortTable = require "Common/SortTable"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mViewEnum = require "Enum/ViewEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local CampDungeonView = mLuaClass("CampDungeonView", mQueueWindow);

function CampDungeonView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_view",
		["ParentLayer"] = mMainLayer,
		["full_cost"] = {"gold","silver","strength"},
	};
end

function CampDungeonView:Init()
	self.mIsTimeOutRefresh = true;
    self:FindAndAddClickListener("Top/Btn_close",function() self:ReturnPrevQueueWindow() end);
    self:FindAndAddClickListener("BtnGonglue",function() self:OnClickGonglue() end);
   
    self.mBossGridEx = mLayoutController.LuaNew(self:Find("bossScrollView/Grid"), require "Module/CampDungeon/CampDungeonBossItemView");
    self.mBossGridEx:SetSelectedViewTop(true);
    self.mLevelGridEx = mLayoutController.LuaNew(self:Find("levelScrollView/Grid"), require "Module/CampDungeon/CampDungeonBossLevelItemView");

    self:RegisterEventListener(mEventEnum.ON_SELECT_CAMPBOSS_ITEM, function(data)
		self:OnSelectBoss(data);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_GET_CAMPDUNGEON_DATA, function(data)
		self:InitData(data);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_OPEN_CAMP_FORMATION, function(data)
		self:OnOpenFormation(data);
	end, true);
	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW, function()
		self:OnShowTop(true);
	end, true);
	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW, function()
		self:OnShowTop(false);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_CAMP_DUNGEON_PASS_LEVEL,function()
		local campDungeonModel = mGameModelManager.CampDungeonModel;
		local selectData = campDungeonModel:GetSelectCamp(mCampDungeonController.mCampID);
		if selectData ~= nil then
			self:ShowBossInfo(selectData,false);
    	end
	end,false);

	self.mGoTop = self:Find("Top").gameObject;
end

function CampDungeonView:OnShowTop(state)
	self.mGoTop:SetActive(state);
end

function CampDungeonView:OnClickGonglue()
	local model = mGameModelManager.CampDungeonModel;
	local ID = model:GetMaxDungeonID(self.mBossID);
	local data = {id = ID};
	mUIManager:HandleUI(mViewEnum.CampDungeonMessageView,1, data);
end

function CampDungeonView:OnOpenFormation(data)
	local callBack = function()
		mCampDungeonController:SendChallengeCampDungeon(data.mSysVO.chapter_id,data.mID)
	end
	local Data = mBattleArrayViewVO.LuaNew();
	local levelConfig = data.mSysVO;
	Data:InitPVETeam(data.mID, callBack);
	mUIManager:HandleUIWithParent(mMainLayer1,mViewEnum.BattleArrayView,1, Data);
end

function CampDungeonView:OnViewShow(logicParams)
	self.mLoginParams = logicParams;
    local campDungeonModel = mGameModelManager.CampDungeonModel;
    local data_soure = campDungeonModel.mCampList;
    if data_soure ~= nil then
       self:InitData(data_soure);
    else
       mCampDungeonController:SendGetCampDungeonList();
    end
end

function CampDungeonView:InitData(data_soure)
	local campDungeonModel = mGameModelManager.CampDungeonModel;
	local bossGridEx = self.mBossGridEx;
	bossGridEx:ToggleAllView(true);
	local logicParams = self.mLoginParams;
	if logicParams ~= nil and logicParams.openLevel ~= nil then
       self.mOpenLevel = logicParams.openLevel;
	end
	local selectData = nil
    bossGridEx:UpdateDataSource(data_soure,function ()
        if logicParams ~= nil and logicParams.jumpParams ~= nil then
           selectData = campDungeonModel:GetSelectCamp(tonumber(logicParams.jumpParams));
        end
        if selectData == nil then
           selectData = campDungeonModel:GetSelectCamp(mCampDungeonController.mCampID);
        end
    	if selectData ~= nil then
    	   bossGridEx:SetViewSelectedByKey(selectData.mID,true)
    	end
    end);
end

function CampDungeonView:OnSelectBoss(data)
    self:ShowBossInfo(data,true);
end

function CampDungeonView:ShowBossInfo(data,isRefreshList)
	local id = data.mID;
	self.mBossID = id;
	local selectData = data.mSelectLevel;
	local openLevel = self.mOpenLevel
	if openLevel ~= nil then
       selectData = openLevel;
	end
	local level_data = data.mDungeonList;
    local levelIndex = selectData.mSysVO.index - 3 > 0 and selectData.mSysVO.index - 3 or 0;
    local gridEx = self.mLevelGridEx;
    if isRefreshList then
    	gridEx:UpdateDataSource(level_data,function ()
			if selectData ~= nil then
			   self.mOpenLevel = nil;
			end
		end);
    end
    if self.mIsTimeOutRefresh then
    	self.mIsTimeOutRefresh = false;
    	mGameTimer.SetTimeout(0.5,function()gridEx:MoveToItemBySize(-104*levelIndex,false);end);
    else
	    gridEx:MoveToItemBySize(-104*levelIndex,false);
	end
end

function CampDungeonView:Dispose()
	local grid_ex1 = self.mBossGridEx;
	if grid_ex1 ~= nil then
		grid_ex1:Dispose();
		self.mBossGridEx = nil;
	end
	local grid_ex2 = self.mLevelGridEx;
	if grid_ex2 ~= nil then
		grid_ex2:Dispose();
		self.mLevelGridEx = nil;
	end
end

function CampDungeonView:OnViewHide(logicParams)
	self.mBossGridEx:ToggleAllView(false);
end

return CampDungeonView;