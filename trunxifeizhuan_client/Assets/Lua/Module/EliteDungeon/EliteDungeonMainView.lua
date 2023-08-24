local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEliteDungeonBuildVO = require "Module/EliteDungeon/EliteDungeonBuildVO"
local mEliteDungeonDetailView = require "Module/EliteDungeon/EliteDungeonDetailView"
local mEliteDungeonController = require "Module/EliteDungeon/EliteDungeonController"
local mEliteDungeonBuildItemView = require "Module/EliteDungeon/EliteDungeonBuildItemView"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mConfigSysdungeon_chapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local mConfigSysstory = require "ConfigFiles/ConfigSysstory"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameTimer = require "Core/Timer/GameTimer"
local EliteDungeonMainView = mLuaClass("EliteDungeonMainView", mQueueWindow);

local MAPWIDTH = 1714;
local BUILD_START_ID = 1901;
local ELITE_DUNGEON_LAST = 1912005;
local BUILD_NUM = 12;
local ROLL_SPEED = 200;

local mBuildEffect = "ui_elite_dungeon_build";
local mBuildOpenEffect = "ui_elite_dungeon_main_view_build_01";
local mBuildClearEffect = "ui_elite_dungeon_main_view_build_02";
local mFightEffect = "ui_peeragelevelsview_levels_panel_item"

function EliteDungeonMainView:InitViewParam()
	return {
		["viewPath"] = "ui/elite_dungeon/",
		["viewName"] = "elite_dungeon_main_view",
		["ParentLayer"] = mMainLayer,
		["full_cost"] = {"gold","silver","strength"},
	    ["ForbitExternalForceShowSound"] = true,
	    ["ForbitExternalForceHideSound"] = true,
	};
end

function EliteDungeonMainView:Init()
	local buildList = {};
	local callBack = function(transform)
        self:OnClickBuild(transform);
    end
    local lastBuildID = BUILD_START_ID + BUILD_NUM - 1;
	for i=BUILD_START_ID,lastBuildID do
		local goBuild = self:Find("Scroll/main_bg/Build"..(i - BUILD_START_ID + 1)).gameObject;
		local data = mEliteDungeonBuildVO.LuaNew(i);
		local buildItem = mEliteDungeonBuildItemView.LuaNew(goBuild,data,callBack);
		buildItem:SetState(false);
		buildList[i] = buildItem;
	end
	self.mBuildList = buildList;
	self.mBgTransform = self:Find('Scroll/main_bg'):GetComponent('RectTransform');
	local go = self:Find("Detail/detail_view").gameObject;
	self.mShowDetailWin = mEliteDungeonDetailView.LuaNew(go);

	local transEffect = self:Find("Scroll/main_bg/Effect");
	self:AddUIEffect(mBuildEffect, transEffect);
	transEffect.gameObject:SetActive(false);
	self.mTransEffect = transEffect;

	local transEffectClear = self:Find("Scroll/main_bg/EffectClear");
	self:AddUIEffect(mBuildClearEffect, transEffectClear);
	transEffectClear.gameObject:SetActive(false);
	self.mTransEffectClear = transEffectClear;

	local transEffectOpen = self:Find("Scroll/main_bg/EffectOpen");
	self:AddUIEffect(mBuildOpenEffect, transEffectOpen);
	transEffectOpen.gameObject:SetActive(false);
	self.mTransEffectOpen = transEffectOpen;

	local transEffectArrow = self:Find("Scroll/main_bg/arrow");
	self:AddUIEffect(mFightEffect, transEffectArrow);
	transEffectArrow.gameObject:SetActive(false);
	self.mTransArrow = transEffectArrow;

	self.mGoTop = self:Find("Top").gameObject;
	self.mGoClickBack = self:Find("Scroll/back_click").gameObject;
	self.mTextDesc1 = self:FindComponent("Detail/Left/desc1","GameEliteText");
	self.mTextDesc2 = self:FindComponent("Detail/Left/desc2","GameEliteText");

    self:FindAndAddClickListener("Top/BtnClose",function() self:OnClickClose(true) end);
    self:FindAndAddClickListener("Scroll/back_click",function() self:OnClickClose() end);

    self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ALL, function(data)
		self:OnRefreshAllData(data);
	end, true);

    self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ID, function(data)
		self:OnRefreshData(data);
	end, true);

	self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_CLOSE_DETAIL, function(data)
		self:OnCloseDetail(data);
	end, true);

	self:RegisterEventListener(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_DIALOG, function(data)
		self:OnRedyShowDialog(data);
	end, true);

	self:RegisterEventListener(self.mEventEnum.ON_ENTER_MAINSCENE, function(data)
		self:OnShowDialog(data);
	end, true);

	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW, function()
		self:OnShowTop(true);
	end, true);

	self:RegisterEventListener(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW, function()
		self:OnShowTop(false);
	end, true);
