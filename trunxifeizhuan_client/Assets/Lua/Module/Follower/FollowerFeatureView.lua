local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGlobalUtil = require "Utils/GlobalUtil"
local FollowerController = require "Module/Follower/FollowerController"
local FollowerFeatureView = mLuaClass("FollowerFeatureView",mBaseView);
local mGlobalColors = mGlobalUtil.Colors;
local mColor = Color;

function FollowerFeatureView:Init()
	self:InitSubView( );
	self:AddListener( );   
end

function FollowerFeatureView:InitSubView( )
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextType = self:FindComponent('Text_type', 'Text');
	self.mLockState = self:FindComponent('Button_lock','GameImage');
	self.mTypeState = self:FindComponent('Image_type','Image');
	self.mPowerState = self:FindComponent('Image_power','Image');
	self.mImageLock = self:FindComponent('Button_lock','Image');
	self.mImageLock.color = mColor.clear;

	local star_list = {};
	for i = 1, mGlobalUtil.FollowerStar do
		local go = self:Find('star_'..i).gameObject;
		star_list[i] = go;
	end
	self.mStarList = star_list;

	local callBack = function() self:OnClickSelect() end;
	local btn_select = self:Find('Button_select').gameObject;
	self:AddBtnClickListener(btn_select, callBack);
	self.mButtonSelect = btn_select;

	self:FindAndAddClickListener("Text_name", function() self:OnClickAlterName() end);
	self:FindAndAddClickListener('Button_lock', function() self:OnClickLockButton() end);

	local btn_comment = self:Find( 'Button_comment' ).gameObject;
	self:AddBtnClickListener(btn_comment, function() self:OnClickCommentButton() end);
	self.mButtonComment = btn_comment;
end

function FollowerFeatureView:AddListener(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_ALTER_NAME, function(vo)
		self:OnUpdateName( vo )
	end, true);
	
	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_LOCK, function(vo)
		self:OnUpdateLock( vo );
	end, true);
end

function FollowerFeatureView:OnClickButtonItem(index)
	local show = index ~= 5;
	self.mButtonComment:SetActive( show);
	self.mLockState.gameObject:SetActive( show );
end

function FollowerFeatureView:OnClickCommentButton(  )
	mUIManager:HandleUI( mViewEnum.FollowerCommentView, 1, self.mData );
end

function FollowerFeatureView:OnUpdateLock( data )
	local icon = data.mLockFlag == 0 and 'retinue_lock1' or 'retinue_lock2';
	self.mLockState:SetSprite(icon);
	self.mImageLock.color = mColor.white;
end

function FollowerFeatureView:OnUpdateName( data )
	local office = data:GetOffice( );
	office = math.min(office, 7);
	self.mTextName.text =  string.format( mGlobalColors[ office ], data:GetName() )
end

function FollowerFeatureView:OnUpdateUI(data)
	self.mData = data;
	local star = data:GetStar();
	for k, v in pairs( self.mStarList ) do
		v:SetActive(k <= star);
	end

	self:OnUpdateName( data );
	self:OnUpdateLock( data );
	self.mTextType.text = data:GetTypeName( );
	self.mButtonSelect:SetActive(not data:IsLead(  ));
	self.mGameObjectUtil:SetImageSprite(self.mTypeState, data:GetTypeIcon( ));
	self.mGameObjectUtil:SetImageSprite(self.mPowerState, data:GetPowerIcon( ));
end

function FollowerFeatureView:OnClickAlterName(  )
	mUIManager:HandleUI(mViewEnum.FollowerAlterNameView, 1, self.mData);
end

function FollowerFeatureView:OnClickSelect()
	--mUIManager:HandleUI(mViewEnum.FollowerImageSelectView, 1, self.mData);
end

--锁定状态0未锁定1锁定
function FollowerFeatureView:OnClickLockButton(  )
	local data = self.mData;
	local lock = data.mLockFlag;
	lock = lock == 0 and 1 or 0;
	FollowerController:SendLockFollower( data.mUID, lock );
end

return FollowerFeatureView;