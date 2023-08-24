local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local mLanguageUtil = require "Utils/LanguageUtil"
local mAlertView = require "Module/CommonUI/AlertBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local GameCenterOnChild = require "Module/CommonUI/GameCenterOnChild";
local mMansionServantHeadItemView = require "Module/Mansion/Servant/MansionServantHeadItemView"
local MansionServantView = mLuaClass("MansionServantView",mQueueWindow);

function MansionServantView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_servant_view",
		["ParentLayer"] = mFollowerSelectLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function MansionServantView:Init()
	self:InitSubView(  );
	self:AddListeners( );
end

function MansionServantView:InitSubView(  )
	self.mSubViewList = {};

	self.mServantItem = mMansionServantHeadItemView.LuaNew( self:Find('servant_item').gameObject );

	local centerBack =  function( go )
		self:OnSelectServantItem( go )
	end;
	self.mScrollRect = self:Find('ScrollView').gameObject;
	self.mCenterOnChild = GameCenterOnChild.LuaNew(self.mScrollRect, centerBack);

	self.mDialogBox = self:Find( 'dialogBox' ).gameObject;
	self.mTextWord = self:FindComponent( 'dialogBox/Tips', 'Text' );
	self.mDialogBg = self:FindComponent( 'dialogBox/Bg', 'RectTransform' );
	self.mDialogBgWidth = self.mDialogBg.sizeDelta.x;

	local parent = self:Find('ScrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mansion/Servant/MansionServantItem",true);

	self:FindAndAddClickListener("Button_close",function() self:OnClickClose(); end);

	local btn_left =  self:Find('Button_left').gameObject
	local btn_right = self:Find('Button_right').gameObject
	self.mUIGray1 = mUIGray.LuaNew():InitGoGraphic( btn_left );
	self.mUIGray2 = mUIGray.LuaNew():InitGoGraphic( btn_right );
	self:AddBtnClickListener(btn_left, function() self:OnClickPrev() end);
	self:AddBtnClickListener(btn_right, function() self:OnClickNext() end);
end

local mLgPayoff = mLanguageUtil.mansion_servant_payoff;
function MansionServantView:OnClickClose( )
	local clickCloseBack = function ( )
		self:ReturnPrevQueueWindow();
	end
	local data = self.mCurrentData;
	if  not data:IsNotHire() and  data:IsStopWork() then
		mAlertView.Show({title=nil, desc1=mLgPayoff, btnName= nil,CallBack = nil, CancelCallBack = clickCloseBack });
	else
		clickCloseBack( );
	end
end

function MansionServantView:OnClickNext()
	self.mCenterOnChild:MoveToNextPage();
end

function MansionServantView:OnClickPrev()
	self.mCenterOnChild:MoveToPrevPage();
end

function MansionServantView:AddListeners(  )
	local mEvent = self.mEventEnum;
	
	self:RegisterEventListener(mEvent.ON_RECV_SERVANT_HIRE_FIRST,function(data)self:OnRecvServantHire(data)end,true);
	self:RegisterEventListener(mEvent.ON_RECV_SERVANT_ALTER_NAME,function(data)self:OnRecvServantAlterName(data)end,true);
	self:RegisterEventListener(mEvent.ON_RECV_SERVANT_AWARD_MONEY,function(data)self:OnRecvServantAwardMoney(data)end,true);
	self:RegisterEventListener(mEvent.ON_RECV_SERVANT_PAYOFF_MONEY,function(data)self:OnRecvServantPayoffMoney(data)end,true);
end

function MansionServantView:OnSelectServantItem( go )
	local name = tonumber(go.name);
	self:OnUpdateSubView(  self.mData.mServantList.mSortTable[name] );
end

function MansionServantView:OnUpdateSubView( data )
	local view = self.mCurrentSubView;
	if view ~= nil then
		view:HideView();
	end
	
	local viewList = self.mSubViewList;
	local viewVO = data:GetCurrentView();
	local viewName = viewVO.cls;
	local view = viewList[viewName];
	if view == nil then
		local go = self:Find(viewVO.path).gameObject;
		view = require('Module/Mansion/Servant/'..viewName).LuaNew(go);
		viewList[viewName] = view;
	end
	view:ShowView(  );
	view:OnUpdateData( data );
	self.mCurrentData = data;
	self.mCurrentSubView = view;
	self:UpdateButtonItem ( data );
	self.mServantItem:UpdateUI( data );
	----self:UpdateServantWord( data );
end

function MansionServantView:UpdateButtonItem( data )
	local id = data.mID;
	self.mUIGray1:SetGray( id == 1 );
	self.mUIGray2:SetGray( id == 3 );
end

function MansionServantView:OnRecvServantHire( data )
	self:OnUpdateSubView( data );
end

function MansionServantView:OnRecvServantAlterName( data )
	self:OnUpdateSubView( data );
end

function MansionServantView:OnRecvServantAwardMoney( data )
	self.mCurrentSubView:OnUpdateData( data );
	self:ShowServantWord( mLanguageUtil.mansion_servant_word_2);
	mCommonTipsView.Show( data:GetAwardExp( ) );
end

function MansionServantView:OnRecvServantPayoffMoney( data )
	self.mCurrentSubView:OnUpdateData( data );
	self:ShowServantWord( mLanguageUtil.mansion_servant_word_3);
end

function MansionServantView:UpdateServantWord( data )
	if data:IsNotHire( ) then
		self:ShowServantWord( mLanguageUtil.mansion_servant_word_1);
	elseif data:IsStopWork( ) then
		self:ShowServantWord( mLanguageUtil.mansion_servant_word_4);
	else
		self:ShowServantWord( mLanguageUtil.mansion_servant_word_5);
	end
end

function MansionServantView:ShowServantWord( word )
	self:DisposeTimer( );

	local dialogBox = self.mDialogBox;
	dialogBox:SetActive( true );
	self.mTextWord.text  = word;
	self.mDialogBg.sizeDelta = Vector2.New(self.mDialogBgWidth, self.mTextWord.preferredHeight + 44); 
	self.mGameTimer = mGameTimer.SetTimeout(1, function() dialogBox:SetActive( false ); end, true, true);
end

function MansionServantView:DisposeTimer(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Dispose( );
		self.mGameTimer = nil;
	end
end

function MansionServantView:OnViewShow( data )
	self.mData = data;
	local data_source = data.mServantList;
	self.mCenterOnChild:BeginLoad()
	self.mGridEx:UpdateDataSource(data_source, function( )
		self.mCenterOnChild:EndLoad();
		local selectId = data.mSelectServantID;
		if  selectId ~= nil then
			data.mSelectServantID = nil;
		else
			selectId = 1;
		end
		self.mCenterOnChild:MoveToItemByIndex( selectId );
	end);
end

function MansionServantView:OnViewHide()
	self.mGridEx:ToggleAllView( false );
	self:DisposeTimer( );
end

function MansionServantView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
	self.mCurrentSubView = nil;
end

return MansionServantView;