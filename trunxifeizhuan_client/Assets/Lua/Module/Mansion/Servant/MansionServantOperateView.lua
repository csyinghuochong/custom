local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local MansionController = require "Module/Mansion/MansionController"
local MansionServantOperateView = mLuaClass("MansionServantOperateView",mBaseWindow);

function MansionServantOperateView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_servant_operate_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function MansionServantOperateView:Init()
	self:InitSubView(  );
	self:AddListeners( );
end

function MansionServantOperateView:InitSubView( )
	
	self.mToggle = self:Find( 'Toggle' );
	self.mImageBg = self:FindComponent ( 'Toggle/Image_bg', 'RectTransform' );

	local buttonList = {};
	for i = 1, 4 do
		buttonList[ i ] = self:Find( 'Toggle/Button'..i );
	end
	self.mButtonList = buttonList;
	
	self.mTextHire  = self:FindComponent( 'Toggle/Button2/Text_cost', "Text" ) ;
	self.mTextAward = self:FindComponent( 'Toggle/Button3/Text_cost', "Text" ) ;
	self.mGameImgPriceIcon1 = self:FindComponent("Toggle/Button3/image_icon","Image");

	self:FindAndAddClickListener('Toggle/Button1',function() self:OnClickWatch() end);
	self:FindAndAddClickListener('Toggle/Button2',function() self:OnClickPayoff() end);
	self:FindAndAddClickListener('Toggle/Button3',function() self:OnClickAward() end);
	self:FindAndAddClickListener('Toggle/Button4',function() self:OnClickPlant() end);
end

function MansionServantOperateView:AddListeners( )
	local mEvent = self.mEventEnum;
end

function MansionServantOperateView:OnViewShow( logicParams )
	local data =  logicParams.data;
	self.mData =  data;
	self.mToggle.localPosition = Vector3.New( logicParams.pos.x, 0, 0 );

	local checkFunction = {
		function ( data ) return true; end;
		function ( data ) return data:IsCanPayoff(); end;
		function ( data ) return data:IsCanAward(); end;
		function ( data ) return data:ShowPlantButton(); end;
	}

	local validIndex = 0;
	for k, v in pairs( self.mButtonList ) do
		local show = checkFunction[k]( data ); 
		v.gameObject:SetActive( show );
		v.localPosition = Vector3.New( 0, 10 - (75 * validIndex) , 0 );
		validIndex = validIndex + ( show and 1 or 0 );
	end

	self.mImageBg.sizeDelta = Vector2.New( 120 , 5 + validIndex * 75 );

	if data:IsCanAward() then
		local awardVO = data:GetAwardCost();
		self.mTextAward.text = awardVO[2];
		self.mGameObjectUtil:SetImageSprite(self.mGameImgPriceIcon1, "common_city_icon_"..awardVO[1]);
	end
	self.mTextHire = data:GetPayoff( );
end

function MansionServantOperateView:OnClickWatch(  )
	local data = self.mData.mMansionVO;
	data.mSelectServantID = self.mData.mID;
	mUIManager:HandleUI(mViewEnum.MansionServantView, 1, data);
	self:HideView( );
end

function MansionServantOperateView:OnClickAward(  )
	MansionController:SendServantAwardMoney( self.mData.mID );
	self:HideView( );
end

function MansionServantOperateView:OnClickPayoff(  )
	MansionController:SendServantPayOffHire( self.mData.mID );
	self:HideView( );
end

function MansionServantOperateView:OnClickPlant(  )
	mUIManager:HandleUI(mViewEnum.MansionPlantQueueView, 1, self.mData.mMansionVO);
	self:HideView( );
end

function MansionServantOperateView:OnViewHide( )
	
end

function MansionServantOperateView:Dispose()
	
end

return MansionServantOperateView;