local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local mTalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local CommonAllAwardItemView = mLuaClass("CommonAllAwardItemView",mLayoutItem);
local mSuper = nil;

function CommonAllAwardItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_all_award_item_view",
	};
end

function CommonAllAwardItemView:Init()
	self.mGoItem = self:Find("item").gameObject;
	self.mGoTalent = self:Find("talent").gameObject;

	local bg = self:FindComponent("bg","Image");
	local kuang = self:FindComponent("kuang","Image");

	local goTalent = self:Find("talent").gameObject;
	self.mTalent = mTalentItemBaseView.LuaNew(goTalent,bg,kuang);

	local goItem = self:Find("item").gameObject;
	self.mItem = mCommonGoodsItemView.LuaNew(goItem,bg,kuang);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CommonAllAwardItemView:ExternalUpdate(data)
	self.mData = data;
	self:OnUpdateData();
end

function CommonAllAwardItemView:OnUpdateData()
	local data = self.mData;
	local go;
	if data.mIsTalent then
		self.mTalent:ExternalUpdate(data.mGoodsData);
	else
		self.mItem:ExternalUpdate(data.mGoodsData);
	end
	self.mGoTalent:SetActive(data.mIsTalent);
	self.mGoItem:SetActive(not data.mIsTalent);
end

return CommonAllAwardItemView;