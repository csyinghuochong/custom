using Assets.Scripts.Com.Net.Protos.Proto;
using System; 
using UnityEngine; 
using PROTO; 
using pb_common; 
using System.IO;
using System.Collections.Generic; 
using Assets.Scripts.Com.Net; 
public class C2S 
{
	public static Dictionary<int, string> descList = new Dictionary<int, string>();
	static C2S()
	{
		descList[8001] = "购买钻石";
		descList[8002] = "领取首充奖励";
		descList[9001] = "错误提示代号";
		descList[9002] = "人物属性更新";
		descList[9003] = "更新人物属性新手状态";
		descList[9004] = "查看其他玩家信息";
		descList[9005] = "获取当前已领取过的VIP奖励";
		descList[9006] = "领取VIP奖励";
		descList[9007] = "更改昵称";
		descList[9008] = "更改头像";
		descList[9009] = "游戏设置";
		descList[9010] = "购买体力";
		descList[9011] = "修改昵称cd";
		descList[9012] = "资源回复倒计时";
		descList[9013] = "请求设置列表";
		descList[9014] = "购买金币";
		descList[9015] = "请求竞技币/联盟币资源信息";
		descList[9016] = "购买英雄技能点";
		descList[9017] = "购买神器战神谷";
		descList[9018] = "获取对方出战列表";
		descList[9019] = "获取玩法次数";
		descList[9020] = "获取已领取的玩法开放奖励列表";
		descList[9021] = "领取的玩法开放奖励";
		descList[9022] = "防沉迷通知";
		descList[9023] = "设置防沉迷";
		descList[9024] = "激活码领取奖励";
		descList[9025] = "通知前端钻石改变";
		descList[10000] = "登录和创角";
		descList[10001] = "心跳包";
		descList[10002] = "告诉前端登陆成功";
		descList[10003] = "初始化初始值和增量";
		descList[10004] = "新进程开启需要到登陆界面";
		descList[10005] = "N点服务器时间刷新了需要重新取界面数据";
		descList[11001] = "聊天信息";
		descList[11002] = "聊天剩余次数";
		descList[11003] = "增加屏蔽玩家发言";
		descList[11004] = "取消屏蔽玩家发言";
		descList[11005] = "请求屏蔽玩家列表";
		descList[11006] = "搜索聊天";
		descList[11007] = "广播信息";
		descList[11008] = "登陆显示聊天信息";
		descList[11009] = "系统后台广播的消息";
		descList[11010] = "查看私聊";
		descList[12001] = "进入地图场景";
		descList[12002] = "场景中移动";
		descList[12003] = "更新场景中其他角色的数据";
		descList[12004] = "离开场景";
		descList[12005] = "进入场景";
		descList[12006] = "进入主城";
		descList[12007] = "场景中召唤师属性更新";
		descList[13001] = "开始匹配镜像";
		descList[13003] = "选英雄";
		descList[13006] = "进入乱斗场景";
		descList[13008] = "退出乱斗场景";
		descList[13010] = "选择的英雄列表";
		descList[13011] = "胜利结算";
		descList[13012] = "单双路解锁宝箱";
		descList[13013] = "单双路宝箱奖励";
		descList[13014] = "单双路新增宝箱";
		descList[13015] = "单双路奖励信息";
		descList[14001] = "好友陌生人列表";
		descList[14002] = "按昵称添加好友黑名单";
		descList[14003] = "按id添加好友黑名单";
		descList[14004] = "删除好友黑名单";
		descList[14005] = "通知列表";
		descList[14006] = "通知操作";
		descList[14007] = "更新添加一个好友";
		descList[14008] = "更新添加一个黑名单";
		descList[14009] = "更新一个通知";
		descList[14010] = "更新删除一个好友黑名单";
		descList[14011] = "更新好友上下线状态";
		descList[14012] = "好友拜访";
		descList[15001] = "背包信息";
		descList[15002] = "背包信息变更";
		descList[15003] = "背包扩充";
		descList[15004] = "出售物品";
		descList[15005] = "使用物品";
		descList[15006] = "碎片合成";
		descList[15007] = "物品使用";
		descList[15008] = "兑换物品";
		descList[15009] = "物品直接购买";
		descList[16001] = "获取印记列表";
		descList[16002] = "生产印记";
		descList[16003] = "出售印记";
		descList[16004] = "吞吃印记";
		descList[16005] = "替换印记和穿上印记";
		descList[16006] = "卸下印记";
		descList[16007] = "删除印记背包中的东西";
		descList[16008] = "添加印记背包中的东西";
		descList[16009] = "设置印记吞吃类型";
		descList[17001] = "打开竞技场";
		descList[17002] = "刷新竞技对手";
		descList[17003] = "购买竞技次数";
		descList[17004] = "查看挑战记录";
		descList[17005] = "挑战竞技对手";
		descList[17006] = "设置竞技阵型";
		descList[17007] = "领取历史排名奖励";
		descList[17008] = "竞技战斗通知";
		descList[17009] = "消除挑战cd";
		descList[17010] = "竞技复仇";
		descList[17011] = "战报红点更新";
		descList[17012] = "获取历史排名奖励";
		descList[18001] = "请求称号信息";
		descList[18002] = "使用称号";
		descList[18003] = "取消称号";
		descList[18004] = "显示称号";
		descList[18005] = "摘除称号";
		descList[18006] = "称号弹窗提示";
		descList[19002] = "读取邮件";
		descList[19003] = "删除邮件";
		descList[19004] = "提取附件";
		descList[19005] = "新增邮件";
		descList[19006] = "获取邮件列表";
		descList[19007] = "一键领取邮件";
		descList[20001] = "获取副本信息";
		descList[20002] = "进入副本";
		descList[20003] = "退出副本";
		descList[20004] = "领取宝箱";
		descList[20005] = "扫荡";
		descList[20006] = "复活某英雄";
		descList[20007] = "购买副本次数";
		descList[20008] = "领取小关卡奖励";
		descList[20009] = "开启新章节特效";
		descList[21001] = "获取排行版信息";
		descList[21002] = "获取排行版标签";
		descList[22001] = "登陆请求商城信息";
		descList[22002] = "购买物品";
		descList[22003] = "手动商城刷新";
		descList[22004] = "系统商城刷新";
		descList[22005] = "打开兑换商城";
		descList[22006] = "购买兑换商城物品";
		descList[22007] = "手动以及系统刷新接口";
		descList[22008] = "打开商城";
		descList[22009] = "获取折扣商城信息";
		descList[23001] = "点击获取攻防战自己的信息";
		descList[23002] = "请求匹配对手";
		descList[23003] = "邀请好友列表";
		descList[23004] = "回馈好友邀请";
		descList[23005] = "选择英雄出战";
		descList[23006] = "好友是否同意攻防战";
		descList[23007] = "战斗数据更新";
		descList[23008] = "战斗消息更新";
		descList[23009] = "魂值互换";
		descList[23010] = "战斗结束";
		descList[23011] = "请求匹配对手的返回";
		descList[23012] = "取消匹配和取消邀请好友";
		descList[23013] = "攻防战好友收到的信息";
		descList[23014] = "选择英雄时逃跑";
		descList[23015] = "好友段位积分状态性息";
		descList[23016] = "发起者同意或者拒绝";
		descList[24001] = "获取任务信息";
		descList[24002] = "接取任务";
		descList[24003] = "领取任务奖励";
		descList[24004] = "任务通知";
		descList[24005] = "任务信息改变";
		descList[24006] = "任务剧情播放通知";
		descList[25000] = "搜索获取所有联盟信息";
		descList[25001] = "获取所有联盟信息";
		descList[25002] = "获取当前联盟信息";
		descList[25003] = "获取当前联盟今日一览信息";
		descList[25004] = "获取当前联盟成员列表";
		descList[25005] = "获取当前联盟BOSS战信息";
		descList[25006] = "创建联盟";
		descList[25007] = "申请加入";
		descList[25008] = "同意申请加入";
		descList[25009] = "拒绝加入";
		descList[25010] = "审核列表";
		descList[25011] = "变更职位";
		descList[25012] = "退出联盟";
		descList[25013] = "踢出联盟";
		descList[25014] = "解散联盟";
		descList[25015] = "每次战斗伤害";
		descList[25016] = "修改宣言";
		descList[25017] = "成员招揽内容";
		descList[25018] = "等级限制设置";
		descList[25019] = "捐献";
		descList[25020] = "选择出战英雄";
		descList[25021] = "已出战英雄";
		descList[25022] = "获取当前出BOSS的血量";
		descList[25023] = "联盟红点提示";
		descList[26001] = "获取签到信息";
		descList[26002] = "签到领取";
		descList[26003] = "连续签到领取";
		descList[26004] = "领取总共几天的奖励";
		descList[26005] = "获取7天信息";
		descList[26006] = "领取7天奖励";
		descList[26007] = "获取另一个7天信息";
		descList[26008] = "领取另一个7天奖励";
		descList[27001] = "获取抽奖信息";
		descList[27002] = "抽奖";
		descList[27003] = "抽铸魂材料";
		descList[28001] = "获取完成引导的id信息";
		descList[28002] = "通知完成引导";
		descList[29001] = "活动操作";
		descList[29002] = "活动信息";
		descList[29003] = "活动请求段位";
		descList[29004] = "活动钻石信息";
		descList[29005] = "购买成长基金";
		descList[29006] = "请求成长基金信息";
		descList[29007] = "领取成长基金信息";
		descList[29008] = "开服7天活动信息";
		descList[29009] = "开服7天奖励领取";
		descList[29010] = "充值活动以领取列表";
		descList[29011] = "充值活动领取当天累计奖励";
		descList[29012] = "充值活动领取7天累计奖励";
		descList[30001] = "请求爬塔信息";
		descList[30003] = "请求己方英雄血量列表";
		descList[30005] = "开始战斗";
		descList[30006] = "战斗结果";
		descList[30007] = "开启宝箱";
		descList[30008] = "关闭宝箱界面";
		descList[30009] = "一键试炼";
		descList[30011] = "更新血量";
		descList[30012] = "购买试炼币";
		descList[30013] = "宝箱全开";
		descList[30014] = "关闭宝箱全开";
		descList[30015] = "请求宝箱全开信息";
		descList[31001] = "获取丛林信息";
		descList[31002] = "挑战丛林";
		descList[31003] = "扫荡丛林";
		descList[31004] = "投降丛林";
		descList[31005] = "丛林战斗结果";
		descList[31006] = "更新丛林伤害";
		descList[32001] = "请求护送信息";
		descList[32002] = "购买护送商船次数";
		descList[32003] = "商船战报列表";
		descList[32004] = "商船加速完成";
		descList[32005] = "购买抢夺商船次数";
		descList[32006] = "商船护送";
		descList[32007] = "开始自己掠夺商船";
		descList[32010] = "掠夺商船战斗结果";
		descList[32011] = "更新商船被拦截";
		descList[32012] = "单个商船信息";
		descList[32013] = "更新商船消失";
		descList[32014] = "更新商船增加";
		descList[32015] = "商船刷新品质";
		descList[32016] = "请求当前商船刷新品质";
		descList[32017] = "商船领取奖励";
		descList[32018] = "商船奖励通知";
		descList[32019] = "商船战报红点";
		descList[33001] = "送花";
		descList[33002] = "膜拜";
		descList[33003] = "领取昨日膜拜奖励";
		descList[33004] = "修改宣言";
		descList[33005] = "开启双倍经验奖励";
		descList[33006] = "取主城雕像信息";
		descList[33007] = "魅力发的私聊";
		descList[33008] = "广播被膜拜信息更新膜拜次数";
		descList[34001] = "宝藏信息";
		descList[34002] = "宝藏抽取";
		descList[35001] = "请求王者展示信息";
		descList[35002] = "请求自己爵位信息";
		descList[35003] = "定时请求领取时薪";
		descList[35004] = "查看段位爵位信息";
		descList[35005] = "查看挑战出战英雄";
		descList[35006] = "购买挑战次数";
		descList[35007] = "设置阵型";
		descList[35008] = "开始挑战";
		descList[35009] = "挑战结果";
		descList[35010] = "请求战报";
		descList[35011] = "请求所有段位信息";
		descList[35012] = "上线段位通知";
		descList[35013] = "爵位战报红点";
		descList[35014] = "购买爵位双倍薪资";
		descList[35015] = "薪资满红点通知";
		descList[36001] = "进入某个地狱获取当前组队信息";
		descList[36002] = "创建队伍";
		descList[36003] = "加入队伍";
		descList[36004] = "退出队伍";
		descList[36005] = "更换队伍英雄";
		descList[36006] = "广播邀请";
		descList[36007] = "开始战斗";
		descList[36008] = "战斗结果";
		descList[36009] = "踢出队伍";
		descList[36010] = "通过聊天加入队伍成功返回";
		descList[37001] = "进入pvp组队界面";
		descList[37002] = "邀请好友";
		descList[37003] = "邀请信息";
		descList[37004] = "邀请回复";
		descList[37005] = "队伍变化";
		descList[37006] = "开始pvp匹配";
		descList[37007] = "离开组队界面";
		descList[37008] = "取消匹配";
		descList[37009] = "选择英雄";
		descList[37010] = "确认英雄";
		descList[37011] = "pvp踢出队伍";
		descList[37012] = "加载广播";
		descList[37013] = "发起投降";
		descList[37014] = "队伍聊天";
		descList[37015] = "战斗结算";
		descList[37016] = "更换召唤师技能";
		descList[37017] = "pvp邀请回复返回";
		descList[37018] = "好友状态更新";
		descList[37019] = "投降选择";
		descList[37021] = "开始战斗";
		descList[37022] = "匹配操作";
		descList[37023] = "pvp心跳";
		descList[37024] = "pvp主机唤醒";
		descList[37025] = "pvp战斗广播房间";
		descList[37026] = "pvp战斗广播个人";
		descList[37027] = "pvp解散队伍";
		descList[37028] = "pvp延迟通知";
		descList[37029] = "pvp服务器ip";
		descList[37030] = "pvp切换主机通知";
		descList[37031] = "pvp登陆选人界面";
		descList[37032] = "pvp查看好友排行";
		descList[37033] = "pvp改变邀请状态";
		descList[37034] = "pvp解锁宝箱";
		descList[37035] = "pvp开启宝箱";
		descList[37036] = "pvp新增宝箱";
		descList[37037] = "pvp对战主界面信息";
		descList[37038] = "pvp进入匹配界面广播";
		descList[37039] = "pvp赛季奖励";
		descList[37040] = "pvp领取赛季奖励";
		descList[37041] = "pvp组队聊天";
		descList[37042] = "pvp陌生人列表";
		descList[37043] = "pvp红点通知";
		descList[38001] = "开房间创建房间";
		descList[38002] = "开房间邀请玩家";
		descList[38003] = "开房间邀请信息";
		descList[38004] = "开房间邀请回复";
		descList[38005] = "开房间队伍变化";
		descList[38006] = "开房间开始游戏";
		descList[38007] = "开房间离开组队界面";
		descList[38008] = "开房间取消游戏";
		descList[38009] = "开房间选择英雄";
		descList[38010] = "开房间确认英雄";
		descList[38011] = "开房间踢出队伍";
		descList[38012] = "开房间加载广播";
		descList[38013] = "开房间发起投降";
		descList[38014] = "开房间队伍聊天";
		descList[38015] = "开房间战斗结算";
		descList[38016] = "开房间更换召唤师技能";
		descList[38017] = "开房间邀请回复邀请者";
		descList[38018] = "开房间好友状态更新";
		descList[38019] = "开房间投降选择";
		descList[38020] = "开房间添加电脑";
		descList[38021] = "开房间开始战斗";
		descList[38023] = "开房间pvp心跳";
		descList[38024] = "开房间主机唤醒";
		descList[38025] = "开房间战斗广播房间";
		descList[38026] = "开房间战斗广播个人";
		descList[38027] = "开房间队伍解散";
		descList[38028] = "开房间延迟通知";
		descList[38029] = "开房间服务器ip";
		descList[38030] = "开房间切换主机通知";
		descList[38031] = "开房间登陆选人界面";
		descList[38032] = "开房间换位请求";
		descList[38033] = "开房间通知换位";
		descList[38034] = "开房间回复请求者";
		descList[38035] = "开房间回复返回";
		descList[38038] = "开房间进入匹配界面广播";
		descList[38042] = "开房间陌生人列表";
		descList[45001] = "获取免费赠送的伙伴信息";
		descList[45002] = "获取所有已拥有的英雄";
		descList[45003] = "设置英雄出战列表";
		descList[45004] = "激活某英雄";
		descList[45005] = "某英雄进阶";
		descList[45006] = "某装备合成";
		descList[45007] = "某英雄升星";
		descList[45008] = "更新或添加英雄";
		descList[45009] = "穿装备";
		descList[45010] = "英雄升级或加经验";
		descList[45011] = "英雄技能升级";
		descList[45012] = "召唤师技能升级";
		descList[45013] = "召唤师技能激活";
		descList[45014] = "英雄装备召唤师技能";
		descList[45015] = "英雄装备升级";
		descList[45016] = "英雄装备强化升阶";
		descList[45017] = "英雄装备铸魂升星";
		descList[45018] = "英雄激活和升级天赋";
		descList[45019] = "英雄技能一键升级";
		descList[45020] = "英雄契约添加星星";
	}

