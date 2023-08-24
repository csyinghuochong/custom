local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mLanguageUtil = require "Utils/LanguageUtil"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mFollowerSkillList = require "Module/Follower/FollowerSkillList"
local mFollowerController = require "Module/Follower/FollowerController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local FollowerSkillCostItem = require "Module/Follower/FollowerSkillCostItem";
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerSkillView = mLuaClass("FollowerSkillView",mCommonTabBaseView);
local mGameLuaInterface = GameLuaInterface;

function FollowerSkillView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_skill_view",
	};
end

function FollowerSkillView:Init()
	self:InitSubView( );
	self:AddListeners();
end

function FollowerSkillView:InitSubView(  )
	local callBack = function ( vo )
		self:OnClickSkillBack(vo);
	end 
	self.mGoodsItem = FollowerSkillCostItem.LuaNew(self:Find('button_add/cost_item').gameObject);
	self.mSkillListView = mFollowerSkillList.LuaNew(self:Find('skill_list').gameObject);
	self.mSkillListView:SetSetSkillBack( callBack );

	local btn_up = self:Find('Button_Up').gameObject;
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(btn_up);
	self:AddBtnClickListener(btn_up, function() self:OnClickUpgrade() end, nil, 0.5);
	self.mUIGray:SetGray(true);

	local btn_add = self:Find( 'button_add' ).gameObject;
	self:AddBtnClickListener(btn_add,function() self:OnClickCostView() end);

	self.mButtonUp = btn_up;
	self.mButtonAdd = btn_add;
	self.mUpSkillTip = self:Find( 'Image_9' ).gameObject;
	self.mMaxSkill = self:Find( 'Text_max' ).gameObject;
	self.mMaxSkill:SetActive( false ); 
	self.mHandCostViewBack = function ( data )
		self:OnHandCostViewBack(data);
	end
	self.mSendFollowerUpLevel = function (  )
		self:SendFollowerUpLevel();
	end
end

function FollowerSkillView:AddListeners( )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_SKILL_UP, function(vo)
		self:OnSkillUp(vo);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_GOODS_UPDATE, function()
        self:UpdateCostNumber();
    end, true);
end

function FollowerSkillView:OnUpdateUI(data)
	self.mData =data;
	
	self:OnHandCostViewBack(nil);
	self.mUpSkillTip:SetActive( false );
	self.mSkillListView:OnUpdateUI(data);
end

function FollowerSkillView:IsAllSkillMax(  )
	local data  = self.mData;
	local skills = data:GetSkillList( );
	for k, v in pairs ( skills ) do
		if v.mActive and not v:IsMaxLevel( ) then
			return false;
		end
	end
	return true;
end

function FollowerSkillView:OnClickSkillBack( data )
	local max = self:IsAllSkillMax( );
	self.mMaxSkill:SetActive( max );
	self.mButtonUp:SetActive( not max );
	self.mButtonAdd:SetActive( not max );
end

function FollowerSkillView:ShowUpSkillTip( )
	local tip = self.mUpSkillTip;
	tip:SetActive( true );
	tip.transform.localPosition = Vector3.New( 199, 0, 0 );
	mGameLuaInterface.DOLocalMoveY(tip.transform, 190, 0.5, function() self:OnMoveEnd() end);
end

function FollowerSkillView:OnMoveEnd(  )
	self.mUpSkillTip:SetActive( false );
end

function FollowerSkillView:OnSkillUp( data )
	self:ShowUpSkillTip( );
	self:UpdateCostNumber( );
	self:OnClickSkillBack( data );
	self.mSkillListView:OnUpdateSkill(data);
end

function FollowerSkillView:UpdateCostNumber( )
	local data = self.mCostData;
	if data == nil then
		return false;
	end

	local costId = data.mID;
	local costType = data.mCostType;
	if costType == 1 then
		local bagModel = mGameModelManager.BagModel;
		local number =  bagModel:GetGoodsNumberGoodsId(costId,bagModel.mTypeEnum.ConSumeType);
		if number > 0 then
			self.mGoodsItem:UpdateGoodsNumber( number );
		else
			self:OnHandCostViewBack( nil );
		end
	else
		self:OnHandCostViewBack( nil );
	end
end

local mLgTip = mLanguageUtil.follower_upgrade_cost;
function FollowerSkillView:OnClickUpgrade()
	local costData = self.mCostData;
	if costData ~= nil then
		if costData.mStar >= 4 then
			mAlertView.Show({title=nil, desc1=nil, desc2=mLgTip, btnName= nil,CallBack = self.mSendFollowerUpLevel});
		else
			self:SendFollowerUpLevel();
		end
	else
		print('请选择消耗材料');
	end
end

function FollowerSkillView:SendFollowerUpLevel( )
	local costData = self.mCostData;
	mFollowerController:SendFollowerSkillUpLevel(self.mData.mUID, costData.mCostType, costData.mID);
end

function FollowerSkillView:OnHandCostViewBack(  data )
	self.mCostData = data;
	
	local costItem = self.mGoodsItem;
	if data == nil then
		costItem:HideView();
	else
		costItem:ShowView();
		costItem:ExternalUpdate(data);
	end

	self.mUIGray:SetGray(data == nil);
end

function FollowerSkillView:OnClickCostView(  )
	mUIManager:HandleUI(mViewEnum.FollowerSkillCostView, 1, { data = self.mData, callBack = self.mHandCostViewBack });
end

function FollowerSkillView:Dispose( )
	self.mSkillListView:CloseView();
end

return FollowerSkillView;