local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigMonster = require "ConfigFiles/ConfigSysmonster"
local mCommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local mCommonSkillItem = require "Module/CommonUI/CommonSkillItemView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mipairs = ipairs

local CampDengeonBossDetialView = mLuaClass("CampDengeonBossDetialView", mQueueWindow);

function CampDengeonBossDetialView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_boss_detial_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function CampDengeonBossDetialView:Init()
    self.mBossName = self:Find("bossName"):GetComponent('Text');
    local skillListItem = {};
    for i=1,5 do
    	skillListItem[i] = mCommonSkillItem.LuaNew(self:Find("skill/skill"..i).gameObject);
    end
    self.mSkillListItem = skillListItem;
    self.mMonster1 = self:Find("monster1");
    self.mMonster2 = self:Find("monster2");
    self.mMonsterName1 = self:Find("monster1/name"):GetComponent('Text');
    self.mMonsterName2 = self:Find("monster2/name"):GetComponent('Text');
    self.mMonster1Skill = mCommonSkillItem.LuaNew(self:Find("monster1/skill1").gameObject);
    self.mMonster2Skill = mCommonSkillItem.LuaNew(self:Find("monster2/skill1").gameObject);
end

function CampDengeonBossDetialView:OnViewShow(logicParams)
    self:SetBossSkill(logicParams.mSysVO.dungeon_boss);
    self:SetBossFollower(logicParams.mSysVO.monster_node);
end

function CampDengeonBossDetialView:SetBossSkill(bossID)
    local monsterConfig = mConfigMonster[bossID];
    self.mBossName.text = monsterConfig.name;
    local skillList = monsterConfig.skills;
    local skillListItem = self.mSkillListItem;
    for i=1,5 do
        if skillList[i] ~= nil then
           skillListItem[i].mGameObject:SetActive(true);
           skillListItem[i]:ExternalUpdate(mCommonSkillVO.LuaNew(skillList[i],0,true,true));
        else
           skillListItem[i].mGameObject:SetActive(false);
        end
    end
end

function CampDengeonBossDetialView:SetBossFollower(monsterNode)
    local followerList = {};
    local index = 1;
    for k,v in mipairs(monsterNode) do
        local monsterVO = v.monster_id
        if monsterVO ~= nil and index < 3 then
           for k,v in mipairs(monsterVO) do
               if v~=nil then
                  followerList[index] = v.monster_id;
                  index = index + 1;
               end
               if index > 2 then
                  break;
               end
           end
        end 
    end
    local monsterConfig1 = mConfigMonster[followerList[1]];
    local monsterConfig2 = mConfigMonster[followerList[2]];
    if monsterConfig1 ~= nil then
       self.mMonster1.gameObject:SetActive(true);
       self.mMonsterName1.text = monsterConfig1.name;
       self.mMonster1Skill:ExternalUpdate(mCommonSkillVO.LuaNew(monsterConfig1.skills[1],0,true,true));
    else
       self.mMonster1.gameObject:SetActive(false);
    end

    if monsterConfig2 ~= nil then
       self.mMonster2.gameObject:SetActive(true);
       self.mMonsterName2.text = monsterConfig2.name;
       self.mMonster2Skill:ExternalUpdate(mCommonSkillVO.LuaNew(monsterConfig2.skills[1],0,true,true));
    else
       self.mMonster2.gameObject:SetActive(false);
    end
end

return CampDengeonBossDetialView;