local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mAlertBaseView = require "Module/CommonUI/AlertBaseView"
local TalentController = require "Module/Talent/TalentController"
local TalentBaseInfoView = require "Module/Talent/TalentBaseInfoView"
local TalentSellSingelView = mLuaClass("TalentSellSingelView", mBaseWindow);

function TalentSellSingelView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_sell_single_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function TalentSellSingelView:Init()
	self.mBaseInfoView = TalentBaseInfoView.LuaNew( self:Find( 'base_view' ).gameObject );
	
	self:FindAndAddClickListener('Button_1', function() self:HideView() end);
	self:FindAndAddClickListener('Button_2', function() self:OnClickSell() end);

	self.mOkBack = function ( )
		self:SendSellTalent( );
	end
	self.mCancelBack = function (  )
		self:HideView( );
	end
end

function TalentSellSingelView:OnViewShow(data)
	self.mData = data;
	self.mBaseInfoView:OnUpdateUI( data );
end

function TalentSellSingelView:OnViewHide()
	
end

function TalentSellSingelView:SendSellTalent(  )
	self:HideView();
	self:SendSellSingelTalent( self.mData );
end

function TalentSellSingelView:SendSellSingelTalent( data )
	local pbTalentModel = { id = data:GetUID( ), num = 1 };
	local pbTalentModels = { };
	pbTalentModels[ 1 ] = pbTalentModel;
	TalentController:SendSellTalent(  pbTalentModels );
end

function TalentSellSingelView:OnClickSell(  )
	local data = self.mData;
	if data:IsHighQulity( ) then
		mAlertBaseView.Show({ desc1=mLanguageUtil.talent_sell_tip1,  CallBack = self.mOkBack, CancelCallBack = self.mCancelBack });
	else
		self:SendSellTalent( );
	end
end

function TalentSellSingelView:Dispose( )
	
end

return TalentSellSingelView;