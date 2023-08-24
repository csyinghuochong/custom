local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mSortTable = require "Common/SortTable"
local mBagGoodsVO = require"Module/Bag/BagGoodsVO"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local MansionController = require "Module/Mansion/MansionController"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mConfigSysmansion_operation_event = require "ConfigFiles/ConfigSysmansion_operation_event"
local MansionNpcEventView = mLuaClass("MansionNpcEventView", mBaseVindow);
local mIpairs = ipairs;
local mPairs = pairs;

function MansionNpcEventView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_npc_event_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionNpcEventView:Init()
	self.mTextTitle = self:FindComponent( 'TextTitle', 'Text' );
	self.mTextDesc = self:FindComponent( 'Text_desc', 'Text' );
	self.mTextBuff = self:FindComponent( 'Text_buff', 'Text' );

	local goodsList = {};
	for i = 1, 3 do
		goodsList[ i ] = mCommonGoodsItemView.LuaNew( self:Find('goods_'..i).gameObject );
	end
	self.mGoodsList = goodsList;

	self:FindAndAddClickListener ( 'Button_1' , function() self:OnClickGetReward(); end , nil, 0.5 );

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_EVENT_REWARD, function(vo)
   		self:OnGetNpcEventReward(  );
   	end, true);

	self.mModelShowView = ModelRenderTexture.LuaNew( self:Find('model') );
end

function MansionNpcEventView:OnGetNpcEventReward(  )
	self:HideView( );
end

function MansionNpcEventView:OnViewShow(logicParams)
	self.mModelShowView:ShowView( );
	self.mEventID = logicParams.mPbData.event_npc_id ;
	local sys_vo = mConfigSysmansion_operation_event[ self.mEventID ];
	self:UpdateBaseInfo( sys_vo );
end

function MansionNpcEventView:UpdateBaseInfo( sys_vo )
	self.mTextTitle.text = sys_vo.title;
	self.mTextDesc.text  = sys_vo.desc;
	self.mTextBuff.text = sys_vo.buff_desc;
	self.mModelShowView:OnUpdateUI( sys_vo.model , true );

	local asset = sys_vo.assets;
	for k, v in pairs( self.mGoodsList ) do
		local vo = asset and asset[ k ] or nil;
		if vo then
			v:ShowView( );
			v:UpdateByIdAndNum(  vo.key, vo.value );
		else
			v:HideView( );
		end
	end
end

function MansionNpcEventView:OnClickGetReward(  )
	MansionController:SendGetNpcEventReward( self.mEventID );
end

function MansionNpcEventView:OnViewHide( )
	self.mModelShowView:HideView( );
end

function MansionNpcEventView:Dispose( )
	self.mModelShowView:Dispose( );
end

return MansionNpcEventView;