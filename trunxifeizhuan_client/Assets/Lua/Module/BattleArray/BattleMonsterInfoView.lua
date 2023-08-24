local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mFollowerSkillList = require "Module/Follower/FollowerSkillList"
local mQueueWindow = require "Core/QueueWindow"
local BattleMonsterInfoView = mLuaClass("BattleMonsterInfoView", mQueueWindow);

function BattleMonsterInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/battle_array/",
		["viewName"] = "battle_monster_info_view",
		["ParentLayer"] = mMainLayer2,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function BattleMonsterInfoView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextOffice = self:FindComponent('Text_office', 'Text');
	self.mTextType = self:FindComponent('Text_actor_type', 'Text');
	self.mTextPower = self:FindComponent('Text_power', 'Text');

	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('monster_item_view').gameObject);
	self.mSkillListView = mFollowerSkillList.LuaNew(self:Find('monster_skill_list').gameObject);
end

function BattleMonsterInfoView:OnViewShow(logicParams)
	local type_name, type_icon = logicParams:GetTypeInfo();
	self.mTextType = type_name;
	self.mTextName.text = logicParams:GetName();
	self.mTextOffice.text = logicParams:GetOfficeName();
	self.mTextPower.text = logicParams:GetPowerName();

	self.mFollowerItem:ExternalUpdateData(logicParams);
	self.mSkillListView:OnUpdateUI(logicParams);
end

function BattleMonsterInfoView:Dispose()
	self.mSkillListView:CloseView();
end

return BattleMonsterInfoView;