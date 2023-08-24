local mLuaClass = require 'Core/LuaClass'
local mBaseLua = require 'Core/BaseLua' 
local mNetManager = require 'Net/NetManager' 
local mipairs = ipairs 
local mtable = table 
local C2S = mLuaClass('C2S',mBaseLua);
	
local pb_10_pb;
local pb_10_pb_pbAccount;
local pb_11_pb;
local pb_11_pb_pbPartnerModel;
local pb_11_pb_pbPartnerBreakOut;
local pb_11_pb_pbPartnerSkillUpOp;
local pb_11_pb_pbPartnerSkillUse;
local pb_11_pb_pbPartnerMemoir;
local pb_11_pb_pbPartnerChangeName;
local pb_11_pb_pbPartnerLock;
local pb_11_pb_pbPartnerCommentAdd;
local pb_11_pb_pbPartnerLook;
local pb_12_pb;
local pb_12_pb_pbGoodSell;
local pb_12_pb_pbGoodModel;
local pb_12_pb_pbEqipModel;
local pb_12_pb_pbEqipModelRemove;
local pb_12_pb_pbEqipModelStrength;
local pb_12_pb_pbEqipModelRe;
local pb_12_pb_pbEqipModelUp;
local pb_13_pb;
local pb_13_pb_pbDungeonBattle;
local pb_13_pb_pbDungeonOver;
local pb_14_pb;
local pb_14_pb_pbEnter;
local pb_14_pb_pbClimbTowerOver;
local pb_14_pb_pbClimbTowerUpdateStory;
local pb_15_pb;
local pb_16_pb;
local pb_16_pb_pbFriend;
local pb_16_pb_pbFriendS;
local pb_16_pb_pbFriendR;
local pb_17_pb;
local pb_17_pb_pbChat;
local pb_18_pb;
local pb_18_pb_pbPlotDungeonOver;
local pb_19_pb;
local pb_19_pb_pbAnswer;
local pb_19_pb_pbNpc;
local pb_19_pb_pbDefensePos;
local pb_19_pb_pbVsPlayer;
local pb_19_pb_pbVsResult;
local pb_19_pb_pbRankPram;
local pb_19_pb_pbPromoteVsResult;
local pb_20_pb;
local pb_20_pb_pbDraftType;
local pb_20_pb_pbDraftChip;
local pb_21_pb;
local pb_21_pb_pbRank;
local pb_22_pb;
local pb_22_pb_pbArenaDefensePos;
local pb_22_pb_pbArenaVsPlayer;
local pb_22_pb_pbArenaVsResult;
local pb_22_pb_pbArenaRankPram;
local pb_23_pb;
local pb_23_pb_pbShopGetList;
local pb_23_pb_pbShopBuy;
local pb_24_pb;
local pb_24_pb_pbMonarchRun;
local pb_25_pb;
local pb_26_pb;
local pb_26_pb_pbMansionServantChangeName;
local pb_26_pb_pbMansionPlanting;
local pb_26_pb_pbMansionPlantPlanlist;
local pb_26_pb_pbMansionFeastAdd;
local pb_27_pb;
local pb_27_pb_pbItemSell;
local pb_28_pb;
local pb_28_pb_pbEliteDungeonBattle;
local pb_28_pb_pbEliteDungeonOver;
local pb_29_pb;
local pb_29_pb_pbGuide;
local pb_30_pb;
local pb_30_pb_pbWearFashionList;
local pb_30_pb_pbFashion;
local pb_30_pb_pbFashionStrength;
local pb_30_pb_pbFashionSuit;
local pb_30_pb_pbFashionSave;
local pb_31_pb;
local pb_32_pb;
local pb_32_pb_pbTalentSell;
local pb_32_pb_pbTalentModelWear;
local pb_32_pb_pbTalentModelRemove;
local pb_32_pb_pbTalentModelStrength;
local pb_32_pb_pbTalentModelUp;
local pb_32_pb_pbTalentModelSave;
local pb_33_pb;
local pb_33_pb_pbChildModel;
local pb_33_pb_pbChildAnswer;
local pb_33_pb_pbChildModelFeed;
local pb_33_pb_pbChildModelUp;
local pb_33_pb_pbChildPos;
local pb_33_pb_pbTaskAcceptModel;
local pb_33_pb_pbTaskModel;
local pb_34_pb;
local pb_35_pb;
local pb_9_pb;
local pb_common_pb;
local pb_common_pb_pbResult;
local pb_common_pb_pbId32;
local pb_common_pb_pbId32R;
local pb_common_pb_pbId64;
local pb_common_pb_pbString;	

ProtolDesc={
		[9001] = "错误提示代号",
		[9002] = "人物属性数据",
		[9003] = "查看其他玩家信息",
		[9005] = "更改主角头像",
		[9006] = "玩家信息更新",
		[10000] = "登录和创角",
		[10001] = "心跳包",
		[10002] = "新进程开启需要到登陆界面",
		[11001] = "获取随从信息",
		[11002] = "随从升级",
		[11003] = "随从切换形象",
		[11004] = "随从技能升级",
		[11005] = "随从晋封",
		[11006] = "随从上阵列表",
		[11007] = "随从突破",
		[11008] = "随从通关传记",
		[11010] = "主角技能激活/升级",
		[11011] = "主角培养放弃/保存",
		[11012] = "主角技能使用",
		[11013] = "新增随从",
		[11014] = "修改随从昵称",
		[11015] = "随从删除",
		[11016] = "锁定/解锁随从",
		[11017] = "主角培养",
		[11018] = "请求随从评价",
		[11019] = "随从评价点赞",
		[11020] = "新增随从评价",
		[11021] = "查看随从",
		[12000] = "背包",
		[12001] = "背包物品刷新",
		[12002] = "出售物品",
		[12003] = "使用物品",
		[12011] = "穿戴",
		[12012] = "卸下",
		[12013] = "强化",
		[12014] = "鉴定",
		[12015] = "重琢",
		[12016] = "精雕",
		[12017] = "打磨",
		[12018] = "抛光",
		[12019] = "一键强化",
		[13000] = "请求挑战副本信息",
		[13001] = "请求挑战副本",
		[13002] = "挑战副本结果",
		[13003] = "复活再战",
		[13004] = "请求随从通关出场率",
		[14000] = "获取爬塔信息",
		[14001] = "进入爬塔关卡",
		[14002] = "爬塔战斗结果",
		[14003] = "更新剧情",
		[15000] = "请求邮件列表",
		[15001] = "查看邮件",
		[15002] = "删除邮件",
		[15003] = "一键删除",
		[15004] = "一键领取",
		[15005] = "领取邮件",
		[15006] = "增加邮件",
		[17000] = "发送聊天消息",
		[17001] = "收到聊天消息",
		[17002] = "请求最近联系人",
		[17003] = "查询与某人的私聊信息",
		[17004] = "更新最新联系人",
		[17005] = "收到公告消息",
		[17009] = "获取GAME MASTER",
		[16000] = "好友列表",
		[16001] = "接收体力",
		[16002] = "发送体力",
		[16003] = "删除好友",
		[16004] = "查找",
		[16005] = "加好友",
		[16006] = "申请列表",
		[16007] = "接受/拒接",
		[16008] = "黑名单列表",
		[16009] = "解禁黑名单",
		[16010] = "仇敌列表",
		[16011] = "删除仇敌",
		[16012] = "加入黑名单",
		[16013] = "查看玩家",
		[16014] = "推荐列表",
		[18000] = "请求主线副本信息",
		[18001] = "请求挑战主线副本",
		[18002] = "挑战主线副本结果",
		[18003] = "通知播放完前置剧情",
		[18004] = "主线副本复活再战",
		[18005] = "剧情副本章节扫荡",
		[19000] = "报考界面",
		[19001] = "报考",
		[19002] = "开始考试",
		[19003] = "提交答案",
		[19004] = "重考当前阶段",
		[19005] = "进入下一阶段",
		[19006] = "评判结果",
		[19007] = "放弃重考",
		[19008] = "友好界面",
		[19009] = "友好",
		[19010] = "晋升",
		[19011] = "提前结束",
		[19012] = "晋封战斗考试准备",
		[19013] = "晋封战斗考试",
		[19014] = "晋封战斗考试结果",
		[19015] = "晋封战斗玩家返回",
		[19020] = "巅峰宫斗",
		[19021] = "刷新列表",
		[19022] = "购买次数",
		[19023] = "防守阵容",
		[19024] = "保存防守阵容",
		[19025] = "准备挑战",
		[19026] = "挑战结果",
		[19027] = "仇人列表",
		[19028] = "准备复仇挑战",
		[19029] = "复仇挑战结果",
		[19030] = "开始挑战",
		[19031] = "复仇挑战",
		[19032] = "巅峰宫斗排行榜",
		[20000] = "请求召唤",
		[20001] = "碎片召唤",
		[20002] = "请求特殊召唤列表",
		[20003] = "请求图鉴列表",
		[21000] = "排行榜",
		[22000] = "竞技场",
		[22001] = "竞技场刷新列表",
		[22002] = "竞技场防守阵容",
		[22003] = "竞技场保存防守阵容",
		[22004] = "竞技场挑战准备",
		[22005] = "竞技场挑战",
		[22006] = "竞技场挑战结果",
		[22007] = "竞技场仇人列表",
		[22008] = "竞技场复仇挑战准备",
		[22009] = "竞技场复仇挑战",
		[22010] = "竞技场复仇挑战结果",
		[22011] = "竞技场排行榜",
		[23000] = "获取商城列表",
		[23001] = "购买道具",
		[23002] = "更新道具",
		[24000] = "获取觐见剧情",
		[24001] = "更新觐见剧情",
		[24002] = "觐见结束获得奖励",
		[24003] = "获取邀宠或承恩技能列表",
		[24004] = "开始邀宠或承恩",
		[25000] = "获取任务列表",
		[25001] = "更新任务",
		[25002] = "删除任务",
		[25003] = "领取任务奖励",
		[26000] = "府邸信息",
		[26001] = "府邸改名",
		[26002] = "府邸串门",
		[26003] = "府邸事件",
		[26004] = "府邸串门进行",
		[26005] = "府邸仆人列表",
		[26006] = "府邸仆人改名",
		[26007] = "府邸仆人打赏",
		[26008] = "府邸仆人发放通宝",
		[26009] = "府邸仆人雇佣",
		[26010] = "府邸仆人信息更新",
		[26011] = "府邸仆人清洁度",
		[26012] = "府邸信息更新",
		[26013] = "府邸开垦土地",
		[26014] = "府邸种子操作",
		[26015] = "府邸请求种子种植顺序",
		[26016] = "府邸更新种子种植顺序",
		[26017] = "府邸更新npc事件",
		[26018] = "府邸npc事件领取奖励",
		[26019] = "府邸npc事件删除",
		[26020] = "府邸离线获得信息",
		[26021] = "府邸关闭",
		[26030] = "府邸打开宴会界面",
		[26031] = "府邸开启宴会",
		[26032] = "府邸获取宴会列表",
		[26033] = "府邸赴宴",
		[26034] = "府邸宴会详细信息",
		[26035] = "府邸宴会邀请",
		[27000] = "府邸背包列表",
		[27001] = "府邸背包更新",
		[27002] = "府邸背包出售",
		[27003] = "府邸背包材料合成",
		[28000] = "请求精英副本信息",
		[28001] = "请求挑战精英副本",
		[28002] = "挑战精英副本结果",
		[28003] = "精英副本复活再战",
		[29000] = "获取完成引导的id信息",
		[29001] = "通知完成引导",
		[30000] = "时装列表",
		[30001] = "保存",
		[30002] = "合成",
		[30003] = "强化",
		[30004] = "进阶",
		[30005] = "升星",
		[30006] = "渲光",
		[30007] = "一键穿戴",
		[30008] = "洗练",
		[30009] = "洗练保存",
		[30010] = "刷新的时装列表",
		[31000] = "获取祭拜先祖信息",
		[31001] = "请求祭拜先祖",
		[31002] = "太后请安",
		[31003] = "太后献礼",
		[31004] = "太后请安/献礼次数",
		[32000] = "才艺背包",
		[32001] = "才艺背包刷新",
		[32002] = "才艺出售",
		[32003] = "才艺穿戴",
		[32004] = "才艺卸下",
		[32005] = "才艺强化",
		[32006] = "才艺研习",
		[32007] = "才艺精研",
		[32008] = "才艺精研保存",
		[33000] = "子女列表",
		[33001] = "子女列表刷新",
		[33002] = "子女喂养",
		[33003] = "子女进阶",
		[33004] = "子女考核",
		[33005] = "子女考核答题",
		[33006] = "子女委任/召回",
		[33007] = "子女上阵列表",
		[33008] = "子女上阵下阵",
		[33009] = "子女事件列表",
		[33010] = "子女事件奖励领取",
		[33011] = "子女任务列表",
		[33012] = "子女任务接取",
		[33013] = "子女任务奖励领取",
		[34001] = "获取神秘商店列表",
		[34002] = "购买神秘商店道具",
		[34003] = "元宝刷新神秘商店",
		[35001] = "请求每日领取体力",
		[35002] = "每日领取体力",
		[35003] = "定时回复体力，精力",
}

