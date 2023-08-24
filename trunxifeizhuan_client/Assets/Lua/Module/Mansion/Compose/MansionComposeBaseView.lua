local mUIGray = require "Utils/UIGray"
local mViewEnum = require "Enum/ViewEnum";
local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local mSortTable = require "Common/SortTable"
local mLanguageUtil = require "Utils/LanguageUtil"
local mBagController = require "Module/Bag/BagController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLayoutController = require "Core/Layout/LayoutController"
local MansionController = require "Module/Mansion/MansionController"
local CommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local CommonAnalyseGoodsInfo = require "Module/CommonUI/CommonAnalyseGoodsInfo"
local MansionComposeGoodsVO = require "Module/Mansion/Compose/MansionComposeGoodsVO"
local ConfigSysmansion_composition = require "ConfigFiles/ConfigSysmansion_composition"
local MansionComposeBaseView = mLuaClass("MansionComposeBaseView", mQueueWindow);

function MansionComposeBaseView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_compose_base_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionComposeBaseView:Init()
	self:InitSubView( );
	self:AddEventListeners( );
end

function MansionComposeBaseView:InitSubView(  )
	self.mTextTitle = self:FindComponent( 'Text_title', 'Text' );
	self.mTextButton = self:FindComponent( 'Button_compose/Text', 'Text' );
	self.mTextDesc = self:FindComponent( 'Text_desc', 'Text' );
	self.mTextPrice = self:FindComponent( 'Text_num', 'Text' );
	self.mImagePrice = self:FindComponent("Imageicon","Image");
	self:FindAndAddClickListener("Button_Get",function() self:OnClickGetButton() end);
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);
	self:FindAndAddClickListener("Button_compose",function() self:OnClickComposeButton() end);

	self.mGridEx1 = mLayoutController.LuaNew(self:Find('scrollView1/Grid'), require "Module/Mansion/Compose/MansionComposeNeedItem");
	self.mGridEx2 = mLayoutController.LuaNew(self:Find('scrollView2/Grid'), require "Module/Mansion/Compose/MansionComposeGoodsItem");
	self.mDataSource1 = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
	self.mDataSource2 = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	self.mGoodsItem = CommonGoodsItemView.LuaNew( self:Find('goodsItem').gameObject );
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self:Find('Button_compose').gameObject);
end

function MansionComposeBaseView:Sort( a, b )
	local aId = a.mID;
	local bId = b.mID;
	local aNumber = a.mNumber;
	local bNumber = b.mNumber;
	local aEnough = a.mGoodsEnough;
	local bEnough = b.mGoodsEnough;
	if aNumber == bNumber then
		if aEnough == bEnough then
			return aId < bId;
		else
			return aEnough;
		end
	else
		return bNumber < aNumber;
	end
end

function MansionComposeBaseView:AddEventListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_BAG_GOODS_REFRESH, function(params) self:OnRecvGoodsUpdate(params); end, true);
    self:RegisterEventListener(mEventEnum.ON_RECV_COMPOSE_MATERIAL, function() self:OnRecvComposeMaterial(); end, true);
    self:RegisterEventListener(mEventEnum.ON_SELECT_COMPOSE_GOODS,function(data) self:OnSelectMaterialBack(data)end,true);
end

function MansionComposeBaseView:OnViewShow( logicParams )
		
	self:UpdateButtonText( logicParams );
	self:InitMaterialList( logicParams );

end

function MansionComposeBaseView:UpdateButtonText( m_type )
	local text = mLanguageUtil[ 'mansion_compose_button_'..m_type ]
	self.mTextTitle.text = text;
	self.mTextButton.text = text;
end

function MansionComposeBaseView:InitMaterialList( m_type )
	local data = self.mDataSource2;
	data:ClearDatas(true);
	for k, v in pairs( ConfigSysmansion_composition ) do 
		if m_type == v.material_type then
			local number = self:GetGoodsNumByGoodsID( k );
			local goodsEnough = self:CheckGoodsIsEnough( v.compose_cost );
			data:AddOrUpdate( k, MansionComposeGoodsVO.LuaNew( k, number, v, goodsEnough ) );
		end
	end
	self.mGridEx2:UpdateDataSource(data);
	self:OnSelectGoodsItem( data.mSortTable[1] );
end

function MansionComposeBaseView:GetGoodsNumByGoodsID( id )
	local bagModel = mGameModelManager.MansionModel;
    return bagModel:GetGoodsNumberGoodsId(id);
end

function MansionComposeBaseView:OnSelectMaterialBack( data )
	self:OnSelectGoodsItem( data );
end

function MansionComposeBaseView:OnSelectGoodsItem( data )
	self.mSelectData = data;
	self:UpdateCostGoods( data );
	self:UpdateGoodsBaseInfo( data );

	self.mGridEx2:SetViewSelectedByKey(data.mID,true);
end

function MansionComposeBaseView:CheckGoodsIsEnough( cost )
	return mGameModelManager.MansionModel:CheckGoodsIsEnough( cost );
end

function MansionComposeBaseView:UpdateCostGoods( data )
	self.mGridEx1:UpdateDataSource( data:GetComposeCostGoods( ) );
	local goodsEnough = self:CheckGoodsIsEnough( data.mCompositionVo.compose_cost );
	self.mUIGray:SetGray(not goodsEnough);
    self.mEnougthGoods = goodsEnough;
end

function MansionComposeBaseView:UpdateGoodsBaseInfo( data )
	self.mGoodsItem:ExternalUpdate( data );
	local configData = data.mSysVO;
	self.mTextPrice.text = configData.sell_price;
	self.mTextDesc.text = configData.desc;
	self.mGameObjectUtil:SetImageSprite(self.mImagePrice, "common_city_icon_"..configData.currency);
end

function MansionComposeBaseView:OnRecvGoodsUpdate( params )

	self:UpdateCostGoods( self.mSelectData );
	self:OnRefreshGoodsNumber( self.mLogicParams );

end

function MansionComposeBaseView:OnRefreshGoodsNumber( m_type )
	local data = self.mDataSource2;
	for k, v in pairs( data.mRawTable ) do 
		local number = self:GetGoodsNumByGoodsID( k );
		local goodsEnough = self:CheckGoodsIsEnough( v.mCompositionVo.compose_cost );
		v.mNumber = number;
		v.mGoodsEnough = goodsEnough;
		data:AddOrUpdate( k, v );
	end
end

function MansionComposeBaseView:OnRecvComposeMaterial(  )
	local goods_id =  self.mSelectData.mID;
	local goods_name = CommonAnalyseGoodsInfo:GetGoodsNameByGoodsId(goods_id);
	mCommonTipsView.Show(string.format( mLanguageUtil.mansion_compose_succeed, goods_name ));
end

function MansionComposeBaseView:OnClickGetButton()
	local selectData = self.mSelectData;
	mBagController:OpenGetView(selectData);
end

function MansionComposeBaseView:OnClickComposeButton(  )
	if self.mEnougthGoods then
      	MansionController:SendComposeMaterial( self.mSelectData.mID ); 
    else
    	mCommonTipsView.Show(mLanguageUtil.common_goods_no_enough);
	end
end

function MansionComposeBaseView:OnViewHide( )
	
end

function MansionComposeBaseView:Dispose()
	self.mGridEx1:Dispose( );
	self.mGridEx2:Dispose( );
end

return MansionComposeBaseView;