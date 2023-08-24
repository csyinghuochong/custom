local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local CommonPopMenuView = require "Module/Mansion/CommonPopMenuView"
local mConfigSysmansion_servant = require "ConfigFiles/ConfigSysmansion_servant"
local MansionServantModelItem = mLuaClass("MansionServantModelItem",mBaseView);
local RectTransformUtility = UnityEngine.RectTransformUtility;
local Input = UnityEngine.Input;
local mSuper = nil;

function MansionServantModelItem:OnLuaNew( id, go )
	self.mID = id;
	self.mSysVO = mConfigSysmansion_servant[ id ]; 

	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self,go);
end

function MansionServantModelItem:Init()
	local sysVO = self.mSysVO;
	local modelView = ModelRenderTexture.LuaNew( self:Find('model') );
	modelView:OnUpdateUI( sysVO.model , 1 );
	self.mModelShowView = modelView;

	self:FindAndAddClickListener( 'button_1',  function ( ) self:OnClickServant(); end , nil, 1);
end

function MansionServantModelItem:OnUpdateUI( data )
	self.mData = data;

	if data:IsNotHire() then
		self:HideView( );
	else
		self:ShowView( );
	end
end

function MansionServantModelItem:OnClickServant( )
	local data = self.mData;
	if not data.mMansionVO:CanOperateServant() then
		return;
	end

	local l_position = CommonPopMenuView:ObjectToUIPosition( self.mTransform ); 
	l_position.x = l_position.x + 100;
	mUIManager:HandleUI(mViewEnum.MansionServantOperateView,1,  { data = self.mData, pos = l_position } );
end

function MansionServantModelItem:OnViewShow()
	self.mModelShowView:ShowView();
end

function MansionServantModelItem:OnViewHide()
	self.mModelShowView:HideView();
end

function MansionServantModelItem:Dispose(  )
	self.mModelShowView:Dispose( );
end

return MansionServantModelItem;