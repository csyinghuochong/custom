local mLuaClass = require 'Core/LuaClass'
local mBaseLua = require 'Core/BaseLua' 
local mNetManager = require 'Net/NetManager' 
local C2S = mLuaClass('C2S',mBaseLua);
	
local pb_26_pb;
local pb_29_pb;
local pb_45_pb;
local pb_8_pb;
local pb_9_pb;
local pb_base_fight_pb;
local pb_common_pb;	

ProtolDesc={
		[8002] = "领取首充奖励",
		[9024] = "激活码领取奖励",
		[26005] = "获取7天信息",
		[26006] = "领取7天奖励",
		[26007] = "获取另一个7天信息",
		[26008] = "领取另一个7天奖励",
		[29001] = "活动操作",
		[29002] = "活动信息",
		[29003] = "活动请求段位",
		[29004] = "活动钻石信息",
		[29005] = "购买成长基金",
		[29006] = "请求成长基金信息",
		[29007] = "领取成长基金信息",
		[29008] = "开服7天活动信息",
		[29009] = "开服7天奖励领取",
		[29010] = "充值活动以领取列表",
		[29011] = "充值活动领取当天累计奖励",
		[29012] = "充值活动领取7天累计奖励",
}

--领取首充奖励
function C2S:FIRST_CHARGE(charge_state_int32)
	pb_8_pb = pb_8_pb or require('Protol.pb_8_pb');
	local msg = pb_8_pb.pbPayFirst();
	msg.charge_state = charge_state_int32;
	mNetManager:SendData(8002,msg:SerializeToString());
end

--激活码领取奖励
function C2S:GET_CODE_AWARD(code_string)
	pb_9_pb = pb_9_pb or require('Protol.pb_9_pb');
	local msg = pb_9_pb.pbCode();
	msg.code = code_string;
	mNetManager:SendData(9024,msg:SerializeToString());
end

--获取7天信息
function C2S:SIGN_7_INFO()
	mNetManager:SendData(26005,nil);
end

--领取7天奖励
function C2S:SIGN_7_GET_AWARD(day_int32)
	pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
	local msg = pb_26_pb.pbSignDay();
	msg.day = day_int32;
	mNetManager:SendData(26006,msg:SerializeToString());
end

--获取另一个7天信息
function C2S:SIGN_7_INFO_OTHER()
	mNetManager:SendData(26007,nil);
end

--领取另一个7天奖励
function C2S:SIGN_7_GET_AWARD_OTHER(day_int32)
	pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
	local msg = pb_26_pb.pbSignDay();
	msg.day = day_int32;
	mNetManager:SendData(26008,msg:SerializeToString());
end

--活动操作
function C2S:ACTIVE_OPREATE(type_int32, arg_int32)
	pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
	local msg = pb_29_pb.pbActiveOp();
	msg.type = type_int32;
	msg.arg = arg_int32;
	mNetManager:SendData(29001,msg:SerializeToString());
end

--活动信息
function C2S:ACTIVE_LOGIN_INFO()
	mNetManager:SendData(29002,nil);
end

--活动请求段位
function C2S:ACTIVE_PHASE_INFO()
	mNetManager:SendData(29003,nil);
end

--活动钻石信息
function C2S:ACTIVE_GOLD_INFO()
	mNetManager:SendData(29004,nil);
end

--购买成长基金
function C2S:ACTIVE_BUY_GROW_FUND()
	mNetManager:SendData(29005,nil);
end

--请求成长基金信息
function C2S:ACTIVE_GROW_FUND_INFO()
	mNetManager:SendData(29006,nil);
end

--领取成长基金信息
function C2S:ACTIVE_GET_GROW_FUND(id_int32)
	pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
	local msg = pb_common_pb.pbId32();
	msg.id = id_int32;
	mNetManager:SendData(29007,msg:SerializeToString());
end

--开服7天活动信息
function C2S:ACTIVE_OPEN_SERV_INFO()
	mNetManager:SendData(29008,nil);
end

--开服7天奖励领取
function C2S:ACTIVE_OPEN_REWARD(id_int32)
	pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
	local msg = pb_common_pb.pbId32();
	msg.id = id_int32;
	mNetManager:SendData(29009,msg:SerializeToString());
end

--充值活动以领取列表
function C2S:ACTIVE_CHARGE_REWARD_LIST()
	mNetManager:SendData(29010,nil);
end

--充值活动领取当天累计奖励
function C2S:ACTIVE_CHARGE_REWARD_TODAY(result_int32)
	pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
	local msg = pb_common_pb.pbResult();
	msg.result = result_int32;
	mNetManager:SendData(29011,msg:SerializeToString());
end

--充值活动领取7天累计奖励
function C2S:ACTIVE_CHARGE_REWARD_7DAY(result_int32)
	pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
	local msg = pb_common_pb.pbResult();
	msg.result = result_int32;
	mNetManager:SendData(29012,msg:SerializeToString());
end

return C2S.LuaNew();