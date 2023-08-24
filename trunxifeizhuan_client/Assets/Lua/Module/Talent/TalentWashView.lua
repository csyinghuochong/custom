local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mLanguage = require "Utils/LanguageUtil"
local mUIManager = require "Manager/UIManager"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local TalentController = require "Module/Talent/TalentController"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local CommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local TalentWashView = mLuaClass("TalentWashView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function TalentWashView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_wash_view",
	};
end

local mJinYanGoodsId = 1011001;
function TalentWashView:Init()

	self:InitSubView(  );
	self:AddListener(  );
end

function TalentWashView:InitSubView(  )
	local attri_list = {};
	local mPath = 'attri_%d';
	for i = 1, 5 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;

	self.mMainAttri = TalentAttributeItem.LuaNew(self:Find( 'base_attri' ).gameObject);
	self.mTalent1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );
	self.mGoodsItem1 = CommonGoodsItemView.LuaNew( self:Find('goods_1').gameObject );
	self.mGoodsItem1:ExternalUpdate(mCommonGoodsVO.LuaNew(mJinYanGoodsId, 1));

	local btn_wash = self:Find( 'Button_1' ).gameObject;
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(btn_wash);
	self:AddBtnClickListener(btn_wash, function() self:OnClickButtonWash() end, nil , 0.3);
end

function TalentWashView:AddListener(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_WASH_TALENT, function( data )
		self:OnRecvTalentWash( data );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_WASH_TALENT_SAVE, function( data )
		self:OnRecvTalentUpdateSave( data );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_WASH_TALENT_GIVE, function( data )
		self:OnRecvTalentUpdateGive( data );
	end, true);
end

function TalentWashView:OnRecvTalentWash( data )
	mUIManager:HandleUI(mViewEnum.TalentWashPopView, 1, data);
end

function TalentWashView:OnRecvTalentUpdateSave( data )
	self:OnUpdateUI( data ); 
end

function TalentWashView:OnRecvTalentUpdateGive( data )
	self:OnUpdateUI( data ); 
end

function TalentWashView:OnClickButtonWash(  )
	local data = self.mData;
	if not self.mCostEnough then
		mCommonTipsView.Show( mLanguage.talent_wash_tip1 );
	elseif data:GetLevel() < 15 then
		mCommonTipsView.Show( mLanguage.talent_wash_tip2 );
	else
		TalentController:SendTalentWash( data:GetFollowerUID(), data:GetUID(), mJinYanGoodsId );
	end
end

function TalentWashView:OnUpdateUI(data)
	if data == nil then
		return;
	end
	self.mData = data;
	self:UpdateSubView(data);
	self:ShowAttribute(data);
end

function TalentWashView:UpdateSubView( data )
	self.mTalent1:ExternalUpdate(data);
	local bagModel = mGameModelManager.BagModel;
	local number = bagModel:GetGoodsNumberGoodsId(mJinYanGoodsId, bagModel.mTypeEnum.ConSumeType);
	self.mGoodsItem1:ShowGoodsNumber( number );
	self.mCostEnough = number > 0;
	self.mUIGray:SetGray(not self.mCostEnough);
end

function TalentWashView:ShowAttribute( data )
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

return TalentWashView;