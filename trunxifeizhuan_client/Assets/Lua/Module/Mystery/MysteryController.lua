local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local MysteryController = mLuaClass("MysteryController",mBaseController);

--协议处理--
function MysteryController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:PLAYER_SHOPS_MYSTERY_LIST(function(pbShopMysteryList)
		mGameModelManager.MysteryModel:OnRecvList(pbShopMysteryList);
	end);
	s2c:PLAYER_SHOPS_MYSTERY_BUY(function(pbResult)
		mGameModelManager.MysteryModel:OnRecvBuy(pbResult);
	end);
end

--事件处理--
function MysteryController:AddEventListeners()
	
end

--获取列表--
function MysteryController:SendGetList()
	self.mC2S:PLAYER_SHOPS_MYSTERY_LIST(true);
end

--购买--
function MysteryController:SendBuy(data)
	local model = mGameModelManager.MysteryModel;
	model.mSelectData = data;
	self.mC2S:PLAYER_SHOPS_MYSTERY_BUY(data.uid,true);
end

--刷新--
function MysteryController:SendRefresh()
	self.mC2S:PLAYER_SHOPS_MYSTERY_REFRESH(true);
end

local mMysteryControllerInstance = MysteryController.LuaNew();
return mMysteryControllerInstance;