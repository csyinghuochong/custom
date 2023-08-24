local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mLanguage = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local TalentController = require "Module/Talent/TalentController"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentStudyCostView = require "Module/Talent/TalentStudyCostView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local TalentStudyView = mLuaClass("TalentStudyView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function TalentStudyView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_study_view",
	};
end

function TalentStudyView:Init()
	local trans = self:Find("buttonView");
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans, function(index)self:OnClickToggle(index);end );

    local toggle_list = { };
    local change_list = { };
    local attri_list = {};
    for i = 1, 5 do
    	toggle_list[ i ] = self:Find( 'buttonView/Button'..i ).gameObject;
    	change_list[ i ] = self:Find( 'change/'..i ).gameObject;
    	attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format('attri%d', i)).gameObject);
    end
    self.mToggleList = toggle_list;
    self.mChangeList = change_list;
  	self.mAttriList = attri_list;
	self.mMainAttri = TalentAttributeItem.LuaNew(self:Find( 'base_attri' ).gameObject);

	self.mTalentItem1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );
	self.mTalentItem2 = TalentItemBaseView.LuaNew( self:Find('talent_2').gameObject );
	self.mTalentItem2:HideView( );
	self.mSelectStuduItem = function( vo )
		self:OnClickCostItem(vo);
	end

	self.mShowCostView = false;
	self.mMainBg = self:Find( 'Image_3' ).gameObject;
	local costView = TalentStudyCostView.LuaNew( );
	costView.mGoParent = self:Find('study_cost_view');
	self.mStudyCostView = costView;

	self:FindAndAddClickListener('button_add',function() self:OnClickCostView() end);
	self:FindAndAddClickListener('Button_1', function() self:OnClickButtonStudy() end, nil , 0.3);

	local mEventEnum = self.mEventEnum;
   	self:RegisterEventListener(mEventEnum.ON_RECV_STUDY_TALENT, function( vo )
     	self:OnStudyTalent( vo );
    end, true);
end

function TalentStudyView:OnClickToggle( index  )
	self:ResetCostData(  );

	if self.mShowCostView then
		self.mStudyCostView:UpdateSelectAttri( index  );
	end
end

function TalentStudyView:OnClickCostView(  )
	local data = self.mData;
	local selectIndex = self:GetSelectToggle( );
	if selectIndex == nil then
		mCommonTipsView.Show( mLanguage.talent_study_tip1 );
	else
		local show = self.mShowCostView;
		local view = self.mStudyCostView;
		if show then
			view:HideView( );
		else
			view:ForceShowView( { attriIndex = selectIndex, data = self.mData, callBack = self.mSelectStuduItem } );
		end
		show = not show ;
		self.mShowCostView = show;
		self.mMainBg:SetActive( show );
	end
end

function TalentStudyView:OnStudyTalent( data )
	self:ResetCostData(  );
	self:ShowAttribute(data);
	self.mStudyCostView:OnStudyTalent( data );
end

function TalentStudyView:ResetCostView( )
	self.mShowCostView = false;
	self.mMainBg:SetActive( false );
	self.mStudyCostView:HideView( );
end

function TalentStudyView:ResetCostData(  )
	self.mCostData = nil;
	self.mTalentItem2:HideView( );
end

function TalentStudyView:OnClickButtonStudy(  )
	local data = self.mData;
	local costData = self.mCostData;
	local selectIndex = self:GetSelectToggle( );
	if costData then
		TalentController:SendTalentStudy( data:GetFollowerUID(), data:GetUID(), selectIndex, costData:GetUID() );
	else
		mCommonTipsView.Show( mLanguage.talent_study_tip2 );
	end
end

function TalentStudyView:OnUpdateUI(data)
	if data == nil then
		return;
	end
	self.mData = data;
	self:ResetCostData(  );
	self:ResetCostView(  );
	self:UpdateSubView(data);
	self:ShowAttribute(data);
	self:ResetSelectToggle();
end

function TalentStudyView:OnViewHide(  )
	self.mStudyCostView:HideView( );
end

function TalentStudyView:Dispose(  )
	self.mStudyCostView:CloseView( );
end

function TalentStudyView:ResetSelectToggle( )
	self.mToggleGroup:CancelCurrentSelect(  );
end

function TalentStudyView:GetSelectToggle( )
	return self.mToggleGroup.mSelectIndex;
end

function TalentStudyView:UpdateSubView( data )
	self.mTalentItem1:ExternalUpdate(data);
end

--有一条属性用
function TalentStudyView:ShowAttribute( data )
	local totalAtti = data:GetAdditionAttri();
	local attriList = self.mAttriList;
	local toggleList = self.mToggleList;
	local changeList = self.mChangeList;
	for k, v in pairs(attriList) do
		local vo = totalAtti[ k ];
		local toggle = toggleList[k];
		local change = changeList[k]
		if vo then
			v:ShowView( );
			toggle:SetActive( true );
			v:UpdateUI(vo.key, vo.value);
			change:SetActive( vo.changed == 1 );
		else
			v:HideView( );
			toggle:SetActive( false );
			change:SetActive( false );
		end
	end

	local maiAttri = data:GetMainAttri( );
	self.mMainAttri:UpdateUI( maiAttri.key, maiAttri.value );
end

function TalentStudyView:OnClickCostItem ( data )
	self.mCostData = data;
	self.mTalentItem2:ShowView( );
	self.mTalentItem2:ExternalUpdate( data );
end

return TalentStudyView;