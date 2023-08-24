local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local MansionServantModelItem = require "Module/Mansion/Servant/MansionServantModelItem"
local MansionServantModelView = mLuaClass("MansionServantModelView",mBaseView);

function MansionServantModelView:Init()
	self:AddListeners();
	self:InitSubView();
end

function MansionServantModelView:InitSubView(  )
	
	local servants = { 2, 3 };
	local servantModels = {};
	for k, id in pairs(servants) do
		servantModels[ id ] = MansionServantModelItem.LuaNew( id, self:Find(tostring(id)).gameObject );
	end
	self.mServantModels = servantModels;

end

function MansionServantModelView:AddListeners(  )
	
end

function MansionServantModelView:OnRecvMansionData( data )
	self.mData = data;
	local servantData = data.mServantList;
	for k, v in pairs( self.mServantModels ) do
		v:OnUpdateUI( servantData:GetValue( k ) );
	end
end

function MansionServantModelView:OnRecvServantHire( data )
	self.mServantModels[ data.mID ]:OnUpdateUI( data );
end

function MansionServantModelView:OnViewShow()

end

function MansionServantModelView:OnViewHide()
	for k, v in pairs( self.mServantModels ) do
		v:HideView( );
	end
end

function MansionServantModelView:Dispose()
	for k, v in pairs( self.mServantModels ) do
		v:CloseView( );
	end
	self.mServantModels = nil;
end

return MansionServantModelView;