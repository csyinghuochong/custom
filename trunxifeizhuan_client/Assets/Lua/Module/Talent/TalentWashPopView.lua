local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local TalentController = require "Module/Talent/TalentController"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local TalentWashPopView = mLuaClass("TalentWashPopView", mBaseWindow);
local mString = string;

function TalentWashPopView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_wash_pop_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function TalentWashPopView:Init()
	local attri_list1 = {};
	local attri_list2 = {};
	local mPath1 = 'attri1_%d';
	local mPath2 = 'attri2_%d';
	for i = 1, 5 do
		attri_list1[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath1, i)).gameObject);
		attri_list2[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath2, i)).gameObject);
	end
	self.mAttriList1 = attri_list1;
	self.mAttriList2 = attri_list2;

	self.mMainAttri = TalentAttributeItem.LuaNew(self:Find( 'base_attri' ).gameObject);
	self.mTalent1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );

	self:FindAndAddClickListener('Button_1', function() self:OnClickButtonSave() end, nil , 0.3);
	self:FindAndAddClickListener('Button_2', function() self:OnClickButtonGive() end, nil , 0.3);
end

function TalentWashPopView:OnViewShow( data )
	self.mData = data;

	self:ShowGoodsInfo( data );
end

function TalentWashPopView:ShowGoodsInfo( data )
	self.mTalent1:ExternalUpdate(data);

	local maiAttri = data:GetMainAttri( );
	self.mMainAttri:UpdateUI( maiAttri.key, maiAttri.value);

	local totalAtti = data:GetAdditionAttri();
	local washAttri = data:GetWashAttribute( );

	local attriList = self.mAttriList1;
	for k, v in pairs(attriList) do
		local vo = totalAtti[ k ];
		if vo then
			v:ShowView( );
			v:UpdateUI(vo.key, vo.value);
		else
			v:HideView( );
		end
	end

	local washList = self.mAttriList2;
	for k, v in pairs(washList) do
		local vo = washAttri[ k ];
		if vo then
			v:ShowView( );
			v:UpdateUI(vo.key, vo.value);
		else
			v:HideView( );
		end
	end
end

function TalentWashPopView:OnClickButtonSave(  )
	self:HideView( );
	local data = self.mData;
	TalentController:SendTalentWashSave( data:GetFollowerUID(), data:GetUID(), 1 );
end

function TalentWashPopView:OnClickButtonGive(  )
	self:HideView( );
	local data = self.mData;
	TalentController:SendTalentWashSave( data:GetFollowerUID(), data:GetUID(), 0 );
end

return TalentWashPopView;