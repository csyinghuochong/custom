local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseView = require "Core/BaseView"
local mLanguage = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local TalentStudyCostView = mLuaClass("TalentStudyCostView", mBaseView);
local mIpairs = ipairs;
local mPairs = pairs;

function TalentStudyCostView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_study_cost_view",
		["ParentLayer"] = mMainLayer1,
	};
end

function TalentStudyCostView:Init()
	self:SetParent(self.mGoParent);
	local goods_parent = self:Find('scrollView/Grid/');
	self.mGridEx = mLayoutController.LuaNew(goods_parent, require "Module/Talent/TalentStudyCostItem");
	self.mGridEx:SetSelectedViewTop( true );

	local trans = self:Find("buttonView");
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_STUDY_ITEM, function(vo)
   		self:OnClickCostItem(vo);
   	end, true);
end

function TalentStudyCostView:OnViewShow(logicParams)
	self.mData = logicParams.data;
	self.mIndex = logicParams.attriIndex;
	self.mCallBack = logicParams.callBack;
	self:OnClickToggle( 1 );
	self.mToggleGroup:OnClickToggleButton( 1 );
end

function TalentStudyCostView:UpdateSelectAttri( index  )
	self.mIndex = index;
	self:OnClickToggle( self.mToggleGroup.mSelectIndex );
end

function TalentStudyCostView:OnClickToggle( index )
	self.mGridEx:UpdateDataSource( self:GetDataSource( index ) );
end

function TalentStudyCostView:OnStudyTalent( data )
	self.mData = data;
	self:OnClickToggle( self.mToggleGroup.mSelectIndex );
end

-- 1 心得 2 秘诀
function TalentStudyCostView:GetDataSource(  goods_type )
	local talentData = self.mData;
	local selectAttr = talentData:GetAdditionAttri()[ self.mIndex ];
	
	local followerModel = mGameModelManager.FollowerModel;
	local talent_type = talentData:GetTalentType( );
	local dataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	if goods_type == 1 then
		if talentData:IsCanStudyXinDeAttri( selectAttr.key ) then
			local talentTable = followerModel:GetTalentTable( 2, talent_type );
			for k, v in pairs ( talentTable.mSortTable ) do
				if v:IsCanStudyXinDe( selectAttr ) then
					dataSource:AddOrUpdate( v:GetUID(), v );
				end 
			end
		end
	else
	
		if talentData:IsCanStudyMiJueAttri( selectAttr.key ) then
			local talentTable = followerModel:GetTalentTable( 3, talent_type );
			for k, v in pairs ( talentTable.mSortTable ) do
				if v:IsCanStudyMiJue( selectAttr, talentData ) then
					dataSource:AddOrUpdate( v:GetUID(), v );
				end
			end
		end
 	end

	return dataSource;
end

function TalentStudyCostView:Sort(a, b)
	local aId = a.mID;
	local bId = b.mID;
	return aId < bId;
end

function TalentStudyCostView:OnClickCostItem( data )
	local talentData = self.mData;
	local goodsType = data:GetGoodsType( );
	if goodsType == 3 and talentData:GetLevel( ) < 15 then
		mCommonTipsView.Show( mLanguage.talent_study_tip3 );
	else
		self.mCallBack( data );
		self.mGridEx:SetViewSelectedByKey( data:GetUID(), true);
	end
end

function TalentStudyCostView:OnViewHide(  )
	self.mGridEx:UnSelectedView( );
end

function TalentStudyCostView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return TalentStudyCostView;