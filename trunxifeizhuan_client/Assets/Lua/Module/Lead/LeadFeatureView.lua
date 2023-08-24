local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local LeadFeatureView = mLuaClass("LeadFeatureView",mBaseView);

function LeadFeatureView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mPowerState = self:FindComponent('Image_power','Image');

	--self:FindAndAddClickListener("Text_name", function() self:OnClickAlterName() end);
end

function LeadFeatureView:OnUpdateUI(data)
	self.mData = data;

	self.mTextName.text = data:GetName();
	self.mGameObjectUtil:SetImageSprite(self.mPowerState, data:GetPowerIcon( ));
end

return LeadFeatureView;