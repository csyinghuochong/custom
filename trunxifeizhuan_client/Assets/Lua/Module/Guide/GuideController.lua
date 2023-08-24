local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local GuideController = mLuaClass("GuideController",mBaseController);

--协议处理--
function GuideController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:GUIDE_INFO(function(pbGuideInfo)
		mGameModelManager.GuideModel:OnRecvGuideInfo(pbGuideInfo);
	end);

	s2c:GUIDE_NOTICE(function(pbGuide)
		mGameModelManager.GuideModel:OnRecvGuideNotice(pbGuide);
	end);
end

--事件处理--
function GuideController:AddEventListeners()
	
end

--获取已完成的新手引导--
function GuideController:SendGetGuideInfo()
	self.mC2S:GUIDE_INFO(true);
end

--通知完成引导--
function GuideController:SendFinishGuide(id,step_id)
	print(id,step_id);
	self.mC2S:GUIDE_NOTICE(id,step_id,true);
end

local mGuideControllerInstance = GuideController.LuaNew();
return mGuideControllerInstance;