end

function EliteDungeonMainView:OnShowTop(state)
	self.mGoTop:SetActive(state);
end

function EliteDungeonMainView:OnRedyShowDialog(chapter_id)
	local configChapter = mConfigSysdungeon_chapter[chapter_id];
	local configStory = mConfigSysstory[configChapter.story_region[2]];
	local data = {sys_story = configStory,chapter = chapter_id};
	self.mDialogData = data;
	self:OnChangeArrowPos();
end

function EliteDungeonMainView:OnShowDialog()
	local data = self.mDialogData;
	if data ~= nil then
		self.mIsShowDialog = true;
		mUIManager:HandleUI(mViewEnum.StoryDialogView, 1, data);
		self.mShowDetailWin:OnClickClose();
		local chapter_id = data.chapter;
		self:ShowOpenAndClearEffect(chapter_id);
		self.mDialogData = nil;
	end
end

function EliteDungeonMainView:ShowOpenAndClearEffect(chapter_id)
	local nowDungeonID = mGameModelManager.EliteDungeonModel.mNowDungeonID;
	if nowDungeonID >= ELITE_DUNGEON_LAST then
		self:PlayEffectClear(chapter_id);
	else
		self:PlayEffectClear(chapter_id);
		self:PlayEffectOpen(chapter_id + 1);
	end
end

function EliteDungeonMainView:PlayEffectClear(chapter_id)
	local trans = self:GetBuildData(chapter_id).transform;
	if trans ~= nil then
		local transEffect = self.mTransEffectClear;
		mGameObjectUtil:SetParent(transEffect,trans);
		transEffect.gameObject:SetActive(true);
		mGameTimer.SetTimeout(3, function(transform) self:SetEffectHide(transEffect) end);
	end
end

function EliteDungeonMainView:PlayEffectOpen(chapter_id)
	local trans = self:GetBuildData(chapter_id).transform;
	if trans ~= nil then
		local transEffect = self.mTransEffectOpen;
		mGameObjectUtil:SetParent(transEffect,trans);
		transEffect.gameObject:SetActive(true);
		mGameTimer.SetTimeout(3, function(transform) self:SetEffectHide(transEffect) end);
	end
end

function EliteDungeonMainView:SetEffectHide(transform)
	if transform ~= nil then
		transform.gameObject:SetActive(false);
	end
end

function EliteDungeonMainView:OnClickClose(isCloseBtn)
	local model = mGameModelManager.EliteDungeonModel;
	model.mSelectBuildID = 0;
	self:CheckAwardIsClose(nil)
	if self.mIsShowEffect then
		self.mShowDetailWin:OnClickClose();
		return;
	end
	if isCloseBtn then
		self:ReturnPrevQueueWindow();
	end
end

function EliteDungeonMainView:CheckAwardIsClose(id)
	local model = mGameModelManager.EliteDungeonModel;
	if id ~= nil then
		model.mSelectBuildID = id;
	end
	if model.mIsOpenAwardWindow then
		mUIManager:HandleUI(mViewEnum.CommonAwardShowView,0, nil);
		model.mIsOpenAwardWindow = false;
	end
end

function EliteDungeonMainView:OnRefreshAllData(data)
	local buildList = self.mBuildList;
	for k,v in pairs(buildList) do
		v:SetState(nil);
	end
	local model = mGameModelManager.EliteDungeonModel;
	local chapter_id = model.mNowMaxChapterID;
	local buildData = self:GetBuildData(chapter_id);
	self:OnChangeArrowPos();
end

function EliteDungeonMainView:OnChangeArrowPos()
	local model = mGameModelManager.EliteDungeonModel;
	local nowDungeonID = model.mNowDungeonID;
	if nowDungeonID == nil then
		self.mTransArrow.gameObject:SetActive(false);
		return;
	end
	if nowDungeonID >= ELITE_DUNGEON_LAST then
		self.mTransArrow.gameObject:SetActive(false);
	else
		self.mTransArrow.gameObject:SetActive(true);
		local nowMaxChapterID = model.mNowMaxChapterID;
		local trans = self:GetBuildData(nowMaxChapterID).transform
		mGameObjectUtil:SetParent(self.mTransArrow, trans);
		self.mTransArrow.localPosition = Vector2.New(-18,25);
	end
end

