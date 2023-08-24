local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteController = require "Module/Promote/PromoteController"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local mDianfenggongdouController = require "Module/Dianfenggongdou/DianfenggongdouController"
local PromoteTopButtonView = mLuaClass("PromoteTopButtonView",mBaseView);
local mSuper = nil;

function PromoteTopButtonView:OnLuaNew( go , view_type )
	self.mViewType = view_type;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function PromoteTopButtonView:Init()
	local btnRule = self:Find( 'Button_rule' ).gameObject;
	local btnRank = self:Find( 'Button_rank' ).gameObject;
	local btnTeam = self:Find( 'Button_team' ).gameObject;
	local btnRecord =self:Find( 'Button_record' ).gameObject;

	self:AddBtnClickListener(btnRule, function() self:OnClickRuleButton() end);
	self:AddBtnClickListener(btnRank, function() self:OnClickRankButton() end, nil, 0.5);
	self:AddBtnClickListener(btnTeam, function() self:OnClickTeamButton() end, nil, 0.5);
	self:AddBtnClickListener(btnRecord, function() self:OnClickRecordButton() end, nil, 0.5);
	self.mButtonRule = btnRule;
	self.mButtonRank = btnRank;
	self.mButtonTeam = btnTeam;
	self.mButtonRecord = btnRecord;
end

function PromoteTopButtonView:OnViewShow( logicParams )
	self:OnUpdateUI(logicParams);
end

function PromoteTopButtonView:SetData(  vo )
	
end

function PromoteTopButtonView:OnUpdateUI(vo)
	self.mData = vo;
end

function PromoteTopButtonView:OnClickRuleButton(  )
	local view_type = self.mViewType;
	if view_type == 1 then
		mUIManager:HandleUI(mViewEnum.ManualView, 1, mConfigSysmanualConst.PROMOTE);
	elseif view_type ==  2 then
		mUIManager:HandleUI(mViewEnum.ManualView, 1, mConfigSysmanualConst.PROMOTEARENA);
	end
end

function PromoteTopButtonView:OnClickRankButton(  )
	mUIManager:HandleUI(mViewEnum.PromoteRankView, 1);
end

function PromoteTopButtonView:OnClickTeamButton(  )
	mDianfenggongdouController:SendGetArenaDefend();
end

function PromoteTopButtonView:OnClickRecordButton(  )
	mUIManager:HandleUI(mViewEnum.DianfenggongdouEnemyView, 1);
end

return PromoteTopButtonView;