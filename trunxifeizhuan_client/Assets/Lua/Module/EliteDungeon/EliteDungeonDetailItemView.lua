local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonMonsterHeadView = require "Module/CommonUI/CommonMonsterHeadView"
local EliteDungeonDetailItemView = mLuaClass("EliteDungeonDetailItemView",mLayoutItem);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgGreen = mLanguageUtil.camp_dungeon_green;
local mLgRed = mLanguageUtil.camp_dungeon_red;
local mLgPurple = mLanguageUtil.camp_dungeon_purple;

function EliteDungeonDetailItemView:InitViewParam()
	return {
		["viewPath"] = "ui/elite_dungeon/",
		["viewName"] = "elite_dungeon_detail_item_view",
	};
end

function EliteDungeonDetailItemView:Init( )
	self.mTextName = self:FindComponent("Name","Text");
	self.mTextState = self:FindComponent("state","Text");
	local go = self:Find("Monster").gameObject;
	self.mMonster = mCommonMonsterHeadView.LuaNew(go);
	self.mGoBlack = self:Find("black").gameObject;
	self.mGoLock = self:Find("lock").gameObject;
	self.mGoBtn = self:Find("Btn").gameObject;
	self:FindAndAddClickListener("Btn",function() self:ClickBattle(); end);

	self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ID, function(dungeonID)
		self:OnRefreshData(dungeonID);
	end, false);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function EliteDungeonDetailItemView:OnRefreshData(dungeonID)
	local data = self.mData;
	if dungeonID == data.mID then
		self:OnUpdateData();
	end
end

function EliteDungeonDetailItemView:ClickBattle()
	local data = self.mData;
	self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_ARRAY,data);
end

function EliteDungeonDetailItemView:OnUpdateData()
	local data = self.mData;
	local nowID = mGameModelManager.EliteDungeonModel.mNowDungeonID;
	self:SetState(nowID >= data.mID);
	self.mTextName.text = data.mConfig.dungeon_name;
	self.mMonster:SetInfo(data.mConfig.dungeon_boss);

	if nowID > data.mID then
		self.mTextState.text = mLgGreen;
	elseif nowID == data.mID then
		if data.mConfig.next_dungeon == 0 then
			self.mTextState.text = mLgGreen;
		else
			self.mTextState.text = mLgRed;
		end
	else
		self.mTextState.text = mLgPurple;
	end
end

function EliteDungeonDetailItemView:SetState(state)
	self.mGoBtn:SetActive(state);
	self.mGoLock:SetActive(not state);
	self.mGoBlack:SetActive(not state);
end

return EliteDungeonDetailItemView;