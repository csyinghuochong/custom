local mLuaClass = require "Core/LuaClass"
local mS2C = require "ProtolManager/S2C"
local mNetManager = require "Net/NetManager"
local mBaseController = require "Core/BaseController"
local mConfigSysecode = require "ConfigFiles/ConfigSysecode"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mConfigSysecodeConst = require "ConfigFiles/ConfigSysecodeConst"
local ErrorCodeController = mLuaClass("ErrorCodeController",mBaseController);
local mErrorCodeActionList = {};
function ErrorCodeController:RegisterErrorCodeAction(errorID,action)
	if errorID == nil or action == nil  then
		error("RegisterErrorCodeAction nil");
	end

	if mErrorCodeActionList[errorID] ~= nil then
		error("RegisterErrorCodeAction error");
	end

	mErrorCodeActionList[errorID] = action;
end

function ErrorCodeController:AddNetListeners()
	mS2C:ERROR_CODE(function(pbError)
		local code = pbError.error_code;
		print("errorCode:",code);
		local externalErrorAction = mErrorCodeActionList[code];
		if externalErrorAction then
			externalErrorAction(mConfigSysecode[code]);
		else
			mCommonTipsView.Show(mConfigSysecode[code].error_tips);
		end
	end);
end

return ErrorCodeController.LuaNew();