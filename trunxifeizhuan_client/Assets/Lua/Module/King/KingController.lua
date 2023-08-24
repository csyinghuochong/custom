local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local KingController = mLuaClass("KingController",mBaseController);

function KingController:AddNetListeners()
	self.mS2C:MONRACH_AUDIENCE_GET(function(pbId32)
		mGameModelManager.KingModel:RecvMonarchOpen(pbId32.id);
		self:Dispatch(mEventEnum.ON_GET_MONARCH_DATA);
	end);
    self.mS2C:MONRACH_AUDIENCE_UPDATE(function(pbMoarchAudience)
		mGameModelManager.KingModel:RecvMonarchUpdate(pbMoarchAudience);
        self:Dispatch(mEventEnum.ON_RUN_NEXT_STORY);
        self:Dispatch(mEventEnum.ON_MONARCH_BEGIN);
	end);
	self.mS2C:MONRACH_AUDIENCE_RESULT(function(pbMonarchAudienceResult)
		mGameModelManager.KingModel:RecvMonarchReward(pbMonarchAudienceResult);
        
	end);

	self.mS2C:MONRACH_GET_SKILL_LIST(function(pbMonarchGetSkills)
		mGameModelManager.KingModel:RecvSkillData(pbMonarchGetSkills);
        self:Dispatch(mEventEnum.ON_SKILL_UPDATE);
	end);
    self.mS2C:MONRACH_START(function(pbMonarchGetSkills)
		mGameModelManager.KingModel:RecvSkillData(pbMonarchGetSkills);
        self:Dispatch(mEventEnum.ON_SKILL_UPDATE);
	end);
end

function KingController:AddEventListeners()

end

function KingController:SendMonrachGetOpen()
	self.mC2S:MONRACH_AUDIENCE_GET(true);
end

function KingController:SendMonrachUpdate(id)
	self.mC2S:MONRACH_AUDIENCE_UPDATE(id,true);
end

--1邀宠 2承恩
function KingController:SendGetSkillData(type)
	self.mC2S:MONRACH_GET_SKILL_LIST(type,true);
end

function KingController:GetSkillListData()
    local isOpen = mFunctionOpenManager:GetFunctionState(mConfigsysfunctionConst.KING);
    local model = mGameModelManager.KingModel;
    if isOpen and not model.mInviteRecv then
        self:SendGetSkillData(1);
    end
end

function KingController:SendUpdateSkill(type,skillId)
	self.mC2S:MONRACH_START(type,skillId,true);
end

return KingController.LuaNew();