--错误提示代号
function C2S:ERROR_CODE(showLoading)
	mNetManager:SendData(9001,nil,showLoading);
end

--人物属性数据
function C2S:PLAYER_BASE(showLoading)
	mNetManager:SendData(9002,nil,showLoading);
end

--查看其他玩家信息
function C2S:PLAYER_OTHER_BASE(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(9003,msg:SerializeToString(),showLoading);
end

--更改主角头像
function C2S:PLAYER_CHANGE_HEAD(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(9005,msg:SerializeToString(),showLoading);
end

--玩家信息更新
function C2S:PLAYER_CHANGE_INFO(showLoading)
	mNetManager:SendData(9006,nil,showLoading);
end

--登录和创角
function C2S:LOGIN(acc_id_int64, acc_name_string, timestamp_int32, server_id_int32, login_ticket_string, suid_string, platform_string, token_string, nickname_string, is_relogin_int32, head_int32, sex_int32, phone_string, fcm_int32,showLoading)
	if pb_10_pb_pbAccount == nil then
		if pb_10_pb == nil then
			pb_10_pb = require('Protol.pb_10_pb');
		end
		pb_10_pb_pbAccount = pb_10_pb.pbAccount();
	end
	local msg = pb_10_pb_pbAccount;
	msg.acc_id = acc_id_int64;
	msg.acc_name = acc_name_string;
	msg.timestamp = timestamp_int32;
	msg.server_id = server_id_int32;
	msg.login_ticket = login_ticket_string;
	msg.suid = suid_string;
	msg.platform = platform_string;
	msg.token = token_string;
	msg.nickname = nickname_string;
	msg.is_relogin = is_relogin_int32;
	msg.head = head_int32;
	msg.sex = sex_int32;
	msg.phone = phone_string;
	msg.fcm = fcm_int32;
	mNetManager:SendData(10000,msg:SerializeToString(),showLoading);
end

--心跳包
function C2S:KEEP_HEART(result_int32,showLoading)
	if pb_common_pb_pbResult == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbResult = pb_common_pb.pbResult();
	end
	local msg = pb_common_pb_pbResult;
	msg.result = result_int32;
	mNetManager:SendData(10001,msg:SerializeToString(),showLoading);
end

--新进程开启需要到登陆界面
function C2S:LOGIN_OK_SERVER(showLoading)
	mNetManager:SendData(10002,nil,showLoading);
end

--获取随从信息
function C2S:PARTNER_LIST(showLoading)
	mNetManager:SendData(11001,nil,showLoading);
end

--随从升级
function C2S:PARTNER_LV_UP(id_int64,showLoading)
	if pb_common_pb_pbId64 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId64 = pb_common_pb.pbId64();
	end
	local msg = pb_common_pb_pbId64;
	msg.id = id_int64;
	mNetManager:SendData(11002,msg:SerializeToString(),showLoading);
end

--随从切换形象
function C2S:PARTNER_MODEL_CHANGE(id_int64, model_int32,showLoading)
	if pb_11_pb_pbPartnerModel == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerModel = pb_11_pb.pbPartnerModel();
	end
	local msg = pb_11_pb_pbPartnerModel;
	msg.id = id_int64;
	msg.model = model_int32;
	mNetManager:SendData(11003,msg:SerializeToString(),showLoading);
end

--随从技能升级
function C2S:PARTNER_SKILL_UP(id_int64, type_int32, cost_id_int64,showLoading)
	if pb_11_pb_pbPartnerSkillUpOp == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerSkillUpOp = pb_11_pb.pbPartnerSkillUpOp();
	end
	local msg = pb_11_pb_pbPartnerSkillUpOp;
	msg.id = id_int64;
	msg.type = type_int32;
	msg.cost_id = cost_id_int64;
	mNetManager:SendData(11004,msg:SerializeToString(),showLoading);
end

--随从晋封
function C2S:PARTNER_POSITION_UP(id_int64,showLoading)
	if pb_common_pb_pbId64 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId64 = pb_common_pb.pbId64();
	end
	local msg = pb_common_pb_pbId64;
	msg.id = id_int64;
	mNetManager:SendData(11005,msg:SerializeToString(),showLoading);
end

--随从上阵列表
function C2S:PARTNER_IN_CAMP(showLoading)
	mNetManager:SendData(11006,nil,showLoading);
end

--随从突破
function C2S:PARTNER_BREAK_OUT(id_int64, cost_ids_int64,showLoading)
	if pb_11_pb_pbPartnerBreakOut == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerBreakOut = pb_11_pb.pbPartnerBreakOut();
	end
	local msg = pb_11_pb_pbPartnerBreakOut;
	msg.id = id_int64;
	if cost_ids_int64 ~= nil then
		local msg_cost_ids = msg.cost_ids
		local count = #msg_cost_ids;
		while count >0 do
			mtable.remove(msg_cost_ids,count);
			count = count - 1;
		end
		for k,v in mipairs(cost_ids_int64) do
			mtable.insert(msg_cost_ids,v);
		end
	end
	mNetManager:SendData(11007,msg:SerializeToString(),showLoading);
end

--随从通关传记
function C2S:PARTNER_PASS_MEMOIR(id_int64, chapter_id_int32,showLoading)
	if pb_11_pb_pbPartnerMemoir == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerMemoir = pb_11_pb.pbPartnerMemoir();
	end
	local msg = pb_11_pb_pbPartnerMemoir;
	msg.id = id_int64;
	msg.chapter_id = chapter_id_int32;
	mNetManager:SendData(11008,msg:SerializeToString(),showLoading);
end

--主角技能激活/升级
function C2S:PARTNER_MAIN_SKILL_UP(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(11010,msg:SerializeToString(),showLoading);
end

--主角培养放弃/保存
function C2S:PARTNER_TRAIN_OP(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(11011,msg:SerializeToString(),showLoading);
end

--主角技能使用
function C2S:PARTNER_MAIN_SKILL_USE(force_int32, line_int32,showLoading)
	if pb_11_pb_pbPartnerSkillUse == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerSkillUse = pb_11_pb.pbPartnerSkillUse();
	end
	local msg = pb_11_pb_pbPartnerSkillUse;
	msg.force = force_int32;
	msg.line = line_int32;
	mNetManager:SendData(11012,msg:SerializeToString(),showLoading);
end

--新增随从
function C2S:PARTNER_ADD(showLoading)
	mNetManager:SendData(11013,nil,showLoading);
end

--修改随从昵称
function C2S:PARTNER_CHANGE_NAME(id_int64, name_string,showLoading)
	if pb_11_pb_pbPartnerChangeName == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerChangeName = pb_11_pb.pbPartnerChangeName();
	end
	local msg = pb_11_pb_pbPartnerChangeName;
	msg.id = id_int64;
	msg.name = name_string;
	mNetManager:SendData(11014,msg:SerializeToString(),showLoading);
end

--随从删除
function C2S:PARTNER_DELETE(id_int64,showLoading)
	if pb_common_pb_pbId64 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId64 = pb_common_pb.pbId64();
	end
	local msg = pb_common_pb_pbId64;
	msg.id = id_int64;
	mNetManager:SendData(11015,msg:SerializeToString(),showLoading);
end

--锁定/解锁随从
function C2S:PARTNER_LOCK(id_int64, flag_int32,showLoading)
	if pb_11_pb_pbPartnerLock == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerLock = pb_11_pb.pbPartnerLock();
	end
	local msg = pb_11_pb_pbPartnerLock;
	msg.id = id_int64;
	msg.flag = flag_int32;
	mNetManager:SendData(11016,msg:SerializeToString(),showLoading);
end

--主角培养
function C2S:PARTNER_TRAIN(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(11017,msg:SerializeToString(),showLoading);
end

--请求随从评价
function C2S:PARTNER_COMMENT_LIST(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(11018,msg:SerializeToString(),showLoading);
end

--随从评价点赞
function C2S:PARTNER_COMMENT_VOTE(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(11019,msg:SerializeToString(),showLoading);
end

--新增随从评价
function C2S:PARTNER_COMMENT_ADD(partner_id_int32, content_string,showLoading)
	if pb_11_pb_pbPartnerCommentAdd == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerCommentAdd = pb_11_pb.pbPartnerCommentAdd();
	end
	local msg = pb_11_pb_pbPartnerCommentAdd;
	msg.partner_id = partner_id_int32;
	msg.content = content_string;
	mNetManager:SendData(11020,msg:SerializeToString(),showLoading);
end

--查看随从
function C2S:PARTNER_COMMENT_LOOK(player_id_int32, id_int32,showLoading)
	if pb_11_pb_pbPartnerLook == nil then
		if pb_11_pb == nil then
			pb_11_pb = require('Protol.pb_11_pb');
		end
		pb_11_pb_pbPartnerLook = pb_11_pb.pbPartnerLook();
	end
	local msg = pb_11_pb_pbPartnerLook;
	msg.player_id = player_id_int32;
	msg.id = id_int32;
	mNetManager:SendData(11021,msg:SerializeToString(),showLoading);
end

--背包
function C2S:PLAYER_BAG(showLoading)
	mNetManager:SendData(12000,nil,showLoading);
end

--背包物品刷新
function C2S:PLAYER_BAG_REFRESH(showLoading)
	mNetManager:SendData(12001,nil,showLoading);
end

--出售物品
function C2S:PLAYER_SELL_GOOD(sell_list_pbGoodModel,showLoading)
	if pb_12_pb_pbGoodSell == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbGoodSell = pb_12_pb.pbGoodSell();
	end
	local msg = pb_12_pb_pbGoodSell;
	if sell_list_pbGoodModel ~= nil then
		local msg_sell_list = msg.sell_list
		local count = #msg_sell_list;
		while count >0 do
			mtable.remove(msg_sell_list,count);
			count = count - 1;
		end
		local pbGoodModel = pb_12_pb.pbGoodModel;
		for k,v in mipairs(sell_list_pbGoodModel) do
			local sell_list = pbGoodModel();
			sell_list.id=v.id;
			sell_list.num=v.num;
			mtable.insert(msg_sell_list,sell_list);
		end
	end
	mNetManager:SendData(12002,msg:SerializeToString(),showLoading);
end

--使用物品
function C2S:PLAYER_USE_GOOD(id_int32, num_int32,showLoading)
	if pb_12_pb_pbGoodModel == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbGoodModel = pb_12_pb.pbGoodModel();
	end
	local msg = pb_12_pb_pbGoodModel;
	msg.id = id_int32;
	msg.num = num_int32;
	mNetManager:SendData(12003,msg:SerializeToString(),showLoading);
end

--穿戴
function C2S:PLAYER_WEAR_EQUIP(partner_id_int32, pos_int32, id_int32,showLoading)
	if pb_12_pb_pbEqipModel == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModel = pb_12_pb.pbEqipModel();
	end
	local msg = pb_12_pb_pbEqipModel;
	msg.partner_id = partner_id_int32;
	msg.pos = pos_int32;
	msg.id = id_int32;
	mNetManager:SendData(12011,msg:SerializeToString(),showLoading);
end

--卸下
function C2S:PLAYER_REMOVE_EQUIP(partner_id_int32, pos_int32,showLoading)
	if pb_12_pb_pbEqipModelRemove == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelRemove = pb_12_pb.pbEqipModelRemove();
	end
	local msg = pb_12_pb_pbEqipModelRemove;
	msg.partner_id = partner_id_int32;
	msg.pos = pos_int32;
	mNetManager:SendData(12012,msg:SerializeToString(),showLoading);
end

--强化
function C2S:PLAYER_STRENGTH_EQUIP(partner_id_int32, id_int32,showLoading)
	if pb_12_pb_pbEqipModelStrength == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelStrength = pb_12_pb.pbEqipModelStrength();
	end
	local msg = pb_12_pb_pbEqipModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	mNetManager:SendData(12013,msg:SerializeToString(),showLoading);
end

--鉴定
function C2S:PLAYER_IDENTYFY_EQUIP(partner_id_int32, id_int32,showLoading)
	if pb_12_pb_pbEqipModelStrength == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelStrength = pb_12_pb.pbEqipModelStrength();
	end
	local msg = pb_12_pb_pbEqipModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	mNetManager:SendData(12014,msg:SerializeToString(),showLoading);
end

--重琢
function C2S:PLAYER_REDENTYFY_EQUIP(partner_id_int32, id_int32, seq_int32,showLoading)
	if pb_12_pb_pbEqipModelRe == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelRe = pb_12_pb.pbEqipModelRe();
	end
	local msg = pb_12_pb_pbEqipModelRe;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.seq = seq_int32;
	mNetManager:SendData(12015,msg:SerializeToString(),showLoading);
end

--精雕
function C2S:PLAYER_UPDENTYFY_EQUIP(partner_id_int32, id_int32, seq_int32,showLoading)
	if pb_12_pb_pbEqipModelRe == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelRe = pb_12_pb.pbEqipModelRe();
	end
	local msg = pb_12_pb_pbEqipModelRe;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.seq = seq_int32;
	mNetManager:SendData(12016,msg:SerializeToString(),showLoading);
end

--打磨
function C2S:PLAYER_UPGRADE_STAR_EQUIP(partner_id_int32, id_int32, use_stone_int32,showLoading)
	if pb_12_pb_pbEqipModelUp == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelUp = pb_12_pb.pbEqipModelUp();
	end
	local msg = pb_12_pb_pbEqipModelUp;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.use_stone = use_stone_int32;
	mNetManager:SendData(12017,msg:SerializeToString(),showLoading);
end

--抛光
function C2S:PLAYER_UPGRADE_COLOR_EQUIP(partner_id_int32, id_int32,showLoading)
	if pb_12_pb_pbEqipModelStrength == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelStrength = pb_12_pb.pbEqipModelStrength();
	end
	local msg = pb_12_pb_pbEqipModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	mNetManager:SendData(12018,msg:SerializeToString(),showLoading);
end

--一键强化
function C2S:PLAYER_STRENGTH_TOP_EQUIP(partner_id_int32, id_int32,showLoading)
	if pb_12_pb_pbEqipModelStrength == nil then
		if pb_12_pb == nil then
			pb_12_pb = require('Protol.pb_12_pb');
		end
		pb_12_pb_pbEqipModelStrength = pb_12_pb.pbEqipModelStrength();
	end
	local msg = pb_12_pb_pbEqipModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	mNetManager:SendData(12019,msg:SerializeToString(),showLoading);
end

--请求挑战副本信息
function C2S:DUNGEON_INFO(showLoading)
	mNetManager:SendData(13000,nil,showLoading);
end

--请求挑战副本
function C2S:DUNGEON_START_BATTLE(dungeon_id_int32, past_id_int32,showLoading)
	if pb_13_pb_pbDungeonBattle == nil then
		if pb_13_pb == nil then
			pb_13_pb = require('Protol.pb_13_pb');
		end
		pb_13_pb_pbDungeonBattle = pb_13_pb.pbDungeonBattle();
	end
	local msg = pb_13_pb_pbDungeonBattle;
	msg.dungeon_id = dungeon_id_int32;
	msg.past_id = past_id_int32;
	mNetManager:SendData(13001,msg:SerializeToString(),showLoading);
end

--挑战副本结果
function C2S:DUNGEON_BATTLE_RESULT(dungeon_id_int32, past_id_int32, result_int32, reward_pbDungeonReward, partner_list_int32,showLoading)
	if pb_13_pb_pbDungeonOver == nil then
		if pb_13_pb == nil then
			pb_13_pb = require('Protol.pb_13_pb');
		end
		pb_13_pb_pbDungeonOver = pb_13_pb.pbDungeonOver();
	end
	local msg = pb_13_pb_pbDungeonOver;
	msg.dungeon_id = dungeon_id_int32;
	msg.past_id = past_id_int32;
	msg.result = result_int32;
	if reward_pbDungeonReward ~= nil then
		local msg_reward = msg.reward
		local count = #msg_reward;
		while count >0 do
			mtable.remove(msg_reward,count);
			count = count - 1;
		end
		local pbDungeonReward = pb_13_pb.pbDungeonReward;
		for k,v in mipairs(reward_pbDungeonReward) do
			local reward = pbDungeonReward();
			reward.goods_id=v.goods_id;
			reward.goods_num=v.goods_num;
			mtable.insert(msg_reward,reward);
		end
	end
	if partner_list_int32 ~= nil then
		local msg_partner_list = msg.partner_list
		local count = #msg_partner_list;
		while count >0 do
			mtable.remove(msg_partner_list,count);
			count = count - 1;
		end
		for k,v in mipairs(partner_list_int32) do
			mtable.insert(msg_partner_list,v);
		end
	end
	mNetManager:SendData(13002,msg:SerializeToString(),showLoading);
end

--复活再战
function C2S:DUNGEON_REBORN_BATTLE(dungeon_id_int32, past_id_int32,showLoading)
	if pb_13_pb_pbDungeonBattle == nil then
		if pb_13_pb == nil then
			pb_13_pb = require('Protol.pb_13_pb');
		end
		pb_13_pb_pbDungeonBattle = pb_13_pb.pbDungeonBattle();
	end
	local msg = pb_13_pb_pbDungeonBattle;
	msg.dungeon_id = dungeon_id_int32;
	msg.past_id = past_id_int32;
	mNetManager:SendData(13003,msg:SerializeToString(),showLoading);
end

--请求随从通关出场率
function C2S:DUNGEON_PARTNER_INFO(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(13004,msg:SerializeToString(),showLoading);
end

--获取爬塔信息
function C2S:CLIMB_TOWERS(id_int32,showLoading)
	if pb_common_pb_pbId32R == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32R = pb_common_pb.pbId32R();
	end
	local msg = pb_common_pb_pbId32R;
	if id_int32 ~= nil then
		local msg_id = msg.id
		local count = #msg_id;
		while count >0 do
			mtable.remove(msg_id,count);
			count = count - 1;
		end
		for k,v in mipairs(id_int32) do
			mtable.insert(msg_id,v);
		end
	end
	mNetManager:SendData(14000,msg:SerializeToString(),showLoading);
end

--进入爬塔关卡
function C2S:CLIMB_TOWER_ENTER(chapter_int32, buffs_int32,showLoading)
	if pb_14_pb_pbEnter == nil then
		if pb_14_pb == nil then
			pb_14_pb = require('Protol.pb_14_pb');
		end
		pb_14_pb_pbEnter = pb_14_pb.pbEnter();
	end
	local msg = pb_14_pb_pbEnter;
	msg.chapter = chapter_int32;
	if buffs_int32 ~= nil then
		local msg_buffs = msg.buffs
		local count = #msg_buffs;
		while count >0 do
			mtable.remove(msg_buffs,count);
			count = count - 1;
		end
		for k,v in mipairs(buffs_int32) do
			mtable.insert(msg_buffs,v);
		end
	end
	mNetManager:SendData(14001,msg:SerializeToString(),showLoading);
end

--爬塔战斗结果
function C2S:CLIMB_TOWER_RESULT(result_int32, member_list_pbTeamMember, reward_pbClimbTowerReward,showLoading)
	if pb_14_pb_pbClimbTowerOver == nil then
		if pb_14_pb == nil then
			pb_14_pb = require('Protol.pb_14_pb');
		end
		pb_14_pb_pbClimbTowerOver = pb_14_pb.pbClimbTowerOver();
	end
	local msg = pb_14_pb_pbClimbTowerOver;
	msg.result = result_int32;
	if member_list_pbTeamMember ~= nil then
		local msg_member_list = msg.member_list
		local count = #msg_member_list;
		while count >0 do
			mtable.remove(msg_member_list,count);
			count = count - 1;
		end
		local pbTeamMember = pb_14_pb.pbTeamMember;
		for k,v in mipairs(member_list_pbTeamMember) do
			local member_list = pbTeamMember();
			member_list.id=v.id;
			member_list.hp=v.hp;
			member_list.status=v.status;
			mtable.insert(msg_member_list,member_list);
		end
	end
	if reward_pbClimbTowerReward ~= nil then
		local msg_reward = msg.reward
		local count = #msg_reward;
		while count >0 do
			mtable.remove(msg_reward,count);
			count = count - 1;
		end
		local pbClimbTowerReward = pb_14_pb.pbClimbTowerReward;
		for k,v in mipairs(reward_pbClimbTowerReward) do
			local reward = pbClimbTowerReward();
			reward.goods_id=v.goods_id;
			reward.goods_num=v.goods_num;
			mtable.insert(msg_reward,reward);
		end
	end
	mNetManager:SendData(14002,msg:SerializeToString(),showLoading);
end

--更新剧情
function C2S:CLIMB_TOWER_UPDATE_STORY(story_start_int32, story_end_int32,showLoading)
	if pb_14_pb_pbClimbTowerUpdateStory == nil then
		if pb_14_pb == nil then
			pb_14_pb = require('Protol.pb_14_pb');
		end
		pb_14_pb_pbClimbTowerUpdateStory = pb_14_pb.pbClimbTowerUpdateStory();
	end
	local msg = pb_14_pb_pbClimbTowerUpdateStory;
	msg.story_start = story_start_int32;
	msg.story_end = story_end_int32;
	mNetManager:SendData(14003,msg:SerializeToString(),showLoading);
end

--请求邮件列表
function C2S:MAIL_MAILS_INFO(showLoading)
	mNetManager:SendData(15000,nil,showLoading);
end

--查看邮件
function C2S:MAIL_READ(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(15001,msg:SerializeToString(),showLoading);
end

--删除邮件
function C2S:MAIL_DEL(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(15002,msg:SerializeToString(),showLoading);
end

--一键删除
function C2S:MAIL_DEL_ALL(showLoading)
	mNetManager:SendData(15003,nil,showLoading);
end

--一键领取
function C2S:MAIL_GET_AWARD_ALL(showLoading)
	mNetManager:SendData(15004,nil,showLoading);
end

--领取邮件
function C2S:MAIL_GET_AWARD(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(15005,msg:SerializeToString(),showLoading);
end

--增加邮件
function C2S:MAIL_ADD(showLoading)
	mNetManager:SendData(15006,nil,showLoading);
end

--发送聊天消息
function C2S:CHAT_SEND(channel_int32, msg_string, target_id_int32,showLoading)
	if pb_17_pb_pbChat == nil then
		if pb_17_pb == nil then
			pb_17_pb = require('Protol.pb_17_pb');
		end
		pb_17_pb_pbChat = pb_17_pb.pbChat();
	end
	local msg = pb_17_pb_pbChat;
	msg.channel = channel_int32;
	msg.msg = msg_string;
	msg.target_id = target_id_int32;
	mNetManager:SendData(17000,msg:SerializeToString(),showLoading);
end

--收到聊天消息
function C2S:CHAT_RECEIVE(showLoading)
	mNetManager:SendData(17001,nil,showLoading);
end

--请求最近联系人
function C2S:CHAT_CONTACT_PERSONS(showLoading)
	mNetManager:SendData(17002,nil,showLoading);
end

--查询与某人的私聊信息
function C2S:CHAT_PRIVATE_MESSAGE(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(17003,msg:SerializeToString(),showLoading);
end

--更新最新联系人
function C2S:CHAT_UPDATE_CONTACT_PERSON(showLoading)
	mNetManager:SendData(17004,nil,showLoading);
end

--收到公告消息
function C2S:CHAT_NOTICE_MESSAGE(showLoading)
	mNetManager:SendData(17005,nil,showLoading);
end

--获取GAME MASTER
function C2S:CHAT_GM_MASTER(showLoading)
	mNetManager:SendData(17009,nil,showLoading);
end

--好友列表
function C2S:PLAYER_FRIENDS_LIST(showLoading)
	mNetManager:SendData(16000,nil,showLoading);
end

--接收体力
function C2S:PLAYER_RECEIVE_ENERGY(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16001,msg:SerializeToString(),showLoading);
end

--发送体力
function C2S:PLAYER_SEND_ENERGY(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16002,msg:SerializeToString(),showLoading);
end

--删除好友
function C2S:PLAYER_DELETE_FRIEND(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16003,msg:SerializeToString(),showLoading);
end

--查找
function C2S:PLAYER_SEARCH_FRIEND(name_string,showLoading)
	if pb_16_pb_pbFriendS == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriendS = pb_16_pb.pbFriendS();
	end
	local msg = pb_16_pb_pbFriendS;
	msg.name = name_string;
	mNetManager:SendData(16004,msg:SerializeToString(),showLoading);
end

--加好友
function C2S:PLAYER_ADD_FRIEND(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16005,msg:SerializeToString(),showLoading);
end

--申请列表
function C2S:PLAYER_FRIEND_REQUEST_LIST(showLoading)
	mNetManager:SendData(16006,nil,showLoading);
end

--接受/拒接
function C2S:PLAYER_FRIEND_REQUEST_HANDLE(id_int32, flag_int32,showLoading)
	if pb_16_pb_pbFriendR == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriendR = pb_16_pb.pbFriendR();
	end
	local msg = pb_16_pb_pbFriendR;
	msg.id = id_int32;
	msg.flag = flag_int32;
	mNetManager:SendData(16007,msg:SerializeToString(),showLoading);
end

--黑名单列表
function C2S:PLAYER_FRIEND_BLACK_LIST(showLoading)
	mNetManager:SendData(16008,nil,showLoading);
end

--解禁黑名单
function C2S:PLAYER_FRIEND_UNBLOCK_BLACK(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16009,msg:SerializeToString(),showLoading);
end

--仇敌列表
function C2S:PLAYER_FRIEND_ENEMY_LIST(showLoading)
	mNetManager:SendData(16010,nil,showLoading);
end

--删除仇敌
function C2S:PLAYER_FRIEND_DELETE_ENEMY(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16011,msg:SerializeToString(),showLoading);
end

--加入黑名单
function C2S:PLAYER_FRIEND_ADD_TO_BLACK(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16012,msg:SerializeToString(),showLoading);
end

--查看玩家
function C2S:PLAYER_FRIEND_OTHER_PLAYER_INFO(id_int32,showLoading)
	if pb_16_pb_pbFriend == nil then
		if pb_16_pb == nil then
			pb_16_pb = require('Protol.pb_16_pb');
		end
		pb_16_pb_pbFriend = pb_16_pb.pbFriend();
	end
	local msg = pb_16_pb_pbFriend;
	msg.id = id_int32;
	mNetManager:SendData(16013,msg:SerializeToString(),showLoading);
end

--推荐列表
function C2S:PLAYER_FRIEND_RECOMMEND_LIST(showLoading)
	mNetManager:SendData(16014,nil,showLoading);
end

--请求主线副本信息
function C2S:DUNGEON_PLOT_LIST(showLoading)
	mNetManager:SendData(18000,nil,showLoading);
end

--请求挑战主线副本
function C2S:DUNGEON_PLOT_BATTLE(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(18001,msg:SerializeToString(),showLoading);
end

--挑战主线副本结果
function C2S:DUNGEON_PLOT_BATTLE_OVER(dungeon_id_int32, result_int32, reward_pbPlotDungeonReward,showLoading)
	if pb_18_pb_pbPlotDungeonOver == nil then
		if pb_18_pb == nil then
			pb_18_pb = require('Protol.pb_18_pb');
		end
		pb_18_pb_pbPlotDungeonOver = pb_18_pb.pbPlotDungeonOver();
	end
	local msg = pb_18_pb_pbPlotDungeonOver;
	msg.dungeon_id = dungeon_id_int32;
	msg.result = result_int32;
	if reward_pbPlotDungeonReward ~= nil then
		local msg_reward = msg.reward
		local count = #msg_reward;
		while count >0 do
			mtable.remove(msg_reward,count);
			count = count - 1;
		end
		local pbPlotDungeonReward = pb_18_pb.pbPlotDungeonReward;
		for k,v in mipairs(reward_pbPlotDungeonReward) do
			local reward = pbPlotDungeonReward();
			reward.goods_id=v.goods_id;
			reward.goods_num=v.goods_num;
			mtable.insert(msg_reward,reward);
		end
	end
	mNetManager:SendData(18002,msg:SerializeToString(),showLoading);
end

--通知播放完前置剧情
function C2S:DUNGEON_PLOT_PLAY(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(18003,msg:SerializeToString(),showLoading);
end

--主线副本复活再战
function C2S:DUNGEON_PLOT_REBORN(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(18004,msg:SerializeToString(),showLoading);
end

--剧情副本章节扫荡
function C2S:DUNGEON_PLOT_SWEEP(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(18005,msg:SerializeToString(),showLoading);
end

--报考界面
function C2S:PLAYER_PROMOTE_INFO(npc_int32,showLoading)
	if pb_19_pb_pbNpc == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbNpc = pb_19_pb.pbNpc();
	end
	local msg = pb_19_pb_pbNpc;
	msg.npc = npc_int32;
	mNetManager:SendData(19000,msg:SerializeToString(),showLoading);
end

--报考
function C2S:PLAYER_PROMOTE_SIGN(showLoading)
	mNetManager:SendData(19001,nil,showLoading);
end

--开始考试
function C2S:PLAYER_PROMOTE_START(showLoading)
	mNetManager:SendData(19002,nil,showLoading);
end

--提交答案
function C2S:PLAYER_PROMOTE_ANSWER(answer_id_int32,showLoading)
	if pb_19_pb_pbAnswer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbAnswer = pb_19_pb.pbAnswer();
	end
	local msg = pb_19_pb_pbAnswer;
	if answer_id_int32 ~= nil then
		local msg_answer_id = msg.answer_id
		local count = #msg_answer_id;
		while count >0 do
			mtable.remove(msg_answer_id,count);
			count = count - 1;
		end
		for k,v in mipairs(answer_id_int32) do
			mtable.insert(msg_answer_id,v);
		end
	end
	mNetManager:SendData(19003,msg:SerializeToString(),showLoading);
end

--重考当前阶段
function C2S:PLAYER_PROMOTE_RESTART(showLoading)
	mNetManager:SendData(19004,nil,showLoading);
end

--进入下一阶段
function C2S:PLAYER_PROMOTE_NEXT(showLoading)
	mNetManager:SendData(19005,nil,showLoading);
end

--评判结果
function C2S:PLAYER_PROMOTE_RESULT(showLoading)
	mNetManager:SendData(19006,nil,showLoading);
end

--放弃重考
function C2S:PLAYER_PROMOTE_RESET(showLoading)
	mNetManager:SendData(19007,nil,showLoading);
end

--友好界面
function C2S:PLAYER_PROMOTE_FRIEND(npc_int32,showLoading)
	if pb_19_pb_pbNpc == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbNpc = pb_19_pb.pbNpc();
	end
	local msg = pb_19_pb_pbNpc;
	msg.npc = npc_int32;
	mNetManager:SendData(19008,msg:SerializeToString(),showLoading);
end

--友好
function C2S:PLAYER_PROMOTE_FRIEND_TO_CHANGE(npc_int32,showLoading)
	if pb_19_pb_pbNpc == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbNpc = pb_19_pb.pbNpc();
	end
	local msg = pb_19_pb_pbNpc;
	msg.npc = npc_int32;
	mNetManager:SendData(19009,msg:SerializeToString(),showLoading);
end

--晋升
function C2S:PLAYER_PROMOTE_PROMOTE(showLoading)
	mNetManager:SendData(19010,nil,showLoading);
end

--提前结束
function C2S:PLAYER_PROMOTE_STOP(showLoading)
	mNetManager:SendData(19011,nil,showLoading);
end

--晋封战斗考试准备
function C2S:PLAYER_PROMOTE_FIGHT_PREPARE(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19012,msg:SerializeToString(),showLoading);
end

--晋封战斗考试
function C2S:PLAYER_PROMOTE_FIGHT_START(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19013,msg:SerializeToString(),showLoading);
end

--晋封战斗考试结果
function C2S:PLAYER_PROMOTE_FIGHT_RESULT(vs_player_id_int32, result_int32, left_num_int32, total_num_int32,showLoading)
	if pb_19_pb_pbPromoteVsResult == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbPromoteVsResult = pb_19_pb.pbPromoteVsResult();
	end
	local msg = pb_19_pb_pbPromoteVsResult;
	msg.vs_player_id = vs_player_id_int32;
	msg.result = result_int32;
	msg.left_num = left_num_int32;
	msg.total_num = total_num_int32;
	mNetManager:SendData(19014,msg:SerializeToString(),showLoading);
end

--晋封战斗玩家返回
function C2S:PLAYER_PROMOTE_FIGHT_PLAYER(showLoading)
	mNetManager:SendData(19015,nil,showLoading);
end

--巅峰宫斗
function C2S:PLAYER_PROMOTE_ARENA(showLoading)
	mNetManager:SendData(19020,nil,showLoading);
end

--刷新列表
function C2S:PLAYER_PROMOTE_ARENA_REFRESH(showLoading)
	mNetManager:SendData(19021,nil,showLoading);
end

--购买次数
function C2S:PLAYER_PROMOTE_ARENA_BUY_TIMES(showLoading)
	mNetManager:SendData(19022,nil,showLoading);
end

--防守阵容
function C2S:PLAYER_PROMOTE_ARENA_DEFENSE_POS(showLoading)
	mNetManager:SendData(19023,nil,showLoading);
end

--保存防守阵容
function C2S:PLAYER_PROMOTE_ARENA_DEFENSE_SAVE(partner_pos_list_pbPartnerPosList,showLoading)
	if pb_19_pb_pbDefensePos == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbDefensePos = pb_19_pb.pbDefensePos();
	end
	local msg = pb_19_pb_pbDefensePos;
	if partner_pos_list_pbPartnerPosList ~= nil then
		local msg_partner_pos_list = msg.partner_pos_list
		local count = #msg_partner_pos_list;
		while count >0 do
			mtable.remove(msg_partner_pos_list,count);
			count = count - 1;
		end
		local pbPartnerPosList = pb_19_pb.pbPartnerPosList;
		for k,v in mipairs(partner_pos_list_pbPartnerPosList) do
			local partner_pos_list = pbPartnerPosList();
			partner_pos_list.team=v.team;
			partner_pos_list.partner_id=v.partner_id;
			partner_pos_list.pos=v.pos;
			mtable.insert(msg_partner_pos_list,partner_pos_list);
		end
	end
	mNetManager:SendData(19024,msg:SerializeToString(),showLoading);
end

--准备挑战
function C2S:PLAYER_PROMOTE_ARENA_PREPARE(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19025,msg:SerializeToString(),showLoading);
end

--挑战结果
function C2S:PLAYER_PROMOTE_ARENA_RESULT(vs_player_id_int32, result_int32, win_int32, lose_int32,showLoading)
	if pb_19_pb_pbVsResult == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsResult = pb_19_pb.pbVsResult();
	end
	local msg = pb_19_pb_pbVsResult;
	msg.vs_player_id = vs_player_id_int32;
	msg.result = result_int32;
	msg.win = win_int32;
	msg.lose = lose_int32;
	mNetManager:SendData(19026,msg:SerializeToString(),showLoading);
end

--仇人列表
function C2S:PLAYER_PROMOTE_ARENA_ENEMY_LIST(showLoading)
	mNetManager:SendData(19027,nil,showLoading);
end

--准备复仇挑战
function C2S:PLAYER_PROMOTE_ARENA_ENEMY_PREPARE(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19028,msg:SerializeToString(),showLoading);
end

--复仇挑战结果
function C2S:PLAYER_PROMOTE_ARENA_ENEMY_RESULT(vs_player_id_int32, result_int32, win_int32, lose_int32,showLoading)
	if pb_19_pb_pbVsResult == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsResult = pb_19_pb.pbVsResult();
	end
	local msg = pb_19_pb_pbVsResult;
	msg.vs_player_id = vs_player_id_int32;
	msg.result = result_int32;
	msg.win = win_int32;
	msg.lose = lose_int32;
	mNetManager:SendData(19029,msg:SerializeToString(),showLoading);
end

--开始挑战
function C2S:PLAYER_PROMOTE_ARENA_FIGHT(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19030,msg:SerializeToString(),showLoading);
end

--复仇挑战
function C2S:PLAYER_PROMOTE_ARENA_ENEMY_FIGHT(player_id_int32,showLoading)
	if pb_19_pb_pbVsPlayer == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbVsPlayer = pb_19_pb.pbVsPlayer();
	end
	local msg = pb_19_pb_pbVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(19031,msg:SerializeToString(),showLoading);
end

--巅峰宫斗排行榜
function C2S:PLAYER_PROMOTE_ARENA_RANK(page_int32,showLoading)
	if pb_19_pb_pbRankPram == nil then
		if pb_19_pb == nil then
			pb_19_pb = require('Protol.pb_19_pb');
		end
		pb_19_pb_pbRankPram = pb_19_pb.pbRankPram();
	end
	local msg = pb_19_pb_pbRankPram;
	msg.page = page_int32;
	mNetManager:SendData(19032,msg:SerializeToString(),showLoading);
end

--请求召唤
function C2S:DRAFT_REQUEST(type_int32,showLoading)
	if pb_20_pb_pbDraftType == nil then
		if pb_20_pb == nil then
			pb_20_pb = require('Protol.pb_20_pb');
		end
		pb_20_pb_pbDraftType = pb_20_pb.pbDraftType();
	end
	local msg = pb_20_pb_pbDraftType;
	msg.type = type_int32;
	mNetManager:SendData(20000,msg:SerializeToString(),showLoading);
end

--碎片召唤
function C2S:DRAFT_WITH_CHIP(id_int32,showLoading)
	if pb_20_pb_pbDraftChip == nil then
		if pb_20_pb == nil then
			pb_20_pb = require('Protol.pb_20_pb');
		end
		pb_20_pb_pbDraftChip = pb_20_pb.pbDraftChip();
	end
	local msg = pb_20_pb_pbDraftChip;
	msg.id = id_int32;
	mNetManager:SendData(20001,msg:SerializeToString(),showLoading);
end

--请求特殊召唤列表
function C2S:DRAFT_GROUP_LIST(showLoading)
	mNetManager:SendData(20002,nil,showLoading);
end

--请求图鉴列表
function C2S:DRAFT_SHOW_LIST(showLoading)
	mNetManager:SendData(20003,nil,showLoading);
end

--排行榜
function C2S:PLAYER_RANK(type_int32, page_int32, num_int32,showLoading)
	if pb_21_pb_pbRank == nil then
		if pb_21_pb == nil then
			pb_21_pb = require('Protol.pb_21_pb');
		end
		pb_21_pb_pbRank = pb_21_pb.pbRank();
	end
	local msg = pb_21_pb_pbRank;
	msg.type = type_int32;
	msg.page = page_int32;
	msg.num = num_int32;
	mNetManager:SendData(21000,msg:SerializeToString(),showLoading);
end

--竞技场
function C2S:PLAYER_ARENA(showLoading)
	mNetManager:SendData(22000,nil,showLoading);
end

--竞技场刷新列表
function C2S:PLAYER_ARENA_REFRESH(showLoading)
	mNetManager:SendData(22001,nil,showLoading);
end

--竞技场防守阵容
function C2S:PLAYER_ARENA_DEFENSE_POS(showLoading)
	mNetManager:SendData(22002,nil,showLoading);
end

--竞技场保存防守阵容
function C2S:PLAYER_ARENA_DEFENSE_POS_SAVE(partner_pos_list_pbArenaPartnerPosList,showLoading)
	if pb_22_pb_pbArenaDefensePos == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaDefensePos = pb_22_pb.pbArenaDefensePos();
	end
	local msg = pb_22_pb_pbArenaDefensePos;
	if partner_pos_list_pbArenaPartnerPosList ~= nil then
		local msg_partner_pos_list = msg.partner_pos_list
		local count = #msg_partner_pos_list;
		while count >0 do
			mtable.remove(msg_partner_pos_list,count);
			count = count - 1;
		end
		local pbArenaPartnerPosList = pb_22_pb.pbArenaPartnerPosList;
		for k,v in mipairs(partner_pos_list_pbArenaPartnerPosList) do
			local partner_pos_list = pbArenaPartnerPosList();
			partner_pos_list.team=v.team;
			partner_pos_list.partner_id=v.partner_id;
			partner_pos_list.pos=v.pos;
			mtable.insert(msg_partner_pos_list,partner_pos_list);
		end
	end
	mNetManager:SendData(22003,msg:SerializeToString(),showLoading);
end

--竞技场挑战准备
function C2S:PLAYER_ARENA_PREPARE_FIGHT(player_id_int32,showLoading)
	if pb_22_pb_pbArenaVsPlayer == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsPlayer = pb_22_pb.pbArenaVsPlayer();
	end
	local msg = pb_22_pb_pbArenaVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(22004,msg:SerializeToString(),showLoading);
end

--竞技场挑战
function C2S:PLAYER_ARENA_FIGHT(player_id_int32,showLoading)
	if pb_22_pb_pbArenaVsPlayer == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsPlayer = pb_22_pb.pbArenaVsPlayer();
	end
	local msg = pb_22_pb_pbArenaVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(22005,msg:SerializeToString(),showLoading);
end

--竞技场挑战结果
function C2S:PLAYER_ARENA_FIGHT_RESULT(vs_player_id_int32, result_int32, win_int32, lose_int32,showLoading)
	if pb_22_pb_pbArenaVsResult == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsResult = pb_22_pb.pbArenaVsResult();
	end
	local msg = pb_22_pb_pbArenaVsResult;
	msg.vs_player_id = vs_player_id_int32;
	msg.result = result_int32;
	msg.win = win_int32;
	msg.lose = lose_int32;
	mNetManager:SendData(22006,msg:SerializeToString(),showLoading);
end

--竞技场仇人列表
function C2S:PLAYER_ARENA_ENEMY(showLoading)
	mNetManager:SendData(22007,nil,showLoading);
end

--竞技场复仇挑战准备
function C2S:PLAYER_ARENA_PREPARE_FIGHT_ENEMY(player_id_int32,showLoading)
	if pb_22_pb_pbArenaVsPlayer == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsPlayer = pb_22_pb.pbArenaVsPlayer();
	end
	local msg = pb_22_pb_pbArenaVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(22008,msg:SerializeToString(),showLoading);
end

--竞技场复仇挑战
function C2S:PLAYER_ARENA_FIGHT_ENEMY(player_id_int32,showLoading)
	if pb_22_pb_pbArenaVsPlayer == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsPlayer = pb_22_pb.pbArenaVsPlayer();
	end
	local msg = pb_22_pb_pbArenaVsPlayer;
	msg.player_id = player_id_int32;
	mNetManager:SendData(22009,msg:SerializeToString(),showLoading);
end

--竞技场复仇挑战结果
function C2S:PLAYER_ARENA_FIGHT_RESULT_ENEMY(vs_player_id_int32, result_int32, win_int32, lose_int32,showLoading)
	if pb_22_pb_pbArenaVsResult == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaVsResult = pb_22_pb.pbArenaVsResult();
	end
	local msg = pb_22_pb_pbArenaVsResult;
	msg.vs_player_id = vs_player_id_int32;
	msg.result = result_int32;
	msg.win = win_int32;
	msg.lose = lose_int32;
	mNetManager:SendData(22010,msg:SerializeToString(),showLoading);
end

--竞技场排行榜
function C2S:PLAYER_ARENA_RANK(page_int32,showLoading)
	if pb_22_pb_pbArenaRankPram == nil then
		if pb_22_pb == nil then
			pb_22_pb = require('Protol.pb_22_pb');
		end
		pb_22_pb_pbArenaRankPram = pb_22_pb.pbArenaRankPram();
	end
	local msg = pb_22_pb_pbArenaRankPram;
	msg.page = page_int32;
	mNetManager:SendData(22011,msg:SerializeToString(),showLoading);
end

--获取商城列表
function C2S:SHOP_LIST(first_type_int32, second_type_int32,showLoading)
	if pb_23_pb_pbShopGetList == nil then
		if pb_23_pb == nil then
			pb_23_pb = require('Protol.pb_23_pb');
		end
		pb_23_pb_pbShopGetList = pb_23_pb.pbShopGetList();
	end
	local msg = pb_23_pb_pbShopGetList;
	msg.first_type = first_type_int32;
	msg.second_type = second_type_int32;
	mNetManager:SendData(23000,msg:SerializeToString(),showLoading);
end

--购买道具
function C2S:SHOP_BUY(first_type_int32, second_type_int32, id_int32, count_int32,showLoading)
	if pb_23_pb_pbShopBuy == nil then
		if pb_23_pb == nil then
			pb_23_pb = require('Protol.pb_23_pb');
		end
		pb_23_pb_pbShopBuy = pb_23_pb.pbShopBuy();
	end
	local msg = pb_23_pb_pbShopBuy;
	msg.first_type = first_type_int32;
	msg.second_type = second_type_int32;
	msg.id = id_int32;
	msg.count = count_int32;
	mNetManager:SendData(23001,msg:SerializeToString(),showLoading);
end

--更新道具
function C2S:SHOP_UPDATE(showLoading)
	mNetManager:SendData(23002,nil,showLoading);
end

--获取觐见剧情
function C2S:MONRACH_AUDIENCE_GET(showLoading)
	mNetManager:SendData(24000,nil,showLoading);
end

--更新觐见剧情
function C2S:MONRACH_AUDIENCE_UPDATE(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(24001,msg:SerializeToString(),showLoading);
end

--觐见结束获得奖励
function C2S:MONRACH_AUDIENCE_RESULT(showLoading)
	mNetManager:SendData(24002,nil,showLoading);
end

--获取邀宠或承恩技能列表
function C2S:MONRACH_GET_SKILL_LIST(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(24003,msg:SerializeToString(),showLoading);
end

--开始邀宠或承恩
function C2S:MONRACH_START(type_int32, skill_id_int32,showLoading)
	if pb_24_pb_pbMonarchRun == nil then
		if pb_24_pb == nil then
			pb_24_pb = require('Protol.pb_24_pb');
		end
		pb_24_pb_pbMonarchRun = pb_24_pb.pbMonarchRun();
	end
	local msg = pb_24_pb_pbMonarchRun;
	msg.type = type_int32;
	msg.skill_id = skill_id_int32;
	mNetManager:SendData(24004,msg:SerializeToString(),showLoading);
end

--获取任务列表
function C2S:TASK_LIST(showLoading)
	mNetManager:SendData(25000,nil,showLoading);
end

--更新任务
function C2S:TASK_UPDATE(showLoading)
	mNetManager:SendData(25001,nil,showLoading);
end

--删除任务
function C2S:TASK_DEL(showLoading)
	mNetManager:SendData(25002,nil,showLoading);
end

--领取任务奖励
function C2S:TASK_GET_REWARD(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(25003,msg:SerializeToString(),showLoading);
end

--府邸信息
function C2S:MANSION_INFO(showLoading)
	mNetManager:SendData(26000,nil,showLoading);
end

--府邸改名
function C2S:MANSION_CHNAGE_NAME(id_string,showLoading)
	if pb_common_pb_pbString == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbString = pb_common_pb.pbString();
	end
	local msg = pb_common_pb_pbString;
	msg.id = id_string;
	mNetManager:SendData(26001,msg:SerializeToString(),showLoading);
end

--府邸串门
function C2S:MANSION_VISIT_LIST(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26002,msg:SerializeToString(),showLoading);
end

--府邸事件
function C2S:MANSION_EVENTS(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26003,msg:SerializeToString(),showLoading);
end

--府邸串门进行
function C2S:MANSION_VISIT_START(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26004,msg:SerializeToString(),showLoading);
end

--府邸仆人列表
function C2S:MANSION_SERVANT_LIST(showLoading)
	mNetManager:SendData(26005,nil,showLoading);
end

--府邸仆人改名
function C2S:MANSION_SERVANT_CHANGE_NAME(id_int32, name_string,showLoading)
	if pb_26_pb_pbMansionServantChangeName == nil then
		if pb_26_pb == nil then
			pb_26_pb = require('Protol.pb_26_pb');
		end
		pb_26_pb_pbMansionServantChangeName = pb_26_pb.pbMansionServantChangeName();
	end
	local msg = pb_26_pb_pbMansionServantChangeName;
	msg.id = id_int32;
	msg.name = name_string;
	mNetManager:SendData(26006,msg:SerializeToString(),showLoading);
end

--府邸仆人打赏
function C2S:MANSION_SERVANT_REWARD(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26007,msg:SerializeToString(),showLoading);
end

--府邸仆人发放通宝
function C2S:MANSION_SERVANT_REWARD_HOUSE_COIN(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26008,msg:SerializeToString(),showLoading);
end

--府邸仆人雇佣
function C2S:MANSION_SERVANT_CALL(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26009,msg:SerializeToString(),showLoading);
end

--府邸仆人信息更新
function C2S:MANSION_SERVANT_UPDATE(showLoading)
	mNetManager:SendData(26010,nil,showLoading);
end

--府邸仆人清洁度
function C2S:MANSION_SERVANT_CLEANUP(showLoading)
	mNetManager:SendData(26011,nil,showLoading);
end

--府邸信息更新
function C2S:MANSION_UPDATE_INFO(showLoading)
	mNetManager:SendData(26012,nil,showLoading);
end

--府邸开垦土地
function C2S:MANSION_OPEN_LAND(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26013,msg:SerializeToString(),showLoading);
end

--府邸种子操作
function C2S:MANSION_SEED_OPERATION(type_int32, land_id_int32, item_id_int32, target_id_int32,showLoading)
	if pb_26_pb_pbMansionPlanting == nil then
		if pb_26_pb == nil then
			pb_26_pb = require('Protol.pb_26_pb');
		end
		pb_26_pb_pbMansionPlanting = pb_26_pb.pbMansionPlanting();
	end
	local msg = pb_26_pb_pbMansionPlanting;
	msg.type = type_int32;
	msg.land_id = land_id_int32;
	msg.item_id = item_id_int32;
	msg.target_id = target_id_int32;
	mNetManager:SendData(26014,msg:SerializeToString(),showLoading);
end

--府邸请求种子种植顺序
function C2S:MANSION_SEED_ORDER_REQUEST(showLoading)
	mNetManager:SendData(26015,nil,showLoading);
end

--府邸更新种子种植顺序
function C2S:MANSION_SEED_ORDER_UPDATE(list_pbMansionPlantPlan,showLoading)
	if pb_26_pb_pbMansionPlantPlanlist == nil then
		if pb_26_pb == nil then
			pb_26_pb = require('Protol.pb_26_pb');
		end
		pb_26_pb_pbMansionPlantPlanlist = pb_26_pb.pbMansionPlantPlanlist();
	end
	local msg = pb_26_pb_pbMansionPlantPlanlist;
	if list_pbMansionPlantPlan ~= nil then
		local msg_list = msg.list
		local count = #msg_list;
		while count >0 do
			mtable.remove(msg_list,count);
			count = count - 1;
		end
		local pbMansionPlantPlan = pb_26_pb.pbMansionPlantPlan;
		for k,v in mipairs(list_pbMansionPlantPlan) do
			local list = pbMansionPlantPlan();
			list.id=v.id;
			list.item_id=v.item_id;
			list.item_count=v.item_count;
			mtable.insert(msg_list,list);
		end
	end
	mNetManager:SendData(26016,msg:SerializeToString(),showLoading);
end

--府邸更新npc事件
function C2S:MANSION_NPC_EVENT_UPDATE(showLoading)
	mNetManager:SendData(26017,nil,showLoading);
end

--府邸npc事件领取奖励
function C2S:MANSION_NPC_EVENT_REWARD(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26018,msg:SerializeToString(),showLoading);
end

--府邸npc事件删除
function C2S:MANSION_NPC_EVENT_DEL(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26019,msg:SerializeToString(),showLoading);
end

--府邸离线获得信息
function C2S:MANSION_OFFLINE_GET_INFO(showLoading)
	mNetManager:SendData(26020,nil,showLoading);
end

--府邸关闭
function C2S:MANSION_CLOSE(showLoading)
	mNetManager:SendData(26021,nil,showLoading);
end

--府邸打开宴会界面
function C2S:MANSION_FEAST_OPEN_WINDOWS(showLoading)
	mNetManager:SendData(26030,nil,showLoading);
end

--府邸开启宴会
function C2S:MANSION_FEAST_OPEN(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26031,msg:SerializeToString(),showLoading);
end

--府邸获取宴会列表
function C2S:MANSION_FESAT_LIST(showLoading)
	mNetManager:SendData(26032,nil,showLoading);
end

--府邸赴宴
function C2S:MANSION_FEAST_ADD(main_id_int32, gift_id_int32,showLoading)
	if pb_26_pb_pbMansionFeastAdd == nil then
		if pb_26_pb == nil then
			pb_26_pb = require('Protol.pb_26_pb');
		end
		pb_26_pb_pbMansionFeastAdd = pb_26_pb.pbMansionFeastAdd();
	end
	local msg = pb_26_pb_pbMansionFeastAdd;
	msg.main_id = main_id_int32;
	msg.gift_id = gift_id_int32;
	mNetManager:SendData(26033,msg:SerializeToString(),showLoading);
end

--府邸宴会详细信息
function C2S:MANSION_FEAST_DETAIL(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(26034,msg:SerializeToString(),showLoading);
end

--府邸宴会邀请
function C2S:MANSION_FEAST_INVITE(showLoading)
	mNetManager:SendData(26035,nil,showLoading);
end

--府邸背包列表
function C2S:MANSION_ITEM_LIST(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(27000,msg:SerializeToString(),showLoading);
end

--府邸背包更新
function C2S:MANSION_ITEM_UPDATE(showLoading)
	mNetManager:SendData(27001,nil,showLoading);
end

--府邸背包出售
function C2S:MANSION_ITEM_SELL(type_int32, id_int32, count_int32,showLoading)
	if pb_27_pb_pbItemSell == nil then
		if pb_27_pb == nil then
			pb_27_pb = require('Protol.pb_27_pb');
		end
		pb_27_pb_pbItemSell = pb_27_pb.pbItemSell();
	end
	local msg = pb_27_pb_pbItemSell;
	msg.type = type_int32;
	msg.id = id_int32;
	msg.count = count_int32;
	mNetManager:SendData(27002,msg:SerializeToString(),showLoading);
end

--府邸背包材料合成
function C2S:MANSION_ITEM_COMPOSITION(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(27003,msg:SerializeToString(),showLoading);
end

--请求精英副本信息
function C2S:ELITE_DUNGEON_LIST(showLoading)
	mNetManager:SendData(28000,nil,showLoading);
end

--请求挑战精英副本
function C2S:ELITE_DUNGEON_BATTLE(dungeon_id_int32,showLoading)
	if pb_28_pb_pbEliteDungeonBattle == nil then
		if pb_28_pb == nil then
			pb_28_pb = require('Protol.pb_28_pb');
		end
		pb_28_pb_pbEliteDungeonBattle = pb_28_pb.pbEliteDungeonBattle();
	end
	local msg = pb_28_pb_pbEliteDungeonBattle;
	msg.dungeon_id = dungeon_id_int32;
	mNetManager:SendData(28001,msg:SerializeToString(),showLoading);
end

--挑战精英副本结果
function C2S:ELITE_DUNGEON_BATTLE_RESULT(dungeon_id_int32, result_int32, reward_pbEliteDungeonReward,showLoading)
	if pb_28_pb_pbEliteDungeonOver == nil then
		if pb_28_pb == nil then
			pb_28_pb = require('Protol.pb_28_pb');
		end
		pb_28_pb_pbEliteDungeonOver = pb_28_pb.pbEliteDungeonOver();
	end
	local msg = pb_28_pb_pbEliteDungeonOver;
	msg.dungeon_id = dungeon_id_int32;
	msg.result = result_int32;
	if reward_pbEliteDungeonReward ~= nil then
		local msg_reward = msg.reward
		local count = #msg_reward;
		while count >0 do
			mtable.remove(msg_reward,count);
			count = count - 1;
		end
		local pbEliteDungeonReward = pb_28_pb.pbEliteDungeonReward;
		for k,v in mipairs(reward_pbEliteDungeonReward) do
			local reward = pbEliteDungeonReward();
			reward.goods_id=v.goods_id;
			reward.goods_num=v.goods_num;
			mtable.insert(msg_reward,reward);
		end
	end
	mNetManager:SendData(28002,msg:SerializeToString(),showLoading);
end

--精英副本复活再战
function C2S:ELITE_DUNGEON_REBORN(dungeon_id_int32,showLoading)
	if pb_28_pb_pbEliteDungeonBattle == nil then
		if pb_28_pb == nil then
			pb_28_pb = require('Protol.pb_28_pb');
		end
		pb_28_pb_pbEliteDungeonBattle = pb_28_pb.pbEliteDungeonBattle();
	end
	local msg = pb_28_pb_pbEliteDungeonBattle;
	msg.dungeon_id = dungeon_id_int32;
	mNetManager:SendData(28003,msg:SerializeToString(),showLoading);
end

--获取完成引导的id信息
function C2S:GUIDE_INFO(showLoading)
	mNetManager:SendData(29000,nil,showLoading);
end

--通知完成引导
function C2S:GUIDE_NOTICE(id_int32, step_int32,showLoading)
	if pb_29_pb_pbGuide == nil then
		if pb_29_pb == nil then
			pb_29_pb = require('Protol.pb_29_pb');
		end
		pb_29_pb_pbGuide = pb_29_pb.pbGuide();
	end
	local msg = pb_29_pb_pbGuide;
	msg.id = id_int32;
	msg.step = step_int32;
	mNetManager:SendData(29001,msg:SerializeToString(),showLoading);
end

--时装列表
function C2S:PLAYER_FASHION_LIST(showLoading)
	mNetManager:SendData(30000,nil,showLoading);
end

--保存
function C2S:PLAYER_FASHION_SAVE(fashion_id_list_int32,showLoading)
	if pb_30_pb_pbWearFashionList == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbWearFashionList = pb_30_pb.pbWearFashionList();
	end
	local msg = pb_30_pb_pbWearFashionList;
	if fashion_id_list_int32 ~= nil then
		local msg_fashion_id_list = msg.fashion_id_list
		local count = #msg_fashion_id_list;
		while count >0 do
			mtable.remove(msg_fashion_id_list,count);
			count = count - 1;
		end
		for k,v in mipairs(fashion_id_list_int32) do
			mtable.insert(msg_fashion_id_list,v);
		end
	end
	mNetManager:SendData(30001,msg:SerializeToString(),showLoading);
end

--合成
function C2S:PLAYER_FASHION_COMBINE(id_int32,showLoading)
	if pb_30_pb_pbFashion == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashion = pb_30_pb.pbFashion();
	end
	local msg = pb_30_pb_pbFashion;
	msg.id = id_int32;
	mNetManager:SendData(30002,msg:SerializeToString(),showLoading);
end

--强化
function C2S:PLAYER_FASHION_STRENGTH(id_int32, use_good_id_int32,showLoading)
	if pb_30_pb_pbFashionStrength == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashionStrength = pb_30_pb.pbFashionStrength();
	end
	local msg = pb_30_pb_pbFashionStrength;
	msg.id = id_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(30003,msg:SerializeToString(),showLoading);
end

--进阶
function C2S:PLAYER_FASHION_PROMOTE(id_int32,showLoading)
	if pb_30_pb_pbFashion == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashion = pb_30_pb.pbFashion();
	end
	local msg = pb_30_pb_pbFashion;
	msg.id = id_int32;
	mNetManager:SendData(30004,msg:SerializeToString(),showLoading);
end

--升星
function C2S:PLAYER_FASHION_UPRGADE_STAR(id_int32,showLoading)
	if pb_30_pb_pbFashion == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashion = pb_30_pb.pbFashion();
	end
	local msg = pb_30_pb_pbFashion;
	msg.id = id_int32;
	mNetManager:SendData(30005,msg:SerializeToString(),showLoading);
end

--渲光
function C2S:PLAYER_FASHION_UPGRADE_COLOR(id_int32,showLoading)
	if pb_30_pb_pbFashion == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashion = pb_30_pb.pbFashion();
	end
	local msg = pb_30_pb_pbFashion;
	msg.id = id_int32;
	mNetManager:SendData(30006,msg:SerializeToString(),showLoading);
end

--一键穿戴
function C2S:PLAYER_FASHION_SAVE_ALL(id_int32,showLoading)
	if pb_30_pb_pbFashionSuit == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashionSuit = pb_30_pb.pbFashionSuit();
	end
	local msg = pb_30_pb_pbFashionSuit;
	msg.id = id_int32;
	mNetManager:SendData(30007,msg:SerializeToString(),showLoading);
end

--洗练
function C2S:PLAYER_FASHION_WASH(id_int32,showLoading)
	if pb_30_pb_pbFashion == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashion = pb_30_pb.pbFashion();
	end
	local msg = pb_30_pb_pbFashion;
	msg.id = id_int32;
	mNetManager:SendData(30008,msg:SerializeToString(),showLoading);
end

--洗练保存
function C2S:PLAYER_FASHION_WASH_SAVE(id_int32, act_int32,showLoading)
	if pb_30_pb_pbFashionSave == nil then
		if pb_30_pb == nil then
			pb_30_pb = require('Protol.pb_30_pb');
		end
		pb_30_pb_pbFashionSave = pb_30_pb.pbFashionSave();
	end
	local msg = pb_30_pb_pbFashionSave;
	msg.id = id_int32;
	msg.act = act_int32;
	mNetManager:SendData(30009,msg:SerializeToString(),showLoading);
end

--刷新的时装列表
function C2S:PLAYER_FASHION_REFRESH(showLoading)
	mNetManager:SendData(30010,nil,showLoading);
end

--获取祭拜先祖信息
function C2S:WORSHIP_ANCESTOR_INFO(showLoading)
	mNetManager:SendData(31000,nil,showLoading);
end

--请求祭拜先祖
function C2S:WORSHIP_ANCESTOR(showLoading)
	mNetManager:SendData(31001,nil,showLoading);
end

--太后请安
function C2S:QUEEN_WISH(showLoading)
	mNetManager:SendData(31002,nil,showLoading);
end

--太后献礼
function C2S:QUEEN_GIFT(showLoading)
	mNetManager:SendData(31003,nil,showLoading);
end

--太后请安/献礼次数
function C2S:QUEEN_INFO(showLoading)
	mNetManager:SendData(31004,nil,showLoading);
end

--才艺背包
function C2S:PLAYER_TALENT_LIST(showLoading)
	mNetManager:SendData(32000,nil,showLoading);
end

--才艺背包刷新
function C2S:PLAYER_TALENT_REFRSH(showLoading)
	mNetManager:SendData(32001,nil,showLoading);
end

--才艺出售
function C2S:PLAYER_TALENT_SELL(sell_list_pbTalentModel,showLoading)
	if pb_32_pb_pbTalentSell == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentSell = pb_32_pb.pbTalentSell();
	end
	local msg = pb_32_pb_pbTalentSell;
	if sell_list_pbTalentModel ~= nil then
		local msg_sell_list = msg.sell_list
		local count = #msg_sell_list;
		while count >0 do
			mtable.remove(msg_sell_list,count);
			count = count - 1;
		end
		local pbTalentModel = pb_32_pb.pbTalentModel;
		for k,v in mipairs(sell_list_pbTalentModel) do
			local sell_list = pbTalentModel();
			sell_list.id=v.id;
			sell_list.num=v.num;
			mtable.insert(msg_sell_list,sell_list);
		end
	end
	mNetManager:SendData(32002,msg:SerializeToString(),showLoading);
end

--才艺穿戴
function C2S:PLAYER_TALENT_WEAR(partner_id_int32, pos_int32, id_int32,showLoading)
	if pb_32_pb_pbTalentModelWear == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelWear = pb_32_pb.pbTalentModelWear();
	end
	local msg = pb_32_pb_pbTalentModelWear;
	msg.partner_id = partner_id_int32;
	msg.pos = pos_int32;
	msg.id = id_int32;
	mNetManager:SendData(32003,msg:SerializeToString(),showLoading);
end

--才艺卸下
function C2S:PLAYER_TALENT_REMOVE(partner_id_int32, pos_int32,showLoading)
	if pb_32_pb_pbTalentModelRemove == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelRemove = pb_32_pb.pbTalentModelRemove();
	end
	local msg = pb_32_pb_pbTalentModelRemove;
	msg.partner_id = partner_id_int32;
	msg.pos = pos_int32;
	mNetManager:SendData(32004,msg:SerializeToString(),showLoading);
end

--才艺强化
function C2S:PLAYER_TALENT_STRENGTH(partner_id_int32, id_int32, use_good_id_int32,showLoading)
	if pb_32_pb_pbTalentModelStrength == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelStrength = pb_32_pb.pbTalentModelStrength();
	end
	local msg = pb_32_pb_pbTalentModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(32005,msg:SerializeToString(),showLoading);
end

--才艺研习
function C2S:PLAYER_TALENT_UP(partner_id_int32, id_int32, seq_int32, use_good_id_int32,showLoading)
	if pb_32_pb_pbTalentModelUp == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelUp = pb_32_pb.pbTalentModelUp();
	end
	local msg = pb_32_pb_pbTalentModelUp;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.seq = seq_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(32006,msg:SerializeToString(),showLoading);
end

--才艺精研
function C2S:PLAYER_TALENT_WASH(partner_id_int32, id_int32, use_good_id_int32,showLoading)
	if pb_32_pb_pbTalentModelStrength == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelStrength = pb_32_pb.pbTalentModelStrength();
	end
	local msg = pb_32_pb_pbTalentModelStrength;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(32007,msg:SerializeToString(),showLoading);
end

--才艺精研保存
function C2S:PLAYER_TALENT_WASH_SAVE(partner_id_int32, id_int32, act_int32,showLoading)
	if pb_32_pb_pbTalentModelSave == nil then
		if pb_32_pb == nil then
			pb_32_pb = require('Protol.pb_32_pb');
		end
		pb_32_pb_pbTalentModelSave = pb_32_pb.pbTalentModelSave();
	end
	local msg = pb_32_pb_pbTalentModelSave;
	msg.partner_id = partner_id_int32;
	msg.id = id_int32;
	msg.act = act_int32;
	mNetManager:SendData(32008,msg:SerializeToString(),showLoading);
end

--子女列表
function C2S:PLAYER_CHILD_LIST(showLoading)
	mNetManager:SendData(33000,nil,showLoading);
end

--子女列表刷新
function C2S:PLAYER_CHILD_REFRESH(showLoading)
	mNetManager:SendData(33001,nil,showLoading);
end

--子女喂养
function C2S:PLAYER_CHILD_FEED(id_int32, use_good_id_int32,showLoading)
	if pb_33_pb_pbChildModelFeed == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildModelFeed = pb_33_pb.pbChildModelFeed();
	end
	local msg = pb_33_pb_pbChildModelFeed;
	msg.id = id_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(33002,msg:SerializeToString(),showLoading);
end

--子女进阶
function C2S:PLAYER_CHILD_UP(id_int32, use_good_id_int32,showLoading)
	if pb_33_pb_pbChildModelUp == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildModelUp = pb_33_pb.pbChildModelUp();
	end
	local msg = pb_33_pb_pbChildModelUp;
	msg.id = id_int32;
	msg.use_good_id = use_good_id_int32;
	mNetManager:SendData(33003,msg:SerializeToString(),showLoading);
end

--子女考核
function C2S:PLAYER_CHILD_TEST(id_int32,showLoading)
	if pb_33_pb_pbChildModel == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildModel = pb_33_pb.pbChildModel();
	end
	local msg = pb_33_pb_pbChildModel;
	msg.id = id_int32;
	mNetManager:SendData(33004,msg:SerializeToString(),showLoading);
end

--子女考核答题
function C2S:PLAYER_CHILD_TEST_ANSWER(answer_id_int32,showLoading)
	if pb_33_pb_pbChildAnswer == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildAnswer = pb_33_pb.pbChildAnswer();
	end
	local msg = pb_33_pb_pbChildAnswer;
	if answer_id_int32 ~= nil then
		local msg_answer_id = msg.answer_id
		local count = #msg_answer_id;
		while count >0 do
			mtable.remove(msg_answer_id,count);
			count = count - 1;
		end
		for k,v in mipairs(answer_id_int32) do
			mtable.insert(msg_answer_id,v);
		end
	end
	mNetManager:SendData(33005,msg:SerializeToString(),showLoading);
end

--子女委任/召回
function C2S:PLAYER_CHILD_USE(id_int32,showLoading)
	if pb_33_pb_pbChildModel == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildModel = pb_33_pb.pbChildModel();
	end
	local msg = pb_33_pb_pbChildModel;
	msg.id = id_int32;
	mNetManager:SendData(33006,msg:SerializeToString(),showLoading);
end

--子女上阵列表
function C2S:PLAYER_CHILD_POS_LIST(showLoading)
	mNetManager:SendData(33007,nil,showLoading);
end

--子女上阵下阵
function C2S:PLAYER_CHILD_POS(camp_int32, pos_int32, child_id_int32,showLoading)
	if pb_33_pb_pbChildPos == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbChildPos = pb_33_pb.pbChildPos();
	end
	local msg = pb_33_pb_pbChildPos;
	msg.camp = camp_int32;
	msg.pos = pos_int32;
	msg.child_id = child_id_int32;
	mNetManager:SendData(33008,msg:SerializeToString(),showLoading);
end

--子女事件列表
function C2S:PLAYER_CHILD_EVENT_LIST(showLoading)
	mNetManager:SendData(33009,nil,showLoading);
end

--子女事件奖励领取
function C2S:PLAYER_CHILD_EVENT_AWARD(showLoading)
	mNetManager:SendData(33010,nil,showLoading);
end

--子女任务列表
function C2S:PLAYER_CHILD_TASK_LIST(showLoading)
	mNetManager:SendData(33011,nil,showLoading);
end

--子女任务接取
function C2S:PLAYER_CHILD_TASK_ACCEPT(task_id_int32, child_id_int32,showLoading)
	if pb_33_pb_pbTaskAcceptModel == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbTaskAcceptModel = pb_33_pb.pbTaskAcceptModel();
	end
	local msg = pb_33_pb_pbTaskAcceptModel;
	msg.task_id = task_id_int32;
	if child_id_int32 ~= nil then
		local msg_child_id = msg.child_id
		local count = #msg_child_id;
		while count >0 do
			mtable.remove(msg_child_id,count);
			count = count - 1;
		end
		for k,v in mipairs(child_id_int32) do
			mtable.insert(msg_child_id,v);
		end
	end
	mNetManager:SendData(33012,msg:SerializeToString(),showLoading);
end

--子女任务奖励领取
function C2S:PLAYER_CHILD_TASK_AWARD(task_id_int32,showLoading)
	if pb_33_pb_pbTaskModel == nil then
		if pb_33_pb == nil then
			pb_33_pb = require('Protol.pb_33_pb');
		end
		pb_33_pb_pbTaskModel = pb_33_pb.pbTaskModel();
	end
	local msg = pb_33_pb_pbTaskModel;
	msg.task_id = task_id_int32;
	mNetManager:SendData(33013,msg:SerializeToString(),showLoading);
end

--获取神秘商店列表
function C2S:PLAYER_SHOPS_MYSTERY_LIST(showLoading)
	mNetManager:SendData(34001,nil,showLoading);
end

--购买神秘商店道具
function C2S:PLAYER_SHOPS_MYSTERY_BUY(id_int32,showLoading)
	if pb_common_pb_pbId32 == nil then
		if pb_common_pb == nil then
			pb_common_pb = require('Protol.pb_common_pb');
		end
		pb_common_pb_pbId32 = pb_common_pb.pbId32();
	end
	local msg = pb_common_pb_pbId32;
	msg.id = id_int32;
	mNetManager:SendData(34002,msg:SerializeToString(),showLoading);
end

--元宝刷新神秘商店
function C2S:PLAYER_SHOPS_MYSTERY_REFRESH(showLoading)
	mNetManager:SendData(34003,nil,showLoading);
end

--请求每日领取体力
function C2S:PLAYER_EVERY_DAY_SP_LIST(showLoading)
	mNetManager:SendData(35001,nil,showLoading);
end

--每日领取体力
function C2S:PLAYER_EVERY_DAY_SP_GET(showLoading)
	mNetManager:SendData(35002,nil,showLoading);
end

--定时回复体力，精力
function C2S:PLAYER_EVERYDAY_SP_ENERGY_TIME(showLoading)
	mNetManager:SendData(35003,nil,showLoading);
end

return C2S.LuaNew();