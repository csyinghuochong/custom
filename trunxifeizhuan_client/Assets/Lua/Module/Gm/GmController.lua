local mLuaClass = require "Core/LuaClass";
local mBaseController = require "Core/BaseController";
local mGameModelManager = require "Manager/GameModelManager";
local mCombatModelManager = require "Module/Combat/CombatModelManager";

local GmController = mLuaClass("GmController", mBaseController);

function GmController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:CHAT_GM_MASTER(function(Data)
		mGameModelManager.GmModel:OnRecvGmList(Data)
	end);
end

function GmController:getServerGmList()
	--这里获取gm命令列表
	--这里发送协议获取gm命令列表

	-- 这里暂时用测试数据
	-- local gmTable = {"add_gold":"增加元宝", "send_sys_mail":"发送系统邮件"};
	-- local mGmModel = mGameModelManager.GmModel;
	-- mGmModel:OnRecvGmList();
	self.mC2S:CHAT_GM_MASTER();
end

-- 测试战斗
function GmController:Fight()
	mCombatModelManager:CreateGmCombatModel(4010017);
end

local mGmControllerInstance = GmController.LuaNew();


return mGmControllerInstance;