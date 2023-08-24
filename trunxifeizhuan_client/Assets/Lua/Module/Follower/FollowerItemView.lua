local mLuaClass = require "Core/LuaClass"
local CommonFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local FollowerItemView = mLuaClass("FollowerItemView",CommonFollowerItemView);
local mSuper = nil;

function FollowerItemView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_item_view",
	};
end

function  FollowerItemView:ClickFollowerItem()
	self:SetSelected(true);
end

function  FollowerItemView:OnSelected(select)
	if select then
		local data = self.mData;
		if data.mIsSelfActor then
    		self:Dispatch(self.mEventEnum.ON_SELECT_FOLLOWER,self.mData);
    	else
    		self:Dispatch(self.mEventEnum.ON_SELECT_OTHERS_FOLLOWER,self.mData);
    	end
	end
end

return FollowerItemView;