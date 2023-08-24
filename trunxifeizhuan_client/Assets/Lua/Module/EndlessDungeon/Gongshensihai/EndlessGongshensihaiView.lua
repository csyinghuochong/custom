local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mConfigSysendless = require "ConfigFiles/ConfigSysendless_chapter"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mEndlessController = require "Module/EndlessDungeon/EndlessDungeonController"
local mLanguage = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSkillBuff = require "ConfigFiles/ConfigSysskill_buff"
local mString = require 'string'
local mSortTable = require "Common/SortTable"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mEventEnum = require "Enum/EventEnum"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigMonster = require "ConfigFiles/ConfigSysmonster"
local GameObject = UnityEngine.GameObject;
local mGlobalUtil = require "Utils/GlobalUtil"
local mColorList = mGlobalUtil.Colors;

local EndlessGongshensihaiView = mLuaClass("EndlessGongshensihaiView", mQueueWindow);

function EndlessGongshensihaiView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_gongshensihai_view",
		["ParentLayer"] = mMainLayer,
        ["ForbitExternalForceShowSound"] = true,
        ["ForbitExternalForceHideSound"] = true,
        ["full_cost"] = {"gold","strength"},
	};
end

function EndlessGongshensihaiView:Init()
    self:FindAndAddClickListener("return",function() self:ReturnPrevQueueWindow() end);
    self.mPalaceName = self:Find("name"):GetComponent('Text');
    self.mPalaceBuff = self:Find("buff/palaceBuff"):GetComponent('Text');
    self.mLevelBuff = self:Find("buff/levelBuff"):GetComponent('Text');
    self.mLevel = self:Find("level"):GetComponent('Text');
    self.mNeedStrengthText = self:FindComponent('needStrength', 'Text');
    self.mLoadBgComplete = function (go)
        self:OnLoadBgComplete(go);
    end
    self:RegisterEventListener(mEventEnum.ON_GET_ENDLESS_DATA, function()
         self:InitData();
    end, true);

    self.mEnemyNameText = self:FindComponent('emenyName', 'Text');
    self:FindAndAddClickListener("Button",function() self:OnChanllage() end);
    self.mImageCost = self:FindComponent('ImageCost', 'GameImage');
    self:FindAndAddClickListener("Rank",function() self:OnRank() end);
    self:FindAndAddClickListener("Reward",function() self:OnReward() end);
    self.mDropGoodsGridEx = mLayoutController.LuaNew(self:Find("goodsGrid"), require "Module/CommonUI/CommonGoodsItemView");

    self.mRoleMode = ModelRenderTexture.LuaNew( self:Find('model') );
end

function EndlessGongshensihaiView:OnViewShow(logicParams)
    local gongshensihaiVO = mGameModelManager.EndlessDungeonModel.mGongshensihaiData;
    if gongshensihaiVO == nil then
       local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
       local chapterList = {chapterEnum.Gongshen};
       mEndlessController:SendGetEndlessInfo(chapterList);
    else
       self:InitData();
    end
    
    self.mRoleMode:ShowView( );
end

function EndlessGongshensihaiView:LoadMainBg( bg )
    if bg == nil and bg == "" then
        return;
    end

    if bg == self.mMainMap then
        return;
    end
    self:DisposeMap();
    self.mMainMap = bg;
    mUIManager:LoadView('ui/common_bg/', bg, self.mLoadBgComplete);
end

function EndlessGongshensihaiView:OnLoadBgComplete(go)
    if go ~= nil then
        self.mMainMapObj = go;
        mGameObjectUtil:SetParent(go.transform, self:Find('main_bg'));
        mGameObjectUtil:RestRectTransform(go.transform);
    end
end

