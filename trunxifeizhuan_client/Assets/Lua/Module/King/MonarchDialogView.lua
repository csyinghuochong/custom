local mLuaClass = require "Core/LuaClass"
local mStoryDialogView = require "Module/Story/StoryDialogView"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigStory = require "ConfigFiles/ConfigSysstory"
local mGameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mConfigSysmonarch = require "ConfigFiles/ConfigSysmonarch"
local mKingController = require "Module/King/KingController"
local mEventEnum = require "Enum/EventEnum"
local StorySceneView = require "Module/Story/StorySceneView"
local MonarchDialogView = mLuaClass("MonarchDialogView",mStoryDialogView);
local mSuper;
local mVector3 = Vector3
local mDGTween = DG.Tweening.ShortcutExtensions;

function MonarchDialogView:InitViewParam()
	return {
		["viewPath"] = "ui/king/",
		["viewName"] = "monarch_dialog_view",
		["ParentLayer"] = mCommonStoryLayer,
	};
end

function MonarchDialogView:Init()
    mSuper = self:GetSuper(mStoryDialogView.LuaClassName);
    mSuper.Init(self);
    self.mImage_Right = self:FindComponent("role_right","RawImage");
    self.mReward = self:Find('dialog_reward').gameObject;
    self.mSelect = self:Find('dialog_select').gameObject;
    self.mMood = self:Find('mood').gameObject;
    self.mMoodBar = self:Find('mood/bar');
    self.mMoodBarImage = self:FindComponent("mood/bar", 'Image');
    self.mMoodHeart = self:FindComponent("mood/heart", 'Image');
    self:CreateCanvas();
    local selectDescList = {};
    local selectObj = {};
    for i=1,3 do
    	selectDescList[i] = self:FindComponent('dialog_select/select'..i..'/selectDesc', 'Text');
      selectObj[i] = self:Find('dialog_select/select'..i).gameObject;
    	self:FindAndAddClickListener('dialog_select/select'..i..'/selectBtn',function() self:OnSelectBranch(i) end);
    end
    self:RegisterEventListener(mEventEnum.ON_RUN_NEXT_STORY, function()
         self:NextStory();
    end, true);
    self:FindAndAddClickListener('dialog_reward/Button',function() self:OnGetReward() end);
    self.mSelectObj = selectObj;
    self.mSelectDescList = selectDescList;
    self.mStorySceneView = StorySceneView.LuaNew( self:Find('main_bg').gameObject ); 
    self.mRewardGoodsGridEx = mLayoutController.LuaNew(self:Find("dialog_reward/goodsScrollView/Grid"), require "Module/CommonUI/CommonGoodsItemView");
end

function MonarchDialogView:CreateCanvas()
    local order = self:GetValidSortingOrder() + 2;

    local canvasReward = self.mReward:GetComponent(typeof(UnityEngine.Canvas));
    canvasReward.overrideSorting = true;
    canvasReward.sortingOrder = order;

    local canvasSelect = self.mSelect:GetComponent(typeof(UnityEngine.Canvas));
    canvasSelect.overrideSorting = true;
    canvasSelect.sortingOrder = order;

    local canvasMood = self.mMood:GetComponent(typeof(UnityEngine.Canvas));
    canvasMood.overrideSorting = true;
    canvasMood.sortingOrder = order;
end

function MonarchDialogView:OnViewShow()
    self.mCallBack = self.mLogicParams;
    self:BeginStory();
end

function MonarchDialogView:BeginStory()
	  self.mMood:SetActive(true);
    self.mSelect:SetActive(false);
    self.mReward:SetActive(false);
    self:RunStory();
end

function MonarchDialogView:RunStory()
    local monarchData = mGameModelManager.KingModel.mMonarchVO;
    self.mMonarchVO = monarchData;
    self:SetMood(monarchData.mMood);
    local dialogConfig = mConfigStory[monarchData:GetConfig().story];
    self.mDialogList = dialogConfig.story_dialogs;
    self.mDialogIndex = 1;
    self:OnClickNext();
    self.mStorySceneView:LoadMainBg(dialogConfig.main_bg);
end

function MonarchDialogView:NextStory()
    self.mSelect:SetActive(false);
    self.mImage_Right.gameObject:SetActive(true);
    self:RunStory();
end

function MonarchDialogView:SetMood(mood)
    local scale = mood / 100;
    self.mMoodBar.localScale = Vector3.New(scale, 1, 1);
    if mood < 34 then
       self.mGameObjectUtil:SetImageSprite(self.mMoodBarImage,"king_happiness_2");
       self.mGameObjectUtil:SetImageSprite(self.mMoodHeart,"king_happiness_red-heart");
    elseif mood > 67 then 
       self.mGameObjectUtil:SetImageSprite(self.mMoodBarImage,"king_happiness_5");
       self.mGameObjectUtil:SetImageSprite(self.mMoodHeart,"king_happiness_green-heart");
    else
       self.mGameObjectUtil:SetImageSprite(self.mMoodBarImage,"king_happiness_1");
       self.mGameObjectUtil:SetImageSprite(self.mMoodHeart,"king_happiness_yellow-heart");
    end
end

function MonarchDialogView:OnEndDialog()
    local monarchType = self.mMonarchVO:GetConfig().story_type;
    if monarchType == 1 or monarchType == 2 then
       self.mMood:SetActive(true);
       self.mSelect:SetActive(true);
       self.mReward:SetActive(false);
       self:InitBranch();
    elseif monarchType == 3 then
       self.mMood:SetActive(false);
       self.mSelect:SetActive(false);
       self.mReward:SetActive(true);
       self:InitReward();
    end
end

function MonarchDialogView:InitBranch()
    self.mImage_Right.gameObject:SetActive(false);
	  local monarchConfig = self.mMonarchVO:GetConfig();
	  local selectDescList = self.mSelectDescList;
    local selectObj = self.mSelectObj;
    for i=1,3 do
       local branch = monarchConfig.branch[i]
       selectObj[i]:SetActive(branch ~= nil);
       if branch ~= nil then
          local config = mConfigSysmonarch[branch];
          selectDescList[i].text = config.des;
       end
    end
end

function MonarchDialogView:InitReward()
	  self.mRewardGoodsGridEx:UpdateDataSource(mGameModelManager.KingModel.mMonarchReward);
end

function MonarchDialogView:OnSelectBranch(index)
    local selectId = self.mMonarchVO:GetConfig().branch[index];
    local config = mConfigSysmonarch[selectId];
    if config.story_type == 4 then
       local mood = self.mMonarchVO.mMood;
       for i,v in ipairs(config.branch) do
          local nextConfig = mConfigSysmonarch[v];
          if mood > nextConfig.mood[1] and mood <= nextConfig.mood[2] then
             mKingController:SendMonrachUpdate(v);
             return;
          end
       end
    else
       mKingController:SendMonrachUpdate(selectId);
    end
    
end

function MonarchDialogView:OnGetReward()
	  self.mTypeWriteView:CloseView();
    self:CloseView();

    local call_back = self.mCallBack;
    if call_back ~= nil then
       call_back();
    end
end

function MonarchDialogView:Dispose()
    mSuper.Dispose(self);
    self.mRewardGoodsGridEx:Dispose();
    self.mStorySceneView:DisposeMap();
end


return MonarchDialogView