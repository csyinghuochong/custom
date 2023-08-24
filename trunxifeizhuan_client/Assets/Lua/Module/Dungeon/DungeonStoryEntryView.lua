local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local GameTimer = require "Core/Timer/GameTimer"
local StoryNpcView = require "Module/Story/StoryNpcView"
local mGameModelManager = require "Manager/GameModelManager"
local StorySceneView = require "Module/Story/StorySceneView"
local mCameraController = require "Manager/CameraController"
local mDungeonController = require "Module/Dungeon/DungeonController"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local DungeonStoryEntryView = mLuaClass("DungeonStoryEntryView",mQueueWindow);

function DungeonStoryEntryView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_story_entry_view",  
		["ParentLayer"] = mMainLayer,
	};
end

function DungeonStoryEntryView:Init()
	self:InitSubView( );
	self:InitStoryData();
	self:AddListeners( );
end

local mCommonBattleEffect = "ui_peeragelevelsview_levels_panel_item";
function DungeonStoryEntryView:InitSubView(  )
	local loadMapBack = function (  )
		self:PlayBlankAnimator( );
	end
	self.mTextTitle = self:FindComponent( 'Text_title', 'Text' );
	self.mStoryNpcView = StoryNpcView.LuaNew( self:Find('npc_view').gameObject );
    self.mStorySceneView = StorySceneView.LuaNew( self:Find('main_bg').gameObject,  loadMapBack); 
	self:FindAndAddClickListener("Button_return", function() self:ReturnPrevQueueWindow() end);
	
	local btnCombat = self:Find( 'Button_combat' ).gameObject;
	self:AddBtnClickListener(btnCombat, function() self:OnClickCombat() end);
	self.mButtonCombat = btnCombat;
	btnCombat:SetActive( false );
	local ImageBg = self:FindComponent( 'Image_blank' , 'Image' );
	ImageBg.gameObject:SetActive( true );
	self.mImageBlank = ImageBg;

	self.mCallBack1 = function (  )
		self:OnEnterMainScene( );
	end
	self.mCallBack2 = function (  )
		self:ReturnPrevQueueWindow() ;
	end
end

function DungeonStoryEntryView:PlayBlankAnimator(  )
	if self.mMapInit == nil then
		self.mMapInit = true;
		local imageBg = self.mImageBlank;
		imageBg:CrossFadeColor( Color.New( 1, 1, 1 , 0), 0.5, true, true );
		GameTimer.SetTimeout(0.5 , function (  )
			imageBg.gameObject:SetActive( false );
		end );
	end
end

function DungeonStoryEntryView:InitStoryData(  )
	local data = {};
	data.beginBack = function ( data )  self:OnBeginDialog( data ) end;
	data.callBack = function ( data )  self:OnAllDialogEnd( data ) end;
	data.returnBack = function( ) self:OnClickStoryReturn( ) end;
	self.mStoryData = data;
end

function DungeonStoryEntryView:OnClickStoryReturn(  )
	self:ReturnPrevQueueWindow();
end

function DungeonStoryEntryView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_MAIN_STORY_END, function(id) self:OnMainStoryEnd(id); end,true);
	self:RegisterEventListener(mEventEnum.ON_ENTER_MAINSCENE, function() self:OnEnterMainScene(); end,true);
	self:RegisterEventListener(mEventEnum.SCENE_LOADING_HIDE, function()self:OnSceneLoadingHide()end,true);

	self.mSetArrayBack = function ( data )
		self:OnSetArrayBack();
	end
end

function DungeonStoryEntryView:OnSetArrayBack(  )
	mDungeonController:SendChallengeDungeon( self.mDungeonId , 1);
end

function DungeonStoryEntryView:OnClickCombat(  )
	local dataVO = mBattleArrayViewVO.LuaNew();
	dataVO:InitPVETeam(self.mDungeonId, self.mSetArrayBack, 5, 5);
	mUIManager:HandleUI(mViewEnum.BattleArrayView, 1, dataVO);
end

function DungeonStoryEntryView:OnViewShow( logicParams )
	self:OnEnterMainScene( );
end

function DungeonStoryEntryView:OnEnterMainScene(  )
	self:UpdateStory(  );
	self.mStoryNpcView:ShowView( );
end

function DungeonStoryEntryView:OnSceneLoadingHide(  )
	self:OnClickHideView( );
end

