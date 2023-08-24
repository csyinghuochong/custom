local mLuaClass = require 'Core/LuaClass'
local mBaseLua = require 'Core/BaseLua' 
local mNetManager = require 'Net/NetManager' 
local S2C = mLuaClass('S2C',mBaseLua);
	
local pb_10_pb;
local pb_11_pb;
local pb_12_pb;
local pb_13_pb;
local pb_14_pb;
local pb_15_pb;
local pb_16_pb;
local pb_17_pb;
local pb_18_pb;
local pb_19_pb;
local pb_20_pb;
local pb_21_pb;
local pb_22_pb;
local pb_23_pb;
local pb_24_pb;
local pb_25_pb;
local pb_26_pb;
local pb_27_pb;
local pb_28_pb;
local pb_29_pb;
local pb_30_pb;
local pb_31_pb;
local pb_32_pb;
local pb_33_pb;
local pb_34_pb;
local pb_35_pb;
local pb_9_pb;
local pb_common_pb;	

S2C.mReceiveCallback={};

--错误提示代号
function S2C:ERROR_CODE(callback_pbError)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_9_pb = pb_9_pb or require('Protol.pb_9_pb');
			msg = pb_9_pb.pbError();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbError(msg);
	end
	self.mReceiveCallback[9001] = doCallback;
end

--人物属性数据
function S2C:PLAYER_BASE(callback_pbPlayerBase)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_9_pb = pb_9_pb or require('Protol.pb_9_pb');
			msg = pb_9_pb.pbPlayerBase();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlayerBase(msg);
	end
	self.mReceiveCallback[9002] = doCallback;
end

--查看其他玩家信息
function S2C:PLAYER_OTHER_BASE(callback_pbOtherPlayerBase)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbOtherPlayerBase();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbOtherPlayerBase(msg);
	end
	self.mReceiveCallback[9003] = doCallback;
end

--更改主角头像
function S2C:PLAYER_CHANGE_HEAD(callback_pbId32)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId32();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId32(msg);
	end
	self.mReceiveCallback[9005] = doCallback;
end

--玩家信息更新
function S2C:PLAYER_CHANGE_INFO(callback_pbPlayerChange)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_9_pb = pb_9_pb or require('Protol.pb_9_pb');
			msg = pb_9_pb.pbPlayerChange();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlayerChange(msg);
	end
	self.mReceiveCallback[9006] = doCallback;
end

--登录和创角
function S2C:LOGIN(callback_pbAccountInit)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_10_pb = pb_10_pb or require('Protol.pb_10_pb');
			msg = pb_10_pb.pbAccountInit();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbAccountInit(msg);
	end
	self.mReceiveCallback[10000] = doCallback;
end

--心跳包
function S2C:KEEP_HEART(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[10001] = doCallback;
end

--新进程开启需要到登陆界面
function S2C:LOGIN_OK_SERVER(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[10002] = doCallback;
end

--获取随从信息
function S2C:PARTNER_LIST(callback_pbPartnerList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbPartnerList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartnerList(msg);
	end
	self.mReceiveCallback[11001] = doCallback;
end

--随从升级
function S2C:PARTNER_LV_UP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11002] = doCallback;
end

--随从切换形象
function S2C:PARTNER_MODEL_CHANGE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11003] = doCallback;
end

--随从技能升级
function S2C:PARTNER_SKILL_UP(callback_pbPartnerSkillUp)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_11_pb = pb_11_pb or require('Protol.pb_11_pb');
			msg = pb_11_pb.pbPartnerSkillUp();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartnerSkillUp(msg);
	end
	self.mReceiveCallback[11004] = doCallback;
end

--随从晋封
function S2C:PARTNER_POSITION_UP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11005] = doCallback;
end

--随从上阵列表
function S2C:PARTNER_IN_CAMP(callback_pbId64R)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId64R();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId64R(msg);
	end
	self.mReceiveCallback[11006] = doCallback;
end

--随从突破
function S2C:PARTNER_BREAK_OUT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11007] = doCallback;
end

--主角技能激活/升级
function S2C:PARTNER_MAIN_SKILL_UP(callback_pbPartnerSkillUp)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_11_pb = pb_11_pb or require('Protol.pb_11_pb');
			msg = pb_11_pb.pbPartnerSkillUp();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartnerSkillUp(msg);
	end
	self.mReceiveCallback[11010] = doCallback;
end

--主角技能使用
function S2C:PARTNER_MAIN_SKILL_USE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11012] = doCallback;
end

--新增随从
function S2C:PARTNER_ADD(callback_pbPartnerAdd)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_11_pb = pb_11_pb or require('Protol.pb_11_pb');
			msg = pb_11_pb.pbPartnerAdd();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartnerAdd(msg);
	end
	self.mReceiveCallback[11013] = doCallback;
end

--修改随从昵称
function S2C:PARTNER_CHANGE_NAME(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11014] = doCallback;
end

--随从删除
function S2C:PARTNER_DELETE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11015] = doCallback;
end

--锁定/解锁随从
function S2C:PARTNER_LOCK(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11016] = doCallback;
end

--主角培养
function S2C:PARTNER_TRAIN(callback_pbId32R)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId32R();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId32R(msg);
	end
	self.mReceiveCallback[11017] = doCallback;
end

--请求随从评价
function S2C:PARTNER_COMMENT_LIST(callback_pbPartnerCommentList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_11_pb = pb_11_pb or require('Protol.pb_11_pb');
			msg = pb_11_pb.pbPartnerCommentList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartnerCommentList(msg);
	end
	self.mReceiveCallback[11018] = doCallback;
end

--随从评价点赞
function S2C:PARTNER_COMMENT_VOTE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11019] = doCallback;
end

--新增随从评价
function S2C:PARTNER_COMMENT_ADD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[11020] = doCallback;
end

--查看随从
function S2C:PARTNER_COMMENT_LOOK(callback_pbPartner)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbPartner();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPartner(msg);
	end
	self.mReceiveCallback[11021] = doCallback;
