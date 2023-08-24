local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mSkillIconPath = mResourceUrl.skill_icon;
local mLayoutController = require "Core/Layout/LayoutController"
local mFollowerController = require "Module/Follower/FollowerController"
local LeadSkillActiveView = mLuaClass("LeadSkillActiveView", mBaseWindow);

function LeadSkillActiveView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_skill_active_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function LeadSkillActiveView:Init()
	self.mObjTransform = self:Find('gameObject');
	local parent = self:Find('gameObject/ScrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerSkillDescItem");

	self.mSkillDesc = self:FindComponent('gameObject/Text_desc', 'Text');
	self.mSkillName = self:FindComponent('gameObject/Text_name', 'Text');

	self:FindAndAddClickListener("gameObject/button_1", function() self:HideView() end);

	self.mImageIcon = self:FindComponent('gameObject/skill/Imange_icon', 'RawImage');
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
end

function LeadSkillActiveView:OnViewShow(logicParams)
	local data = logicParams[1];
	local pos  = logicParams[2];
	local data_source = data:GetDescVOList();
	self.mGridEx:UpdateDataSource(data_source);
	self:ShowSkillDesc(data.mSkillInfo);
	self.mObjTransform.localPosition = pos == 1 and Vector3.New(-198.5, -23.6, 0) or Vector3.zero;
end

function LeadSkillActiveView:ShowSkillDesc(data)
	self.mSkillDesc.text = data.desc;
	self.mSkillName.text = data.name;
	mUITextureManager.LoadTexture(mSkillIconPath, data.icon,self.mLoadedIcon);
end

function LeadSkillActiveView:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
end

function LeadSkillActiveView:Dispose()
	self.mGridEx:Dispose();
end

return LeadSkillActiveView;