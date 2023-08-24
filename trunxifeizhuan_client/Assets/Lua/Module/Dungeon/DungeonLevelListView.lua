local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mDungeonController = require "Module/Dungeon/DungeonController"
local DungeonLevelItemView = require "Module/Dungeon/DungeonLevelItemView"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local DungeonLevelListView = mLuaClass("DungeonLevelListView", mQueueWindow);

function DungeonLevelListView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_level_list_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function DungeonLevelListView:Init()
	local levelListView = { }; 

	self.mSetArrayBack = function(  )
		self:OnClickCombat( );
	end
	for i = 1, 7 do
		levelListView[ i ] = DungeonLevelItemView.LuaNew( self:Find( 'item'..i ).gameObject );
	end
	self.mLevelListView = levelListView;

	self.mTextName = self:FindComponent( 'Text_1', 'Text' );
	self.mButtonPrev = self:Find( 'button_1' ).gameObject; 
	self.mButtonNext = self:Find( 'button_2' ).gameObject; 
	self:AddBtnClickListener(self.mButtonPrev, function() self:OnClickPrevChapter(); end);
	self:AddBtnClickListener(self.mButtonNext, function() self:OnClickNextChapter(); end);
	self:FindAndAddClickListener("button_close",function()  self:ReturnPrevQueueWindow(); end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_DUNGEON_ITEM,function(data) self:OnClickTeam(data); end,true);
end

function DungeonLevelListView:OnClickTeam( data )
	self.mDungeonId = data.mID;
	local dataVO = mBattleArrayViewVO.LuaNew();
	dataVO:InitPVETeam(data.mID, self.mSetArrayBack, 5, 5);
	mUIManager:HandleUI(mViewEnum.BattleArrayView, 1, dataVO);
end

function DungeonLevelListView:OnClickCombat(  )
	mDungeonController:SendChallengeDungeon(self.mDungeonId, 2);
end

function DungeonLevelListView:OnViewShow(logicParams)
   if logicParams == nil then
   		return;
   end
   local chapter_id = logicParams.chapter_id;
   local dungeon_id = logicParams.dungeon_id;
  
   local DungeonModel = mGameModelManager.DungeonModel;
   if chapter_id == nil then
   		chapter_id = DungeonModel.mConfigSysdungeon[ dungeon_id ].chapter_id;
   end

   self:UpdateLevelList( chapter_id );
end

function DungeonLevelListView:UpdateLevelList( chapter_id )
 	self.mChapterId = chapter_id;
	local DungeonModel = mGameModelManager.DungeonModel;
   	local chapter_vo = DungeonModel:GetChapterVO( chapter_id ); 
	local levelListView = self.mLevelListView;
	for k, v in pairs(chapter_vo.mDungeonByIndex) do
		levelListView[ k ]:OnUpdateData( v );
	end
	self.mTextName.text = chapter_vo.mSysVO.chapter_name;
	self.mButtonPrev:SetActive( chapter_id ~= DungeonModel.mMinChapterId );
	self.mButtonNext:SetActive( chapter_id ~= DungeonModel.mMaxChapterId );
end

function DungeonLevelListView:OnClickPrevChapter( )
	self:UpdateLevelList( self.mChapterId - 1 );
end

local mLgChapterNoOpenTip = mLanguageUtil.dungeon_chapter_no_open;
function DungeonLevelListView:OnClickNextChapter( )
	local chapter_id = self.mChapterId + 1;
	if mGameModelManager.DungeonModel:GetChapterVO( chapter_id ):IsOpen( ) then
		self:UpdateLevelList( self.mChapterId + 1 );
	else
		mCommonTipsView.Show(mLgChapterNoOpenTip);
	end
end

function DungeonLevelListView:OnViewHide(logicParams)
    
end

function DungeonLevelListView:Dispose( )

end

return DungeonLevelListView;