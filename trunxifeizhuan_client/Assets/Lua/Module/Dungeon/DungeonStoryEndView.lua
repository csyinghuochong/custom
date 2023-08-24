local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mDungeonController = require "Module/Dungeon/DungeonController"
local DungeonStoryEndView = mLuaClass("DungeonStoryEndView", mBaseWindow);
local mVector2 = Vector2;

function DungeonStoryEndView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_story_end_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function DungeonStoryEndView:Init()
	local btn_next = self:Find( 'button_2' ).gameObject
	self:AddBtnClickListener(btn_next, function() self:OnClickNext() end);
	self.mButtonNext = btn_next;
	self.mTextName = self:FindComponent( 'Text_1', 'Text' );
	self:FindAndAddClickListener('button_close', function() self:OnClickClose() end);

	local main_bg = self:Find( 'main_bg' ).gameObject;
	local btn_prev = self:Find( 'button_1').gameObject;
	main_bg:SetActive( false );
	btn_prev:SetActive( false );
end

function DungeonStoryEndView:OnClickNext()
	self:HideView( );
	self.mCallBack1( );
end

function DungeonStoryEndView:OnClickClose()
	self:HideView( );
	self.mCallBack2( );
end

function DungeonStoryEndView:OnViewShow( logicParams )
	self.mCallBack1 = logicParams.callBack1;
	self.mCallBack2 = logicParams.callBack2;
	local chapter_id = logicParams.chapter_id;
	local next_chapter = chapter_id + 1;
	local DungeonModel = mGameModelManager.DungeonModel;
	self.mButtonNext:SetActive( chapter_id ~= DungeonModel.mMaxChapterId );
	self.mTextName.text = DungeonModel:GetChapterVO(chapter_id).mSysVO.chapter_name;
end

return DungeonStoryEndView;