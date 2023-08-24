local mLuaClass = require 'Core/LuaClass'
local mBaseLua = require 'Core/BaseLua' 
local mNetManager = require 'Net/NetManager' 
local S2C = mLuaClass('S2C',mBaseLua);
	
local pb_26_pb;
local pb_29_pb;
local pb_45_pb;
local pb_8_pb;
local pb_9_pb;
local pb_base_fight_pb;
local pb_common_pb;	

S2C.mReceiveCallback={};

--领取首充奖励
function S2C:FIRST_CHARGE(callback_pbPayFirst)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_8_pb = pb_8_pb or require('Protol.pb_8_pb');
			msg = pb_8_pb.pbPayFirst();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPayFirst(msg);
	end
	self.mReceiveCallback[8002] = doCallback;
end

--激活码领取奖励
function S2C:GET_CODE_AWARD(callback_pbCodeGoods)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_9_pb = pb_9_pb or require('Protol.pb_9_pb');
			msg = pb_9_pb.pbCodeGoods();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbCodeGoods(msg);
	end
	self.mReceiveCallback[9024] = doCallback;
end

--获取7天信息
function S2C:SIGN_7_INFO(callback_pbSignPlayerSign)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbSignPlayerSign();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbSignPlayerSign(msg);
	end
	self.mReceiveCallback[26005] = doCallback;
end

--领取7天奖励
function S2C:SIGN_7_GET_AWARD(callback_pbSignPlayerSign)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbSignPlayerSign();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbSignPlayerSign(msg);
	end
	self.mReceiveCallback[26006] = doCallback;
end

--获取另一个7天信息
function S2C:SIGN_7_INFO_OTHER(callback_pbSignPlayerSignList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbSignPlayerSignList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbSignPlayerSignList(msg);
	end
	self.mReceiveCallback[26007] = doCallback;
end

--领取另一个7天奖励
function S2C:SIGN_7_GET_AWARD_OTHER(callback_pbSignPlayerSignList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbSignPlayerSignList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbSignPlayerSignList(msg);
	end
	self.mReceiveCallback[26008] = doCallback;
end

--活动操作
function S2C:ACTIVE_OPREATE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29001] = doCallback;
end

--活动信息
function S2C:ACTIVE_LOGIN_INFO(callback_pbActiveLogin)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbActiveLogin();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbActiveLogin(msg);
	end
	self.mReceiveCallback[29002] = doCallback;
end

--活动请求段位
function S2C:ACTIVE_PHASE_INFO(callback_pbId32)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId32();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId32(msg);
	end
	self.mReceiveCallback[29003] = doCallback;
end

--活动钻石信息
function S2C:ACTIVE_GOLD_INFO(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29004] = doCallback;
end

--购买成长基金
function S2C:ACTIVE_BUY_GROW_FUND(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29005] = doCallback;
end

--请求成长基金信息
function S2C:ACTIVE_GROW_FUND_INFO(callback_pbActiveGrowFund)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbActiveGrowFund();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbActiveGrowFund(msg);
	end
	self.mReceiveCallback[29006] = doCallback;
end

--领取成长基金信息
function S2C:ACTIVE_GET_GROW_FUND(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29007] = doCallback;
end

--开服7天活动信息
function S2C:ACTIVE_OPEN_SERV_INFO(callback_pbActiveOpen)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbActiveOpen();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbActiveOpen(msg);
	end
	self.mReceiveCallback[29008] = doCallback;
end

--开服7天奖励领取
function S2C:ACTIVE_OPEN_REWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29009] = doCallback;
end

--充值活动以领取列表
function S2C:ACTIVE_CHARGE_REWARD_LIST(callback_pbActiveChargeList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbActiveChargeList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbActiveChargeList(msg);
	end
	self.mReceiveCallback[29010] = doCallback;
end

--充值活动领取当天累计奖励
function S2C:ACTIVE_CHARGE_REWARD_TODAY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29011] = doCallback;
end

--充值活动领取7天累计奖励
function S2C:ACTIVE_CHARGE_REWARD_7DAY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[29012] = doCallback;
end

return S2C.LuaNew();