end

--背包
function S2C:PLAYER_BAG(callback_pbGoodList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_12_pb = pb_12_pb or require('Protol.pb_12_pb');
			msg = pb_12_pb.pbGoodList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbGoodList(msg);
	end
	self.mReceiveCallback[12000] = doCallback;
end

--背包物品刷新
function S2C:PLAYER_BAG_REFRESH(callback_pbGoodList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_12_pb = pb_12_pb or require('Protol.pb_12_pb');
			msg = pb_12_pb.pbGoodList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbGoodList(msg);
	end
	self.mReceiveCallback[12001] = doCallback;
end

--出售物品
function S2C:PLAYER_SELL_GOOD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12002] = doCallback;
end

--使用物品
function S2C:PLAYER_USE_GOOD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12003] = doCallback;
end

--穿戴
function S2C:PLAYER_WEAR_EQUIP(callback_pbEquip)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbEquip();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEquip(msg);
	end
	self.mReceiveCallback[12011] = doCallback;
end

--卸下
function S2C:PLAYER_REMOVE_EQUIP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12012] = doCallback;
end

--强化
function S2C:PLAYER_STRENGTH_EQUIP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12013] = doCallback;
end

--鉴定
function S2C:PLAYER_IDENTYFY_EQUIP(callback_pbAttributeWash)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbAttributeWash();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbAttributeWash(msg);
	end
	self.mReceiveCallback[12014] = doCallback;
end

--重琢
function S2C:PLAYER_REDENTYFY_EQUIP(callback_pbAttributeWash)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbAttributeWash();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbAttributeWash(msg);
	end
	self.mReceiveCallback[12015] = doCallback;
end

--精雕
function S2C:PLAYER_UPDENTYFY_EQUIP(callback_pbAttributeWash)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbAttributeWash();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbAttributeWash(msg);
	end
	self.mReceiveCallback[12016] = doCallback;
end

--打磨
function S2C:PLAYER_UPGRADE_STAR_EQUIP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12017] = doCallback;
end

--抛光
function S2C:PLAYER_UPGRADE_COLOR_EQUIP(callback_pbNewAddAttribute)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_12_pb = pb_12_pb or require('Protol.pb_12_pb');
			msg = pb_12_pb.pbNewAddAttribute();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbNewAddAttribute(msg);
	end
	self.mReceiveCallback[12018] = doCallback;
end

--一键强化
function S2C:PLAYER_STRENGTH_TOP_EQUIP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[12019] = doCallback;
end

