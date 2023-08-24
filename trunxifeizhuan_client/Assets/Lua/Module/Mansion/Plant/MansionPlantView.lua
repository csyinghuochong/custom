local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local MansionController = require "Module/Mansion/MansionController"
local MansionPlantItem = require "Module/Mansion/Plant/MansionPlantItem"
local CommonAnalyseGoodsInfo = require "Module/CommonUI/CommonAnalyseGoodsInfo"
local MansionPlantView = mLuaClass("MansionPlantView",mBaseView);
local mVector2 = Vector2;

function MansionPlantView:Init()
	self:AddListeners();
	self:InitSubView();
end

function MansionPlantView:InitSubView(  )
	local viewList = {};
	local number = self.mTransform.childCount;
	for i = 1, number do
		viewList[i] = MansionPlantItem.LuaNew( self:Find(tostring(i)).gameObject );
	end
	self.mPlantViews = viewList;
end

function MansionPlantView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_BUY_LAND, function(data)
   		self:OnRecvBuyLand( data );
   	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_PLANT_OP, function(data)
   		self:OnRecvPlantOperate( data );
   	end, true);
end

function MansionPlantView:OnRecvMansionData( pb_data )
	self.mData = pb_data;
	local viewList = self.mPlantViews;
	local plantVO = pb_data.mPlantInfoList;
	for k, v in pairs( plantVO ) do
		viewList[k]:OnUpdateUI( v );
	end
end

function MansionPlantView:OnRecvBuyLand( data )
	self.mPlantViews[data.mID]:OnUpdateUI( data );
end

function MansionPlantView:OnRecvPlantOperate( data )
	self:ShowPlantOperateTip( data );
	self.mPlantViews[data.mID]:OnUpdateUI( data );
end

function MansionPlantView:ShowPlantOperateTip( data )
	local goodsTip = nil;
	if data.mSelfOperate ~= true then
		return;
	end
	local itemId = data.mOpItemID;
	if itemId ~= nil and itemId ~= 0 then
		goodsTip = CommonAnalyseGoodsInfo:GetSingleGoodsNameAndNumber( { goods_id = data.mOpItemID, goods_num = data.mOpItemNum} );
	end
	local op_type = data.mOpItemType;
	local typeEnum = MansionController.mPlantTyepEnum;
	if op_type == typeEnum.Watering then
		mCommonTipsView.Show( mLanguageUtil.mansion_watering_tip );
	elseif op_type == typeEnum.Trouble then
		mCommonTipsView.Show( mLanguageUtil.mansion_troudle_tip );
	elseif op_type == typeEnum.Steal then
		mCommonTipsView.Show( mLanguageUtil.mansion_steal_goods..goodsTip );
	elseif op_type == typeEnum.Harvest then
		mCommonTipsView.Show( mLanguageUtil.mansion_harvest_goods..goodsTip );
	end
end

function MansionPlantView:OnViewShow()
	for k, v in pairs( self.mPlantViews ) do
		v:ShowView ( );
	end
end

function MansionPlantView:OnViewHide()
	for k, v in pairs( self.mPlantViews ) do
		v:HideView ( );
	end
end

function MansionPlantView:Dispose(  )
	for k, v in pairs( self.mPlantViews ) do
		v:CloseView ( );
	end
	self.mPlantViews = nil;
end

return MansionPlantView;