function EliteDungeonMainView:GetBuildData(chapter_id)
	local buildVO = mEliteDungeonBuildVO.LuaNew(chapter_id);
	local trans = self:Find("Scroll/main_bg/Build"..(chapter_id - BUILD_START_ID + 1));
	local buildData = {data = buildVO,transform = trans};
	return buildData;
end

function EliteDungeonMainView:OnRefreshData(data)
	local buildList = self.mBuildList;
	local buildID = mConfigSysdungeon[data].chapter_id;
	buildList[buildID]:SetState(nil);
	local showDetailWin = self.mShowDetailWin;
	if showDetailWin ~= nil then
		showDetailWin:OnRollScroll();
	end
end

function EliteDungeonMainView:OnCloseDetail(data)
	local transEffect = self.mTransEffect;
	if transEffect ~= nil then
		transEffect.gameObject:SetActive(false);
		--self.mGoLeft:SetActive(false);
		self.mIsShowEffect = false;
	end
end

function EliteDungeonMainView:OnClickBuild(buildItemData)
	local model = mGameModelManager.EliteDungeonModel;
	if buildItemData.data.mID == model.mSelectBuildID then
		return;
	end
	local transform = buildItemData.transform;
	if transform ~= nil then
		local deviceWidth = mUIManager:GetDeviceWidth();
		local xPos = -(transform.localPosition.x + (deviceWidth/6));
		if xPos < -((MAPWIDTH - deviceWidth)/2) then
			xPos = -((MAPWIDTH - deviceWidth)/2) + 1;
		end
		if xPos > (MAPWIDTH - deviceWidth)/2 then
			xPos = (MAPWIDTH - deviceWidth)/2 - 1;
		end
		self:RollMap(xPos);

		local transEffect = self.mTransEffect;
		transEffect.gameObject:SetActive(true);

		mGameObjectUtil:SetParent(transEffect, transform);
		self.mIsShowEffect = true;
	else
		self.mBgTransform.anchoredPosition = Vector2.zero;
	end

	local isNeedShowDialog = self:CheckIsNeedShowDialog(buildItemData.data.mID);
	if isNeedShowDialog then
		self.mShowDetailWin:OnClickClose(true);
		--self.mGoLeft:SetActive(false);
		self:CheckAwardIsClose(buildItemData.data.mID);
		local CallBack = function()
			self:OnShowDetail(buildItemData.data);
		end
		local configChapter = mConfigSysdungeon_chapter[buildItemData.data.mID];
		local configStory = mConfigSysstory[configChapter.story_region[1]];
		local data = {sys_story = configStory,callBack = CallBack};
		mUIManager:HandleUI(mViewEnum.StoryDialogView, 1, data);
	else
		self:OnShowDetail(buildItemData.data);
	end
end

function EliteDungeonMainView:OnShowDetail(data)
	local showDetailWin = self.mShowDetailWin;
	showDetailWin:OnSetInfo(data);
	self:CheckAwardIsClose(data.mID);

	local configChapter = mConfigSysdungeon_chapter[data.mID];
	--self.mGoLeft:SetActive(true);
	self.mTextDesc1.text = configChapter.desc2;
	self.mTextDesc2.text = configChapter.desc1;
end

function EliteDungeonMainView:CheckIsNeedShowDialog(chapter_id)
	local model = mGameModelManager.EliteDungeonModel;
	local nowDungeonID = model.mNowDungeonID;
	local firstID = mConfigSysdungeon_chapter[chapter_id].start_id;
	return nowDungeonID == firstID;
end

function EliteDungeonMainView:RollMap(xPos)
	local transMap = self:Find("Scroll/main_bg");
	local mapXpos = transMap.localPosition.x;
	local journey = math.abs(xPos - mapXpos);
	local second1,second2 = math.modf(journey/ROLL_SPEED);
	mDGTween.DOLocalMoveX(transMap, xPos, second1+second2,true);
end

function EliteDungeonMainView:OnViewShow(logicParams)
    local model = mGameModelManager.EliteDungeonModel;
    if not model.mIsEverGetDungeonID then
    	model.mIsEverGetDungeonID = true;
    	mEliteDungeonController:GetEliteDungeonList();
    end
    self.mTransEffect.gameObject:SetActive(self.mIsShowEffect);
    --self.mGoLeft:SetActive(self.mIsShowEffect);
    self:OnChangeArrowPos();
end

function EliteDungeonMainView:OnViewHide(logicParams)
    self.mTransEffect.gameObject:SetActive(false);
    self.mTransArrow.gameObject:SetActive(false);
end

return EliteDungeonMainView;