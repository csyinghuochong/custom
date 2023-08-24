local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum";
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local GameTimer = require "Core/Timer/GameTimer"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mDungeonController = require "Module/Dungeon/DungeonController"
local GameCenterOnChild = require "Module/Dungeon/DungeonChapterCenterOn";
local DungeonChapterListView = mLuaClass("DungeonChapterListView", mQueueWindow);

function DungeonChapterListView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_chapter_list_view",
		["ParentLayer"] = mMainLayer,
		["cost"] = {"strength"},
		["ViewSound"] = "ty_0004",
		["ViewSoundStop"] = true,
	};
end

function DungeonChapterListView:Init()
	self:InitSubView( );
	self:AddListeners( );
end

function DungeonChapterListView:InitSubView(  )
	local parent = self:Find('Guide_ChapterList/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Dungeon/DungeonChapterItemView");
	self.mTextSweepCost = self:FindComponent( 'view1/button_1/Text_1', 'Text' );

	local centerBack =  function( go )
		self:OnSelectChapterItem( go )
	end;
	self.mScrollRect = self:Find('Guide_ChapterList').gameObject;
	self.mCenterOnChild = GameCenterOnChild.LuaNew(self.mScrollRect, centerBack);
	
	self:FindAndAddClickListener('view1/button_1',function() self:OnClickSweepButton(); end);
	self:FindAndAddClickListener('view1/button_2',function() self:OnClickWatchButton(); end);
	self:FindAndAddClickListener('view1/button_3',function() self:OnClickStoryReview(); end);
	self:FindAndAddClickListener('view2/button_4',function() self:OnClickReviewButton(); end);
	self:FindAndAddClickListener('view2/button_5',function() self:OnClickMainDungeon(); end);
	self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow(); end);
end

function DungeonChapterListView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_CHAPTER_ITEM,function(data) self:OnClickChapterItem(data); end,true);
end

function DungeonChapterListView:OnViewShow(logicParams)
	if logicParams ~= nil  then
		if logicParams.jumpParams ~= nil then
      	 	local targetChapter = tonumber(logicParams.jumpParams);
       		self:OnClickMainDungeon( targetChapter );
       	else
       		local turnType = logicParams.turnType;
       		if turnType == 2 then
       			self:OnClickStoryReview( );
       		else
       			self:OnClickMainDungeon( );
       		end
       	end
   	else
   		self:OnClickMainDungeon(  );
	end
end

function DungeonChapterListView:OnUpdateButton( o_type )
	local view1 = self:Find( 'view1' ).gameObject;
	local view2 = self:Find( 'view2' ).gameObject;
	view1:SetActive( o_type == 1 );
	view2:SetActive( o_type == 2 );
	self.mOpType = o_type;
end

function DungeonChapterListView:GetMainDungeonListVO()
	local new_index = 1;
	local chapters = mGameModelManager.DungeonModel.mChapterList;
	local data = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);

	for k, v in pairs(chapters) do
		data:AddOrUpdate(k, v);
		local chapter_index = v.mSysVO.chapter_index;
		if v:IsOpen( ) and chapter_index > new_index then
			new_index = chapter_index;
		end
	end

	return data, new_index;
end

function DungeonChapterListView:GetStoryReviewListVO()
	local chapters = mGameModelManager.DungeonModel.mChapterList;
	local data = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);

	for k, v in pairs(chapters) do
		if v:IsPass( ) then
			data:AddOrUpdate(k, v);
		end
	end

	return data, 1;
end

function DungeonChapterListView:OnClickChapterItem(data)
	self:Dispatch(mEventEnum.ON_RUN_NEXT_STEP);
	if self.mOpType == 1 then
		mUIManager:HandleUI(mViewEnum.DungeonLevelListView, 1, {chapter_id = data.mID });
	else
		mUIManager:HandleUI(mViewEnum.DungeonReviewStoryView, 1, data.mID);
	end
end

function DungeonChapterListView:OnClickSweepButton(  )
	local chapter_id = self.mChapterId;
	if mGameModelManager.DungeonModel:GetChapterVO( chapter_id ):IsPass() then
		mDungeonController:SendDungeonSweep( chapter_id );
	else
		mCommonTipsView.Show(mLanguageUtil.dungeon_chapter_no_open);
	end
end

function DungeonChapterListView:OnClickWatchButton(  )
	local vo = mGameModelManager.DungeonModel.mChapterList[ self.mChapterId ];
	local data = { goods = vo.mSysVO.award_show; posX= nil };
	mUIManager:HandleUI(mViewEnum.CommonAwardShowView,1, data);
end

function DungeonChapterListView:OnClickReviewButton(  )
	local chapterId = self.mChapterId;
	if chapterId then
		mUIManager:HandleUI(mViewEnum.DungeonReviewStoryView, 1, chapterId);
	end
end

function DungeonChapterListView:OnSelectChapterItem( go )
	self.mChapterId = tonumber( go.name );
	self.mTextSweepCost.text = mGameModelManager.DungeonModel:GetChapterVO( self.mChapterId ):GetChapterSweepCost( );
end

function DungeonChapterListView:GetTargetChapterIndex( targetChapter )
	return targetChapter and mGameModelManager.DungeonModel:GetChapterVO(targetChapter).mSysVO.chapter_index or nil;
end

function DungeonChapterListView:OnClickMainDungeon( targetChapter )
	self:OnUpdateButton( 1 );

	local data, new_index = self:GetMainDungeonListVO();
	local targetIndex = self:GetTargetChapterIndex( targetChapter );
	local targetIndex = targetIndex and targetIndex or new_index;
	self:UpdateChapterList( data, new_index );
end

function DungeonChapterListView:UpdateChapterList( data, index )
	self.mChapterId = nil;
	local centerOnChild = self.mCenterOnChild;
	centerOnChild:BeginLoad();
	centerOnChild:RemoveUpdate( );
	self.mGridEx:UpdateDataSource(data, function( )
		local number = #data.mSortTable;
		centerOnChild:EndLoad( number );
		if number >= 1 then
			centerOnChild:MoveToItemByIndex( index );
			GameTimer.SetTimeout( 0.05 , function (  )
				centerOnChild:UpdateItemScale(  );
			end);
		end
	end);
end

function DungeonChapterListView:OnClickStoryReview(  )
	self:OnUpdateButton( 2 );

	local data, index = self:GetStoryReviewListVO( );
	self:UpdateChapterList( data, index );
end

function DungeonChapterListView:OnViewHide( )
	self.mChapterId = nil;
	self.mCenterOnChild:RemoveUpdate( );
	mUIManager:HandleUI(mViewEnum.CommonAwardShowView, 0);
end

function DungeonChapterListView:Dispose()
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return DungeonChapterListView;