--剧情结束
function DungeonStoryEntryView:OnMainStoryEnd( story_id )
	local DungeonModel = mGameModelManager.DungeonModel;
	local dungeon_id =  DungeonModel:GetStoryCombatId( story_id );

	if  dungeon_id ~= 0 then
		self.mStoryId = story_id;
		self.mDungeonId = dungeon_id;
		self:ShowStoryEnd( );
	else
		local new_id = self:GetNewStoryId( story_id );
		local last_chapter = DungeonModel:GetChapterVOByStory( story_id );
		local new_chapter =  DungeonModel:GetChapterVOByStory( new_id );

		if last_chapter ~= new_chapter then
			mUIManager:HandleUI(mViewEnum.DungeonStoryEndView, 1, { chapter_id = last_chapter.mID, callBack1 = self.mCallBack1,callBack2 = self.mCallBack2 });
		else
			self.mStoryId = new_id;
			self:ShowBlankScreenView( );
			self.mGameTimer = GameTimer.HandSetTimeout(0.8, function (  )
				self:InitStoryScene(  );
				self:OpenStoryDialogView( ); 
			end );
		end
	end
	self:UpdateTitleText( );
end

function DungeonStoryEntryView:ResetUI(  )
	self.mButtonCombat:SetActive( false );
end

function DungeonStoryEntryView:GetNewStoryId( story_id )
	return mGameModelManager.DungeonModel:GetNewOpenStoryId( story_id );
end

function DungeonStoryEntryView:ShowBlankScreenView(  )
	mUIManager:HandleUI(mViewEnum.CombatBlankScreenView, 1);
end

--获取最新的剧情
function DungeonStoryEntryView:UpdateStory(  )
	local DungeonModel = mGameModelManager.DungeonModel;
	local last_story = DungeonModel:GetLastPassStory( );
	if DungeonModel:IsAllStoryPass( ) then
		self.mStoryId = last_story;
		self:InitStoryScene( );
		self:ShowStoryEnd( );
		self.mDungeonId = DungeonModel:GetLastPassLevel( );
	elseif last_story ~= 0 and DungeonModel:IsStoryNeedCombat( last_story ) then
		self.mStoryId = last_story;
		self:InitStoryScene( );
		self:ShowStoryEnd( );
		self.mDungeonId = DungeonModel:GetStoryCombatId( last_story );
	else
		self.mStoryId = self:GetNewStoryId( last_story );
		self:InitStoryScene(  );
		self:OpenStoryDialogView( );
	end
	self:UpdateTitleText( );
end

function DungeonStoryEntryView:UpdateTitleText()
	self.mTextTitle.text = mGameModelManager.DungeonModel:GetStoryNameById( self.mStoryId );
end

function DungeonStoryEntryView:ShowStoryEnd(  )
	local npcView = self.mStoryNpcView;
	local npcState = npcView:GetNpcLastState( );
	npcView:ShowLastState( npcState );
	self:UpdateCombatBtn( npcState );
end

function DungeonStoryEntryView:UpdateCombatBtn( npcState )
	local btnCombat = self.mButtonCombat;
	btnCombat:SetActive( true );
	local npc_id = self:GetCombatNpcId( );
	local npc_vo = npcState[ npc_id ];
	local l_transform = btnCombat.transform;
	l_transform.localPosition = Vector3.New( npc_vo.position_x, npc_vo.position_y, 0 );
	local scale = npc_vo.scale / 300;
	scale = math.min( 1.3,  scale);
	l_transform.localScale = Vector3.one * scale;
end

function DungeonStoryEntryView:GetCombatNpcId(  )
	local npc_vo = self:GetStoryVO(  )
	return npc_vo.combat_npc;
end

function DungeonStoryEntryView:GetStoryVO(  )
	local story_id = self.mStoryId;
	local mConfigSysstory = mGameModelManager.DungeonModel.mConfigSysstory;
	local sys_story = mConfigSysstory[ story_id ] ;
	if sys_story == nil then
		print ( '无效的剧情Id:  '.. story_id)
	end
	return sys_story;
end

function DungeonStoryEntryView:ShowStoryAnimator( data )
	if data.animator ==  1 then
	end
end

function DungeonStoryEntryView:InitStoryScene(  )
	local data = self:GetStoryVO();
	self.mStorySceneView:LoadMainBg(data.main_bg);
	self.mStoryNpcView:InitNpcModel( data );
end

function DungeonStoryEntryView:OpenStoryDialogView(  )
	local data  = self.mStoryData;
	data.sys_story = self:GetStoryVO();
	mUIManager:HandleUI(mViewEnum.StoryDialogView, 1, data);
end

function DungeonStoryEntryView:OnBeginDialog( data )
	self.mStoryNpcView:UpdateNpcAction( data );
end

function DungeonStoryEntryView:OnAllDialogEnd( )
	mDungeonController:SendCombatStoryEnd(self.mStoryId);
end

function DungeonStoryEntryView:OnViewHide( logicParams )
	self:ResetUI( );
	self:DisposeTimer( );
	self.mStoryNpcView:HideView( );
end

function DungeonStoryEntryView:DisposeTimer(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Dispose( );
		self.mGameTimer = nil;
	end
end

function DungeonStoryEntryView:Dispose()
	self.mMapInit = nil;
	self.mStorySceneView:DisposeMap();
	self.mStoryNpcView:CloseView( );
end

return DungeonStoryEntryView;