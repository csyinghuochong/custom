local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mSortTable = require "Common/SortTable"
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mGameLuaInterface = GameLuaInterface;
local mDGTween = DG.Tweening.ShortcutExtensions;
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonChatButton = require "Module/CommonUI/CommonChatButton"
local MansionController = require "Module/Mansion/MansionController"
local mConfigsysfunction = require "ConfigFiles/ConfigSysfunction_open"
local mMansionPlantView = require "Module/Mansion/Plant/MansionPlantView"
local mMansionPlayerItemVO = require "Module/Mansion/Main/MansionPlayerItemVO"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local MansionMainSceneView = require "Module/Mansion/Main/MansionMainSceneView"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local MansionNpcModelItem = require "Module/Mansion/NPCEvent/MansionNpcModelItem"
local MansionServantModelView = require "Module/Mansion/Servant/MansionServantModelView"
local MansionMainView = mLuaClass("MansionMainView", mBaseWindow);

function MansionMainView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_main_view",
		["ParentLayer"] = mMansionLayer,
	};
end

function MansionMainView:Init()

	self:AddListeners();
	self:InitSubView();
	self:RegisterFunctionGo();

end

function MansionMainView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_SELF_MANSION_DATA,function(data) self:OnRecvMansionData(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_VISIT_MANSION_DATA,function(data) self:OnRecvMansionData(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_ALTER_MANSION_NAME,function(data) self:UpdateMansionName(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_CAN_VISIT_PLAYER_LIST,function(data) self:OnRecvPlayerList(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_HOUSE_COIN,function(data) self:UpdateMansionMoney(); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_BOOM_COIN,function(data) self:UpdateBoomNumber(); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_CLEAN_UPDATE,function(data) self:UpdateMansionClean( data ); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_SERVANT_HIRE_FIRST,function(data)self:OnRecvServantHire(data)end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_EVENT_UPDATE,function(data)self:OnRecvUpdateNPCEvent(data)end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_EVENT_REWARD,function(data)self:OnRecvNPCEventReward(data)end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_EVENT_DELETE,function(data)self:OnRecvNPCEventDelete(data)end,true);

	self:FindAndAddClickListener("Panel/TopRight/Button_return",function() self:HideView() end);
	self:FindAndAddClickListener('Panel/TopLeft/BaseInfo/Image_head_icon',function() self:OnClickHead() end);
	self:FindAndAddClickListener('Panel/Left/PlayerList/Button_close',function() self:OnClickVisitButton() end);

	self.mButtonVisit1 = self:Find('Panel/Left/PlayerList/Button_visit').gameObject;
	self.mButtonVisit2 = self:Find('Panel/Left/PlayerList/Toggle').gameObject;
	self:AddBtnClickListener(self.mButtonVisit1,function() self:OnClickVisitButton() end);

	self.mButtonGoHome = self:Find('Panel/BottomRight/Button_return').gameObject;
	self:AddBtnClickListener(self.mButtonGoHome,function() self:OnClickReturnHome() end);

	self.mButtonClean = self:Find('Scroll/main_bg/clean').gameObject;
	self:AddBtnClickListener(self.mButtonClean,function() self:OnClickCleanMansion() end);
end

function MansionMainView:InitSubView(  )
	self.mVisitExpand = false;
	self.mVisitListView = self:Find('Panel/Left/PlayerList').transform;

	local goChatButton = self:Find("Panel/TopLeft/InputField_chat").gameObject;
	self.mChatButton = mCommonChatButton.LuaNew(goChatButton);


	local parent = self:Find('Panel/Left/PlayerList/scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mansion/Main/MansionPlayerItemView");
	self.mDataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);

	local callBack = function( index )
		self:OnClickPlayerType(index);
	end
	self.mMainSceneView = MansionMainSceneView.LuaNew(self:Find('Scroll').gameObject);
	self.mToggleGroup = mCommonToggleGroup.LuaNew(self:Find('Panel/Left/PlayerList/Toggle'),callBack,1);
	self.mPlantView = mMansionPlantView.LuaNew( self:Find('Scroll/main_bg/plant').gameObject );
	self.mNpcModelItem = MansionNpcModelItem.LuaNew( self:Find('Scroll/main_bg/npc').gameObject );
	self.mServantModelView = MansionServantModelView.LuaNew(self:Find('Scroll/main_bg/servant').gameObject);

	self.mSlider = self:FindComponent('Panel/TopLeft/BaseInfo/Slider', 'Slider');
	self.mTextMansionName = self:FindComponent('Panel/TopLeft/BaseInfo/Text_name', 'Text');
	self.mTextMansionLevel = self:FindComponent('Panel/TopLeft/BaseInfo/Text_lv', 'Text');
	self.mTextMansionMoney = self:FindComponent('Panel/TopLeft/BaseInfo/Text_money', 'Text');
	self.mTextMansionBoom = self:FindComponent('Panel/TopLeft/BaseInfo/Text_boom', 'Text');
	self.mGameImageHead = self:FindComponent("Panel/TopLeft/BaseInfo/Image_head_icon/head","GameImage");
	self.mSelfFunction = self:Find('Panel/BottomRight/Funciton_open').gameObject;

end

function MansionMainView:Sort( a, b )
	return a.mPlayerID < b.mPlayerID;
end

function MansionMainView:RegisterFunctionGo(  )
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MANSION_RANK,self:FindAndAddClickListenerReturnTrance('Panel/BottomRight/Funciton_open/Button_rank',function() self:OnClickRank() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MANSION_EVENT,self:FindAndAddClickListenerReturnTrance('Panel/BottomRight/Funciton_open/Button_event',function() self:OnClickEvent() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MANSION_BAG,self:FindAndAddClickListenerReturnTrance('Panel/BottomRight/Funciton_open/Button_bag',function() self:OnClickBag() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MANSION_STORE,self:FindAndAddClickListenerReturnTrance('Panel/BottomRight/Funciton_open/Button_store',function() self:OnClickStore() end).gameObject);
end

function MansionMainView:OnViewShow()
	self.mPlantView:ShowView();
	self.mNpcModelItem:ShowView( );
	self.mServantModelView:ShowView( );
	mUIManager:HandleMainSceneViewVisible(0);
	MansionController:SendEnterSelfMansion();
	self:OnClickPlayerType( self.mToggleGroup.mSelectIndex );
end

function MansionMainView:OnViewHide(  )
	self.mPlantView:HideView();
	self.mNpcModelItem:HideView( );
	self.mServantModelView:HideView( );
	mUIManager:HandleMainSceneViewVisible(1);
	MansionController:SendHideMansionView( );
end

--recv data
function MansionMainView:OnRecvMansionData(data)
	self.mData = data;

	self:UpdateBaseInfo( data );
	self:UpdateFunctionButton( data );
	self:UpdateSubView ( data );
	self:UnSelectedView( data );
	self:UpdateMansionClean( data );
	self:UpdateNpcEventView( data );
end

function MansionMainView:UpdateBaseInfo( data )
	self:UpdateHeadIcon( data );
	self:UpdateMansionName( data );
	self:UpdateMansionMoney( data );
end

function MansionMainView:UnSelectedView(  data )
	local isSelf = data:IsSelfMansion();
	if isSelf then
		self.mGridEx:UnSelectedView( );
	end
end

function MansionMainView:UpdateMansionName( data )
	self.mTextMansionName.text = data:GetMansionName();
end

function MansionMainView:UpdateHeadIcon( data )
	self.mGameImageHead:SetSprite(data:GetHeadIcon());
end

function MansionMainView:UpdateBoomNumber( data )
	local data = self.mData;
	self.mSlider.value = data:GetBoomRate();
	self.mTextMansionBoom.text = data:GetBoomRateStr();
	self.mTextMansionLevel.text = data:GetMansionLevel();
end

function MansionMainView:UpdateMansionMoney(  )
	self.mTextMansionMoney.text = self.mData:GetTotalMoney( );
end

function MansionMainView:UpdateFunctionButton( data )
	local isSelf = data:IsSelfMansion();
	self.mButtonGoHome:SetActive(not isSelf);
	self.mSelfFunction:SetActive(isSelf);
end

function MansionMainView:UpdateSubView ( data)
	self.mPlantView:OnRecvMansionData( data );
	self.mMainSceneView:OnRecvMansionData( data );
	self.mServantModelView:OnRecvMansionData( data );
end

function MansionMainView:UpdateNpcEventView( data )
	local npcView = self.mNpcModelItem;
	local selfMansion = data:IsSelfMansion( );
	local event_id = data.mPbData.event_npc_id;
	if selfMansion and event_id ~= 0 then
		npcView:ShowView( );
		npcView:OnUpdateUI( data );
	else
		npcView:HideView( );
	end
end

function MansionMainView:UpdateMansionClean( data )
	self:UpdateBoomNumber( data );
	self.mButtonClean:SetActive( data:CanOperateClean() );
end

function MansionMainView:OnRecvServantHire( data )
	self.mServantModelView:OnRecvServantHire( data );
end

function MansionMainView:OnRecvPlayerList( pbMansionVisitList )
	local dataSource = self.mDataSource;
	dataSource:ClearDatas(true);
	for k, v in ipairs(pbMansionVisitList.list) do
		dataSource:AddOrUpdate(k, mMansionPlayerItemVO.LuaNew(v));
	end
	self.mGridEx:UpdateDataSource(dataSource);
	self.mGridEx:Reset();
end

function MansionMainView:OnRecvUpdateNPCEvent( data )
	self:UpdateNpcEventView( data );
end

function MansionMainView:OnRecvNPCEventReward( data )
	self.mNpcModelItem:HideView( );
end

function MansionMainView:OnRecvNPCEventDelete( data )
	self.mNpcModelItem:HideView( );
end

--click event
function MansionMainView:OnClickRank(  )
	mUIManager:HandleUI(mViewEnum.MansionRankView, 1);
end

function MansionMainView:OnClickEvent(  )
	mUIManager:HandleUI(mViewEnum.MansionEventView, 1);
end

function MansionMainView:OnClickBag(  )
	mUIManager:HandleUI(mViewEnum.MansionBagView, 1);
end

function MansionMainView:OnClickStore(  )
	mUIManager:HandleUI(mViewEnum.MansionStoreView, 1, self.mData);
end

function MansionMainView:OnClickReturnHome()
	MansionController:SendEnterSelfMansion();
end

function MansionMainView:OnClickCleanMansion(  )
	MansionController:SendCleanMansion( );
end

function MansionMainView:OnClickPlayerType( op_type )
	MansionController:RequestPlayerList( op_type );
end

function MansionMainView:OnClickHead(  )
	mUIManager:HandleUI(mViewEnum.MansionBaseInfoView, 1, self.mData);
end

function MansionMainView:OnClickVisitButton( )
	mDGTween.DOLocalMoveX(self.mVisitListView, self.mVisitExpand and -140 or 0, 0.3,true);
	local expand =  not self.mVisitExpand;
	self.mVisitExpand = expand;
	self.mButtonVisit1:SetActive( not expand );
	self.mButtonVisit2:SetActive(  expand );
end

function MansionMainView:Dispose()
	self.mGridEx:Dispose();
	self.mChatButton:CloseView();
	self.mPlantView:CloseView();
	self.mServantModelView:CloseView( );
end

return MansionMainView;