local mLuaClass = require "Core/LuaClass"
local CommonBaseItemView = require"Module/Fashion/Common/CommonBaseItemView"
local FashionStyleItemView = mLuaClass("FashionStyleItemView", CommonBaseItemView);
local Vector3 = Vector3;
local mScaleOne = Vector3.one;
local mPositions = {
	[1] = Vector3.New(0,0,0);
	[2] = Vector3.New(160,0,0);
	[3] = Vector3.New(0,-30,0);
	[4] = Vector3.New(160,-30,0);
}

local mExpSprites = {
	"common_redpipe",
	"common_retinue_streamer2",
	"common_dress_violet",
	"common_bluepipe",
	"common_greenpipe"
}
function FashionStyleItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "style_attribute_item_view",
	};
end

function FashionStyleItemView:OnAwake()

	self.mActivedView = self:Find("actived").gameObject;
	self.mUnActiveView = self:Find("unactive").gameObject;
	self.mStyleText = self:FindComponent("actived/style_type","Text");
	self.mGradeText = self:FindComponent("actived/grade","Text");
	self.mExpSlider = self:FindComponent("actived/exp","Slider");
	self.mExpGraphic = self:FindComponent("actived/exp/Fill","Image");
	self.mUnActiveText = self:FindComponent("unactive","Text");
end

function FashionStyleItemView:GetPosition()
	return mPositions[self.mIndex or 1];
end

function FashionStyleItemView:UpdateUnActiveView(data)
	self.mUnActiveText.text = string.format("%s(%d 星激活)",data:GetName(),data.actived_star);
end

function FashionStyleItemView:AlwaysShowActiveView()
	self.mAlaysShowActiveView = true;
end

function FashionStyleItemView:UpdateActiveView(data)

	self.mStyleText.text = data:GetName();
	self.mGradeText.text = data:GetGradeName();
	self.mGameObjectUtil:SetImageSprite(self.mExpGraphic,mExpSprites[data.grade]);
	self.mExpSlider.value = data.grade_offset;
end

function FashionStyleItemView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionStyleItemView:OnUpdateData(data)

	local actived = data.actived;
	if self.mAlaysShowActiveView then
		actived = true;
	end

	local activeView = self.mActivedView;
	local unactiveView = self.mUnActiveView;

	activeView:SetActive(actived);
	unactiveView:SetActive(actived == false);

	if actived then
		self:UpdateActiveView(data);
	else
		self:UpdateUnActiveView(data);
	end
end
return FashionStyleItemView;