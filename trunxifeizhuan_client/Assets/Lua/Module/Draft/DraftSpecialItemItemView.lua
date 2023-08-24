local mLuaClass = require "Core/LuaClass"
local FollowerItemView = require "Module/Follower/FollowerItemView"
local DraftSpecialItemItemView = mLuaClass("DraftSpecialItemItemView",FollowerItemView);

function  DraftSpecialItemItemView:ClickFollowerItem()
	self:Dispatch(self.mEventEnum.ON_DRAFT_SHOW_FOLLOWER,self.mData);
end

return DraftSpecialItemItemView;