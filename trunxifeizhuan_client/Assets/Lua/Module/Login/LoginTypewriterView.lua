local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mTypewriterEffectView = require "Module/Story/TypewriterEffectView"
local LoginTypewriterView = mLuaClass("LoginTypewriterView", mBaseView);
local mSuper = nil;

function LoginTypewriterView:OnLuaNew( go, text1, text2 )
	self.mTextValue1 = text1;
	self.mTextValue2 = text2;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
   	mSuper.OnLuaNew(self, go);
end

function LoginTypewriterView:Init()
	self.mView1 = mTypewriterEffectView.LuaNew( self:Find( 'view1' ).gameObject );
	self.mView2 = mTypewriterEffectView.LuaNew( self:Find( 'view2' ).gameObject );

	self.mViewParam1 = {text = self.mTextValue1, callback = function() self:OnView1End() end, charsPerSecond = 20};
	self.mViewParam2 = {text = self.mTextValue2, callback = function() self:OnView2End() end, charsPerSecond = 20};
end

function LoginTypewriterView:OnViewShow(  )
	self.mView1:ShowView( );
	self.mView1:SetData( self.mViewParam1 );
end

function LoginTypewriterView:OnView1End( )
	self.mView2:ShowView( );
	self.mView2:SetData( self.mViewParam2 );
end

function LoginTypewriterView:OnView2End(  )
	
end

function LoginTypewriterView:OnViewHide(  )
	self.mView1:HideView( );
	self.mView2:HideView( );
end

function LoginTypewriterView:Dispose()
	
end

return LoginTypewriterView;