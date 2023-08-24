local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mSortTable = require "Common/SortTable"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mConfigSysdungeon_chapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local mGameModelManager = require "Manager/GameModelManager"
local CampDungeonMessageView = mLuaClass("CampDungeonMessageView", mBaseWindow);

function CampDungeonMessageView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_message_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function CampDungeonMessageView:Init()
    local parentBoss = self:Find("Scroll/Grid/scrollViewBoss/Grid");
    self.mGridBoss = mLayoutController.LuaNew(parentBoss,require "Module/CampDungeon/CampDungeonMonsterItemView");
    local parentAward = self:Find("Scroll/Grid/scrollViewAward/Grid");
    self.mGridAward = mLayoutController.LuaNew(parentAward,require "Module/CommonUI/CommonGoodsItemView");
    local parentFollower = self:Find("Scroll/Grid/scrollViewFollower/Grid");
    self.mGridFollower = mLayoutController.LuaNew(parentFollower,require "Module/CampDungeon/CampDungeonFollowerItemView");
    local parentToggle = self:Find("Toggle/scrollViewToggle/Grid");
    self.mGridToggle = mLayoutController.LuaNew(parentToggle,require "Module/CampDungeon/CampDungeonToggleItemView");

    self.mGoToggle = self:Find("Toggle").gameObject;
    self.mTextChapterName = self:FindComponent("Top/chapter_name","Text");
    self.mTextDungeonName = self:FindComponent("Top/dungeon_name","Text");
    self.mTextDesc = self:FindComponent("Scroll/Grid/desc","Text");

    self:FindAndAddClickListener("Top/BtnToggle",function()self:SetToggleState(true)end);
    self:FindAndAddClickListener("Toggle/BackClick",function()self:SetToggleState(false)end);

    self:RegisterEventListener(self.mEventEnum.ON_SELECT_CAMP_TOGGLE, function(data)
        self:OnSelectToggle(data);
    end, true);

    self:RegisterEventListener(self.mEventEnum.ON_CAMP_DUNGEON_RESET_FOLLOWERLIST_SIZE, function(data)
        self:SetScrollSizeY(data);
    end, true);
end

function CampDungeonMessageView:SetToggleState(state)
    self.mGoToggle:SetActive(state);
end

function CampDungeonMessageView:OnSelectToggle(data)
    self:SetToggleState(false);
    if self.mDungeonID == data.id then
        return;
    end
    self.mDungeonID = data.id;
    self:CreateMessage(data.id);
end

function CampDungeonMessageView:CreateMessage(id)
    local config = mConfigSysdungeon[id];
    self.mTextDungeonName.text = config.dungeon_name;
    self.mTextDesc.text = config.desc;

    self:CreateMonster(config.monster_node);
    self:CreateAward(config.drop_show);
    self:CreateFollower(id,config.chapter_id);
end

function CampDungeonMessageView:CreateMonster(monster_node)
    local data_soure = mSortTable.LuaNew(nil,nil,true);
    local count = #monster_node;
    local monsterList = monster_node[count].monster_id;
    if monsterList ~= nil then
        for k,v in ipairs(monsterList) do
            local data = {id=v.monster_id,level=v.lv};
            data_soure:AddOrUpdate(data.id,data);
        end
    end
    local bossList = monster_node[count].boss_id;
    if bossList ~= nil then
        for k,v in ipairs(bossList) do
            local boss = {id=v.monster_id,level=v.lv};
            data_soure:AddOrUpdate(boss.id,boss);
        end
    end
    self.mGridBoss:UpdateDataSource(data_soure);
end

function CampDungeonMessageView:CreateAward(drop_show)
    local data_soure = mSortTable.LuaNew(nil,nil,true);
    for k,v in ipairs(drop_show) do
        local goodsVO = mCommonGoodsVO.LuaNew(v,0,nil,true);
        data_soure:AddOrUpdate(v,goodsVO);
    end
    self.mGridAward:UpdateDataSource(data_soure);
end

function CampDungeonMessageView:OnViewShow(logicParams)
	self.mDungeonID = logicParams.id;
    local id = logicParams.id;
    local config = mConfigSysdungeon[id];
    self:CreateToggle(config.chapter_id);
    self:CreateMessage(id);
end

function CampDungeonMessageView:CreateFollower(id,chapter_id)
    local model = mGameModelManager.CampDungeonModel;
    local data_soure = model:GetDungeonData(chapter_id,id).mDungeonList;
    self:SetScrollSizeY(#data_soure.mSortTable);
    self.mGridFollower:UpdateDataSource(data_soure);
end

function CampDungeonMessageView:SetScrollSizeY(count)
    local trans = self:Find("Scroll/Grid");
    local addSizeY = (Mathf.Round(count/2)) * 106;
    trans.sizeDelta = Vector2(530,385 + addSizeY);
end

function CampDungeonMessageView:CreateToggle(id)
    local configChapter = mConfigSysdungeon_chapter[id];
    local start_id = configChapter.start_id;
    local count = configChapter.dungeon_count-1;
    local data_soure = mSortTable.LuaNew(nil,nil,true);
    for i=0,count do
        local data = {id = start_id + i};
        data_soure:AddOrUpdate(start_id + i,data);
    end
    self.mGridToggle:UpdateDataSource(data_soure);
    self.mTextChapterName.text = configChapter.chapter_name;
end

function CampDungeonMessageView:Dispose()
	
end

return CampDungeonMessageView;