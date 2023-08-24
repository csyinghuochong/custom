local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mFollowerSkillList = require "Module/Follower/FollowerSkillList"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeView"
local BattleFollowerInfoView = mLuaClass("BattleFollowerInfoView", mQueueWindow);

function BattleFollowerInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/battle_array/",
		["viewName"] = "battle_follower_info_view",
		["ParentLayer"] = mMainLayer2,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function BattleFollowerInfoView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextOffice = self:FindComponent('Text_office', 'Text');
	self.mTextType = self:FindComponent('Text_actor_type', 'Text');

	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('follower_item_view').gameObject);
	self.mSkillListView = mFollowerSkillList.LuaNew(self:Find('follower_skill_list').gameObject);
	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('follower_attri_view').gameObject);

	self:FindAndAddClickListener("common_bg/Button_close",function() self:HideView() end);
end

function BattleFollowerInfoView:OnViewShow(logicParams)
	local type_name, type_icon = logicParams:GetTypeInfo();
	self.mTextType.text = type_name;
	self.mTextName.text = logicParams:GetName();
	self.mTextOffice.text = logicParams:GetOfficeName();

	self.mFollowerItem:ExternalUpdateData(logicParams);
	self.mSkillListView:OnUpdateUI(logicParams);
	self.mAttributeView:OnUpdateUI(logicParams);
end

function BattleFollowerInfoView:Dispose()
	self.mSkillListView:CloseView();
	self.mAttributeView:CloseView();
end

return BattleFollowerInfoView;