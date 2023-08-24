local mBaseWindow = require "Core/BaseWindow"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local mTalentItemVO = require "Module/Talent/TalentItemVO"
local mGameModelManager = require "Manager/GameModelManager"
local mMysteryController = require "Module/Mystery/MysteryController"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local MysteryBuyTalentView = mLuaClass("MysteryBuyTalentView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgNotEnough = mLanguageUtil.store_not_enough;

function MysteryBuyTalentView.Show(data)
	mUIManager:HandleUI(mViewEnum.MysteryBuyTalentView, 1, data);
end

function MysteryBuyTalentView:InitViewParam()
	return {
		["viewPath"] = "ui/mystery/",
		["viewName"] = "mystery_talent_buy_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MysteryBuyTalentView:Init()
	local addtionAttri = {};
	for i = 1, 6 do
		addtionAttri[ i ] = TalentAttributeItem.LuaNew( self:Find('attri'..i).gameObject );
	end
	self.mAddtionAttri = addtionAttri;
	self.mTalentItem = TalentItemBaseView.LuaNew( self:Find('talent_item').gameObject );
	self.mBaseAtrri = TalentAttributeItem.LuaNew( self:Find('base_attri').gameObject );
	self.mTextDesc = self:FindComponent( 'Text_desc', 'Text' );
	self.mTextPrice = self:FindComponent('Btn/Text','Text');

	self:FindAndAddClickListener("Btn",function() self:OnBuy() end);

	self:RegisterEventListener(self.mEventEnum.ON_GET_MYSTERY_LIST,function(data)self:HideView();end,true);
end

function MysteryBuyTalentView:OnBuy()
	local data = self.mData;
	local coin = mGameModelManager.RoleModel.mPlayerBase.coin;
	local cost = data.talent.price;
	if coin >= cost then
		mMysteryController:SendBuy(data);
	else
		local equip = mConfigSysgoods[1000002];
		local str = string.format(mLgNotEnough,equip.goods_name);
		mCommonTipsView.Show(str);
	end
	self:HideView();
end

function MysteryBuyTalentView:OnViewShow(data)
	self.mData = data;
	local talent_vo = mTalentItemVO.LuaNew(data.talent.talent,nil);
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
	local mainAttri = talent_vo:GetMainAttri( );
	self.mBaseAtrri:UpdateUI( mainAttri.key, mainAttri.value );
	self.mTextDesc.text = talent_vo:GetTalengDesc( );
	self.mTalentItem:ExternalUpdate( talent_vo );
	self.mTextPrice.text = data.talent.price;
end

function MysteryBuyTalentView:OnViewHide(  )

end

function MysteryBuyTalentView:Dispose( )
	
end

return MysteryBuyTalentView;