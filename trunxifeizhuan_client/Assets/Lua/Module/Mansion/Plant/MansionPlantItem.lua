local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum";
local mTimeUtil = require "Utils/TimeUtil"
local mUIManager = require "Manager/UIManager"
local GameTimer = require "Core/Timer/GameTimer"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mAlertView = require "Module/CommonUI/AlertBaseView"
local mUITextureManager = require "Manager/UITextureManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local MansionController = require "Module/Mansion/MansionController"
local CommonPopMenuView = require "Module/Mansion/CommonPopMenuView"
local MansionPlantItem = mLuaClass("MansionPlantItem",mBaseView);
local GameObject = UnityEngine.GameObject;
local mVector2 = Vector2;
local mColor = Color;

function MansionPlantItem:Init()
	self.mTimeBg = self:Find( 'bg_time' ).gameObject;
	self.mSeedIcon = self:FindComponent('model', 'RawImage');
	self.mTextTime = self:FindComponent( 'Text_time', 'Text' );
	self.mSeedIcon.color = mColor.clear;

	self.mBtnHarvest = self:Find('btn_harvest').gameObject;
	self.mBtnWatering = self:Find('btn_watering').gameObject;
	self.mBtnTrouble = self:Find('btn_trouble').gameObject;

	local btn_buy = self:Find( 'btn_buy' ).gameObject;
	self.mBuyButtonObj = btn_buy;
	self.mUIGray = mUIGray.LuaNew():InitGoGraphic(btn_buy);
	self:AddBtnClickListener( btn_buy,  function() self:OnClickBuyLand() end,nil, 1)

	self:FindAndAddClickListener("btn_plant",function() self:OnClickPlant() end,nil, 1);
	self:FindAndAddClickListener("btn_harvest",function() self:OnClickHarvest() end,nil, 1);
	self:FindAndAddClickListener("btn_watering",function() self:OnClickWatering() end,nil, 1);
	self:FindAndAddClickListener("btn_trouble",function() self:OnClickTrouble() end,nil, 1);
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
end

function MansionPlantItem:OnUpdateUI( data )
	self.mData = data;

	self:UpdateBuyButton( data );
	self:OnUpateRipeTime( data );
	self:UpdateOperateButton( data );
	self:UpdateSeedIcon( data );
end

local mResourceUrl = require "AssetManager/ResourceUrl"
local mSeedIcon = mResourceUrl.seed_icon;
function MansionPlantItem:UpdateSeedIcon( data )
	if data:IsHaveSeed( ) then
		mUITextureManager.LoadTexture(mSeedIcon, data:GetPlantCurIcon( ), self.mLoadedIcon);
	end
	self.mSeedIcon.gameObject:SetActive( data:IsHaveSeed() );
end

function MansionPlantItem:UpdateBuyButton( data )
	self.mBuyButtonObj:SetActive( not data:IsOpen() and data.mMansionVO:CanOperatePlant() );
	self.mUIGray:SetGray( not data:IsUnLock() );
end

function MansionPlantItem:UpdateOperateButton(  data )
	self.mBtnHarvest:SetActive( data:ShowStealBtn( ) );
	self.mBtnWatering:SetActive( data:ShowWaterBtn( ) );
	self.mBtnTrouble:SetActive( data:ShowTroubleBtn( ) );
end

function MansionPlantItem:OnUpateRipeTime( data )
	local remainTime = data:GetSeedLastRipeTime();
	self:DisposeTimer();
    if remainTime > 0 then
    	self.mRemainTime =  remainTime;
    	self:OnTimerInterval();
    	self.mTimeBg:SetActive( true );
        self.mGameTimer = GameTimer.SetInterval(1, function() self:OnTimerInterval() end);
    else
    	self.mTextTime.text = "";
    	self.mTimeBg:SetActive( false );
   	end
end

function MansionPlantItem:OnTimerInterval()
	local data = self.mData;
    local time = self.mRemainTime;
    time = time - 1;
    if time >= 0 then
       self.mTextTime.text = mTimeUtil:TransToHourMinSec(time);
       self.mBtnWatering:SetActive( data:ShowWaterBtn( ) );
    else
       data:SetSeedRipe();
       self:OnUpdateUI( data );
    end
    self.mRemainTime = time;
end

local mLgBuyLand = mLanguageUtil.mansion_buy_land_tip;
function MansionPlantItem:OnClickBuyLand(  )
	local data = self.mData;
	if data:IsUnLock() then
		local clickBuyLandBack = function ( )
			MansionController:SendBuyLand( data.mID );
		end
		mAlertView.Show({title=nil, desc1=data:ExplainBuyTip(mLgBuyLand), btnName= nil,CallBack = clickBuyLandBack});
	else
		mCommonTipsView.Show( data:GetLockTip( ) );
	end
end

function MansionPlantItem:OnClickPlant(  )
	local data = self.mData;

	if data.mMansionVO:CanOperatePlant() then
		if data:IsHaveSeed() then
			local l_position = CommonPopMenuView:ObjectToUIPosition( self.mTransform ); 
			mUIManager:HandleUI(mViewEnum.MansionPlantOperateView, 1, { data =  data, position = l_position } );
		elseif data:IsOpen() then
			mUIManager:HandleUI(mViewEnum.MansionPlantBagView, 1, data);
		end
	end
end

function MansionPlantItem:OnClickHarvest(  )
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	if data.mMansionVO:CanOperatePlant() then
		MansionController:SendPlantOperate( typeEnum.Harvest, data.mID, 0, 0 );
	else
		MansionController:SendPlantOperate( typeEnum.Steal, data.mID, 0, data.mMansionVO:GetPlayerID());
	end
end

--浇水
function MansionPlantItem:OnClickWatering( )
	local data = self.mData;
	local mansionVo = data.mMansionVO;
	local typeEnum = MansionController.mPlantTyepEnum;
	local target_id = mansionVo:IsSelfMansion() and 0 or mansionVo:GetPlayerID();
	MansionController:SendPlantOperate( typeEnum.Watering, data.mID, 0, target_id );
end

--捣乱
function MansionPlantItem:OnClickTrouble( )
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	MansionController:SendPlantOperate( typeEnum.Trouble, data.mID, 0, data.mMansionVO:GetPlayerID() );
end

function MansionPlantItem:OnLoadedIcon(textrue)
	if self.mIsDestory then
		return;
	end
	local icon = self.mSeedIcon;
	icon.texture = textrue;
	icon.color = mColor.white;
end

function MansionPlantItem:OnViewHide(  )
	self:DisposeTimer();
end

function MansionPlantItem:DisposeTimer(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Dispose( );
		self.mGameTimer = nil;
	end
end

return MansionPlantItem;