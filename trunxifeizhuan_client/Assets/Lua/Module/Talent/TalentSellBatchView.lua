local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mAlertBaseView = require "Module/CommonUI/AlertBaseView"
local TalentController = require "Module/Talent/TalentController"
local TalentSellBatchView = mLuaClass("TalentSellBatchView", mBaseWindow);

function TalentSellBatchView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_sell_batch_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function TalentSellBatchView:Init()
	self.mTextPrice = self:FindComponent( 'TextPrice', 'Text' );
	self.mTextDesc = self:FindComponent( 'TextDesc', 'Text' );

	self:FindAndAddClickListener('BtnCancel', function() self:HideView() end, nil , 0.3);
	self:FindAndAddClickListener('BtnOk', function() self:OnClickSell() end, nil , 0.3);

	self.mOkBack = function ( )
		self:SendSellTalent( );
	end
	self.mCancelBack = function (  )
		self:HideView( );
	end
end

function TalentSellBatchView:OnViewShow( logicParams )
	self.mData = logicParams;

	self:ShowGoodsInfo( logicParams );
end

function TalentSellBatchView:ShowGoodsInfo( data )
	local number = #data;
	local totalPrice = 0;
	for k, v in pairs( data ) do
		totalPrice = totalPrice + v:GetSellPrice( );
	end

	self.mTextPrice.text = totalPrice;
	self.mTextDesc.text = string.format( mLanguageUtil.talent_batch_sell_tip2, number );
end

function TalentSellBatchView:OnViewHide()
	
end

function TalentSellBatchView:SendSellTalent(  )
	local pbTalentModels = { };
	for k, v in pairs ( self.mData ) do
		table.insert( pbTalentModels, { id = v:GetUID( ), num = 1 } );
	end
	TalentController:SendSellTalent(  pbTalentModels );

	self:HideView();
end

function TalentSellBatchView:OnClickSell(  )
	local have = false;
	for k, v in pairs ( self.mData ) do
		if v:IsHighQulity( ) then
			have = true;
			break;
		end
	end
	if have then
		mAlertBaseView.Show({ desc1=mLanguageUtil.talent_sell_tip1,  CallBack = self.mOkBack, CancelCallBack = self.mCancelBack });
	else
		self:SendSellTalent( );
	end
end

function TalentSellBatchView:Dispose( )
	
end

return TalentSellBatchView;