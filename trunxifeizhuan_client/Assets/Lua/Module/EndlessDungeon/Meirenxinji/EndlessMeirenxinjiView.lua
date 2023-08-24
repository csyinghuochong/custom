local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mEndlessMeirenxinjiItemView = require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenxinjiItemView"
local mConfigGlobalValue = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mEndlessController = require "Module/EndlessDungeon/EndlessDungeonController"
local mVector2 = Vector2;
local mColor = Color;
local mGameTimer = require "Core/Timer/GameTimer"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local EndlessMeirenxinjiView = mLuaClass("EndlessMeirenxinjiView", mQueueWindow);

local COUNT = 15;
local MEIREN_FIRST = 1601000;
local MAP_WIDTH = 3520;
local TIP_WIDTH = 33;

local mFightEffect = "ui_peeragelevelsview_levels_panel_item"
function EndlessMeirenxinjiView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_meirenxinji_view",
		["ParentLayer"] = mMainLayer,
        ["ForbitExternalForceShowSound"] = true,
        ["ForbitExternalForceHideSound"] = true,
        ["full_cost"] = {"gold","energy"},
	};
end

function EndlessMeirenxinjiView:Init()
    self:FindAndAddClickListener("Top/BtnClose",function() self:ReturnPrevQueueWindow() end);
    self:FindAndAddClickListener("Btn",function() self:OnClickRule() end);
    self:FindAndAddClickListener("Fight",function() self:OnChanllage() end);
    
    local monsterList = {};
    for i=1,COUNT do
        local goMonster = self:Find("Scroll/main_bg/Bridge/Pos"..i).gameObject;
        local monsterItem = mEndlessMeirenxinjiItemView.LuaNew(goMonster);
        monsterList[i] = monsterItem;
    end
    self.mMonsterList = monsterList;

    self.mImgTip = self:FindComponent("Tips","Image");
    self.mTransFight = self:Find("Fight");
    self:AddUIEffect(mFightEffect, self.mTransFight);

    local scrollRect = self:FindComponent("Scroll","GameScrollRect");
    scrollRect.onDragChanged:AddListener(function(vec)self:OnScrollRoll(vec)end);

    self:RegisterEventListener(mEventEnum.ON_GET_ENDLESS_DATA, function()
        self:InitData();end, 
        true);
    self:RegisterEventListener(mEventEnum.ON_SHOW_MEIRENXINJI_ROTATION, function()
        self:OnChanllage();
        end, 
        true);
    self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW, function()
        self:OnShowTop(true);
    end, true);

    self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW, function()
        self:OnShowTop(false);
    end, true);

    self.mGoTop = self:Find("Top").gameObject;
end

function EndlessMeirenxinjiView:OnShowTop(state)
    self.mGoTop:SetActive(state);
end

function EndlessMeirenxinjiView:OnClickRule()
    mUIManager:HandleUI(mViewEnum.ManualView,1, mConfigSysmanualConst.MEIRENXINJI);
end

function EndlessMeirenxinjiView:OnChanllage()
    local arrayBack = function (enemyHeros)
       self:FormationBack(enemyHeros);
    end
    local data = mBattleArrayViewVO.LuaNew();
    local model = mGameModelManager.EndlessDungeonModel;
    model:SetSelectBuff({});
    data:InitMeirenxinjiTeam(model.mMeirenxinjiData.mBattleID ,arrayBack);
    mUIManager:HandleUI(mViewEnum.EndlessBattleArrayView,1, data);
end

function EndlessMeirenxinjiView:FormationBack(enemyHeros)
    local endlessModle = mGameModelManager.EndlessDungeonModel;
    endlessModle:SetMeirenFightInfo(enemyHeros,{});
    mEndlessController:SendChallengeEndless(endlessModle.mChapterEnum.Meiren,{});
end

function EndlessMeirenxinjiView:OnScrollRoll(vec)
    local model = mGameModelManager.EndlessDungeonModel;
    model.mNowPosX = self:Find("Scroll/main_bg").localPosition.x;
    local monsterList = self.mMonsterList;
    for k,v in ipairs(monsterList) do
        v:CalculateIsShowModel();
    end
    self:CheckIsShowTips(vec);
end

