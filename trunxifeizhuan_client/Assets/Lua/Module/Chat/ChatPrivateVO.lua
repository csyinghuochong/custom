local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mSortTable = require "Common/SortTable"
local mChatVO = require "Module/Chat/ChatVO"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mGameModelManager = require "Manager/GameModelManager"
local ChatPrivateVO = mLuaClass("ChatPrivateVO", BaseLua);

--私聊列表--
function ChatPrivateVO:OnLuaNew(data)
	self.base = data.base;
	self.player_name = data.player_name;
	self.is_online = data.is_online;
	self.time = data.time;
	self.count = data.count;
	self.isReal = true;				--用于判断该数据是否为临时插入
	self.isEverGetTable = false;	--用于判断是否获取过该对象的历史消息
	self.dataSoure = mSortTable.LuaNew(function(a,b)return self:SortTime(a,b) end,nil,true);
	self.dataSoure:SetMax(mConfigSysglobal_value[mConfigGlobalConst.CHAT_SAVE_MESSAGES],true);
end

function ChatPrivateVO:SortTime(a,b)
	return a.create_time < b.create_time;
end

function ChatPrivateVO:CreateSoure(list)
	local model = mGameModelManager.ChatModel;
	local data_soure = self.dataSoure;
	data_soure:ClearDatas(true);
	for k,v in ipairs(list) do
		local chatVO = mChatVO.LuaNew(v);
		data_soure:AddOrUpdate(model.mChatID,chatVO);
		model.mChatID = model.mChatID + 1;
	end
end

function ChatPrivateVO:AddChat(chat)
	local model = mGameModelManager.ChatModel;
	local data_soure = self.dataSoure;
	local chatVO = mChatVO.LuaNew(chat);
	data_soure:AddOrUpdate(model.mChatID,chatVO);
	model.mChatID = model.mChatID + 1;
end


return ChatPrivateVO;