local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local WorshipQueenController = mLuaClass("WorshipQueenController",mBaseController);

--协议处理--
function WorshipQueenController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:QUEEN_WISH(function(pbWorshipReward)
		mGameModelManager.WorshipQueenModel:OnRecvWishAward(pbWorshipReward);
	end);

	s2c:QUEEN_GIFT(function(pbWorshipReward)
		mGameModelManager.WorshipQueenModel:OnRecvGiftAward(pbWorshipReward);
	end);

	s2c:QUEEN_INFO(function(pbQueenInfo)
		mGameModelManager.WorshipQueenModel:OnRecvQueenInfo(pbQueenInfo);
	end);
end

--事件处理--
function WorshipQueenController:AddEventListeners()
	
end

function WorshipQueenController:OnSendWish(state)
	if state == 1 then
		self.mC2S:QUEEN_WISH(true);
	else
		self.mC2S:QUEEN_GIFT(true);
	end
end

function WorshipQueenController:OnGetQueenInfo()
	self.mC2S:QUEEN_INFO(true);
end


local mWorshipQueenControllerInstance = WorshipQueenController.LuaNew();
return mWorshipQueenControllerInstance;