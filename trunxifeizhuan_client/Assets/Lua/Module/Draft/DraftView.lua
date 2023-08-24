local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mDraftController = require "Module/Draft/DraftController"
local mDraftChipConfig = require "ConfigFiles/ConfigSysdraft_chip"
local mTimeUtil = require "Utils/TimeUtil"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mUIGray = require "Utils/UIGray"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local DraftView = mLuaClass("DraftView", mQueueWindow);

function DraftView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "draft_view",
		["ParentLayer"] = mMainLayer,
    ["full_cost"] = {"gold","silver"},
    ["ChangeSceneDispose"] = true,
	};
end

function DraftView:Init()
	  self:FindAndAddClickListener("return",function() self:ReturnPrevQueueWindow(); end);
    self:FindAndAddClickListener("Window/Guide_Draft_Button",function() self:OnDraftBtn(); end,nil,0.5);
    self.mBtnGray = mUIGray.LuaNew():InitGoGraphic(self:Find('Window/Guide_Draft_Button').gameObject);
    self.mDraftGridEx = mLayoutController.LuaNew(self:Find("Window/DraftScrollView/Grid"), require "Module/Draft/DraftItemView");
    self.mDraftGridEx:SetSelectedViewTop(true);
    local specialParent = self:Find("specialList/followerGrid");
    self.mSpecialDraftGridEx = mLayoutController.LuaNew(specialParent, require "Module/Draft/DraftSpecialItemItemView");
    local chipParent = self:Find("chipList/scrollView/followerGrid");
    self.mChipGridEx = mLayoutController.LuaNew(chipParent, require "Module/Draft/DraftChipItemView");
    self.mDraftCost = self:FindComponent("Window/cost/num","Text");
    self.mIcon = self:FindComponent("Window/cost/icon", 'Image');
    self.mCost = self:Find('Window/cost').gameObject;
    self.mSpecialList = self:Find('specialList').gameObject;
    self.mChipList = self:Find('chipList').gameObject;
    self.mTimeStr = self:FindComponent('specialList/time','Text');
    self:FindAndAddClickListener("specialList/detial",function() self:OnDetailBtn(); end);
    self:FindAndAddClickListener("BtnArchive",function() self:OnArchiveBtn(); end);
    self:RegisterEventListener(mEventEnum.ON_SELECT_DRAFT, function(data)
         self:OnSelect(data);
    end, true);
    self:RegisterEventListener(mEventEnum.ON_GET_SPECIAL_GROUP, function()
         self:ShowSpecialView();
    end, true);
    self:RegisterEventListener(mEventEnum.ON_DRAFT_REMOVE_ITEM, function()
         local selectData = mGameModelManager.DraftModel.mDraftList.mSortTable[1];
         if selectData ~= nil then
            self.mDraftGridEx:SetViewSelectedByKey(selectData.mChipId,true);
         end
    end, true);
    self:RegisterEventListener(mEventEnum.ON_DRAFT_SHOW_FOLLOWER, function(data)
         self:OnShowFollower(data);
    end, true);
    mGameModelManager.DraftModel.mBagUpdate = false;
    self.mGoWindow = self:Find("Window").gameObject;

    self:PreLoadAsset("ui/draft/","draft_success_view");
end

function DraftView:OnShowFollower(data)
    local archiveModel = mGameModelManager.ArchiveModel;
    archiveModel:SetNowIndex(data);
    mUIManager:HandleUI(mViewEnum.ArchiveShowView,1,data.mID);
end

function DraftView:OnViewShow(logicParams)
    local gridEx = self.mDraftGridEx;
    if self.mHaveInit ~= true then
		   self.mDraftGridEx:Reset();
		   local data_soure = mGameModelManager.DraftModel.mDraftList;
		   
		   gridEx:UpdateDataSource(data_soure,function ()
		      self.mHaveInit = true;
		      local selectData = data_soure.mSortTable[1];
		      if selectData ~= nil then
		         gridEx:SetViewSelectedByKey(selectData.mChipId,true);
		      end
		    end);
    end
    if mGameModelManager.DraftModel.mBagUpdate then
       gridEx:NotifyItemsUpdate();
       mGameModelManager.DraftModel.mBagUpdate = false;
    end
end

function DraftView:OnSelect(data)
    self:InitSelectData(data);
end

function DraftView:ShowSpecialView()
    self.mSpecialList:SetActive(true);
    if self.mSpecialInit then
       return;
    end
    local list = mGameModelManager.DraftModel.mSpecialDraftList[1];
    self.mSpecialDraftGridEx:UpdateDataSource(list);
    self.mRefreshTime = mGameModelManager.DraftModel.mRefreshTime;
    self:OnTimerInterval();
    local timerInterval = self.mTimerInterval;
    if timerInterval == nil then
       self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
    else
       timerInterval:ReStart();
    end 
    self.mSpecialInit = true;