function EndlessGongshensihaiView:InitData()
    if self.mBattleID ~= mGameModelManager.EndlessDungeonModel.mGongshensihaiData.mBattleID then
        local gongshensihaiVO = mGameModelManager.EndlessDungeonModel.mGongshensihaiData;
        local palaceID = gongshensihaiVO:GetPalaceID();
        local difficult = gongshensihaiVO:GetDifficult();
        local level = gongshensihaiVO:GetLevelID();
        local dungeonConfig = gongshensihaiVO:GetConfig();
        self.mDungeonConfig = dungeonConfig;
        self.mBattleLevel = level;
        local config = mConfigSysendless[palaceID];
        self.mLevel.text = "("..level.."/10)";
        self.mPalaceName.text = mString.format(mColorList[difficult],config.palace_name);
        self.mPalaceBuff.text = mString.format(mLanguage.endless_palace_buff,mConfigSkillBuff[config.buff_id].desc);
        self.mLevelBuff.text = mString.format(mLanguage.endless_level_buff,mConfigSkillBuff[config.level_buff[level]].desc);
        self:LoadMainBg(config.map);
        self.mGongshensihaiVO = gongshensihaiVO;
        self:ShowDropItem();
        self.mBattleID = self.mGongshensihaiVO.mBattleID;
    end
    self:ShowModel(mConfigMonster[self.mDungeonConfig.dungeon_boss]);
end

function EndlessGongshensihaiView:ShowModel(monsterConfig)
    if monsterConfig == nil or monsterConfig.model == nil then
       return;
    end
    self.mEnemyNameText.text = monsterConfig.name;
    local bustIcon = monsterConfig.model;
   
    self.mRoleMode:OnUpdateUI( bustIcon );
end

function EndlessGongshensihaiView:ShowDropItem()
    local dungeonConfig = self.mDungeonConfig;
    local last_number, icon =  self:GetLastResource(dungeonConfig.strength_w[1]);
    self.mNeedStrengthText.text = dungeonConfig.strength_w[2];
    self.mImageCost:SetSprite(icon);
    local goodsList = dungeonConfig.drop_show;
    local goods_data = mSortTable.LuaNew();
    for i,v in ipairs(goodsList) do
        goods_data:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v,0,nil,true));
    end

    self.mDropGoodsGridEx:UpdateDataSource(goods_data);
end

function EndlessGongshensihaiView:GetLastResource( costType )
    local roleModel = mGameModelManager.RoleModel;
    local playerBase = roleModel.mPlayerBase;
    if costType == roleModel.mTypeEnum.mEnumCostEnergy then
        return playerBase.energy, 'common_city_icon_10';
    else
        return playerBase.sp, 'common_city_icon_9';
    end
end

function EndlessGongshensihaiView:OnLoadedBg(bg)
    self.mPalaceBg.texture = bg;
end

function EndlessGongshensihaiView:OnRank()
    -- body
end

function EndlessGongshensihaiView:OnChanllage()
    local arrayBack = function ()
       self:OnClickChallenge();
    end
    local data = mBattleArrayViewVO.LuaNew();
    data:InitGongshensihaiTeam(self.mBattleID,arrayBack);
    mUIManager:HandleUI(mViewEnum.EndlessGongshensihaiArrayView,1, data);
end

function EndlessGongshensihaiView:OnClickChallenge()
    mEndlessController:SendChallengeEndless(mGameModelManager.EndlessDungeonModel.mChapterEnum.Gongshen);
end

function EndlessGongshensihaiView:OnReward()
   
end

function EndlessGongshensihaiView:DisposeMap(  )
    if self.mMainMapObj ~= nil then
        GameObject.DestroyImmediate(self.mMainMapObj);
        self.mMainMapObj = nil;
    end
    self.mMainMap = nil;
end

function EndlessGongshensihaiView:Dispose()
    self.mBattleID = nil;
    self.mDropGoodsGridEx:Dispose();
    self:DisposeMap();
    self.mRoleMode:Dispose();
end

function EndlessGongshensihaiView:OnViewHide(logicParams)
   self.mRoleMode:HideView( );
end

return EndlessGongshensihaiView;