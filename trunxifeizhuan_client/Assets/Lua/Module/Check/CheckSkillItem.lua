local mLuaClass = require "Core/LuaClass"
local mCommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local CheckSkillItem = mLuaClass("CheckSkillItem",mCommonSkillItemView)

function CheckSkillItem:InitViewParam()
	return {
		["viewPath"] = "ui/check/",
		["viewName"] = "check_skill_item",
	};
end

return CheckSkillItem;