local mLuaClass = require "Core/LuaClass"
local mConfigSysecode = require "ConfigFiles/ConfigSysecode"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local TalentController = require "Module/Talent/TalentController"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local mConfigSysecodeConst = require "ConfigFiles/ConfigSysecodeConst"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local TalentStrengthView = mLuaClass("TalentStrengthView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function TalentStrengthView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_strength_view",
	};
end

local mRuyiGoodsId = 1010701;
function TalentStrengthView:Init()
	self:SetParent(self.mGoParent);
	
	self.mToggle = self:FindComponent('Toggle', 'Toggle');
	self.mTextCost = self:FindComponent('Text_cost', 'Text');
	self.mTextStrength = self:FindComponent( 'Text_2', 'Text' );
	self.mTextSucceed = self:FindComponent('Text_5', 'Text');
	self.mTextYuyiNum = self:FindComponent('Text_6', 'Text');
	self.mToggle.isOn = false;

	local attri_list = {};
	local mPath = 'attri%d';
	for i = 1, 5 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;
	self.mMainAttri = TalentAttributeItem.LuaNew(self:Find( 'base_attri' ).gameObject);
	self.mNewAttri = self:Find( 'attri_add' ).gameObject;
	self.mNewAttri:SetActive( false );

	self.mTalentItem1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );
 	self.mTalentItem2 = TalentItemBaseView.LuaNew( self:Find('talent_2').gameObject );

 	self.mObjectSucceed = self:Find( 'Image_1' ).gameObject;
 	self.mObjectFail = self:Find( 'Image_5' ).gameObject;
 	self.mObjectSucceed:SetActive( false );
	self.mObjectFail:SetActive( false );

	self:FindAndAddClickListener('Button_1', function() self:OnClickButtonOne() end, nil , 0.3);
	self:FindAndAddClickListener('Button_2', function() self:OnClickButtonTen() end, nil , 0.3);

	local mEventEnum = self.mEventEnum;
    self:RegisterEventListener(mEventEnum.ON_UP_TALENT_FAILED, function(  )
     	self:OnStrengthTalentFailed(  );
    end, false);
end

function TalentStrengthView:OnClickButtonOne(  )
	local data = self.mData;
	self.mStrengthType = 1;
	TalentController:SendTalentStrength( data:GetFollowerUID(), data:GetUID(), self:GetCostGoodsId() );
end

function TalentStrengthView:GetCostGoodsId(  )
	if self.mToggle.isOn then
		local number = self:GetRuyiNumber( );
		return number > 0 and mRuyiGoodsId or 0
	else
		return 0;
	end
end

function TalentStrengthView:OnClickButtonTen(  )
	local data = self.mData;
	self.mStrengthType = 2;
	TalentController:SendTalentStrength( data:GetFollowerUID(), data:GetUID(), self:GetCostGoodsId() );
end

function TalentStrengthView:GetRuyiNumber(  )
	local bagModel = mGameModelManager.BagModel;
	return bagModel:GetGoodsNumberGoodsId(mRuyiGoodsId, bagModel.mTypeEnum.ConSumeType);
end

function TalentStrengthView:OnStrengthTalent( data )
	self:ResetUI( );
	self:OnUpdateView( data );
	self:ShowWinOrFaildView( 1 );
end

--win 0(无)  1(成功)  2(失败)
function TalentStrengthView:ShowWinOrFaildView( win )
	self.mObjectSucceed:SetActive( win == 1 );
	self.mObjectFail:SetActive(win == 2 );
end

function TalentStrengthView:OnStrengthTalentFailed (   )
	local strength_num = self.mStrengthNumber;
	if self.mStrengthType == 2 and strength_num < 10 then
		self:OnClickButtonTen( );
		self.mStrengthNumber = strength_num + 1;
	else
		self:ResetUI( );
		self:ShowWinOrFaildView( 2 );
		mCommonTipsView.Show(mConfigSysecode[mConfigSysecodeConst.ERROR_STRENGTH_FAIL].error_tips);
	end
	self:UpdateCostNum( );
end

function TalentStrengthView:ResetUI(  )
	self.mStrengthType =nil;
	self.mStrengthNumber = 0;
end

function TalentStrengthView:OnUpdateUI(data)
	self.mData = data;

	self:ResetUI(  );
	self:OnUpdateView( data );
	self:ShowWinOrFaildView( 0 );
	self.mToggle.isOn = false;
end

function TalentStrengthView:OnUpdateView( data )
	self:UpdateCostNum( );
	self:UpdateSubView(data);
	self:ShowAttribute(data);
end

function TalentStrengthView:UpdateCostNum(  )
	local number = self:GetRuyiNumber();
	self.mTextYuyiNum.text = 'X'..number;
	self.mToggle.gameObject:SetActive( number > 0);
end

function TalentStrengthView:UpdateSubView( data )
	self.mTalentItem1:ExternalUpdate(data);
	self.mTalentItem2:ExternalUpdate(data:GetNextLevelClone());
	self.mTextCost.text = data:GetStrengthCost();
	self.mTextSucceed.text =  data:GetStrengthSucceed( );
	self.mTextStrength.text = data:GetStrengthAttriTip( );
end

function TalentStrengthView:ShowAttribute( data )
	local maiAttri = data:GetMainAttri( );
	self.mMainAttri:UpdateUITo( maiAttri.key, maiAttri.value, data:GetStrengthAttri( ) );

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

return TalentStrengthView;