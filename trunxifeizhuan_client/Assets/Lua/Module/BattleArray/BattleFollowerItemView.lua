local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mFollowerItemView = require "Module/Follower/FollowerItemView"
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local BattleFollowerItemView = mLuaClass("BattleFollowerItemView",mFollowerItemView);
local mSuper = nil;

function BattleFollowerItemView:Init()
	self.mFollowerData = {follower = nil, state = nil};
	self.mImageSelect = self:Find("on_select").gameObject;
	local buttonInfo = self:Find('icon').gameObject;
	local btn = CommonButtonEventListener.LuaNew(buttonInfo,0.75,nil,function() self:ClickLookUpFollower() end,nil);

	mSuper = self:GetSuper(mFollowerItemView.LuaClassName);
	mSuper.Init(self);
end

function  BattleFollowerItemView:ClickFollowerItem()
	local data = self.mData;
	if not data:IsLead() then
		local followerData = self.mFollowerData;
		followerData.follower = data;
		followerData.state = not self.mIsSelectd;
		self:DispatchFollowerData(followerData);
	end
end

function BattleFollowerItemView:DispatchFollowerData(data)
	self:Dispatch(mEventEnum.ON_SELECT_BATTLE_FOLLOWER, data);
	self:PlaySoundName("ty_0208");
end

function  BattleFollowerItemView:ClickLookUpFollower()
	local data = self.mData;
	if data then
		mUIManager:HandleUI(mViewEnum.BattleFollowerInfoView, 1, data);
	end
end

function  BattleFollowerItemView:UpdateUI()
	mSuper.UpdateUI(self);
	self.mGameObject:SetActive(true);
	self:ShowSelectedFlag(self.mIsSelectd or false);
end

function  BattleFollowerItemView:ShowSelectedFlag(selected)
	self.mIsSelectd = selected;
	local imageSelect = self.mImageSelect;
	if imageSelect ~= nil then
		imageSelect:SetActive(selected);
	end
end

return BattleFollowerItemView;