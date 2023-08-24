local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local TalentBaseInfoView = mLuaClass("TalentBaseInfoView", mBaseView);

function TalentBaseInfoView:Init()
	local addtionAttri = {};
	for i = 1, 6 do
		addtionAttri[ i ] = TalentAttributeItem.LuaNew( self:Find('attri'..i).gameObject );
	end
	self.mAddtionAttri = addtionAttri;
	
	self.mTalentItem = TalentItemBaseView.LuaNew( self:Find('talent_item').gameObject );
	self.mBaseAtrri = TalentAttributeItem.LuaNew( self:Find('base_attri').gameObject );
	self.mTextDesc = self:FindComponent( 'Text_desc', 'Text' );
end

function TalentBaseInfoView:OnViewShow( talent_vo )
	self:OnUpdateUI( talent_vo );
end

function TalentBaseInfoView:OnUpdateUI( talent_vo )
	self.mData = talent_vo;
	local addtionAttri = talent_vo:GetAdditionAttri();
	for k, v in pairs ( self.mAddtionAttri ) do
		local vo = addtionAttri[ k ];
		if vo then
			v:ShowView( );
			v:UpdateUI( vo.key, vo.value );
		else
			v:HideView( );
		end
	end

	self.mTextDesc.text = talent_vo:GetTalengDesc( );
	self.mTalentItem:ExternalUpdate( talent_vo );

	if talent_vo:GetGoodsType() == 1 then
		local mainAttri = talent_vo:GetMainAttri( );
		self.mBaseAtrri:UpdateUI( mainAttri.key, mainAttri.value );
	else
		self.mBaseAtrri:UpdateAttriStr( talent_vo:GetOtherAttributeStr( ), '');
	end
end

return TalentBaseInfoView;