local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mCommonAllAwardItemView = require "Module/CommonUI/CommonAllAwardItemView"
local CommonGetAwardItemView = mLuaClass("CommonGetAwardItemView",mCommonAllAwardItemView);
local mSuper = nil;

function CommonGetAwardItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_get_award_item_view",
	};
end

function CommonGetAwardItemView:Init()
	self.mTextName = self:FindComponent("name","Text");
	mSuper = self:GetSuper(mCommonAllAwardItemView.LuaClassName);
	mSuper.Init(self);
end

function CommonGetAwardItemView:OnUpdateData()
	mSuper.OnUpdateData(self);
	local param = self.mData;
	local strName;
	if param.mIsTalent then
		strName = param.mGoodsData:GetName();
	else
		strName = param.mGoodsData.mSysVO.goods_name;
	end
	self.mTextName.text = strName;
end

function CommonGetAwardItemView:Dispose( )
	self.mTalent:CloseView( );
	self.mItem:CloseView( );
end

return CommonGetAwardItemView;