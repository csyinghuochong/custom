local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mDungeonController = require "Module/Dungeon/DungeonController"
local DungeonReviewEndView = mLuaClass("DungeonReviewEndView", mBaseWindow);
local mVector2 = Vector2;

function DungeonReviewEndView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_story_end_view",
		["ParentLayer"] = mMainLayer1,
	};
end

function DungeonReviewEndView:Init()
	local btn_prev = self:Find( 'button_1').gameObject;
	local btn_next = self:Find( 'button_2' ).gameObject
	self:AddBtnClickListener(btn_prev, function() self:OnClickPrev() end);
	self:AddBtnClickListener(btn_next, function() self:OnClickNext() end);
	self.mButtonNext = btn_next;
	self.mButtonPrev = btn_prev;
	self.mTextName = self:FindComponent( 'Text_1', 'Text' );
	self:FindAndAddClickListener('button_close', function() self:OnClickClose() end);
end

function DungeonReviewEndView:OnClickNext()
	mUIManager:HandleUI(mViewEnum.DungeonReviewStoryView, 1,  self.mLogicParams + 1);
	self:HideView( );
end

function DungeonReviewEndView:OnClickPrev()
	mUIManager:HandleUI(mViewEnum.DungeonReviewStoryView, 1,  self.mLogicParams - 1);
	self:HideView( );
end

function DungeonReviewEndView:OnClickClose()
	mUIManager:HandleUI(mViewEnum.DungeonChapterListView, 1, { turnType = 2 });
	self:HideView( );
end

function DungeonReviewEndView:OnViewShow( logicParams )
	local next_chapter = logicParams + 1;
	local DungeonModel = mGameModelManager.DungeonModel;
	local chapter_vo = DungeonModel:GetChapterVO( next_chapter )
	self.mButtonPrev:SetActive( logicParams ~= DungeonModel.mMinChapterId );
	self.mButtonNext:SetActive( chapter_vo and chapter_vo:IsPass( ) );
	self.mTextName.text = DungeonModel:GetChapterVO(logicParams).mSysVO.chapter_name;
end

return DungeonReviewEndView;