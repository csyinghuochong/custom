local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mCommonMonsterHeadView = require "Module/CommonUI/CommonMonsterHeadView"
local CampDungeonBossLevelItemView = mLuaClass("CampDungeonBossLevelItemView", mLayoutItem);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgGreen = mLanguageUtil.camp_dungeon_green;
local mLgRed = mLanguageUtil.camp_dungeon_red;
local mLgPurple = mLanguageUtil.camp_dungeon_purple;

function CampDungeonBossLevelItemView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_chapter_item_view",
	};
end

function CampDungeonBossLevelItemView:Init()
	local go = self:Find("Monster").gameObject;
	self.mMonster = mCommonMonsterHeadView.LuaNew(go);
	self.mNameStr = self:Find("name"):GetComponent('Text');
	self.mLock = self:Find("lock").gameObject;
	self.mLockBg = self:Find("lockbg").gameObject;
	self.mFight = self:Find("btnFight").gameObject;
	self.mTextState = self:FindComponent("pass","Text");
	self:FindAndAddClickListener("btnFight",function()self:OnClickFight()end)
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CampDungeonBossLevelItemView:OnClickFight()
	local data = self.mData;
	self:Dispatch(mEventEnum.ON_OPEN_CAMP_FORMATION,data);
end

function CampDungeonBossLevelItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

function CampDungeonBossLevelItemView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	local config = data.mSysVO;
	local state = data.mState;
	self.mMonster:SetInfo(config.dungeon_boss);
	self.mNameStr.text = config.dungeon_name;
	local lock = state == 3;
	self.mLock:SetActive(lock);
	self.mLockBg:SetActive(lock);
	self.mFight:SetActive(not lock);
	if state == 1 then
		self.mTextState.text = mLgGreen;
	elseif state == 2 then
		self.mTextState.text = mLgRed;
	elseif state == 3 then
		self.mTextState.text = mLgPurple;
	end
end

return CampDungeonBossLevelItemView;