--请求挑战副本信息
function S2C:DUNGEON_INFO(callback_pbDungeonList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_13_pb = pb_13_pb or require('Protol.pb_13_pb');
			msg = pb_13_pb.pbDungeonList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDungeonList(msg);
	end
	self.mReceiveCallback[13000] = doCallback;
end

--请求挑战副本
function S2C:DUNGEON_START_BATTLE(callback_pbDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_13_pb = pb_13_pb or require('Protol.pb_13_pb');
			msg = pb_13_pb.pbDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDungeonBattleResult(msg);
	end
	self.mReceiveCallback[13001] = doCallback;
end

--挑战副本结果
function S2C:DUNGEON_BATTLE_RESULT(callback_pbDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_13_pb = pb_13_pb or require('Protol.pb_13_pb');
			msg = pb_13_pb.pbDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDungeonBattleResult(msg);
	end
	self.mReceiveCallback[13002] = doCallback;
end

--复活再战
function S2C:DUNGEON_REBORN_BATTLE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[13003] = doCallback;
end

--请求随从通关出场率
function S2C:DUNGEON_PARTNER_INFO(callback_pbDungeonPartnerInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_13_pb = pb_13_pb or require('Protol.pb_13_pb');
			msg = pb_13_pb.pbDungeonPartnerInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDungeonPartnerInfo(msg);
	end
	self.mReceiveCallback[13004] = doCallback;
end

--获取爬塔信息
function S2C:CLIMB_TOWERS(callback_pbClimbTowers)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_14_pb = pb_14_pb or require('Protol.pb_14_pb');
			msg = pb_14_pb.pbClimbTowers();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbClimbTowers(msg);
	end
	self.mReceiveCallback[14000] = doCallback;
end

--进入爬塔关卡
function S2C:CLIMB_TOWER_ENTER(callback_pbEnterResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_14_pb = pb_14_pb or require('Protol.pb_14_pb');
			msg = pb_14_pb.pbEnterResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEnterResult(msg);
	end
	self.mReceiveCallback[14001] = doCallback;
end

--爬塔战斗结果
function S2C:CLIMB_TOWER_RESULT(callback_pbClimbTowerResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_14_pb = pb_14_pb or require('Protol.pb_14_pb');
			msg = pb_14_pb.pbClimbTowerResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbClimbTowerResult(msg);
	end
	self.mReceiveCallback[14002] = doCallback;
end

--请求邮件列表
function S2C:MAIL_MAILS_INFO(callback_pbMailsInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_15_pb = pb_15_pb or require('Protol.pb_15_pb');
			msg = pb_15_pb.pbMailsInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMailsInfo(msg);
	end
	self.mReceiveCallback[15000] = doCallback;
end

--查看邮件
function S2C:MAIL_READ(callback_pbMailInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_15_pb = pb_15_pb or require('Protol.pb_15_pb');
			msg = pb_15_pb.pbMailInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMailInfo(msg);
	end
	self.mReceiveCallback[15001] = doCallback;
end

--删除邮件
function S2C:MAIL_DEL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[15002] = doCallback;
end

--一键删除
function S2C:MAIL_DEL_ALL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[15003] = doCallback;
end

--一键领取
function S2C:MAIL_GET_AWARD_ALL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[15004] = doCallback;
end

--领取邮件
function S2C:MAIL_GET_AWARD(callback_pbMailInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_15_pb = pb_15_pb or require('Protol.pb_15_pb');
			msg = pb_15_pb.pbMailInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMailInfo(msg);
	end
	self.mReceiveCallback[15005] = doCallback;
end

--增加邮件
function S2C:MAIL_ADD(callback_pbMailIntro)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_15_pb = pb_15_pb or require('Protol.pb_15_pb');
			msg = pb_15_pb.pbMailIntro();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMailIntro(msg);
	end
	self.mReceiveCallback[15006] = doCallback;
end

--收到聊天消息
function S2C:CHAT_RECEIVE(callback_pbReturnChat)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_17_pb = pb_17_pb or require('Protol.pb_17_pb');
			msg = pb_17_pb.pbReturnChat();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbReturnChat(msg);
	end
	self.mReceiveCallback[17001] = doCallback;
end

--请求最近联系人
function S2C:CHAT_CONTACT_PERSONS(callback_pbContactPersons)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_17_pb = pb_17_pb or require('Protol.pb_17_pb');
			msg = pb_17_pb.pbContactPersons();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbContactPersons(msg);
	end
	self.mReceiveCallback[17002] = doCallback;
end

--查询与某人的私聊信息
function S2C:CHAT_PRIVATE_MESSAGE(callback_pbReturnChats)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_17_pb = pb_17_pb or require('Protol.pb_17_pb');
			msg = pb_17_pb.pbReturnChats();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbReturnChats(msg);
	end
	self.mReceiveCallback[17003] = doCallback;
end

--更新最新联系人
function S2C:CHAT_UPDATE_CONTACT_PERSON(callback_pbContactPerson)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_17_pb = pb_17_pb or require('Protol.pb_17_pb');
			msg = pb_17_pb.pbContactPerson();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbContactPerson(msg);
	end
	self.mReceiveCallback[17004] = doCallback;
end

--收到公告消息
function S2C:CHAT_NOTICE_MESSAGE(callback_pbBroadcastNotice)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbBroadcastNotice();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbBroadcastNotice(msg);
	end
	self.mReceiveCallback[17005] = doCallback;
end

--获取GAME MASTER
function S2C:CHAT_GM_MASTER(callback_pbChatGmList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_17_pb = pb_17_pb or require('Protol.pb_17_pb');
			msg = pb_17_pb.pbChatGmList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChatGmList(msg);
	end
	self.mReceiveCallback[17009] = doCallback;
end

--好友列表
function S2C:PLAYER_FRIENDS_LIST(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16000] = doCallback;
end

--接收体力
function S2C:PLAYER_RECEIVE_ENERGY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16001] = doCallback;
end

--发送体力
function S2C:PLAYER_SEND_ENERGY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16002] = doCallback;
end

--删除好友
function S2C:PLAYER_DELETE_FRIEND(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16003] = doCallback;
end

--查找
function S2C:PLAYER_SEARCH_FRIEND(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16004] = doCallback;
end

--加好友
function S2C:PLAYER_ADD_FRIEND(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16005] = doCallback;
end

--申请列表
function S2C:PLAYER_FRIEND_REQUEST_LIST(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16006] = doCallback;
end

--接受/拒接
function S2C:PLAYER_FRIEND_REQUEST_HANDLE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16007] = doCallback;
end

--黑名单列表
function S2C:PLAYER_FRIEND_BLACK_LIST(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16008] = doCallback;
end

--解禁黑名单
function S2C:PLAYER_FRIEND_UNBLOCK_BLACK(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16009] = doCallback;
end

--仇敌列表
function S2C:PLAYER_FRIEND_ENEMY_LIST(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16010] = doCallback;
end

--删除仇敌
function S2C:PLAYER_FRIEND_DELETE_ENEMY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16011] = doCallback;
end

--加入黑名单
function S2C:PLAYER_FRIEND_ADD_TO_BLACK(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[16012] = doCallback;
end

--查看玩家
function S2C:PLAYER_FRIEND_OTHER_PLAYER_INFO(callback_pbOtherPlayer)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbOtherPlayer();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbOtherPlayer(msg);
	end
	self.mReceiveCallback[16013] = doCallback;
end

--推荐列表
function S2C:PLAYER_FRIEND_RECOMMEND_LIST(callback_pbFriendList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_16_pb = pb_16_pb or require('Protol.pb_16_pb');
			msg = pb_16_pb.pbFriendList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFriendList(msg);
	end
	self.mReceiveCallback[16014] = doCallback;
end

--请求主线副本信息
function S2C:DUNGEON_PLOT_LIST(callback_pbPlotDungeonInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_18_pb = pb_18_pb or require('Protol.pb_18_pb');
			msg = pb_18_pb.pbPlotDungeonInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlotDungeonInfo(msg);
	end
	self.mReceiveCallback[18000] = doCallback;
end

--请求挑战主线副本
function S2C:DUNGEON_PLOT_BATTLE(callback_pbPlotDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_18_pb = pb_18_pb or require('Protol.pb_18_pb');
			msg = pb_18_pb.pbPlotDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlotDungeonBattleResult(msg);
	end
	self.mReceiveCallback[18001] = doCallback;
end

--挑战主线副本结果
function S2C:DUNGEON_PLOT_BATTLE_OVER(callback_pbPlotDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_18_pb = pb_18_pb or require('Protol.pb_18_pb');
			msg = pb_18_pb.pbPlotDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlotDungeonBattleResult(msg);
	end
	self.mReceiveCallback[18002] = doCallback;
end

--通知播放完前置剧情
function S2C:DUNGEON_PLOT_PLAY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[18003] = doCallback;
end

--主线副本复活再战
function S2C:DUNGEON_PLOT_REBORN(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[18004] = doCallback;
end

--剧情副本章节扫荡
function S2C:DUNGEON_PLOT_SWEEP(callback_pbPlotDungeonSweepResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_18_pb = pb_18_pb or require('Protol.pb_18_pb');
			msg = pb_18_pb.pbPlotDungeonSweepResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPlotDungeonSweepResult(msg);
	end
	self.mReceiveCallback[18005] = doCallback;
end

--报考界面
function S2C:PLAYER_PROMOTE_INFO(callback_pbSignInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbSignInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbSignInfo(msg);
	end
	self.mReceiveCallback[19000] = doCallback;
end

--报考
function S2C:PLAYER_PROMOTE_SIGN(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19001] = doCallback;
end

--开始考试
function S2C:PLAYER_PROMOTE_START(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19002] = doCallback;
end

--提交答案
function S2C:PLAYER_PROMOTE_ANSWER(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19003] = doCallback;
end

--重考当前阶段
function S2C:PLAYER_PROMOTE_RESTART(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19004] = doCallback;
end

--进入下一阶段
function S2C:PLAYER_PROMOTE_NEXT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19005] = doCallback;
end

--评判结果
function S2C:PLAYER_PROMOTE_RESULT(callback_pbNpcResultList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbNpcResultList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbNpcResultList(msg);
	end
	self.mReceiveCallback[19006] = doCallback;
end

--放弃重考
function S2C:PLAYER_PROMOTE_RESET(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19007] = doCallback;
end

--友好界面
function S2C:PLAYER_PROMOTE_FRIEND(callback_pbNpcFreind)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbNpcFreind();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbNpcFreind(msg);
	end
	self.mReceiveCallback[19008] = doCallback;
end

--友好
function S2C:PLAYER_PROMOTE_FRIEND_TO_CHANGE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19009] = doCallback;
end

--晋升
function S2C:PLAYER_PROMOTE_PROMOTE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19010] = doCallback;
end

--提前结束
function S2C:PLAYER_PROMOTE_STOP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19011] = doCallback;
end

--晋封战斗考试准备
function S2C:PLAYER_PROMOTE_FIGHT_PREPARE(callback_pbArenaVsPlayerDefense)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbArenaVsPlayerDefense();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaVsPlayerDefense(msg);
	end
	self.mReceiveCallback[19012] = doCallback;
end

--晋封战斗考试
function S2C:PLAYER_PROMOTE_FIGHT_START(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19013] = doCallback;
end

--晋封战斗考试结果
function S2C:PLAYER_PROMOTE_FIGHT_RESULT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19014] = doCallback;
end

--晋封战斗玩家返回
function S2C:PLAYER_PROMOTE_FIGHT_PLAYER(callback_pbVsPlayer)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbVsPlayer();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbVsPlayer(msg);
	end
	self.mReceiveCallback[19015] = doCallback;
end

--巅峰宫斗
function S2C:PLAYER_PROMOTE_ARENA(callback_pbPromoteArena)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbPromoteArena();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPromoteArena(msg);
	end
	self.mReceiveCallback[19020] = doCallback;
end

--刷新列表
function S2C:PLAYER_PROMOTE_ARENA_REFRESH(callback_pbPromoteArena)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbPromoteArena();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbPromoteArena(msg);
	end
	self.mReceiveCallback[19021] = doCallback;
end

--购买次数
function S2C:PLAYER_PROMOTE_ARENA_BUY_TIMES(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19022] = doCallback;
end

--防守阵容
function S2C:PLAYER_PROMOTE_ARENA_DEFENSE_POS(callback_pbDefensePos)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbDefensePos();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDefensePos(msg);
	end
	self.mReceiveCallback[19023] = doCallback;
end

--保存防守阵容
function S2C:PLAYER_PROMOTE_ARENA_DEFENSE_SAVE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19024] = doCallback;
end

--准备挑战
function S2C:PLAYER_PROMOTE_ARENA_PREPARE(callback_pbArenaVsPlayerDefense)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbArenaVsPlayerDefense();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaVsPlayerDefense(msg);
	end
	self.mReceiveCallback[19025] = doCallback;
end

--挑战结果
function S2C:PLAYER_PROMOTE_ARENA_RESULT(callback_pbReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbReward(msg);
	end
	self.mReceiveCallback[19026] = doCallback;
end

--仇人列表
function S2C:PLAYER_PROMOTE_ARENA_ENEMY_LIST(callback_pbEnemyList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbEnemyList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEnemyList(msg);
	end
	self.mReceiveCallback[19027] = doCallback;
end

--准备复仇挑战
function S2C:PLAYER_PROMOTE_ARENA_ENEMY_PREPARE(callback_pbArenaVsPlayerDefense)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbArenaVsPlayerDefense();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaVsPlayerDefense(msg);
	end
	self.mReceiveCallback[19028] = doCallback;
end

--复仇挑战结果
function S2C:PLAYER_PROMOTE_ARENA_ENEMY_RESULT(callback_pbReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbReward(msg);
	end
	self.mReceiveCallback[19029] = doCallback;
end

--开始挑战
function S2C:PLAYER_PROMOTE_ARENA_FIGHT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19030] = doCallback;
end

--复仇挑战
function S2C:PLAYER_PROMOTE_ARENA_ENEMY_FIGHT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[19031] = doCallback;
end

--巅峰宫斗排行榜
function S2C:PLAYER_PROMOTE_ARENA_RANK(callback_pbRankRe)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_19_pb = pb_19_pb or require('Protol.pb_19_pb');
			msg = pb_19_pb.pbRankRe();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbRankRe(msg);
	end
	self.mReceiveCallback[19032] = doCallback;
end

--请求召唤
function S2C:DRAFT_REQUEST(callback_pbDraftResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_20_pb = pb_20_pb or require('Protol.pb_20_pb');
			msg = pb_20_pb.pbDraftResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDraftResult(msg);
	end
	self.mReceiveCallback[20000] = doCallback;
end

--碎片召唤
function S2C:DRAFT_WITH_CHIP(callback_pbDraftResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_20_pb = pb_20_pb or require('Protol.pb_20_pb');
			msg = pb_20_pb.pbDraftResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDraftResult(msg);
	end
	self.mReceiveCallback[20001] = doCallback;
end

--请求特殊召唤列表
function S2C:DRAFT_GROUP_LIST(callback_pbDraftGroup)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_20_pb = pb_20_pb or require('Protol.pb_20_pb');
			msg = pb_20_pb.pbDraftGroup();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDraftGroup(msg);
	end
	self.mReceiveCallback[20002] = doCallback;
end

--请求图鉴列表
function S2C:DRAFT_SHOW_LIST(callback_pbDraftShow)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_20_pb = pb_20_pb or require('Protol.pb_20_pb');
			msg = pb_20_pb.pbDraftShow();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbDraftShow(msg);
	end
	self.mReceiveCallback[20003] = doCallback;
end

--排行榜
function S2C:PLAYER_RANK(callback_pbRankData)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_21_pb = pb_21_pb or require('Protol.pb_21_pb');
			msg = pb_21_pb.pbRankData();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbRankData(msg);
	end
	self.mReceiveCallback[21000] = doCallback;
end

--竞技场
function S2C:PLAYER_ARENA(callback_pbArena)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArena();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArena(msg);
	end
	self.mReceiveCallback[22000] = doCallback;
end

--竞技场刷新列表
function S2C:PLAYER_ARENA_REFRESH(callback_pbArena)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArena();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArena(msg);
	end
	self.mReceiveCallback[22001] = doCallback;
end

--竞技场防守阵容
function S2C:PLAYER_ARENA_DEFENSE_POS(callback_pbArenaDefensePos)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArenaDefensePos();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaDefensePos(msg);
	end
	self.mReceiveCallback[22002] = doCallback;
end

--竞技场保存防守阵容
function S2C:PLAYER_ARENA_DEFENSE_POS_SAVE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[22003] = doCallback;
end

--竞技场挑战准备
function S2C:PLAYER_ARENA_PREPARE_FIGHT(callback_pbArenaVsPlayerDefense)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbArenaVsPlayerDefense();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaVsPlayerDefense(msg);
	end
	self.mReceiveCallback[22004] = doCallback;
end

--竞技场挑战
function S2C:PLAYER_ARENA_FIGHT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[22005] = doCallback;
end

--竞技场挑战结果
function S2C:PLAYER_ARENA_FIGHT_RESULT(callback_pbArenaReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArenaReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaReward(msg);
	end
	self.mReceiveCallback[22006] = doCallback;
end

--竞技场仇人列表
function S2C:PLAYER_ARENA_ENEMY(callback_pbArenaEnemyList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArenaEnemyList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaEnemyList(msg);
	end
	self.mReceiveCallback[22007] = doCallback;
end

--竞技场复仇挑战准备
function S2C:PLAYER_ARENA_PREPARE_FIGHT_ENEMY(callback_pbArenaVsPlayerDefense)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbArenaVsPlayerDefense();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaVsPlayerDefense(msg);
	end
	self.mReceiveCallback[22008] = doCallback;
end

--竞技场复仇挑战
function S2C:PLAYER_ARENA_FIGHT_ENEMY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[22009] = doCallback;
end

--竞技场复仇挑战结果
function S2C:PLAYER_ARENA_FIGHT_RESULT_ENEMY(callback_pbArenaReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArenaReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaReward(msg);
	end
	self.mReceiveCallback[22010] = doCallback;
end

--竞技场排行榜
function S2C:PLAYER_ARENA_RANK(callback_pbArenaRankRe)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_22_pb = pb_22_pb or require('Protol.pb_22_pb');
			msg = pb_22_pb.pbArenaRankRe();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbArenaRankRe(msg);
	end
	self.mReceiveCallback[22011] = doCallback;
end

--获取商城列表
function S2C:SHOP_LIST(callback_pbShopList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_23_pb = pb_23_pb or require('Protol.pb_23_pb');
			msg = pb_23_pb.pbShopList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbShopList(msg);
	end
	self.mReceiveCallback[23000] = doCallback;
end

--购买道具
function S2C:SHOP_BUY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[23001] = doCallback;
end

--更新道具
function S2C:SHOP_UPDATE(callback_pbShopList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_23_pb = pb_23_pb or require('Protol.pb_23_pb');
			msg = pb_23_pb.pbShopList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbShopList(msg);
	end
	self.mReceiveCallback[23002] = doCallback;
end

--获取觐见剧情
function S2C:MONRACH_AUDIENCE_GET(callback_pbId32)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId32();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId32(msg);
	end
	self.mReceiveCallback[24000] = doCallback;
end

--更新觐见剧情
function S2C:MONRACH_AUDIENCE_UPDATE(callback_pbMonarchAudience)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_24_pb = pb_24_pb or require('Protol.pb_24_pb');
			msg = pb_24_pb.pbMonarchAudience();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMonarchAudience(msg);
	end
	self.mReceiveCallback[24001] = doCallback;
end

--觐见结束获得奖励
function S2C:MONRACH_AUDIENCE_RESULT(callback_pbMonarchAudienceResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_24_pb = pb_24_pb or require('Protol.pb_24_pb');
			msg = pb_24_pb.pbMonarchAudienceResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMonarchAudienceResult(msg);
	end
	self.mReceiveCallback[24002] = doCallback;
end

--获取邀宠或承恩技能列表
function S2C:MONRACH_GET_SKILL_LIST(callback_pbMonarchGetSkills)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_24_pb = pb_24_pb or require('Protol.pb_24_pb');
			msg = pb_24_pb.pbMonarchGetSkills();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMonarchGetSkills(msg);
	end
	self.mReceiveCallback[24003] = doCallback;
end

--开始邀宠或承恩
function S2C:MONRACH_START(callback_pbMonarchGetSkills)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_24_pb = pb_24_pb or require('Protol.pb_24_pb');
			msg = pb_24_pb.pbMonarchGetSkills();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMonarchGetSkills(msg);
	end
	self.mReceiveCallback[24004] = doCallback;
end

--获取任务列表
function S2C:TASK_LIST(callback_pbTaskList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_25_pb = pb_25_pb or require('Protol.pb_25_pb');
			msg = pb_25_pb.pbTaskList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTaskList(msg);
	end
	self.mReceiveCallback[25000] = doCallback;
end

--更新任务
function S2C:TASK_UPDATE(callback_pbTaskList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_25_pb = pb_25_pb or require('Protol.pb_25_pb');
			msg = pb_25_pb.pbTaskList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTaskList(msg);
	end
	self.mReceiveCallback[25001] = doCallback;
end

--删除任务
function S2C:TASK_DEL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[25002] = doCallback;
end

--领取任务奖励
function S2C:TASK_GET_REWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[25003] = doCallback;
end

--府邸信息
function S2C:MANSION_INFO(callback_pbMansion)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansion();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansion(msg);
	end
	self.mReceiveCallback[26000] = doCallback;
end

--府邸改名
function S2C:MANSION_CHNAGE_NAME(callback_pbString)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbString();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbString(msg);
	end
	self.mReceiveCallback[26001] = doCallback;
end

--府邸串门
function S2C:MANSION_VISIT_LIST(callback_pbMansionVisitList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionVisitList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionVisitList(msg);
	end
	self.mReceiveCallback[26002] = doCallback;
end

--府邸事件
function S2C:MANSION_EVENTS(callback_pbMansionEvents)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionEvents();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionEvents(msg);
	end
	self.mReceiveCallback[26003] = doCallback;
end

--府邸串门进行
function S2C:MANSION_VISIT_START(callback_pbMansion)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansion();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansion(msg);
	end
	self.mReceiveCallback[26004] = doCallback;
end

--府邸仆人列表
function S2C:MANSION_SERVANT_LIST(callback_pbMansionServantList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionServantList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionServantList(msg);
	end
	self.mReceiveCallback[26005] = doCallback;
end

--府邸仆人改名
function S2C:MANSION_SERVANT_CHANGE_NAME(callback_pbMansionServantChangeName)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionServantChangeName();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionServantChangeName(msg);
	end
	self.mReceiveCallback[26006] = doCallback;
end

--府邸仆人打赏
function S2C:MANSION_SERVANT_REWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26007] = doCallback;
end

--府邸仆人发放通宝
function S2C:MANSION_SERVANT_REWARD_HOUSE_COIN(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26008] = doCallback;
end

--府邸仆人雇佣
function S2C:MANSION_SERVANT_CALL(callback_pbMansionServantList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionServantList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionServantList(msg);
	end
	self.mReceiveCallback[26009] = doCallback;
end

--府邸仆人信息更新
function S2C:MANSION_SERVANT_UPDATE(callback_pbMansionServant)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionServant();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionServant(msg);
	end
	self.mReceiveCallback[26010] = doCallback;
end

--府邸仆人清洁度
function S2C:MANSION_SERVANT_CLEANUP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26011] = doCallback;
end

--府邸信息更新
function S2C:MANSION_UPDATE_INFO(callback_pbMansion)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansion();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansion(msg);
	end
	self.mReceiveCallback[26012] = doCallback;
end

--府邸开垦土地
function S2C:MANSION_OPEN_LAND(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26013] = doCallback;
end

--府邸种子操作
function S2C:MANSION_SEED_OPERATION(callback_pbMansionPlantingResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionPlantingResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionPlantingResult(msg);
	end
	self.mReceiveCallback[26014] = doCallback;
end

--府邸请求种子种植顺序
function S2C:MANSION_SEED_ORDER_REQUEST(callback_pbMansionPlantPlanlist)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionPlantPlanlist();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionPlantPlanlist(msg);
	end
	self.mReceiveCallback[26015] = doCallback;
end

--府邸更新种子种植顺序
function S2C:MANSION_SEED_ORDER_UPDATE(callback_pbMansionPlantPlanlist)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionPlantPlanlist();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionPlantPlanlist(msg);
	end
	self.mReceiveCallback[26016] = doCallback;
end

--府邸更新npc事件
function S2C:MANSION_NPC_EVENT_UPDATE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26017] = doCallback;
end

--府邸npc事件领取奖励
function S2C:MANSION_NPC_EVENT_REWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26018] = doCallback;
end

--府邸npc事件删除
function S2C:MANSION_NPC_EVENT_DEL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26019] = doCallback;
end

--府邸离线获得信息
function S2C:MANSION_OFFLINE_GET_INFO(callback_pbMansionOfflineInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionOfflineInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionOfflineInfo(msg);
	end
	self.mReceiveCallback[26020] = doCallback;
end

--府邸打开宴会界面
function S2C:MANSION_FEAST_OPEN_WINDOWS(callback_pbMansionFeastInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionFeastInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionFeastInfo(msg);
	end
	self.mReceiveCallback[26030] = doCallback;
end

--府邸开启宴会
function S2C:MANSION_FEAST_OPEN(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26031] = doCallback;
end

--府邸获取宴会列表
function S2C:MANSION_FESAT_LIST(callback_pbMansionFeastList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionFeastList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionFeastList(msg);
	end
	self.mReceiveCallback[26032] = doCallback;
end

--府邸赴宴
function S2C:MANSION_FEAST_ADD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26033] = doCallback;
end

--府邸宴会详细信息
function S2C:MANSION_FEAST_DETAIL(callback_pbMansionFeastDetail)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_26_pb = pb_26_pb or require('Protol.pb_26_pb');
			msg = pb_26_pb.pbMansionFeastDetail();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbMansionFeastDetail(msg);
	end
	self.mReceiveCallback[26034] = doCallback;
end

--府邸宴会邀请
function S2C:MANSION_FEAST_INVITE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[26035] = doCallback;
end

--府邸背包列表
function S2C:MANSION_ITEM_LIST(callback_pbItemList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_27_pb = pb_27_pb or require('Protol.pb_27_pb');
			msg = pb_27_pb.pbItemList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbItemList(msg);
	end
	self.mReceiveCallback[27000] = doCallback;
end

--府邸背包更新
function S2C:MANSION_ITEM_UPDATE(callback_pbItemList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_27_pb = pb_27_pb or require('Protol.pb_27_pb');
			msg = pb_27_pb.pbItemList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbItemList(msg);
	end
	self.mReceiveCallback[27001] = doCallback;
end

--府邸背包出售
function S2C:MANSION_ITEM_SELL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[27002] = doCallback;
end

--府邸背包材料合成
function S2C:MANSION_ITEM_COMPOSITION(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[27003] = doCallback;
end

--请求精英副本信息
function S2C:ELITE_DUNGEON_LIST(callback_pbEliteDungeonList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_28_pb = pb_28_pb or require('Protol.pb_28_pb');
			msg = pb_28_pb.pbEliteDungeonList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEliteDungeonList(msg);
	end
	self.mReceiveCallback[28000] = doCallback;
end

--请求挑战精英副本
function S2C:ELITE_DUNGEON_BATTLE(callback_pbEliteDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_28_pb = pb_28_pb or require('Protol.pb_28_pb');
			msg = pb_28_pb.pbEliteDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEliteDungeonBattleResult(msg);
	end
	self.mReceiveCallback[28001] = doCallback;
end

--挑战精英副本结果
function S2C:ELITE_DUNGEON_BATTLE_RESULT(callback_pbEliteDungeonBattleResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_28_pb = pb_28_pb or require('Protol.pb_28_pb');
			msg = pb_28_pb.pbEliteDungeonBattleResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbEliteDungeonBattleResult(msg);
	end
	self.mReceiveCallback[28002] = doCallback;
end

--精英副本复活再战
function S2C:ELITE_DUNGEON_REBORN(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[28003] = doCallback;
end

--获取完成引导的id信息
function S2C:GUIDE_INFO(callback_pbGuideInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbGuideInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbGuideInfo(msg);
	end
	self.mReceiveCallback[29000] = doCallback;
end

--通知完成引导
function S2C:GUIDE_NOTICE(callback_pbGuide)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_29_pb = pb_29_pb or require('Protol.pb_29_pb');
			msg = pb_29_pb.pbGuide();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbGuide(msg);
	end
	self.mReceiveCallback[29001] = doCallback;
end

--时装列表
function S2C:PLAYER_FASHION_LIST(callback_pbFashionList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_30_pb = pb_30_pb or require('Protol.pb_30_pb');
			msg = pb_30_pb.pbFashionList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFashionList(msg);
	end
	self.mReceiveCallback[30000] = doCallback;
end

--保存
function S2C:PLAYER_FASHION_SAVE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30001] = doCallback;
end

--合成
function S2C:PLAYER_FASHION_COMBINE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30002] = doCallback;
end

--强化
function S2C:PLAYER_FASHION_STRENGTH(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30003] = doCallback;
end

--进阶
function S2C:PLAYER_FASHION_PROMOTE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30004] = doCallback;
end

--升星
function S2C:PLAYER_FASHION_UPRGADE_STAR(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30005] = doCallback;
end

--渲光
function S2C:PLAYER_FASHION_UPGRADE_COLOR(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30006] = doCallback;
end

--一键穿戴
function S2C:PLAYER_FASHION_SAVE_ALL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30007] = doCallback;
end

--洗练
function S2C:PLAYER_FASHION_WASH(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30008] = doCallback;
end

--洗练保存
function S2C:PLAYER_FASHION_WASH_SAVE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[30009] = doCallback;
end

--刷新的时装列表
function S2C:PLAYER_FASHION_REFRESH(callback_pbFashionList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_30_pb = pb_30_pb or require('Protol.pb_30_pb');
			msg = pb_30_pb.pbFashionList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbFashionList(msg);
	end
	self.mReceiveCallback[30010] = doCallback;
end

--获取祭拜先祖信息
function S2C:WORSHIP_ANCESTOR_INFO(callback_pbWorshipInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_31_pb = pb_31_pb or require('Protol.pb_31_pb');
			msg = pb_31_pb.pbWorshipInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbWorshipInfo(msg);
	end
	self.mReceiveCallback[31000] = doCallback;
end

--请求祭拜先祖
function S2C:WORSHIP_ANCESTOR(callback_pbWorshipReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_31_pb = pb_31_pb or require('Protol.pb_31_pb');
			msg = pb_31_pb.pbWorshipReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbWorshipReward(msg);
	end
	self.mReceiveCallback[31001] = doCallback;
end

--太后请安
function S2C:QUEEN_WISH(callback_pbWorshipReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_31_pb = pb_31_pb or require('Protol.pb_31_pb');
			msg = pb_31_pb.pbWorshipReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbWorshipReward(msg);
	end
	self.mReceiveCallback[31002] = doCallback;
end

--太后献礼
function S2C:QUEEN_GIFT(callback_pbWorshipReward)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_31_pb = pb_31_pb or require('Protol.pb_31_pb');
			msg = pb_31_pb.pbWorshipReward();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbWorshipReward(msg);
	end
	self.mReceiveCallback[31003] = doCallback;
end

--太后请安/献礼次数
function S2C:QUEEN_INFO(callback_pbQueenInfo)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_31_pb = pb_31_pb or require('Protol.pb_31_pb');
			msg = pb_31_pb.pbQueenInfo();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbQueenInfo(msg);
	end
	self.mReceiveCallback[31004] = doCallback;
end

--才艺背包
function S2C:PLAYER_TALENT_LIST(callback_pbTalentList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_32_pb = pb_32_pb or require('Protol.pb_32_pb');
			msg = pb_32_pb.pbTalentList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalentList(msg);
	end
	self.mReceiveCallback[32000] = doCallback;
end

--才艺背包刷新
function S2C:PLAYER_TALENT_REFRSH(callback_pbTalentList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_32_pb = pb_32_pb or require('Protol.pb_32_pb');
			msg = pb_32_pb.pbTalentList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalentList(msg);
	end
	self.mReceiveCallback[32001] = doCallback;
end

--才艺出售
function S2C:PLAYER_TALENT_SELL(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[32002] = doCallback;
end

--才艺穿戴
function S2C:PLAYER_TALENT_WEAR(callback_pbTalent)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbTalent();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalent(msg);
	end
	self.mReceiveCallback[32003] = doCallback;
end

--才艺卸下
function S2C:PLAYER_TALENT_REMOVE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[32004] = doCallback;
end

--才艺强化
function S2C:PLAYER_TALENT_STRENGTH(callback_pbTalent)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbTalent();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalent(msg);
	end
	self.mReceiveCallback[32005] = doCallback;
end

--才艺研习
function S2C:PLAYER_TALENT_UP(callback_pbTalentAttributeAdd)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_32_pb = pb_32_pb or require('Protol.pb_32_pb');
			msg = pb_32_pb.pbTalentAttributeAdd();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalentAttributeAdd(msg);
	end
	self.mReceiveCallback[32006] = doCallback;
end

--才艺精研
function S2C:PLAYER_TALENT_WASH(callback_pbTalentAttributeAdd)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_32_pb = pb_32_pb or require('Protol.pb_32_pb');
			msg = pb_32_pb.pbTalentAttributeAdd();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalentAttributeAdd(msg);
	end
	self.mReceiveCallback[32007] = doCallback;
end

--才艺精研保存
function S2C:PLAYER_TALENT_WASH_SAVE(callback_pbTalent)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbTalent();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTalent(msg);
	end
	self.mReceiveCallback[32008] = doCallback;
end

--子女列表
function S2C:PLAYER_CHILD_LIST(callback_pbChildList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildList(msg);
	end
	self.mReceiveCallback[33000] = doCallback;
end

--子女列表刷新
function S2C:PLAYER_CHILD_REFRESH(callback_pbChildList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildList(msg);
	end
	self.mReceiveCallback[33001] = doCallback;
end

--子女喂养
function S2C:PLAYER_CHILD_FEED(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33002] = doCallback;
end

--子女进阶
function S2C:PLAYER_CHILD_UP(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33003] = doCallback;
end

--子女考核
function S2C:PLAYER_CHILD_TEST(callback_pbChildTest)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildTest();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildTest(msg);
	end
	self.mReceiveCallback[33004] = doCallback;
end

--子女考核答题
function S2C:PLAYER_CHILD_TEST_ANSWER(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33005] = doCallback;
end

--子女委任/召回
function S2C:PLAYER_CHILD_USE(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33006] = doCallback;
end

--子女上阵列表
function S2C:PLAYER_CHILD_POS_LIST(callback_pbChildPosList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildPosList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildPosList(msg);
	end
	self.mReceiveCallback[33007] = doCallback;
end

--子女上阵下阵
function S2C:PLAYER_CHILD_POS(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33008] = doCallback;
end

--子女事件列表
function S2C:PLAYER_CHILD_EVENT_LIST(callback_pbChildEventList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildEventList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildEventList(msg);
	end
	self.mReceiveCallback[33009] = doCallback;
end

--子女事件奖励领取
function S2C:PLAYER_CHILD_EVENT_AWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33010] = doCallback;
end

--子女任务列表
function S2C:PLAYER_CHILD_TASK_LIST(callback_pbChildTaskList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_33_pb = pb_33_pb or require('Protol.pb_33_pb');
			msg = pb_33_pb.pbChildTaskList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbChildTaskList(msg);
	end
	self.mReceiveCallback[33011] = doCallback;
end

--子女任务接取
function S2C:PLAYER_CHILD_TASK_ACCEPT(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33012] = doCallback;
end

--子女任务奖励领取
function S2C:PLAYER_CHILD_TASK_AWARD(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[33013] = doCallback;
end

--获取神秘商店列表
function S2C:PLAYER_SHOPS_MYSTERY_LIST(callback_pbShopMysteryList)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_34_pb = pb_34_pb or require('Protol.pb_34_pb');
			msg = pb_34_pb.pbShopMysteryList();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbShopMysteryList(msg);
	end
	self.mReceiveCallback[34001] = doCallback;
end

--购买神秘商店道具
function S2C:PLAYER_SHOPS_MYSTERY_BUY(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[34002] = doCallback;
end

--元宝刷新神秘商店
function S2C:PLAYER_SHOPS_MYSTERY_REFRESH(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[34003] = doCallback;
end

--请求每日领取体力
function S2C:PLAYER_EVERY_DAY_SP_LIST(callback_pbId32R)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbId32R();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbId32R(msg);
	end
	self.mReceiveCallback[35001] = doCallback;
end

--每日领取体力
function S2C:PLAYER_EVERY_DAY_SP_GET(callback_pbResult)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_common_pb = pb_common_pb or require('Protol.pb_common_pb');
			msg = pb_common_pb.pbResult();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbResult(msg);
	end
	self.mReceiveCallback[35002] = doCallback;
end

--定时回复体力，精力
function S2C:PLAYER_EVERYDAY_SP_ENERGY_TIME(callback_pbTimeSpEnergy)
	local msg = nil;
	local doCallback = function(byteBuffer)
		if msg == nil then
			pb_35_pb = pb_35_pb or require('Protol.pb_35_pb');
			msg = pb_35_pb.pbTimeSpEnergy();
		end
		msg:ParseFromString(byteBuffer);
		callback_pbTimeSpEnergy(msg);
	end
	self.mReceiveCallback[35003] = doCallback;
end

return S2C.LuaNew();