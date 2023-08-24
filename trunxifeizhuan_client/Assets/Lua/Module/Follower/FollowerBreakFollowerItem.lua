local mLuaClass = require "Core/LuaClass"
local mFollowerItemView = require "Module/Follower/FollowerItemView"
local FollowerBreakFollowerItem = mLuaClass("FollowerBreakFollowerItem",mFollowerItemView);
local mSuper = nil;

function FollowerBreakFollowerItem:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_item_view",
	};
end

function  FollowerBreakFollowerItem:ClickFollowerItem()
	local mEventEnum = self.mEventEnum;

	if self.mShowSelectd then
		self:Dispatch(mEventEnum.ON_CANCEL_BREAK_FOLLOWER, self.mData);
	else
		self:Dispatch(mEventEnum.ON_SELECT_BREAK_FOLLOWER, self.mData);
	end
end

function FollowerBreakFollowerItem:OnSelected()
	
end

return FollowerBreakFollowerItem;