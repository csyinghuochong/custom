local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote";
local PromoteJoinVO = mLuaClass("PromoteJoinVO", BaseLua);
local mLanguageUtil = require "Utils/LanguageUtil"
local mExemDescLevel = mLanguageUtil.promote_exam_level;
local mExemDescOffice = mLanguageUtil.promote_exam_office;
local mTable = require 'table'
local mString = require 'string'

function PromoteJoinVO:GetRoleOffice( )
	return mGameModelManager.RoleModel:GetOffice();
end

function PromoteJoinVO:GetNeedOffice( id )
	local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	return mLeadBaseVO:GetOfficeName( id, sex);
end

function PromoteJoinVO:GetRoleLevel(  )
	return mGameModelManager.RoleModel.mPlayerBase.level;
end

function PromoteJoinVO:GetExamCondition(  )
	local text_desc = {};
	local role_office = self:GetRoleOffice();
	local exam_condition = mConfigSyspromote[ role_office ].exam_condition;
	for k, v in pairs(exam_condition) do
		if v ~= 0 then
			local l_desc = "";
			local l_state = false;

			if k == 1 then
				l_desc = mString.format(mExemDescLevel, v);
				l_state = self:GetRoleLevel( ) >= v;
			else
				l_desc = mString.format(mExemDescOffice, self:GetNeedOffice(v));
				l_state = role_office >= v ;
			end
			mTable.insert(text_desc, { desc = l_desc, state = l_state  });
		end
	end
	return text_desc;
end

return PromoteJoinVO;