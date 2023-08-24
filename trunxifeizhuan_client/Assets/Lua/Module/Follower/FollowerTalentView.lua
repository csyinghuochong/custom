local mLuaClass = require "Core/LuaClass"
local TalentEquipView = require "Module/Talent/TalentEquipView"
local TalentController = require "Module/Talent/TalentController"
local TalentTypeListView = require "Module/Talent/TalentTypeListView"
local TalentBagMiniView = require "Module/Talent/TalentBagMiniView"
local TalentSellSingelView = require "Module/Talent/TalentSellSingelView"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerTalentSuitView = require "Module/Follower/FollowerTalentSuitView";
local FollowerTalentPopView = require "Module/Follower/FollowerTalentPopView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local FollowerTalentView = mLuaClass("FollowerTalentView",mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mButonText1 = mLanguageUtil.follower_talent_pop_button1;
local mButonText2 = mLanguageUtil.follower_talent_pop_button2;
local mButonText3 = mLanguageUtil.follower_talent_pop_button3;
local mButonText4 = mLanguageUtil.follower_talent_pop_button4;
local mButonText5 = mLanguageUtil.follower_talent_pop_button5;
local mString = string;
local mSuper;

function FollowerTalentView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_talent_view",
	};
end

function FollowerTalentView:Init( )
	self:InitSubView( );
	self:AddListener( );
end

function FollowerTalentView:InitSubView(  )
	self.mTextTalentName = self:FindComponent( 'bag_view/Text_1', 'Text' );
	self.mFollowerItem = mFollowerItemView.LuaNew ( self:Find( 'retinue_item' ).gameObject );

	self.mTalentEquipView = TalentEquipView.LuaNew ( self:Find( 'equip_view' ).gameObject );

	self.mTalentTypeView = TalentTypeListView.LuaNew( self:Find('type_view').gameObject, 1 );
	self.mTalentTypeView:ShowView( );

	self.mTanlentBagView = TalentBagMiniView.LuaNew( self:Find( 'bag_view' ).gameObject, require "Module/Talent/TalentItemGoodsView" );
	self.mTanlentBagView:HideView( );

	local trans = self:Find("type_view/buttonView");
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);

	self.mTalentSuitView = FollowerTalentSuitView.LuaNew( );
	self.mTalentSuitView.mGoParent = self:Find( 'suit_view' );

	local strengthBack = function ( data )
		self:OnClickStrenghtTalent( data );
	end
	local removeBack = function ( data )
		self:OnClickRemoveTalent( data );
	end
	local wearBack = function ( data )
		self:OnClickWearTalent( data );
	end
	local sellBack = function ( data )
		self:OnClickSellTalent( data );
	end
	local HideView1 = function()
		self:OnHideBaseView1();
	end
	local HideView2 = function()
		self:OnHideBaseView2();
	end

	local viewParams = { };
	viewParams[1] = { parent = self:Find( 'base_view1' ), text1 = mButonText3, text2 = mButonText1, 
						callback1 = strengthBack, callback2 = removeBack, callback3 = HideView1 };
	viewParams[2] = {  parent = self:Find( 'base_view2' ), text1 = mButonText3, text2 = mButonText2, 
						callback1 = strengthBack, callback2 = wearBack, callback3 = HideView2 };
	viewParams[3] = {  parent = self:Find( 'base_view2' ), text1 = mButonText4, text2 = mButonText5, 
						callback1 = HideView2,    callback2 = sellBack,   callback3 = HideView2 };
	self.mViewParas = viewParams;

	self.mTalentBaseView1 = FollowerTalentPopView.LuaNew(  );
	self.mTalentBaseView2 = FollowerTalentPopView.LuaNew(  );

	self:FindAndAddClickListener("bag_view/button_return", function() self:OnRetrunTypeTalent() end);

	self:OnClickToggle( 1 );
end

