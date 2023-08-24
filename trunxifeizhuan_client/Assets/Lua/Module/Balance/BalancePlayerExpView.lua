local mLuaClass = require "Core/LuaClass"
local BaseView = require "Core/BaseView"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mUpdateManager = require "Manager/UpdateManager"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local mGameModelManager = require "Manager/GameModelManager"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local BalancePlayerExpView = mLuaClass("BalancePlayerExpView", BaseView);

function BalancePlayerExpView:Init(  )
	self.mUpLevel = self:Find( 'Image_1' ).gameObject;
	self.mMaxLevel = self:Find( 'Text_5' ).gameObject;
	self.mExpLabel = self:Find( 'Text_3' ).gameObject;
	self.mTextPlayerLv = self:FindComponent( 'Text_2', 'Text' );
	self.mTextAddExp   = self:FindComponent( 'Text_4', 'Text' );
	self.mSlider = self:FindComponent('Slider', 'Slider');

	local modelView = mModelShowView.LuaNew(self:Find("model"),true,0,0);
	modelView:OnUpdateVO( mGameModelManager.FollowerModel:GetLeadVO() );	
	self.mModelShowView = modelView;
end

function BalancePlayerExpView:OnViewShow( data )
	self:ShowLvAndExp( );
	self.mModelShowView:ShowView(  );
end

function BalancePlayerExpView:ShowLvAndExp(  )
	local old_lv =  mCombatModelManager.mPlayerLv;
	local old_exp =  mCombatModelManager.mPlayerExp;
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	local new_lv = roleBase.level;
	local new_exp = roleBase.exp;
	local addExp = self:GetAddExp( old_lv, old_exp, new_lv, new_exp );
	local newRate = new_exp / mConfigSysexp[ new_lv ].lead_exp;
	local oldRate = old_exp / mConfigSysexp[ old_lv ].lead_exp;
	self.mTextAddExp.text = addExp;
	self.mUpLevel:SetActive( old_lv ~= new_lv );
	if mLeadBaseVO:IsLevelMaxed( new_lv) then  
		self.mTextPlayerLv.text = new_lv;
		self.mSlider.value = 0;
		self.mMaxLevel:SetActive( true );
		self.mExpLabel:SetActive( false );
		self.mTextAddExp.text = '';
	elseif addExp > 0 then
		self.mOldLv = old_lv;
		self.mNewLv = new_lv;
		self.mOldRate = oldRate
		self.mNewRate = newRate;
		self.mTextPlayerLv.text = old_lv;
		self.mSlider.value = oldRate;
		mUpdateManager:AddUpdate(self);
	else
		self.mTextPlayerLv.text = new_lv;
		self.mSlider.value = newRate;
	end
end

function BalancePlayerExpView:OnUpdate()
	local silder = self.mSlider;
	local oldLv = self.mOldLv;
	silder.value = silder.value + ( Time.deltaTime / 3 );
	if oldLv < self.mNewLv then
		if silder.value >= 1 then
			self.mOldLv = oldLv + 1;
			self.mTextPlayerLv.text = oldLv + 1;
			silder.value = 0;
		end
	else
		if silder.value >= self.mNewRate then
			mUpdateManager:RemoveUpdate(self);
		end
	end
end

function BalancePlayerExpView:GetAddExp( old_lv, old_exp, new_lv,  new_exp )
	if old_lv == new_lv and old_exp == new_exp then
		return 0;
	elseif old_lv == new_lv then
		return new_exp - old_exp;
	else
		local addExp = 0;
		for k = old_lv, new_lv do
			local need_exp = mConfigSysexp[ k ].lead_exp;
			if k == old_lv then
				addExp = addExp + ( need_exp - old_exp );
			elseif k == new_lv then
				addExp = addExp + new_exp;
			else
				addExp = addExp + need_exp;
			end
		end
		return addExp;
	end
end


function BalancePlayerExpView:OnViewHide(  )
	self.mModelShowView:HideView( );
	mUpdateManager:RemoveUpdate(self);
end

function BalancePlayerExpView:Dispose( )
	self.mModelShowView:Dispose( );
end

return BalancePlayerExpView;