local mLuaClass = require "Core/LuaClass"
local LeadSkillHuangqinView = require "Module/Lead/LeadSkillHuangqinView"
local LeadSkillDonggongView = mLuaClass("LeadSkillDonggongView", LeadSkillHuangqinView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function LeadSkillDonggongView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_skill_donggong_view",
	};
end

function LeadSkillDonggongView:GetSkillBranch(  )
	return 3;
end

return LeadSkillDonggongView;