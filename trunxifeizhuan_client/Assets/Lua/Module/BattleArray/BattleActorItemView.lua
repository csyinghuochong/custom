local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local BattleActorItemView = mLuaClass("BattleActorItemView",mBaseView);
local mSuper = nil;

function BattleActorItemView:OnLuaNew( team, go, canOpLead )
	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self,go);

    self.mTeam = team;
    self.mCanOpLead = canOpLead;
end

function BattleActorItemView:Init()
	self.mFollowerData = {follower = nil, state = nil};
	self.mImageBg = self:Find('Image_bg').gameObject;
	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('item').gameObject);

	local btn = CommonButtonEventListener.LuaNew(self.mImageBg,0.75,nil,function() self:ClickLookUpFollower() end,function() self:OnClickLeaveArray() end);
end

function  BattleActorItemView:ClickLookUpFollower()
	local data = self.mData;
	if self.mTeam == 2 then
		mUIManager:HandleUI(mViewEnum.BattleMonsterInfoView, 1, data);
	else
		mUIManager:HandleUI(mViewEnum.BattleFollowerInfoView, 1, data);
	end
end

function BattleActorItemView:OnClickLeaveArray( )
	local data = self.mData;
	if data == nil then
		return;
	end
	if self.mTeam == 2 then
		mUIManager:HandleUI(mViewEnum.BattleMonsterInfoView, 1, data);
	elseif self.mTeam == 1  then
		if self.mCanOpLead or not data:IsLead(  ) then
			local followerData = self.mFollowerData;
			followerData.follower = self.mData;
			followerData.state = false;
			self:Dispatch(mEventEnum.ON_SELECT_BATTLE_FOLLOWER,  followerData );
			self:PlaySoundName("ty_0208");
		end
	end
end

function  BattleActorItemView:SetData(vo)
	self.mData = vo;
	local followerItem = self.mFollowerItem;
	if vo ~= nil then
		followerItem:ShowView();
		followerItem:ExternalUpdateData(vo);
	else
		followerItem:HideView();
	end
end

function  BattleActorItemView:SetSelected(selected)
	self.mImageSelect:SetActive(selected);
	if not selected then
		self.mData = nil;
	end
end

return BattleActorItemView;