function EndlessMeirenxinjiView:CheckIsShowTips(vec)
    local posX,posLeft,posRight = self:GetPos();
    if posX >= posRight or posX <= posLeft then
        local tipPosX;
        if posX >= posRight then
            tipPosX = -(mUIManager:GetDeviceWidth() - TIP_WIDTH)/2;
            if vec.x > 0 then
                self:PlayTipsAnimation();
            end
        end
        if posX <= posLeft then
            tipPosX = (mUIManager:GetDeviceWidth() - TIP_WIDTH)/2;
            if vec.x < 0 then
                self:PlayTipsAnimation();
            end
        end
        self.mImgTip.transform.localPosition = mVector2(tipPosX,0);
    end
end

function EndlessMeirenxinjiView:PlayTipsAnimation()
    local img = self.mImgTip;
    img.color = mColor.white;
    self.mAlpha = 1;
    if self.mTimerInterval ~= nil then
        self.mTimerInterval:Stop();
    end
    self.mTimerInterval = mGameTimer.SetInterval(0.1, function() self:OnTimerInterval() end);
end

function EndlessMeirenxinjiView:OnTimerInterval()
    local alpha = self.mAlpha;
    alpha = alpha - 0.1;
    if alpha <= 0 then
        self.mTimerInterval:Stop();
    else
        self.mImgTip.color = mColor.New(1,1,1,alpha);
    end
    self.mAlpha = alpha;
end

function EndlessMeirenxinjiView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    local endlessData = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData;
    if endlessData == nil then
       local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
       local chapterList = {chapterEnum.Meiren};
       mEndlessController:SendGetEndlessInfo(chapterList);
    else
       self:InitData();
    end
end

function EndlessMeirenxinjiView:InitData()
    local model = mGameModelManager.EndlessDungeonModel;
    local data = model.mMeirenxinjiData;
    self:ChangeMapPos(data.mBattleID);
    self:ChangeFightPos(data.mBattleID,data.mStatus);
    if data.mData_soure ~= nil then
        local sortTable = data.mData_soure.mSortTable;
        local monsterList = self.mMonsterList;
        for k,v in ipairs(monsterList) do
            v:SetData(data.mData_soure.mSortTable[k]);
        end
    end
end

function EndlessMeirenxinjiView:ChangeMapPos(battleID)
    local posX,posLeft,posRight = self:GetPos(battleID);
    local mapPosX = 0;
    if posX <= posLeft then
        mapPosX = -posLeft;
    elseif posX >= posRight then
        mapPosX = -posRight;
    else
        mapPosX = -posX;
    end
    local transMap = self:Find("Scroll/main_bg");
    transMap.localPosition = mVector2(mapPosX,0);
    local model = mGameModelManager.EndlessDungeonModel;
    model.mNowPosX = mapPosX;
end

function EndlessMeirenxinjiView:ChangeFightPos(battleID,status)
    local trans = self.mTransFight;
    if status == 1 then
        trans.gameObject:SetActive(false);
    else
        local monsterTrans = self:Find("Scroll/main_bg/Bridge/Pos"..tostring(battleID - MEIREN_FIRST));
        if monsterTrans ~= nil then
            mGameObjectUtil:SetParent(trans, monsterTrans);
            trans.localPosition = mVector2(5,65);
            trans.gameObject:SetActive(true);
        else
            trans.gameObject:SetActive(false);
        end
    end
end

function EndlessMeirenxinjiView:GetPos(battleID)
    local trans;
    if battleID ~= nil then
        trans = self:Find("Scroll/main_bg/Bridge/Pos"..tostring(battleID - MEIREN_FIRST));
    else
        trans = self:Find("Scroll/main_bg");
    end
    local posX = trans.localPosition.x;
    local posLeft = -(MAP_WIDTH - mUIManager:GetDeviceWidth())/2;
    local posRight = (MAP_WIDTH - mUIManager:GetDeviceWidth())/2;
    return posX,posLeft,posRight;
end

function EndlessMeirenxinjiView:OnViewHide(logicParams)
    local timeInterval = self.mTimerInterval;
    if timeInterval ~= nil then
        timeInterval:Stop();
        self.mTimerInterval = nil;
        self.mImgTip.color = mColor.clear;
    end

    local monsterList = self.mMonsterList;
    for k,v in ipairs(monsterList) do
        v:OnViewHide();
    end

    self.mTransFight.gameObject:SetActive(false);
end

function EndlessMeirenxinjiView:Dispose()
    
end

return EndlessMeirenxinjiView;

