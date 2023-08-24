local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mNetInterface = Assets.Scripts.Com.Net.NetInterface;
local mLuaNetSocketParam = Com.Net.Lua.LuaNetSocketParam;
local mLuaRawPacket = Com.Net.Lua.LuaRawPacket;
local mC2S = nil;
local mS2C = nil;
local mReceiveCallback = nil;
local mProtolDesc;
local NetManager = mLuaClass("NetManager",mBaseLua);

function NetManager:OnLuaNew()
	local param = mLuaNetSocketParam.New();

	param["receiveCallback"] = function()
		self:ReceiveCallback();
	end

	self.mLuaNetSocketParam = param;
	mNetInterface.InitLuaSocketParam(param);
end

function NetManager:InitProtolDesc()
	if mProtolDesc == nil then
		mC2S = require "ProtolManager/C2S"
		mS2C = require "ProtolManager/S2C"
		mReceiveCallback = mS2C.mReceiveCallback;
		mProtolDesc = ProtolDesc;
	end
end

function NetManager:ReceiveCallback()
	self:InitProtolDesc();

	local buffList = self.mLuaNetSocketParam.buffList;

	for i=0,buffList.Count - 1 do
		local buff = buffList[i];
		local cmdID = buff.cmdID;
		local byteBuffer = buff.byteBuffer;

		local callback = mReceiveCallback[cmdID];
		if callback then
			--print("<<<<<<<<<<<<<<<<<<<<<",mProtolDesc[cmdID]);
			callback(byteBuffer);
		else
			print("<<<<<<<<<<<<<<<<<<<<<未侦听 ",cmdID,mProtolDesc[cmdID]);
		end
	end
end

function NetManager:SendData(cmdID,bytes)
	self:InitProtolDesc();

	local packet = mLuaRawPacket.New();
	packet.mCMDID = cmdID;
	packet.byteString = bytes;
	mNetInterface.SendDataFromLua(packet);

	--print(">>>>>>>>>>>>>>>>>>>>",mProtolDesc[cmdID]);
end

local instance = NetManager.LuaNew();
return instance;