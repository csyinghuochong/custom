local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGlobalUtil = require "Utils/GlobalUtil"
local FollowerTalentSuitItem = require "Module/Follower/FollowerTalentSuitItem"
local FollowerTalentSuitView = mLuaClass("FollowerTalentSuitView",mBaseView);

function FollowerTalentSuitView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_talent_suit_view",
	};
end

function FollowerTalentSuitView:Init()
	self:SetParent(self.mGoParent);
	self.mSuitDesc = self:Find( 'talent_desc' ).gameObject;
	self.mRectSuitBg =  self:FindComponent( 'talent_desc/bg', 'RectTransform' );
	self.mTextSuitName = self:FindComponent( 'talent_desc/bg/name', 'Text' );
	self.mTextSuitDesc = self:FindComponent( 'talent_desc/bg/desc', 'Text' );
	self.mSuitDesc:SetActive( false );

	local callBack = function ( data, flag )
		self:OnPressTalentSuitItem( data, flag );
	end
	local suitList = {};
	for i = 1, 3 do
		suitList[ i ] = FollowerTalentSuitItem.LuaNew( self:Find( 'talent_sout/'..i ).gameObject, i, callBack );
	end
	self.mSuitList = suitList;
end

function FollowerTalentSuitView:OnViewShow(data)
	self.mData = data;
	self:UpdateSuitList( data );
end

function FollowerTalentSuitView:OnPressTalentSuitItem( data, flag )
	self.mSuitDesc:SetActive( flag == 1 );
	self.mTextSuitDesc.text = data:GetDesc( );
	self.mTextSuitName.text = data:GetSuitName( );
	local contentHeight = self.mTextSuitDesc.preferredHeight;
	self.mRectSuitBg.sizeDelta = Vector3.New( 280, contentHeight + 74, 0);
end

function FollowerTalentSuitView:UpdateSuitList( data )
	local suitList = self.mSuitList;
	local suitVOList = data:GetSuitList( );
	for k, v in pairs( suitList ) do
		 local vo = suitVOList[ k ];
		 if vo then
		 	v:ShowView( );
		 	v:ExternalUpdateData( vo );
		 else
		 	v:HideView( );
		 end
	end
end

return FollowerTalentSuitView;