end

function DraftView:ShowChipView()
    self.mChipList:SetActive(true);
    self.mChipGridEx:UpdateDataSource(mGameModelManager.BagModel:GetValidGoodsListWithType(5));
end

function DraftView:OnTimerInterval()
    local time = self.mRefreshTime - mGameModelManager.LoginModel:GetCurrentTime();
    if time > 60*60*24 then
       self.mTimeStr.text = mTimeUtil:TransToDayHour(time);
    else
       self.mTimeStr.text = mTimeUtil:TransToHourMinSec(time);
    end
    if time <= 0 and self.mTimerInterval ~= nil then
       local time_interval = self.mTimerInterval;
       if time_interval ~= nil then
          time_interval:Dispose();
          self.mTimerInterval = nil;
       end
    end
end

function DraftView:InitSelectData(draftData)
    if draftData.mType == 8 then
       --弹出特殊召唤界面
      if mGameModelManager.DraftModel.mSpecialDraftList == nil then
        mDraftController:SendGetDraftGroup();
      else
        self:ShowSpecialView();
      end
    else
      self.mSpecialList:SetActive(false);
    end
    
    if draftData.mType == 10 then
       self.mBtnGray:SetGray(true);
       self:ShowChipView();
    else
       self.mBtnGray:SetGray(false);
       self.mChipList:SetActive(false);
    end
    self.mSelectType = draftData.mType;
    local sysConfig = draftData.mSysVO;
    if sysConfig ~= nil then
       self.mSysConfig = sysConfig;
       if sysConfig.gold_cost > 0 then
          self.mCost:SetActive(true);
          self.mDraftCost.text = sysConfig.gold_cost;
          self.mGameObjectUtil:SetImageSprite(self.mIcon,"common_city_icon_3");
       elseif sysConfig.coin_cost > 0 then
          self.mCost:SetActive(true);
          self.mDraftCost.text = sysConfig.coin_cost;
          self.mGameObjectUtil:SetImageSprite(self.mIcon,"common_city_icon_2");
       else
          self.mCost:SetActive(false);
       end
    else
        self.mChipId = draftData.mChipId;
      	self.mCost:SetActive(true);
      	self.mGameObjectUtil:SetImageSprite(self.mIcon,"common_city_icon_2");
      	self.mDraftCost.text = mDraftChipConfig[draftData.mChipId].coin_cost;
    end
end

function DraftView:OnDraftBtn()
  local playBase = mGameModelManager.RoleModel.mPlayerBase;
	if self.mSelectType ~= 0 then
	    if self.mSelectType ~= 10 then
         local sysConfig = self.mSysConfig;
         if sysConfig.coin_cost > playBase.coin then
            mCommonTipsView.Show(mLanguageUtil.common_silver_no_enough);
            return;
         end
         if sysConfig.gold_cost > playBase.gold then
            mCommonTipsView.Show(mLanguageUtil.common_gold_no_enough);
            return;
         end  
         if not mGameModelManager.BagModel:CheckGoodsIsEnough(sysConfig.goods_cost) then
            mCommonTipsView.Show(mLanguageUtil.common_goods_no_enough);
            return;
         end    
	       mDraftController:SendDraft(self.mSelectType);
	    end
	else
      local chipId = self.mChipId;
      local coinCost = mDraftChipConfig[chipId].coin_cost;
      if coinCost > playBase.coin then
         mCommonTipsView.Show(mLanguageUtil.common_silver_no_enough);
         return;
      end
    	mDraftController:SendChipDrfat(chipId);
	end
end

function DraftView:OnDetailBtn()
   mDraftController:OpenSpecialListView();
end

function DraftView:OnArchiveBtn()
  self.mGoWindow:SetActive(false);
  local callBack = function()
    self.mGoWindow:SetActive(true);
  end
  mUIManager:HandleUI(mViewEnum.ArchiveView,1,callBack);
end

function DraftView:OnViewHide(logicParams)
  local time_interval = self.mTimerInterval;
  if(time_interval ~= nil) then 
       time_interval:Stop();
  end
end

function DraftView:Dispose()
	local grid_ex1 = self.mDraftGridEx;
	if grid_ex1 ~= nil then
		grid_ex1:Dispose();
	end
  local grid_ex2 = self.mSpecialDraftGridEx;
  if grid_ex2 ~= nil then
    grid_ex2:Dispose();
  end
  local grid_ex3 = self.mChipGridEx;
  if grid_ex3 ~= nil then
    grid_ex3:Dispose();
  end
  self.mHaveInit = false;
  local timerInterval = self.mTimerInterval;
  if timerInterval ~= nil then
     timerInterval:Dispose();
     self.mTimerInterval = nil;
  end
end

return DraftView;