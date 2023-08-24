local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local MansionController = require "Module/Mansion/MansionController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionPlantOperateView = mLuaClass("MansionPlantOperateView", mBaseVindow);
local mIpairs = ipairs;
local mPairs = pairs;

function MansionPlantOperateView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_plant_operate_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

--种植操作类型 1种植 2铲除 3施肥 4浇水 5捣乱 6 偷取 7 收获
local goodsIds = { 
		mConfigSysglobal_value[mConfigGlobalConst.MANSION_FERTILIZER_ONE_ID],
		mConfigSysglobal_value[mConfigGlobalConst.MANSION_FERTILIZER_TWO_ID] };
function MansionPlantOperateView:Init()
	local operateFunction = {
		function ( )  self:OnClickEradicate( );  end;
		function ( )  self:OnClickFertilize1( );  end;
		function ( )  self:OnClickFertilize2( );  end;
		function ( )  self:OnClickWatering( );  end;
	}

	local btnList = {};
	for i = 1, #operateFunction do
		self:FindAndAddClickListener ( string.format( 'bg4/Grid/item%d/icon', i ) , operateFunction[ i ], nil, 0.5 );
		btnList[ i ] = self:Find( 'bg4/Grid/item'..i ).gameObject;
	end
	self.mButtonList = btnList;

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_PLANT_OP, function(data)
       	self:OnRecvPlantOperate( data );
    end, true);

    self:InitSubView( );
end

function MansionPlantOperateView:InitSubView( )
	local goods1 = self:Find('bg4/Grid/item2').gameObject;
	local goods2 = self:Find('bg4/Grid/item3').gameObject;
	self.mUIGray1 = mUIGray.LuaNew():InitGoGraphics(goods1);
	self.mUIGray2 = mUIGray.LuaNew():InitGoGraphics(goods2);

	self.mGoodsItem1 = mCommonGoodsItemView.LuaNew( goods1 );
	self.mGoodsItem2 = mCommonGoodsItemView.LuaNew( goods2 );
	self.mGoodsItem1:UpdateByIdAndNum(goodsIds[1],  1, nil, false);
	self.mGoodsItem2:UpdateByIdAndNum(goodsIds[2],  1, nil, false);
	self.mBgRectTransform = self:FindComponent( 'bg4', 'RectTransform' );
	self.mBgHeight = self.mBgRectTransform.sizeDelta.y;
	self.mArrowTransform = self:Find( 'bg4/arrow' );
	self.mArrowPositionY = self.mArrowTransform.localPosition.y;
end

function MansionPlantOperateView:UpdateGoodsNumer(  )
	local bagModel = mGameModelManager.BagModel;
  	local number1 = bagModel:GetGoodsNumberGoodsId(goodsIds[1], bagModel.mTypeEnum.Material);
  	local number2 = bagModel:GetGoodsNumberGoodsId(goodsIds[2], bagModel.mTypeEnum.Material);
  	self.mGoodsItem1:ShowGoodsNumber( number1 )
  	self.mGoodsItem2:ShowGoodsNumber( number2 );
  	self.mUIGray1:SetGray( number1 == 0 );
  	self.mUIGray2:SetGray( number2 == 0 );
  	self.mGoodsNumber1 = number1;
  	self.mGoodsNumber2 = number2;
end

function MansionPlantOperateView:OnViewShow(logicParams)
	self:UpdateOperateButton ( logicParams.data );
	self:UpdateBgPosition (logicParams.position );
	self:UpdateGoodsNumer( );
end

function MansionPlantOperateView:UpdateBgPosition( position )
	self.mBgRectTransform.localPosition = Vector3.New( position.x , position.y + self.mBgHeight / 2, 0 );
end

function MansionPlantOperateView:OnViewHide( )
	
end

function MansionPlantOperateView:OnRecvPlantOperate( data )
	self:UpdateOperateButton ( data );
	self:UpdateGoodsNumer( );
end

function MansionPlantOperateView:CheckIsShowButton( data, index )
	local mansionVo = data.mMansionVO;
	local selfMansion = mansionVo:CanOperatePlant( );
	if index == 1 or index == 2 or index == 3 then
		return selfMansion;
	elseif index == 4 then
		return data:ShowWaterBtn( );
	end
	return false;
end
 
function MansionPlantOperateView:UpdateOperateButton( data )
	self.mData = data;

	if data:IsNotRipe( )  then	
		local validIndex = 0;
		for k, v in pairs( self.mButtonList ) do
			local show = self:CheckIsShowButton( data, k );
			v:SetActive( show );
			validIndex = validIndex + ( show and 1 or 0 );
		end

		local rectTransform = self.mBgRectTransform;
		rectTransform.sizeDelta = Vector3.New( 40 + validIndex * 90 , self.mBgHeight, 0);
	else
		self:HideView( );
	end
end

--铲除
function MansionPlantOperateView:OnClickEradicate( )
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	MansionController:SendPlantOperate( typeEnum.Eradicate, data.mID, 0, 0 );
end

--施肥1
function MansionPlantOperateView:OnClickFertilize1( )
	if self.mGoodsNumber1 < 1 then
		return;
	end
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	MansionController:SendPlantOperate( typeEnum.Fertilize, data.mID, goodsIds[1], 0 );
end

--施肥2
function MansionPlantOperateView:OnClickFertilize2( )
	if self.mGoodsNumber2 < 1 then
		return;
	end
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	MansionController:SendPlantOperate( typeEnum.Fertilize, data.mID, goodsIds[2], 0 );
end

--浇水
function MansionPlantOperateView:OnClickWatering( )
	local data = self.mData;
	local mansionVo = data.mMansionVO;
	local typeEnum = MansionController.mPlantTyepEnum;
	local target_id = mansionVo:IsSelfMansion() and 0 or mansionVo:GetPlayerID();
	MansionController:SendPlantOperate( typeEnum.Watering, data.mID, 0, target_id );
end

function MansionPlantOperateView:Dispose( )
	
end

return MansionPlantOperateView;