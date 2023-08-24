local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local MansionController = require "Module/Mansion/MansionController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local MansionServantHireWorkView = mLuaClass("MansionServantHireWorkView",mBaseView);

function MansionServantHireWorkView:Init()	
	self.mSlider = self:FindComponent('Slider', 'Slider');

	self.mTextLevel1 = self:FindComponent( 'Text_level1', 'Text' );
	self.mTextLevel2 = self:FindComponent( 'Text_level2', 'Text' );
	self.mTextBoom1 = self:FindComponent( 'Text_1', 'Text' );
	self.mTextHire1 = self:FindComponent( 'Text_hire', 'Text' );
	self.mStopStatus = self:Find( 'Text_5' ).gameObject;
	self.mTextStatus = self:FindComponent( 'Text_status', 'Text' );
	self.mTextAward = self:FindComponent( 'button_award/Text_Price', 'Text' );
	self.mTextHire = self:FindComponent( 'button_payoff/Text_Price', 'Text' );
	self.mGameImgPriceIcon1 = self:FindComponent("button_award/PriceIcon","Image");

	local button_award = self:Find( 'button_award' );
	self.mButtonAward = button_award.gameObject;
	self.mPositonAward = button_award.localPosition;
	local button_payoff = self:Find('button_payoff');
	self.mButtonPayoff = button_payoff.gameObject;
	self.mPositionPayoff = button_payoff.localPosition;
	self:AddBtnClickListener(button_award, function() self:OnClickAward() end);
	self:AddBtnClickListener(button_payoff, function() self:OnClickPayoff() end);
	self:FindAndAddClickListener("button_alter", function() self:OnClickAlterName() end);
end

function MansionServantHireWorkView:OnUpdateData( data )
	self.mData = data;

	self.mSlider.value = data:GetExpRate( );
	self.mTextLevel1.text = data:GetLevel( );
	self.mTextLevel2.text = data:GetNextLevel();
	self.mTextBoom1.text = data:GetUpgradeTip();
	self.mTextHire1.text = data:GetUpgradeHire();

	self.mStopStatus:SetActive( data:IsStopWork() );
	self.mTextStatus.text = data:GetWorkState();

	self:UpdateAwardButton( data );
	self:UpdatePayoffButton(data );
	self:UpdateButtonPosition( );
end

function MansionServantHireWorkView:UpdateAwardButton( data )
	local canAward = data:IsCanAward();
	if canAward then
		local awardVO = data:GetAwardCost();
		self.mTextAward.text = awardVO[2];
		self.mGameObjectUtil:SetImageSprite(self.mGameImgPriceIcon1, "common_city_icon_"..awardVO[1]);
	end 
	self.mButtonAward:SetActive(  canAward );
	self.mShowButtonAward = canAward;
end

function MansionServantHireWorkView:UpdatePayoffButton( data )
	local canPay = data:IsCanPayoff( );
	self.mButtonPayoff:SetActive( canPay  );
	self.mTextHire.text = data:GetPayoff( );
	self.mShowButtonPayoff = canPay;
end

function MansionServantHireWorkView:UpdateButtonPosition(  )
	local showAward = self.mShowButtonAward;
	local showPay = self.mShowButtonPayoff;
	local positionAward = self.mPositonAward;
	local positionPay = self.mPositionPayoff;
	local transformAward = self.mButtonAward.transform;
	local transformPay = self.mButtonPayoff.transform;
	if showPay and showAward then
		transformAward.localPosition = positionAward;
		transformPay.localPosition = positionPay;
	elseif showPay then
		transformPay.localPosition = Vector3.New( (positionPay.x + positionAward.x) / 2, positionPay.y, 0 );
	elseif showAward then
		transformAward.localPosition= Vector3.New((positionPay.x + positionAward.x) / 2, positionPay.y, 0 );
	end
end

function MansionServantHireWorkView:OnClickAward( )
	MansionController:SendServantAwardMoney( self.mData.mID );
end

function MansionServantHireWorkView:OnClickPayoff( )
	MansionController:SendServantPayOffHire( self.mData.mID );
end

function MansionServantHireWorkView:OnClickAlterName(  )
	local vo = self.mData;
	local data = {};
	data.mCost =  vo.mFreeName and 0 or mConfigSysglobal_value[mConfigGlobalConst.MANSION_SERVANT_CHANGE_NAME_GOLD];
	data.mCallBack = function ( name )
		MansionController:SendServantAlterName( vo.mID, name);
	end
	mUIManager:HandleUI(mViewEnum.CommonAlterNameView, 1, data);
end

function MansionServantHireWorkView:OnViewShow()
	
end

function MansionServantHireWorkView:OnViewHide()

end

return MansionServantHireWorkView;