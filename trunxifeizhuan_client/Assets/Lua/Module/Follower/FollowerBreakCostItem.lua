local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local FollowerBreakCostItem = mLuaClass("FollowerBreakCostItem", mBaseView);
local mSuper;

function FollowerBreakCostItem:OnLuaNew(go, callBack)
	self.mCallBack = callBack;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
   	mSuper.OnLuaNew(self,go);
end

function FollowerBreakCostItem:Init()
	self.mObjectLock = self:Find( 'lock' ).gameObject;
	self.mObjectAdd =  self:Find( 'button_add' ).gameObject;
	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('retinue_item').gameObject);

	self:FindAndAddClickListener('button_add', function() self:OnClickButton() end);
end

function FollowerBreakCostItem:OnClickButton(  )
	self.mCallBack( );
end

function FollowerBreakCostItem:SetValid( )
	self.mCostData = nil;
	self.mFollowerItem:HideView();
	self.mObjectAdd:SetActive( true );
	self.mObjectLock:SetActive( false );
end

function FollowerBreakCostItem:Reset( )
	self.mCostData = nil;
	self.mObjectAdd:SetActive( false );
	self.mObjectLock:SetActive( true );
	self.mFollowerItem:HideView();
end

function FollowerBreakCostItem:SetLock(  )
	self:Reset( );
end

function FollowerBreakCostItem:OnSelectCostItem(  data )
	self.mCostData = data;
	self.mFollowerItem:ShowView();
	self.mFollowerItem:ExternalUpdateData(data);
end

function FollowerBreakCostItem:OnCancelCostItem(  )
	self.mCostData = nil;
	self.mFollowerItem:HideView();
end

return FollowerBreakCostItem;