function FollowerTalentView:AddListener(  )
	local mEventEnum = self.mEventEnum;

	self:RegisterEventListener(mEventEnum.ON_WEAR_TALENT, function( vo )
		self:OnWearEquip( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_REMOVE_TALENT, function( pos )
     	self:OnRemoveEquip( pos );
    end, true);

    self:RegisterEventListener(mEventEnum.ON_SELECT_TYPE_TALENT, function(vo)
		self:OnSelectTalentType(vo);
	end, true);
end

function FollowerTalentView:OnSelectTalentType( data )
	self.mTalentTypeView:HideView( );
	self.mTanlentBagView:ShowView( data );
	self.mTextTalentName.text = data:GetTypeName( );
end

function FollowerTalentView:OnRetrunTypeTalent(  )
	self.mTalentTypeView:ShowView( );
	self.mTanlentBagView:HideView( );
end

function FollowerTalentView:OnClickToggle( index )
	self.mTalentTypeView:ForceShowView( index );
end

--随从界面选中背包的才艺
function FollowerTalentView:OnFollowerSelectTalentItem( data )
	local view2 = self.mTalentBaseView2;
	local viewParams = self.mViewParas;
	if data:GetGoodsType() == 1 then
		view2:SetExternalParams( viewParams[ 2 ] );
	else
		view2:SetExternalParams( viewParams[ 3 ] );
	end
	view2:ForceShowView( data );
	self.mTanlentBagView:OnSelectTalentItem( data );
end

--随从界面选中穿戴的才艺1
function FollowerTalentView:OnFollowerSelectEquipItem( data )
	local view1 = self.mTalentBaseView1;
	view1:SetExternalParams( self.mViewParas[ 1 ] );
	view1:ForceShowView( data );
	self.mTalentEquipView:OnSelectEquipItem( data );
end

--才艺界面切换随从
function FollowerTalentView:OnTalentClickFollowerItem( data, talent )
	self.mData = data;
	self.mFollowerItem:ExternalUpdateData( data );
	self.mTalentEquipView:OnUpdateFollower( data );
	self.mTalentEquipView:OnSelectEquipItem( talent );
	self.mTanlentBagView:UnSelectedView( );
end

--才艺界面选中背包的才艺
function FollowerTalentView:OnTalentSelectTalentItem( data )
	self.mTalentEquipView:SetSelected( nil );
	self.mTanlentBagView:OnSelectTalentItem( data );
end

--才艺界面选中穿戴的才艺
function FollowerTalentView:OnTalentSelectEquipItem( data )
	self.mTalentEquipView:OnSelectEquipItem( data );
	self.mTanlentBagView:UnSelectedView( );
end

function FollowerTalentView:OnTalentStrengthEquip( data )
	self.mTalentEquipView:OnUpdateTalent( data );
end

function FollowerTalentView:ResetTalentSubView( talentVO )
	self.mTalentSuitView:HideView( );
	self.mTalentBaseView1:HideView( );
	self.mTalentBaseView2:HideView( );

	if talentVO:GetFollowerUID() == 0 then
		self.mTalentEquipView:SetSelected( nil );
	else
		self.mTanlentBagView:UnSelectedView( );
	end
end

--穿戴装备
function FollowerTalentView:OnWearEquip( data )
	self.mTalentEquipView:OnWearEquip( data );
	self.mTalentTypeView:UpdateTypeList( );
	self:UpdateSuitList( self.mData );
end

function FollowerTalentView:OnRemoveEquip( pos )
	self.mTalentEquipView:OnRemoveEquip( pos );
	self.mTalentTypeView:UpdateTypeList( );
	self:UpdateSuitList( self.mData );
end

function FollowerTalentView:OnClickRemoveTalent( talent_vo )
	self:OnHideBaseView1( );
	TalentController:SendTalentRemove( self.mData.mUID, talent_vo:GetPosition() );
end

function FollowerTalentView:OnClickWearTalent( talent_vo )
	self:OnHideBaseView2( );
	TalentController:SendTalentWear( self.mData.mUID, talent_vo:GetPosition(), talent_vo.mID);
end

function FollowerTalentView:OnClickSellTalent( talent_vo )
	self:OnHideBaseView2( );
	TalentSellSingelView:SendSellSingelTalent( talent_vo );
end

function FollowerTalentView:OnClickStrenghtTalent( talent_vo )
	self:Dispatch(self.mEventEnum.ON_CLICK_STRENGTH_TALENT, talent_vo);
end

function FollowerTalentView:OnHideBaseView1(  )
	self.mTalentBaseView1:HideView( );
end

function FollowerTalentView:OnHideBaseView2(  )
	self.mTalentBaseView2:HideView( );
end

function FollowerTalentView:OnUpdateUI(data)
	if data==nil then
		return;
	end
	self.mData = data;
	self:UpdateSuitList(data);
	self.mFollowerItem:ExternalUpdateData( data );
	self.mTalentEquipView:OnUpdateFollower( data );
	self.mTalentBaseView1:HideView( );
	self.mTalentTypeView:UpdateTypeList( );
end

function FollowerTalentView:UpdateSuitList( data )
	local suitVOList = data:GetSuitList( );
	local suitView = self.mTalentSuitView;
	if #suitVOList > 0 then
		suitView:ForceShowView( data );
	else
		suitView:HideView( );
	end
end

function FollowerTalentView:OnViewHide( )
	self.mTalentBaseView1:HideView( );
	self.mTalentBaseView2:HideView( );
end

function FollowerTalentView:Dispose()
	self.mTalentTypeView:CloseView( );
	self.mTalentEquipView:CloseView( );
	self.mTanlentBagView:CloseView( );
	self.mTalentSuitView:CloseView( );
	self.mTalentBaseView1:CloseView( );
	self.mTalentBaseView2:CloseView( );
end

return FollowerTalentView;