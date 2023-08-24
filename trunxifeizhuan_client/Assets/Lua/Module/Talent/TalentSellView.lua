local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local TalentBagMiniView = require "Module/Talent/TalentBagMiniView"
local TalentTypeListView = require "Module/Talent/TalentTypeListView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local TalentSellView = mLuaClass("TalentSellView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;
local mTable = table;

function TalentSellView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_sell_view",
	};
end

function TalentSellView:Init()
	self:InitSubView( );
	self:AddListener( );
end

function TalentSellView:InitSubView(  )
	self.mTalentTypeView = TalentTypeListView.LuaNew( self:Find('type_view').gameObject, 1 );
	self.mTalentTypeView:HideView( );	
	
	self.mTanlentBagView = TalentBagMiniView.LuaNew( self:Find( 'bag_view' ).gameObject, require "Module/Talent/TalentItemSellView" );
	self.mTanlentBagView:HideView( );

	local trans = self:Find("buttonView");
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);
    self.mToggleGroup:SetCanAlwaysReturn( true );

    local btn_1 = self:Find( 'bag_view/Button_1' ).gameObject;
    local btn_2 = self:Find( 'bag_view/Button_2' ).gameObject;
    local btn_3 = self:Find( 'bag_view/Button_3' ).gameObject;
    self:AddBtnClickListener(btn_1, function() self:OnClickBatchButton() end);
    self:AddBtnClickListener(btn_2, function() self:OnClickCancelSelect() end);
    self:AddBtnClickListener(btn_3, function() self:OnClickSellSelect() end);
    self.mButton1 = btn_1;
    self.mButton2 = btn_2;
    self.mButton3 = btn_3;
    self.mSellList = { };
end

function TalentSellView:AddListener(  )
	local mEventEnum = self.mEventEnum;

	self:RegisterEventListener(mEventEnum.ON_SELECT_SELL_ITEM, function( vo )
		self:OnSelectTalentItem( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_TALENT_UPDATE, function( )
		self:OnRecvTalentUpdate( );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_TYPE_TALENT, function(vo)
		self:OnSelectTalentType(vo);
	end, true);
end

--界面打开
function TalentSellView:OnUpdateUI(data)
	self:ResetUI( );
	self:SetSelectToggle( 1 );
end

function TalentSellView:ResetUI(  )
	self:OnClickCancelSelect( );
	self:SetBatchSellState( false );
end

function TalentSellView:SetSelectToggle( index )
	self.mTanlentBagView:HideView( );
	self.mTalentTypeView:ForceShowView( index );
	self.mToggleGroup:OnClickToggleButton( index, false );
end

function TalentSellView:Dispose(  )
	self.mTanlentBagView:CloseView( );
	self.mTalentTypeView:CloseView( );
end

function TalentSellView:OnRecvTalentUpdate( )
	self.mSellList = { };
end

--切换标签
function TalentSellView:OnClickToggle( index )
	self:ResetUI( );
	self:SetSelectToggle( index );
end

function TalentSellView:OnClickBatchButton(  )
	self:SetBatchSellState( true );
end

function TalentSellView:SetBatchSellState( state )
	self.mBatchSell = state;
	self.mButton1:SetActive( not state );
	self.mButton2:SetActive( state );
	self.mButton3:SetActive( state );
	self.mTanlentBagView:UnSelectedView( );
end

function TalentSellView:OnClickCancelSelect(  )
	local sellList = self.mSellList;
	local bagView  = self.mTanlentBagView;
	for k , v in pairs( sellList ) do
		bagView:OnClickCancelSelect( v:GetUID() );
	end
	self.mSellList = { };
end

function TalentSellView:OnClickSellSelect(  )
	local sellList = self.mSellList;
	if #sellList > 0 then
		mUIManager:HandleUI(mViewEnum.TalentSellBatchView, 1,  sellList );
	else
		mCommonTipsView.Show( mLanguageUtil.talent_batch_sell_tip1 );
	end
end

function TalentSellView:OnSelectTalentType(data)
	self.mTalentTypeView:HideView( );
	self.mTanlentBagView:ShowView( data );
end

function TalentSellView:OnSelectTalentItem(data)
	local bagView = self.mTanlentBagView;
	local uid = data:GetUID();
	if self.mBatchSell then
		local have = false;
		local sellList = self.mSellList;
		for k, v in pairs( sellList ) do
			if data == v then
				have = true;
				mTable.remove( sellList, k );
				break;
			end
		end

		if have then
			bagView:OnClickCancelSelect( uid );
		else
			mTable.insert( sellList, data );
			bagView:ShowSelectedFlag( uid );
		end
	else
		mUIManager:HandleUI(mViewEnum.TalentSellSingelView, 1, data);
		bagView:SetViewSelectedByKey( uid );
	end 
end

return TalentSellView;