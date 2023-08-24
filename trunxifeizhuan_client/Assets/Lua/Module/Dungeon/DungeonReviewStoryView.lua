local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum";
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local GameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local mDungeonStoryEntryView = require "Module/Dungeon/DungeonStoryEntryView";
local DungeonReviewStoryView = mLuaClass("DungeonReviewStoryView", mDungeonStoryEntryView);
local GameObject = UnityEngine.GameObject;
local mVector3 = Vector3;
local mSuper = nil;

function DungeonReviewStoryView:Init(  )
	mSuper = self:GetSuper(mDungeonStoryEntryView.LuaClassName);
    mSuper.Init(self);
end

function DungeonReviewStoryView:AddListeners(  )
	
end

function DungeonReviewStoryView:OnViewShow( logicParams )
	local story_region =  mGameModelManager.DungeonModel:GetChapterVO( logicParams ).mSysVO.story_region;
	self.mChapterId = logicParams;
	self.mStoryId =  story_region[ 1 ];
	self.mStroyEndId =  story_region[ 2 ];

	self:InitStoryScene(  );
	self:UpdateTitleText( );
	self:OpenStoryDialogView( );
	self.mStoryNpcView:ShowView( );
end

function DungeonReviewStoryView:UpdateCombatBtn(  )
	
end

function DungeonReviewStoryView:OnClickStoryReturn(  )
	self:OnClickHideView();
	mUIManager:HandleUI(mViewEnum.DungeonChapterListView, 1, { turnType = 2 });
end

function DungeonReviewStoryView:BeginNextStory( )
	self.mStoryId = self.mStoryId + 1;
	self:InitStoryScene(  );
	self:OpenStoryDialogView( );
end

function DungeonReviewStoryView:OnAllDialogEnd( )
	self:ShowStoryEnd( );
	if self.mStoryId < self.mStroyEndId then
		self:ShowBlankScreenView( );
		self.mGameTimer = GameTimer.HandSetTimeout(0.8, function (  )
			self:BeginNextStory( ); 
		end );
	else
		self:OnClickHideView();
		mUIManager:HandleUI(mViewEnum.DungeonReviewEndView, 1, self.mChapterId);
	end
end

return DungeonReviewStoryView;