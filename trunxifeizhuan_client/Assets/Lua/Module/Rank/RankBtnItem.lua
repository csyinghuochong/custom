local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mColor = Color
local RankBtnItem = mLuaClass("RankBtnItem",mLayoutItem);
local mSuper = nil;

function RankBtnItem:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_btn_item_view",
	};
end

function RankBtnItem:Init( )
	self.mTextTitle = self:FindComponent("text","Text");
	self.mGoNormal = self:Find("on_normal").gameObject;
	self.mGoSelect = self:Find("on_select").gameObject;
	self:FindAndAddClickListener("on_normal",function()self:OnClickBtn();end);
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_BUTTON_SELECT_RANK,function(data)self:OnChangeBtnState(data);end,true);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function RankBtnItem:OnClickBtn()
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_BUTTON_SELECT_RANK,self.mData);
end

function RankBtnItem:OnChangeBtnState(data)
	if data.config.type == self.mData.config.type then
		self.mData.isSelected = true;
	else
		if self.mData.isSelected then
			self.mData.isSelected = false;
		end
	end
	self:SetBtnState(self.mData);
end

function RankBtnItem:OnUpdateData()
	local data = self.mData;
	self.mTextTitle.text = data.config.btn_name;
	self:SetBtnState(data);
end

function RankBtnItem:SetBtnState(data)
	if data.isSelected then
		self.mGoNormal:SetActive(false);
		self.mGoSelect:SetActive(true);
	else
		self.mGoNormal:SetActive(true);
		self.mGoSelect:SetActive(false);
	end
end

return RankBtnItem;