	//购买钻石
	public static void RMB_BUY(String order_id, String receipt, String charge, String pay_way,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPayToS data = new pbPayToS();
		data.order_id = order_id;
		data.receipt = receipt;
		data.charge = charge;
		data.pay_way = pay_way;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(8001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取首充奖励
	public static void FIRST_CHARGE(Int32 charge_state,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPayFirst data = new pbPayFirst();
		data.charge_state = charge_state;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(8002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//错误提示代号
	public static void ERROR_CODE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//人物属性更新
	public static void PLAYER_BASE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新人物属性新手状态
	public static void PLAYER_NEW_STATE(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9003,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//查看其他玩家信息
	public static void LOOK_OTHER_PLAYER_INFO(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前已领取过的VIP奖励
	public static void VIP_GET_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取VIP奖励
	public static void VIP_GET_AWARD(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更改昵称
	public static void CHANGE_NAME(String name,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbChangeName data = new pbChangeName();
		data.name = name;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更改头像
	public static void CHANGE_HEAD(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//游戏设置
	public static void SYS_GAME_SET(List<PROTO.pbSetting> list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGameSetting data = new pbGameSetting();
		data.list.AddRange(list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买体力
	public static void BUY_ENERGY(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//修改昵称cd
	public static void CHANGE_NAME_CD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9011,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//资源回复倒计时
	public static void RESOURCE_ENDTIME(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9012,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求设置列表
	public static void SETTING_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9013,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买金币
	public static void BUY_COIN(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9014,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求竞技币/联盟币资源信息
	public static void REQ_RES_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9015,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买英雄技能点
	public static void BUY_SKILL_POINT(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9016,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买神器战神谷
	public static void BUY_PLAYER_SKILL_POINT(Int32 id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMars data = new pbMars();
		data.id = id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9017,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取对方出战列表
	public static void GET_OTHER_BATTLE_LIST(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9018,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取玩法次数
	public static void GET_RED_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9019,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取已领取的玩法开放奖励列表
	public static void GET_BASE_OPEN_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9020,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取的玩法开放奖励
	public static void GET_BASE_OPEN_AWARD(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9021,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//防沉迷通知
	public static void FCM_CHAT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9022,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//设置防沉迷
	public static void FCM_SETTING(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9023,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//激活码领取奖励
	public static void GET_CODE_AWARD(String code,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbCode data = new pbCode();
		data.code = code;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(9024,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//通知前端钻石改变
	public static void CHANGE_GOLD_MSG(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(9025,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//登录和创角
	public static void LOGIN(Int64 acc_id, String acc_name, Int32 timestamp, Int32 server_id, String login_ticket, String suid, String platform, String token, String nickname, Int32 is_relogin, Int32 head, Int32 sex, String phone, Int32 fcm,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbAccount data = new pbAccount();
		data.acc_id = acc_id;
		data.acc_name = acc_name;
		data.timestamp = timestamp;
		data.server_id = server_id;
		data.login_ticket = login_ticket;
		data.suid = suid;
		data.platform = platform;
		data.token = token;
		data.nickname = nickname;
		data.is_relogin = is_relogin;
		data.head = head;
		data.sex = sex;
		data.phone = phone;
		data.fcm = fcm;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(10000,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//心跳包
	public static void KEEP_HEART(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(10001,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//告诉前端登陆成功
	public static void LOGIN_OK(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(10002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//初始化初始值和增量
	public static void CONNECT_INIT_OK(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(10003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//新进程开启需要到登陆界面
	public static void LOGIN_OK_SERVER(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(10004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//N点服务器时间刷新了需要重新取界面数据
	public static void REFLESH_SYS_TIME(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(10005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//聊天信息
	public static void CHAT_INFO(Int32 type, String msg, String nickname,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbChat data = new pbChat();
		data.type = type;
		data.msg = msg;
		data.nickname = nickname;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(11001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//聊天剩余次数
	public static void CHAT_TIMES(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//增加屏蔽玩家发言
	public static void CHAT_ADD_SHIELD(Int64 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbShield data = new pbShield();
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(11003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//取消屏蔽玩家发言
	public static void CHAT_DEL_SHIELD(Int64 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbShield data = new pbShield();
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(11004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求屏蔽玩家列表
	public static void CHAT_SHIELD_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//搜索聊天
	public static void CHAT_SEARCH(String name,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbSearch data = new pbSearch();
		data.name = name;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(11006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//广播信息
	public static void BROADCAST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//登陆显示聊天信息
	public static void CHAT_LOGIN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//系统后台广播的消息
	public static void SYS_BROADCAST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11009,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//查看私聊
	public static void CHAT_LEAVE_MESSAGE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(11010,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入地图场景
	public static void ENTER_SCENE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//场景中移动
	public static void SCENE_MOVE(Int32 x, Int32 y, Int32 z,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbScene data = new pbScene();
		data.x = x;
		data.y = y;
		data.z = z;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(12002,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新场景中其他角色的数据
	public static void UPDATA_SCENE_PLAYER(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//离开场景
	public static void LEAVE_SCENE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入场景
	public static void PLAYER_ENTER_SCENE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入主城
	public static void PLAYER_ENTER_CITY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//场景中召唤师属性更新
	public static void SCENE_PLAYER_UPDATE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(12007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始匹配镜像
	public static void MATCH_START(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13001,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选英雄
	public static void MATCH_SELECT_HERO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(13003,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入乱斗场景
	public static void MATCH_ENTER(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13006,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//退出乱斗场景
	public static void MATCH_LEAVE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(13008,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选择的英雄列表
	public static void MATCH_BATTLE_HERO(List<System.Int32> hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMatchHero data = new pbMatchHero();
		data.hero_id.AddRange(hero_id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13010,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//胜利结算
	public static void MATCH_BATTLE_OVER(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13011,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//单双路解锁宝箱
	public static void MATCH_UNLOCK_BOX(Int32 type, Int32 index,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMeleeBoxOp data = new pbMeleeBoxOp();
		data.type = type;
		data.index = index;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//单双路宝箱奖励
	public static void MATCH_BOX_REWARD(Int32 type, Int32 index,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMeleeBoxOp data = new pbMeleeBoxOp();
		data.type = type;
		data.index = index;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//单双路新增宝箱
	public static void MATCH_ADD_BOX(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(13014,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//单双路奖励信息
	public static void MATCH_REWARD_INFO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(13015,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//好友陌生人列表
	public static void FRIEND_LIST(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbFriendType data = new pbFriendType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//按昵称添加好友黑名单
	public static void ADD_FRIEND(Int32 type, String nickname,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbFriendAdd data = new pbFriendAdd();
		data.type = type;
		data.nickname = nickname;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//按id添加好友黑名单
	public static void FRIEND_ADD(Int32 type, Int64 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbAddFriend data = new pbAddFriend();
		data.type = type;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//删除好友黑名单
	public static void FRIEND_DELETE(Int32 type, Int64 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbFriendDelete data = new pbFriendDelete();
		data.type = type;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//通知列表
	public static void FRIEND_NOTE_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//通知操作
	public static void FRIEND_NOTE_OP(Int32 ack_code, Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbFriendOpNotice data = new pbFriendOpNotice();
		data.ack_code = ack_code;
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新添加一个好友
	public static void FRIEND_UPDATE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新添加一个黑名单
	public static void FRIEND_UPDATE_BLACK(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新一个通知
	public static void FRIEND_UPDATE_NOTE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14009,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新删除一个好友黑名单
	public static void FRIEND_UPDATE_DELETE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新好友上下线状态
	public static void FRIEND_STATE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(14011,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//好友拜访
	public static void FRIEND_LOOKFOR(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(14012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//背包信息
	public static void BAG_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(15001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//背包信息变更
	public static void BAG_CHANGED(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(15002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//背包扩充
	public static void BAG_ENLARGE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(15003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//出售物品
	public static void SELL_GOODS(Int32 index, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGoodsSell data = new pbGoodsSell();
		data.index = index;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//使用物品
	public static void GOODS_USE(Int32 index,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGoodsUse data = new pbGoodsUse();
		data.index = index;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//碎片合成
	public static void COMBINE_GOODS(Int32 index,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGoodsUse data = new pbGoodsUse();
		data.index = index;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//物品使用
	public static void USE_GOODS(Int32 goods_id, Int32 num, Int32 target,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUseGoods data = new pbUseGoods();
		data.goods_id = goods_id;
		data.num = num;
		data.target = target;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//兑换物品
	public static void USE_GOODS_TO_GOODS(Int32 goods_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGoodsToGoods data = new pbGoodsToGoods();
		data.goods_id = goods_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//物品直接购买
	public static void GOODS_DIRECT_BUY(Int32 goods_id, Int32 goods_num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGoodsBuy data = new pbGoodsBuy();
		data.goods_id = goods_id;
		data.goods_num = goods_num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(15009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取印记列表
	public static void MARKING_GET_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(16001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//生产印记
	public static void MARKING_DO_MARKING(Int32 num, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMarkDo data = new pbMarkDo();
		data.num = num;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//出售印记
	public static void MARKING_SELL_MARKING(Int32 id, Int32 pos, Int32 hero_id, List<System.Int32> ids, Int32 vip,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMarkIds data = new pbMarkIds();
		data.id = id;
		data.pos = pos;
		data.hero_id = hero_id;
		data.ids.AddRange(ids);
		data.vip = vip;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//吞吃印记
	public static void MARKING_SWALLOW_MARKING(Int32 id, Int32 pos, Int32 hero_id, List<System.Int32> ids, Int32 vip,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMarkIds data = new pbMarkIds();
		data.id = id;
		data.pos = pos;
		data.hero_id = hero_id;
		data.ids.AddRange(ids);
		data.vip = vip;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//替换印记和穿上印记
	public static void MARKING_WEAR_OR_REPLACE(Int32 id, Int32 pos, Int32 hero_id, List<System.Int32> ids, Int32 vip,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMarkIds data = new pbMarkIds();
		data.id = id;
		data.pos = pos;
		data.hero_id = hero_id;
		data.ids.AddRange(ids);
		data.vip = vip;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//卸下印记
	public static void MARKING_REMOVE(Int32 id, Int32 pos, Int32 hero_id, List<System.Int32> ids, Int32 vip,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMarkIds data = new pbMarkIds();
		data.id = id;
		data.pos = pos;
		data.hero_id = hero_id;
		data.ids.AddRange(ids);
		data.vip = vip;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//删除印记背包中的东西
	public static void MARKING_BAG_REMOVE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(16007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//添加印记背包中的东西
	public static void MARKING_BAG_ADD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(16008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//设置印记吞吃类型
	public static void MARKING_SETTING(List<System.Int32> id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32R data = new pbId32R();
		data.id.AddRange(id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(16009,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//打开竞技场
	public static void ARENA_OPEN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//刷新竞技对手
	public static void ARENA_REFRESH(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买竞技次数
	public static void ARENA_BUY_TIMES(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//查看挑战记录
	public static void ARENA_BATTLE_REP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//挑战竞技对手
	public static void ARENA_BATTLE(Int64 player_id, Int32 rank_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbArenaBattle data = new pbArenaBattle();
		data.player_id = player_id;
		data.rank_id = rank_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(17005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//设置竞技阵型
	public static void ARENA_SET_HERO(List<System.Int32> hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbArenaSetHero data = new pbArenaSetHero();
		data.hero_id.AddRange(hero_id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(17006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取历史排名奖励
	public static void ARENA_GET_BOX(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//竞技战斗通知
	public static void ARENA_BATTLE_OVER(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(17008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//消除挑战cd
	public static void ARENA_CLEAN_CD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17009,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//竞技复仇
	public static void ARENA_AGAIN(Int64 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId64 data = new pbId64();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(17010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战报红点更新
	public static void ARENA_RED_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17011,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取历史排名奖励
	public static void ARENA_HISTORY_REWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(17012,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求称号信息
	public static void TITLE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(18001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//使用称号
	public static void TITLE_USE(Int32 title_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTitleOp data = new pbTitleOp();
		data.title_id = title_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(18002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//取消称号
	public static void TITLE_CANCEL(Int32 title_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTitleOp data = new pbTitleOp();
		data.title_id = title_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(18003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//显示称号
	public static void TITLE_SHOW(Int32 title_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTitleOp data = new pbTitleOp();
		data.title_id = title_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(18004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//摘除称号
	public static void TITLE_DELETE(Int32 title_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTitleOp data = new pbTitleOp();
		data.title_id = title_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(18005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//称号弹窗提示
	public static void TITLE_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(18006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//读取邮件
	public static void MAIL_READ(Int32 mail_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMailOp data = new pbMailOp();
		data.mail_id = mail_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(19002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//删除邮件
	public static void MAIL_DELETE(Int32 mail_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMailOp data = new pbMailOp();
		data.mail_id = mail_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(19003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//提取附件
	public static void MAIL_ATTACHMENT(Int32 mail_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMailOp data = new pbMailOp();
		data.mail_id = mail_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(19004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//新增邮件
	public static void MAIL_ADD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(19005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取邮件列表
	public static void MAIL_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(19006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//一键领取邮件
	public static void MAIL_ALL_GET(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(19007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取副本信息
	public static void DUNGEON_GET_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(20001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入副本
	public static void DUNGEON_ENTER(Int32 dungeon_id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbEnterDungeon data = new pbEnterDungeon();
		data.dungeon_id = dungeon_id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//退出副本
	public static void DUNGEON_QUIT(Int32 dungeon_id, Int32 succ, List<System.Int32> star, Int32 starttime, List<System.Int32> heros,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbQuitDungeon data = new pbQuitDungeon();
		data.dungeon_id = dungeon_id;
		data.succ = succ;
		data.star.AddRange(star);
		data.starttime = starttime;
		data.heros.AddRange(heros);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取宝箱
	public static void DUNGEON_STAR_AWARD(Int32 chapter_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDungeonStarAward data = new pbDungeonStarAward();
		data.chapter_id = chapter_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//扫荡
	public static void DUNGEON_SWEEP(Int32 chapter_id, Int32 dungeon_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDungeonSweep data = new pbDungeonSweep();
		data.chapter_id = chapter_id;
		data.dungeon_id = dungeon_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//复活某英雄
	public static void DUNGEON_REVIVAL_HERO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买副本次数
	public static void DUNGEON_BUY(Int32 dungeon_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDungeonBuy data = new pbDungeonBuy();
		data.dungeon_id = dungeon_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取小关卡奖励
	public static void DUNGEON_GET_SMALL_AWARD(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开启新章节特效
	public static void DUNGEON_CHAPTER_OPEN(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(20009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取排行版信息
	public static void GET_RANKING_INFO(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(21001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取排行版标签
	public static void GET_RANKING_TITLE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(21002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//登陆请求商城信息
	public static void MALL_INFO(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallType data = new pbMallType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买物品
	public static void MALL_BUY(Int32 type, Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallBuy data = new pbMallBuy();
		data.type = type;
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//手动商城刷新
	public static void MALL_REFRESH_SELF(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallRefresh data = new pbMallRefresh();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//系统商城刷新
	public static void MALL_REFRESH_SYS(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(22004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//打开兑换商城
	public static void MALL_INFO_ANOTHER(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallType data = new pbMallType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买兑换商城物品
	public static void MALL_BUY_ANOTHER(Int32 type, Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallBuy data = new pbMallBuy();
		data.type = type;
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//手动以及系统刷新接口
	public static void MALL_ANOTHER_REFLESH(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallRefresh data = new pbMallRefresh();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//打开商城
	public static void MALL_OPEN_NOTICE(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallType data = new pbMallType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取折扣商城信息
	public static void MALL_DISCOUNT_INFO(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMallType data = new pbMallType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(22009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//点击获取攻防战自己的信息
	public static void DOUBLE_BATTLE_GET_SELF_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求匹配对手
	public static void DOUBLE_BATTLE_GET_ENEMY_INFO(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23002,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//邀请好友列表
	public static void DOUBLE_BATTLE_FRIENDS(List<System.Int32> player_id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleFriend data = new pbDoubleBattleFriend();
		data.player_id.AddRange(player_id);
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23003,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//回馈好友邀请
	public static void DOUBLE_BATTLE_GET_FRIENDS_REPLY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23004,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选择英雄出战
	public static void DOUBLE_BATTLE_CHOOSE_HEROS(Int32 type, Int32 attack_or_defense, List<System.Int32> id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleSelectHero data = new pbDoubleBattleSelectHero();
		data.type = type;
		data.attack_or_defense = attack_or_defense;
		data.id.AddRange(id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//好友是否同意攻防战
	public static void DOUBLE_BATTLE_FRIEND_AGREE(Int32 player_id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleFriendRequest data = new pbDoubleBattleFriendRequest();
		data.player_id = player_id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23006,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗数据更新
	public static void DOUBLE_BATTLE_MSG(Int32 soul, List<PROTO.pbDoubleBattleMsgInfo> msg,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleMsgs data = new pbDoubleBattleMsgs();
		data.soul = soul;
		data.msg.AddRange(msg);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23007,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗消息更新
	public static void DOUBLE_BATTLE_SPEIAL_MSG(Int32 type, String msg,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleSpecialMsg data = new pbDoubleBattleSpecialMsg();
		data.type = type;
		data.msg = msg;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23008,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//魂值互换
	public static void DOUBLE_BATTLE_SOUL_CHANGE(Int32 id, Int32 attack_soul, Int32 defend_soul,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleSoulChange data = new pbDoubleBattleSoulChange();
		data.id = id;
		data.attack_soul = attack_soul;
		data.defend_soul = defend_soul;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗结束
	public static void DOUBLE_BATTLE_END(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求匹配对手的返回
	public static void DOUBLE_BATTLE_GET_ENEMY_REPLY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23011,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//取消匹配和取消邀请好友
	public static void DOUBLE_BATTLE_CANCEL(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23012,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//攻防战好友收到的信息
	public static void DOUBLE_BATTLE_FRIEND_GET_MSG(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23013,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选择英雄时逃跑
	public static void DOUBLE_BATTLE_CHOOSE_ESCAPE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23014,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//好友段位积分状态性息
	public static void DOUBLE_BATTLE_FRIENDS_STATUS(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(23015,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//发起者同意或者拒绝
	public static void DOUBLE_BATTLE_FRIEND_SELF_AGREE(Int32 player_id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDoubleBattleFriendRequest data = new pbDoubleBattleFriendRequest();
		data.player_id = player_id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(23016,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取任务信息
	public static void TASK_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(24001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//接取任务
	public static void TASK_ACCEPT(Int32 id, Int32 task_type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTaskOp data = new pbTaskOp();
		data.id = id;
		data.task_type = task_type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(24002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取任务奖励
	public static void TASK_REWARD(Int32 id, Int32 task_type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTaskOp data = new pbTaskOp();
		data.id = id;
		data.task_type = task_type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(24003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//任务通知
	public static void TASK_NOTICE(Int32 id, Int32 state, Int32 times, Int32 plot_flag,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTask data = new pbTask();
		data.id = id;
		data.state = state;
		data.times = times;
		data.plot_flag = plot_flag;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(24004,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//任务信息改变
	public static void TASK_CHANGE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(24005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//任务剧情播放通知
	public static void TASK_PLOT_NOTICE(Int32 id, Int32 task_type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTaskOp data = new pbTaskOp();
		data.id = id;
		data.task_type = task_type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(24006,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//搜索获取所有联盟信息
	public static void UNION_SELECT(String name1, String name2, Int32 page,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionSelect data = new pbUnionSelect();
		data.name1 = name1;
		data.name2 = name2;
		data.page = page;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25000,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取所有联盟信息
	public static void UNION_ALL_INFO(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResult data = new pbUnionResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前联盟信息
	public static void UNION_SELF_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前联盟今日一览信息
	public static void UNION_EXP_INFO_MSG(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前联盟成员列表
	public static void UNION_MEMBER_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前联盟BOSS战信息
	public static void UNION_BOSS_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//创建联盟
	public static void UNION_CREATE(Int32 type, String name, String announcement,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionCreate data = new pbUnionCreate();
		data.type = type;
		data.name = name;
		data.announcement = announcement;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//申请加入
	public static void UNION_APPLY(List<System.Int32> result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResultList data = new pbUnionResultList();
		data.result.AddRange(result);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//同意申请加入
	public static void UNION_REQUEST(List<System.Int32> result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResultList data = new pbUnionResultList();
		data.result.AddRange(result);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//拒绝加入
	public static void UNION_REFUSE(List<System.Int32> result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResultList data = new pbUnionResultList();
		data.result.AddRange(result);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//审核列表
	public static void UNION_APPLY_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//变更职位
	public static void UNION_CHANGE(Int32 target_id, Int32 target_office,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionChange data = new pbUnionChange();
		data.target_id = target_id;
		data.target_office = target_office;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25011,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//退出联盟
	public static void UNION_QUIT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25012,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//踢出联盟
	public static void UNION_QUIT_OUT(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResult data = new pbUnionResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//解散联盟
	public static void UNION_DISMISS(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25014,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//每次战斗伤害
	public static void UNION_ATT_INFO(Int32 boss_id, Int32 value, List<System.Int32> heros,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionBossResult data = new pbUnionBossResult();
		data.boss_id = boss_id;
		data.value = value;
		data.heros.AddRange(heros);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25015,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//修改宣言
	public static void UNION_CHANGE_ANN(String result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionString data = new pbUnionString();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25016,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//成员招揽内容
	public static void UNION_ADD_MEMBER(Int32 type, String result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionChatString data = new pbUnionChatString();
		data.type = type;
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25017,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//等级限制设置
	public static void UNION_SET_LIMIT_LEVEL(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResult data = new pbUnionResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25018,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//捐献
	public static void UNION_ALMS(Int32 type, Int32 value,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionBuild data = new pbUnionBuild();
		data.type = type;
		data.value = value;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25019,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选择出战英雄
	public static void UNION_CHOOSE_HERO(List<PROTO.pbUnionResultHeroNew> result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResultHeroListNew data = new pbUnionResultHeroListNew();
		data.result.AddRange(result);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25020,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//已出战英雄
	public static void UNION_HAD_HERO_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25021,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取当前出BOSS的血量
	public static void UNION_GET_BOSS_HP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbUnionResult data = new pbUnionResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(25022,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//联盟红点提示
	public static void UNION_RED_HOT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(25023,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取签到信息
	public static void SIGN_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(26001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//签到领取
	public static void SIGN_GAT_AWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(26002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//连续签到领取
	public static void SIGN_ALWAYS_GET_AWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(26003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取总共几天的奖励
	public static void SIGN_ALL_DAY_AWARD(Int32 day,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbSignDay data = new pbSignDay();
		data.day = day;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(26004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取7天信息
	public static void SIGN_7_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(26005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取7天奖励
	public static void SIGN_7_GET_AWARD(Int32 day,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbSignDay data = new pbSignDay();
		data.day = day;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(26006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取另一个7天信息
	public static void SIGN_7_INFO_OTHER(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(26007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取另一个7天奖励
	public static void SIGN_7_GET_AWARD_OTHER(Int32 day,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbSignDay data = new pbSignDay();
		data.day = day;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(26008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取抽奖信息
	public static void DRAW_LOTTERY_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(27001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//抽奖
	public static void DRAW_LOTTERY(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDrawType data = new pbDrawType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(27002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//抽铸魂材料
	public static void DRAW_LOTTERY_EQUIP_STAR(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbDrawType data = new pbDrawType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(27003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取完成引导的id信息
	public static void GUIDE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(28001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//通知完成引导
	public static void GUIDE_NOTICE(Int32 id, Int32 step,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbGuide data = new pbGuide();
		data.id = id;
		data.step = step;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(28002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//活动操作
	public static void ACTIVE_OPREATE(Int32 type, Int32 arg,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbActiveOp data = new pbActiveOp();
		data.type = type;
		data.arg = arg;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(29001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//活动信息
	public static void ACTIVE_LOGIN_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//活动请求段位
	public static void ACTIVE_PHASE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//活动钻石信息
	public static void ACTIVE_GOLD_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买成长基金
	public static void ACTIVE_BUY_GROW_FUND(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求成长基金信息
	public static void ACTIVE_GROW_FUND_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取成长基金信息
	public static void ACTIVE_GET_GROW_FUND(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(29007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开服7天活动信息
	public static void ACTIVE_OPEN_SERV_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开服7天奖励领取
	public static void ACTIVE_OPEN_REWARD(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(29009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//充值活动以领取列表
	public static void ACTIVE_CHARGE_REWARD_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(29010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//充值活动领取当天累计奖励
	public static void ACTIVE_CHARGE_REWARD_TODAY(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(29011,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//充值活动领取7天累计奖励
	public static void ACTIVE_CHARGE_REWARD_7DAY(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(29012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求爬塔信息
	public static void TOWER_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求己方英雄血量列表
	public static void TOWER_SELE_HP_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始战斗
	public static void TOWER_START_BATTLE(Int32 id, List<System.Int32> hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTowerBattle data = new pbTowerBattle();
		data.id = id;
		data.hero_id.AddRange(hero_id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗结果
	public static void TOWER_BATTLE_OVER(Int32 result, List<PROTO.pbTowerHero> self_hp_list, List<PROTO.pbTowerHero> ememy_hp_list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTowerOver data = new pbTowerOver();
		data.result = result;
		data.self_hp_list.AddRange(self_hp_list);
		data.ememy_hp_list.AddRange(ememy_hp_list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30006,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开启宝箱
	public static void TOWER_OPEN_BOX(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//关闭宝箱界面
	public static void TOWER_LEAVE_BOX(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//一键试炼
	public static void TOWER_SKIP_LAYER(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30009,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新血量
	public static void TOWER_UPDATE_HP(List<PROTO.pbTowerHero> self_hp_list, List<PROTO.pbTowerHero> ememy_hp_list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbTowerUpdateHp data = new pbTowerUpdateHp();
		data.self_hp_list.AddRange(self_hp_list);
		data.ememy_hp_list.AddRange(ememy_hp_list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30011,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买试炼币
	public static void TOWER_BUY_SCORE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30012,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//宝箱全开
	public static void TOWER_OPEN_ALL_BOX(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(30013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//关闭宝箱全开
	public static void TOWER_LEAVE_ALL_BOX(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30014,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求宝箱全开信息
	public static void TOWER_OPEN_BOX_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(30015,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取丛林信息
	public static void JUNGLE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(31001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//挑战丛林
	public static void JUNGLE_BATTLE(Int32 id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbJungleBattle data = new pbJungleBattle();
		data.id = id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(31002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//扫荡丛林
	public static void JUNGLE_SWEEP(Int32 id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbJungleBattle data = new pbJungleBattle();
		data.id = id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(31003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//投降丛林
	public static void JUNGLE_LOSE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(31004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//丛林战斗结果
	public static void JUNGLE_RESULT(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(31005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新丛林伤害
	public static void JUNGLE_REFRESH_HURT(Int64 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId64 data = new pbId64();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(31006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求护送信息
	public static void ESCORT_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买护送商船次数
	public static void ESCORT_BUY_ESCORT_TIMES(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船战报列表
	public static void ESCORT_BATTLE_REP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船加速完成
	public static void ESCORT_QUICK_OVER(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32004,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买抢夺商船次数
	public static void ESCORT_BUY_ROB_TIMES(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船护送
	public static void ESCORT_START(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(32006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始自己掠夺商船
	public static void ESCORT_SELF_ROB(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(32007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//掠夺商船战斗结果
	public static void ESCORT_ROB_RESULT(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(32010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新商船被拦截
	public static void ESCORT_UPDATE_ROB(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32011,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//单个商船信息
	public static void ESCORT_BOUT_INFO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(32012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新商船消失
	public static void ESCORT_DELETE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32013,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新商船增加
	public static void ESCORT_ADD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32014,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船刷新品质
	public static void ESCORT_REFRESH_QUALITY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32015,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求当前商船刷新品质
	public static void ESCORT_CURRENT_QUALITY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32016,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船领取奖励
	public static void ESCORT_GET_REWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32017,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船奖励通知
	public static void ESCORT_REWARD_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32018,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//商船战报红点
	public static void ESCORT_REP_RED(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(32019,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//送花
	public static void CHARM_GIVE_ROSE(Int32 player_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbCharmGiveRose data = new pbCharmGiveRose();
		data.player_id = player_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(33001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//膜拜
	public static void CHARM_WORSHIP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(33002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//领取昨日膜拜奖励
	public static void CHARM_WORSHIP_GET_AWARD(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(33003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//修改宣言
	public static void CHARM_WORSHIP_CHANGE_WORD(Int32 rank, String word,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbCharmChangeWord data = new pbCharmChangeWord();
		data.rank = rank;
		data.word = word;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(33004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开启双倍经验奖励
	public static void CHARM_WORSHIP_DO_DOUBLE(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(33005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//取主城雕像信息
	public static void CHARM_WORSHIP_GET_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(33006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//魅力发的私聊
	public static void CHARM_WORSHIP_CHAT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(33007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//广播被膜拜信息更新膜拜次数
	public static void CHARM_WORSHIP_BROADCAST_NUM(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(33008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//宝藏信息
	public static void MINE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(34001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//宝藏抽取
	public static void MINE_DRAW(Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbMineDrawType data = new pbMineDrawType();
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(34002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求王者展示信息
	public static void PEERAGE_SHOW(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35001,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求自己爵位信息
	public static void PEERAGE_SELF_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//定时请求领取时薪
	public static void PEERAGE_TIME_REWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//查看段位爵位信息
	public static void PEERAGE_PHASE_INFO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//查看挑战出战英雄
	public static void PEERAGE_BATTLE_HERO(Int32 phase, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPeerageBattle data = new pbPeerageBattle();
		data.phase = phase;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买挑战次数
	public static void PEERAGE_BUY_TIMES(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//设置阵型
	public static void PEERAGE_SET_HERO(List<PROTO.pbPeerageSetHero> hero_list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPeerageSetHeroList data = new pbPeerageSetHeroList();
		data.hero_list.AddRange(hero_list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始挑战
	public static void PEERAGE_START_BATTLE(Int32 phase, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPeerageBattle data = new pbPeerageBattle();
		data.phase = phase;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//挑战结果
	public static void PEERAGE_BATTLE_OVER(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35009,data,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求战报
	public static void PEERAGE_BATTLE_REP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//请求所有段位信息
	public static void PEERAGE_PHASE_ALL(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35011,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//上线段位通知
	public static void PEERAGE_LOGIN_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35012,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//爵位战报红点
	public static void PEERAGE_REP_RED(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35013,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//购买爵位双倍薪资
	public static void PEERAGE_BUY_DOUBLE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(35014,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//薪资满红点通知
	public static void PEERAGE_SALARY_RED(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(35015,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入某个地狱获取当前组队信息
	public static void HELL_ENTER(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellEnter data = new pbHellEnter();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//创建队伍
	public static void HELL_CREAT(Int32 id, Int32 hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellCreatTeam data = new pbHellCreatTeam();
		data.id = id;
		data.hero_id = hero_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//加入队伍
	public static void HELL_ADD(Int32 id, Int32 team_id, Int32 hero_id, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellAddTeam data = new pbHellAddTeam();
		data.id = id;
		data.team_id = team_id;
		data.hero_id = hero_id;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//退出队伍
	public static void HELL_QUIT(Int32 id, Int32 team_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellQuitTeam data = new pbHellQuitTeam();
		data.id = id;
		data.team_id = team_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更换队伍英雄
	public static void HELL_CHANGE(Int32 id, Int32 team_id, Int32 hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellChangeTeam data = new pbHellChangeTeam();
		data.id = id;
		data.team_id = team_id;
		data.hero_id = hero_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//广播邀请
	public static void HELL_CHAT(Int32 id, Int32 team_id, Int32 combat,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellChat data = new pbHellChat();
		data.id = id;
		data.team_id = team_id;
		data.combat = combat;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始战斗
	public static void HELL_FIGHT_START(Int32 id, Int32 team_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellFightStart data = new pbHellFightStart();
		data.id = id;
		data.team_id = team_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗结果
	public static void HELL_FIGHT_END(Int32 id, Int32 team_id, Int32 type, Int32 hit,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellFightEnd data = new pbHellFightEnd();
		data.id = id;
		data.team_id = team_id;
		data.type = type;
		data.hit = hit;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//踢出队伍
	public static void HELL_OUT_TEAM(Int32 id, Int32 team_id, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHellTPTeam data = new pbHellTPTeam();
		data.id = id;
		data.team_id = team_id;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(36009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//通过聊天加入队伍成功返回
	public static void HELL_ADD_FROM_CHAT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(36010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//进入pvp组队界面
	public static void PVP_ENTER_TEAM_INTERFACE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//邀请好友
	public static void PVP_INVITE_FRIEND(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//邀请信息
	public static void PVP_INVITE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//邀请回复
	public static void PVP_INVITE_ACK(Int32 result, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpInviteRet data = new pbPvpInviteRet();
		data.result = result;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//队伍变化
	public static void PVP_TEAM_CHANGE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始pvp匹配
	public static void PVP_START_MATCH(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//离开组队界面
	public static void PVP_LEAVE_INTERFACE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//取消匹配
	public static void PVP_CANCEL(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37008,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//选择英雄
	public static void PVP_SELECT_HERO(Int32 player_id, Int32 hero_id, Int32 star,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpSelectHero data = new pbPvpSelectHero();
		data.player_id = player_id;
		data.hero_id = hero_id;
		data.star = star;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//确认英雄
	public static void PVP_SET_HERO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp踢出队伍
	public static void PVP_KICK(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37011,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//加载广播
	public static void PVP_LOAD(Int32 player_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpLoad data = new pbPvpLoad();
		data.player_id = player_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//发起投降
	public static void PVP_GIVE_UP_START(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//队伍聊天
	public static void PVP_CHAT(String msg, String nickname,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpChat data = new pbPvpChat();
		data.msg = msg;
		data.nickname = nickname;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37014,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//战斗结算
	public static void PVP_BATTLE_OVER(Int32 type, Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpBattleResult data = new pbPvpBattleResult();
		data.type = type;
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37015,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更换召唤师技能
	public static void PVP_CHANGE_SKILL(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37016,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp邀请回复返回
	public static void PVP_INVITE_RETURN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37017,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//好友状态更新
	public static void PVP_FRIEND_STATE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37018,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//投降选择
	public static void PVP_GIVE_UP_RESULT(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37019,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开始战斗
	public static void PVP_BATTLE_START(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37021,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//匹配操作
	public static void PVP_MATCH_OP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37022,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp心跳
	public static void PVP_HEART(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37023,null,0);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp主机唤醒
	public static void PVP_MAIN_WAKE_UP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37024,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp战斗广播房间
	public static void PVP_BROADCAST_ROOM(List<PROTO.pbPvpMessage> list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpBroadroom data = new pbPvpBroadroom();
		data.list.AddRange(list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37025,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp战斗广播个人
	public static void PVP_BROADCAST_OTHER(Int32 player_id, List<PROTO.pbPvpMessage> list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpBroadother data = new pbPvpBroadother();
		data.player_id = player_id;
		data.list.AddRange(list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37026,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp解散队伍
	public static void PVP_DISMISS_TEAM(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37027,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp延迟通知
	public static void PVP_NET_DELAY(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37028,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp服务器ip
	public static void PVP_SER_IP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37029,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp切换主机通知
	public static void PVP_CHANGE_MAIN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37030,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp登陆选人界面
	public static void PVP_LOGIN_SELECT_HERO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37031,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp查看好友排行
	public static void PVP_GET_FRIEND_RANK(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37032,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp改变邀请状态
	public static void PVP_CHANGE_INVITE_STATE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37033,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp解锁宝箱
	public static void PVP_UNLOCK_BOX(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37034,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp开启宝箱
	public static void PVP_OPEN_BOX(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37035,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp新增宝箱
	public static void PVP_ADD_BOX(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37036,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp对战主界面信息
	public static void PVP_MAIN_INTERFACE_INFO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37037,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp进入匹配界面广播
	public static void PVP_NOTICE_ENTER_MATCH(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37038,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp赛季奖励
	public static void PVP_SEASON_REWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37039,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp领取赛季奖励
	public static void PVP_GET_SEASON_REWARD(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37040,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp组队聊天
	public static void PVP_TEAM_CHAT(String msg, String nickname,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPvpChat data = new pbPvpChat();
		data.msg = msg;
		data.nickname = nickname;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(37041,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp陌生人列表
	public static void PVP_ROUND_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37042,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//pvp红点通知
	public static void PVP_RED_NOTICE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(37043,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间创建房间
	public static void ROOM_CREATE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间邀请玩家
	public static void ROOM_INVITE(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38002,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间邀请信息
	public static void ROOM_INVITE_REQ(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38003,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间邀请回复
	public static void ROOM_INVITE_REPLY(Int32 result, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomInviteRet data = new pbRoomInviteRet();
		data.result = result;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间队伍变化
	public static void ROOM_TEAM_CHANGE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38005,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间开始游戏
	public static void ROOM_START_MATCH(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38006,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间离开组队界面
	public static void ROOM_LEAVE_ROOM(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38007,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间取消游戏
	public static void ROOM_CANCEL_MATCH(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间选择英雄
	public static void ROOM_SELECT_HERO(Int32 player_id, Int32 hero_id, Int32 star,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomSelectHero data = new pbRoomSelectHero();
		data.player_id = player_id;
		data.hero_id = hero_id;
		data.star = star;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间确认英雄
	public static void ROOM_SET_HERO(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38010,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间踢出队伍
	public static void ROOM_KICK(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38011,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间加载广播
	public static void ROOM_LOAD(Int32 player_id, Int32 num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomLoad data = new pbRoomLoad();
		data.player_id = player_id;
		data.num = num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间发起投降
	public static void ROOM_GIVE_UP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间队伍聊天
	public static void ROOM_TEAM_CHAT(String msg, String nickname,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomChat data = new pbRoomChat();
		data.msg = msg;
		data.nickname = nickname;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38014,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间战斗结算
	public static void ROOM_BATTLE_RESULT(Int32 type, Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomBattleResult data = new pbRoomBattleResult();
		data.type = type;
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38015,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间更换召唤师技能
	public static void ROOM_UPDATE_SKILL(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38016,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间邀请回复邀请者
	public static void ROOM_INVITE_RETURN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38017,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间好友状态更新
	public static void ROOM_FRIEND_STATE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38018,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间投降选择
	public static void ROOM_SELECT_GIVE_UP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38019,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间添加电脑
	public static void ROOM_ADD_ROBOT(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38020,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间开始战斗
	public static void ROOM_START_BATTLE(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38021,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间pvp心跳
	public static void ROOM_HEART(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38023,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间主机唤醒
	public static void ROOM_WAKE_UP(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38024,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间战斗广播房间
	public static void ROOM_BROAD_ROOM(List<PROTO.pbRoomMessage> list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomBroad data = new pbRoomBroad();
		data.list.AddRange(list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38025,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间战斗广播个人
	public static void ROOM_BROAD_OTHER(Int32 player_id, List<PROTO.pbRoomMessage> list,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomBroadother data = new pbRoomBroadother();
		data.player_id = player_id;
		data.list.AddRange(list);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38026,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间队伍解散
	public static void ROOM_DISMISS_TEAM(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38027,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间延迟通知
	public static void ROOM_NET_DELAY(Int32 result,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbResult data = new pbResult();
		data.result = result;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38028,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间服务器ip
	public static void ROOM_SERV_IP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38029,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间切换主机通知
	public static void ROOM_CHANGE_MAIN(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38030,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间登陆选人界面
	public static void ROOM_LOAD_SELECT(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38031,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间换位请求
	public static void ROOM_CHANGE_POS_REQ(Int32 id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32 data = new pbId32();
		data.id = id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38032,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间通知换位
	public static void ROOM_NOTICE_CHANGE_POS(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38033,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间回复请求者
	public static void ROOM_CHANGE_POS_REPLY(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38034,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间回复返回
	public static void ROOM_CHANGE_POS_RETURN(Int32 result, Int32 pos, Int32 player_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbRoomChangeRet data = new pbRoomChangeRet();
		data.result = result;
		data.pos = pos;
		data.player_id = player_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(38035,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间进入匹配界面广播
	public static void ROOM_NOTICE_ENTER_MATCH(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38038,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//开房间陌生人列表
	public static void ROOM_ROUND_LIST(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(38042,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取免费赠送的伙伴信息
	public static void GET_FREE_HERO(Int32 hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroId data = new pbHeroId();
		data.hero_id = hero_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45001,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//获取所有已拥有的英雄
	public static void HERO_GET_ALL_HERO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(45002,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//设置英雄出战列表
	public static void HERO_SET_BATTLE_STATE(Int32 battle_state, List<System.Int32> hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroIds data = new pbHeroIds();
		data.battle_state = battle_state;
		data.hero_id.AddRange(hero_id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45003,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//激活某英雄
	public static void HERO_ACTIVE_HERO(List<System.Int32> id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbId32R data = new pbId32R();
		data.id.AddRange(id);
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45004,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//某英雄进阶
	public static void HERO_UP_QUALITY(Int32 hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroId data = new pbHeroId();
		data.hero_id = hero_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45005,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//某装备合成
	public static void HERO_EQUIP_MERGE(Int32 equip_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroEquipId data = new pbHeroEquipId();
		data.equip_id = equip_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45006,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//某英雄升星
	public static void HERO_UP_STAT(Int32 hero_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroId data = new pbHeroId();
		data.hero_id = hero_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45007,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//更新或添加英雄
	public static void HERO_UP_AND_ADD_HERO(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(45008,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//穿装备
	public static void HERO_WEAR_EQUIP(Int32 hero_id, Int32 equip_id, Int32 pos,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroWearEquip data = new pbHeroWearEquip();
		data.hero_id = hero_id;
		data.equip_id = equip_id;
		data.pos = pos;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45009,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄升级或加经验
	public static void HERO_UP_LV_OR_EXP(Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		var rawPacket=RawPacket.CreateInstance().Init(45010,null,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄技能升级
	public static void HERO_SKILL_UP(Int32 hero_id, Int32 skill_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroUpSkill data = new pbHeroUpSkill();
		data.hero_id = hero_id;
		data.skill_id = skill_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45011,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//召唤师技能升级
	public static void HERO_PLAYER_SKILL_UP(Int32 skill_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPlayerUpSkill data = new pbPlayerUpSkill();
		data.skill_id = skill_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45012,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//召唤师技能激活
	public static void HERO_PLAYER_SKILL_CREAT(Int32 skill_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbPlayerUpSkill data = new pbPlayerUpSkill();
		data.skill_id = skill_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45013,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄装备召唤师技能
	public static void HERO_WEAR_PLAYER_SKILL(Int32 hero_id, Int32 skill_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroUpSkill data = new pbHeroUpSkill();
		data.hero_id = hero_id;
		data.skill_id = skill_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45014,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄装备升级
	public static void HERO_EQUIP_UP_LEVEL(Int32 hero_id, Int32 pos, Int32 type,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroUpEquip data = new pbHeroUpEquip();
		data.hero_id = hero_id;
		data.pos = pos;
		data.type = type;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45015,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄装备强化升阶
	public static void HERO_EQUIP_UP_QUALITY(Int32 hero_id, Int32 pos,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroEquipUp data = new pbHeroEquipUp();
		data.hero_id = hero_id;
		data.pos = pos;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45016,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄装备铸魂升星
	public static void HERO_EQUIP_UP_STAR(Int32 hero_id, Int32 pos,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroEquipUp data = new pbHeroEquipUp();
		data.hero_id = hero_id;
		data.pos = pos;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45017,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄激活和升级天赋
	public static void HERO_DO_UP_GENIUS(Int32 hero_id, Int32 pos,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroEquipUp data = new pbHeroEquipUp();
		data.hero_id = hero_id;
		data.pos = pos;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45018,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄技能一键升级
	public static void HERO_ALL_SKILL_DO_UP(Int32 hero_id, Int32 skill_id,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroUpSkill data = new pbHeroUpSkill();
		data.hero_id = hero_id;
		data.skill_id = skill_id;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45019,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

	//英雄契约添加星星
	public static void HERO_DEED_UP_STAR(Int32 hero_id, Int32 deed_star_num,Action<RawPacket> sendAction = null)
	{
		//MemoryStream databuf = new MemoryStream();
		pbHeroDeed data = new pbHeroDeed();
		data.hero_id = hero_id;
		data.deed_star_num = deed_star_num;
		//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);
		var rawPacket=RawPacket.CreateInstance().Init(45020,data,1);
		if (sendAction != null)
		{
				sendAction(rawPacket);
				return;
		}
		NetInterface.SendData(rawPacket);
	}

}