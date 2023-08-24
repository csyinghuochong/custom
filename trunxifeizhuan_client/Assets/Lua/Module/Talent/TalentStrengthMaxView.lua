local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local TalentController = require "Module/Talent/TalentController"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local TalentStrengthMaxView = mLuaClass("TalentStrengthMaxView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function TalentStrengthMaxView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_strength_max_view",
	};
end

function TalentStrengthMaxView:Init()
	self:SetParent(self.mGoParent);

	local attri_list = {};
	local mPath = 'attri%d';
	for i = 1, 6 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;
	self.mMainAttri = TalentAttributeItem.LuaNew(self:Find( 'base_attri' ).gameObject);

	self.mTalentItem1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );
end

function TalentStrengthMaxView:OnUpdateUI(data)
	self.mData = data;
	
	self:UpdateSubView(data);
	self:ShowAttribute(data);
end

function TalentStrengthMaxView:UpdateSubView( data )
	self.mTalentItem1:ExternalUpdate(data);
end

function TalentStrengthMaxView:ShowAttribute( data )
	local maiAttri = data:GetMainAttri( );
	self.mMainAttri:UpdateUI( maiAttri.key, maiAttri.value );

	local totalAtti = data:GetAdditionAttri();
	local attriList = self.mAttriList;
	for k, v in pairs(attriList) do
		local vo = totalAtti[ k ];
		if vo then
			v:ShowView( );
			v:UpdateUI(vo.key, vo.value);
		else
			v:HideView( );
		end
	end
end

return TalentStrengthMaxView;