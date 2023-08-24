local mLuaClass = require "Core/LuaClass"
local mCommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local CommonSkillBaseItemView = mLuaClass("CommonSkillBaseItemView", mCommonSkillItemView);

function CommonSkillBaseItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_skill_base_item_view",
	};
end

return CommonSkillBaseItemView;