local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local TalentBagMiniView = mLuaClass("TalentBagMiniView", mBaseView);
local mSuper = nil;

function TalentBagMiniView:OnLuaNew(go, talengItem)
	self.mTalentItem = talengItem;
	
	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self, go);
end

function TalentBagMiniView:Init()
	
	self:InitSubView(  );
	self:AddListener(  );

end

function TalentBagMiniView:InitSubView(  )
	local parent = self:Find('scrollView/Grid');
	local gridEx = mLayoutController.LuaNew(parent, self.mTalentItem);
	gridEx:SetSelectedViewTop( true );
	self.mGridEx = gridEx;

	local trans = self:Find("buttonView");
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);
end

function TalentBagMiniView:AddListener( )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_TALENT_UPDATE, function( )
		self:OnRecvTalentUpdate( );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_UP_TALENT_SUCCEED, function( vo )
     	self:OnStrengthTalent( vo );
    end, true);
end

function TalentBagMiniView:OnViewShow( vo )
	self.mTalentTypeVO = vo;
	self:ToggelBagView( 1 );
end

function TalentBagMiniView:ToggelBagView( index )
	self.mToggleGroup:OnClickToggleButton( index );
	self:OnClickToggle( index );
end

function TalentBagMiniView:GetSubTypeIndex(  )
	return self.mToggleGroup.mSelectIndex;
end

function TalentBagMiniView:OnSelectTalentItem( vo )
	self:SetViewSelectedByKey( vo:GetUID() );
end

function TalentBagMiniView:OnRecvTalentUpdate( )
	self:OnClickToggle( self:GetSubTypeIndex( ) );
end

function TalentBagMiniView:OnStrengthTalent( vo )
	if vo:GetFollowerUID( ) == 0 then
		self:OnRecvTalentUpdate( );
	end
end

function TalentBagMiniView:OnClickToggle( index )
	local vo = self.mTalentTypeVO;
	self:UpdateTypeList( vo.mGoodsType , vo.mTalentType, index - 1 );
end

function TalentBagMiniView:UpdateTypeList( goods_type, talent_type, pos )
	local data =  mGameModelManager.FollowerModel:GetTalentTableByPos( goods_type, talent_type, pos );
	data:SetDatasDirty();
	self.mGridEx:UpdateDataSource( data );
end

function TalentBagMiniView:OnClickCancelSelect( uid )
	self.mGridEx:GetChild( uid ):ShowSelectedFlag( false );
end

function TalentBagMiniView:ShowSelectedFlag ( uid )
	self.mGridEx:GetChild( uid ):ShowSelectedFlag( true );
end

function TalentBagMiniView:SetViewSelectedByKey( uid )
	self.mGridEx:SetViewSelectedByKey(  uid, true );
end

function TalentBagMiniView:UnSelectedView( )
	self.mGridEx:UnSelectedView( );
end

function TalentBagMiniView:OnViewHide(  )
	self:UnSelectedView( );
end

function TalentBagMiniView:Dispose( )
	self.mGridEx:Dispose();
end

return TalentBagMiniView;