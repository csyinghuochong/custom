local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local MansionController = require "Module/Mansion/MansionController"
local CommonPopMenuView = require "Module/Mansion/CommonPopMenuView"
local mConfigSysmansion_operation_event = require "ConfigFiles/ConfigSysmansion_operation_event"
local MansionNpcModelItem = mLuaClass("MansionNpcModelItem",mBaseView);

function MansionNpcModelItem:Init()
	local modelView = ModelRenderTexture.LuaNew( self:Find('model') );
	self.mModelShowView = modelView;
	self:InitPopMenuData(  );

	self:FindAndAddClickListener( 'button_1',  function ( ) self:OnClickNpc(); end , nil, 1);
end

function MansionNpcModelItem:OnUpdateUI( data )
	self.mData = data;
	local event_id = data.mPbData.event_npc_id;
	local sysVo = mConfigSysmansion_operation_event[ event_id ];
	self.mModelShowView:OnUpdateUI( sysVo.model , true );
	self.mEventID = event_id;
	self.mEventVO = sysVo;
end

function MansionNpcModelItem:OnClickNpc( )
	if self.mEventVO.type == 1 then
		self:OpenPopMenu( );
	else
		self:OpenNpcView( );
	end
end

function MansionNpcModelItem:InitPopMenuData(  )
	self.mMenuData = 
	{
		{ btnName = mLanguageUtil.mansion_npc_event_check,  callBack = function() self:OnClickCheck() end },
		{ btnName = mLanguageUtil.mansion_npc_event_expel,  callBack = function() self:OnClickExpel() end },
	};
end

function MansionNpcModelItem:OpenPopMenu(  )
	local l_position = CommonPopMenuView:ObjectToUIPosition( self.mTransform ); 
	l_position.x = l_position.x + 100;
	l_position.y = l_position.y + 100;
	mUIManager:HandleUI(mViewEnum.CommonPopMenuView, 1, { data = self.mMenuData, position = l_position } );
end

function MansionNpcModelItem:OpenNpcView(  )
	mUIManager:HandleUI(mViewEnum.MansionNpcEventView, 1, self.mData);
end

function MansionNpcModelItem:OnClickCheck( )
	mUIManager:HandleUI(mViewEnum.MansionStoreView, 1, self.mData);
end

function MansionNpcModelItem:OnClickExpel( )
	MansionController:SendDeleteNpcEvent( self.mEventID );
end

function MansionNpcModelItem:OnViewShow()
	self.mModelShowView:ShowView();
end

function MansionNpcModelItem:OnViewHide()
	self.mModelShowView:HideView();
end

function MansionNpcModelItem:Dispose(  )
	self.mModelShowView:Dispose();
end

return MansionNpcModelItem;