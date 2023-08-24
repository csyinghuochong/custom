local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local WorshipAncestorController = mLuaClass("WorshipAncestorController",mBaseController);

--协议处理--
function WorshipAncestorController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:WORSHIP_ANCESTOR_INFO(function(pbWorshipInfo)
		mGameModelManager.WorshipAncestorModel:OnRecvInfo(pbWorshipInfo);
	end);

	s2c:WORSHIP_ANCESTOR(function(pbWorshipReward)
		mGameModelManager.WorshipAncestorModel:OnRecvAward(pbWorshipReward);
	end);
end

--事件处理--
function WorshipAncestorController:AddEventListeners()
	
end

function WorshipAncestorController:OnGetInfo()
	self.mC2S:WORSHIP_ANCESTOR_INFO(true);
end

function WorshipAncestorController:OnGetAward()
	self.mC2S:WORSHIP_ANCESTOR(true);
end

local mWorshipAncestorControllerInstance = WorshipAncestorController.LuaNew();
return mWorshipAncestorControllerInstance;