local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mEndlessController = require "Module/EndlessDungeon/EndlessDungeonController"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSkillBuff = require "ConfigFiles/ConfigSysskill_buff"
local mLanguage = require "Utils/LanguageUtil"
local mString = require 'string'
local mEventEnum = require "Enum/EventEnum"
local mSortTable = require "Common/SortTable"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mStoryManager = require "Module/Story/StoryManager"
local mVector3 = Vector3;

local EndlessShengongmeiyingView = mLuaClass("EndlessShengongmeiyingView", mQueueWindow);

function EndlessShengongmeiyingView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_shengongmeiying_view",
		["ParentLayer"] = mMainLayer,
        ["ForbitExternalForceShowSound"] = true,
        ["ForbitExternalForceHideSound"] = true,
	};
end

function EndlessShengongmeiyingView:Init()
    self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow() end);
    self.mPalaceLevel = self:Find("level"):GetComponent('Text');
    self.mPalaceBuff = self:Find("buff/palaceBuff"):GetComponent('Text');
    self.mHaveStrengthText = self:FindComponent('drop/haveStrength', 'Text');
    self.mNeedStrengthText = self:FindComponent('drop/needStrength', 'Text');
    self.mSelectTrans = self:Find('Scroll/main_bg/select');
    self.mCostLabel = self:FindComponent('drop/costStr', 'Text');
    self:FindAndAddClickListener("drop/Button",function() self:OnChanllage() end);
    self:RegisterEventListener(mEventEnum.ON_GET_ENDLESS_DATA, function()
         self:InitData();
    end, true);
    self.mImageCost1 = self:FindComponent('drop/ImageCost', 'GameImage');
    self.mImageCost2 = self:FindComponent('drop/ImageCost2', 'GameImage');
    self.mDropGoodsGridEx = mLayoutController.LuaNew(self:Find("drop/goodsScrollView/Grid"), require "Module/CommonUI/CommonGoodsItemView");
end

function EndlessShengongmeiyingView:OnViewShow(logicParams)
    local shengongmeiyingVO = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
    if shengongmeiyingVO == nil then
       local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
       local chapterList = {chapterEnum.ShengongNormal};
       mEndlessController:SendGetEndlessInfo(chapterList);
    else
       self:InitData();
    end
end

function EndlessShengongmeiyingView:InitData()
    local shengongmeiyingVO = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
    if self.mBattleID ~= shengongmeiyingVO.mBattleID then
        self.mPalaceLevel.text = "("..shengongmeiyingVO:GetConfig().index.."/"..shengongmeiyingVO:GetMaxLevel()..")";
        -- local buffID = shengongmeiyingVO:GetBuffID();
        -- self.mPalaceBuff.text = mString.format(mLanguage.endless_youmei_buff,mConfigSkillBuff[buffID].desc);
        self.mShengongmeiyingVO = shengongmeiyingVO;
        self:ShowDropItem();
        self.mBattleID = shengongmeiyingVO.mBattleID;
    end
    local storyID = shengongmeiyingVO.mStoryID;
    if storyID ~= 0 then
       mStoryManager:OnPlayStory(storyID, function() 
          mEndlessController:SendPlayStory(0,shengongmeiyingVO.mStoryEndID);
          shengongmeiyingVO.mStoryID = 0;

       end);
    end
    if shengongmeiyingVO:GetConfig().index == shengongmeiyingVO:GetMaxLevel() and shengongmeiyingVO.mStatus == 1 then
        storyID = shengongmeiyingVO.mStoryEndID;
        mStoryManager:OnPlayStory(storyID, function() 
            mEndlessController:SendPlayStory(0,0);
            self:ReturnPrevQueueWindow() 
        end);
    end
end

function EndlessShengongmeiyingView:ShowDropItem()
    local dungeonConfig = self.mShengongmeiyingVO:GetConfig();
    self.mSelectTrans.localPosition = mVector3.New(dungeonConfig.icon_pos[1], dungeonConfig.icon_pos[2], 0);
    local last_number, icon ,cost_text =  self:GetLastResource(dungeonConfig.strength_w[1]);
    self.mCostLabel.text = cost_text;
    self.mHaveStrengthText.text = last_number;
    self.mNeedStrengthText.text = dungeonConfig.strength_w[2];
    self.mImageCost1:SetSprite(icon);
    self.mImageCost2:SetSprite(icon);
    local goodsList = dungeonConfig.drop_show;
    local goods_data = mSortTable.LuaNew();
    for i,v in ipairs(goodsList) do
        goods_data:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v,0,nil,true));
    end

    self.mDropGoodsGridEx:UpdateDataSource(goods_data);
end

function EndlessShengongmeiyingView:GetLastResource( costType )
    local roleModel = mGameModelManager.RoleModel;
    local playerBase = roleModel.mPlayerBase;
    if costType == roleModel.mTypeEnum.mEnumCostEnergy then
        return playerBase.energy, 'common_city_icon_10', mLanguage.battle_cost_energy;
    else
        return playerBase.sp, 'common_city_icon_9', mLanguage.battle_cost_strength;
    end
end

function EndlessShengongmeiyingView:OnChanllage()
    local arrayBack = function ()
       self:OnClickChallenge();
    end
    local data = mBattleArrayViewVO.LuaNew();
    data:InitShengongmeiyingTeam(self.mShengongmeiyingVO.mBattleID,arrayBack);
    mUIManager:HandleUI(mViewEnum.EndlessShengongmeiyingArrayView,1, data);
end

function EndlessShengongmeiyingView:OnClickChallenge()
    mEndlessController:SendChallengeEndless(self.mShengongmeiyingVO.mChapterID);
end

function EndlessShengongmeiyingView:Dispose()
    self.mBattleID = nil;
    self.mDropGoodsGridEx:Dispose();
end

return EndlessShengongmeiyingView;