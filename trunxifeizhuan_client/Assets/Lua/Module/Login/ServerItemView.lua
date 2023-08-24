local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local ServerItemView = mLuaClass("ServerItemView",mLayoutItem);
local mSuper = nil;

function ServerItemView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "server_item_view",
	};
end

function ServerItemView:Init( )
	self.mTextServerName = self:FindComponent('Text', 'Text');
	self.mServerState = self:FindComponent('Image_state','Image');
	self:AddBtnClickListener(self.mGameObject,function() self:ClickServerItem() end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ServerItemView:ClickServerItem()
	local data = self.mData;
	local call_back = data.mCallBack;
	if call_back then
		call_back(data);
	end
end

function ServerItemView:OnViewShow( )
	
end

function ServerItemView:OnUpdateData()
	self.mTextServerName.text = self.mData.mServerName;
	--self.mGameObjectUtil:SetImageSprite(self.mServerState, "login_icon_red");
end

return ServerItemView;