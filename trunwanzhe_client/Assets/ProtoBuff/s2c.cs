
/**
 *  (自动生成，请勿编辑！)
 */

using System;
using System.IO;
using System.Collections.Generic;
using PROTO;
using pb_common;
using ProtoBuf;

namespace Assets.Scripts.Com.Net.Protos.Proto
{
    public class S2C
    {
        public static Dictionary<int, string> descList = new Dictionary<int, string>();
        private static PBNetCMDData<T> CreateNetCMDData<T>(int key, string desc) where T : global::ProtoBuf.IExtensible, new()
        {
            descList[key] = desc;
            return new PBNetCMDData<T>(key);
        }


        //public const int CMD_1_0 = 256; // 心跳 : LoginHeartMsg_1_0
        //public static readonly PBNetCMDData<pbBossState> CLS_1_0 = CreateNetCMDData<pbBossState>(CMD_1_0, "心跳 : LoginHeartMsg_1_0");

		
		public static PBNetCMDData<pbPayToC> CLS_RMB_BUY { get { return CreateNetCMDData<pbPayToC>(8001, "购买钻石");}}
		public static PBNetCMDData<pbPayFirst> CLS_FIRST_CHARGE { get { return CreateNetCMDData<pbPayFirst>(8002, "领取首充奖励");}}
		public static PBNetCMDData<pbError> CLS_ERROR_CODE { get { return CreateNetCMDData<pbError>(9001, "错误提示代号");}}
		public static PBNetCMDData<pbPlayerBase> CLS_PLAYER_BASE { get { return CreateNetCMDData<pbPlayerBase>(9002, "人物属性更新");}}
		public static PBNetCMDData<pbOtherPlayerBase> CLS_LOOK_OTHER_PLAYER_INFO { get { return CreateNetCMDData<pbOtherPlayerBase>(9004, "查看其他玩家信息");}}
		public static PBNetCMDData<pbVipBaseInfo> CLS_VIP_GET_INFO { get { return CreateNetCMDData<pbVipBaseInfo>(9005, "获取当前已领取过的VIP奖励");}}
		public static PBNetCMDData<pbResult> CLS_VIP_GET_AWARD { get { return CreateNetCMDData<pbResult>(9006, "领取VIP奖励");}}
		public static PBNetCMDData<pbPlayerBase> CLS_CHANGE_NAME { get { return CreateNetCMDData<pbPlayerBase>(9007, "更改昵称");}}
		public static PBNetCMDData<pbPlayerBase> CLS_CHANGE_HEAD { get { return CreateNetCMDData<pbPlayerBase>(9008, "更改头像");}}
		public static PBNetCMDData<pbResult> CLS_SYS_GAME_SET { get { return CreateNetCMDData<pbResult>(9009, "游戏设置");}}
		public static PBNetCMDData<pbResult> CLS_BUY_ENERGY { get { return CreateNetCMDData<pbResult>(9010, "购买体力");}}
		public static PBNetCMDData<pbId32> CLS_CHANGE_NAME_CD { get { return CreateNetCMDData<pbId32>(9011, "修改昵称cd");}}
		public static PBNetCMDData<pbResCd> CLS_RESOURCE_ENDTIME { get { return CreateNetCMDData<pbResCd>(9012, "资源回复倒计时");}}
		public static PBNetCMDData<pbGameSetting> CLS_SETTING_LIST { get { return CreateNetCMDData<pbGameSetting>(9013, "请求设置列表");}}
		public static PBNetCMDData<pbResult> CLS_BUY_COIN { get { return CreateNetCMDData<pbResult>(9014, "购买金币");}}
		public static PBNetCMDData<pbResInfo> CLS_REQ_RES_INFO { get { return CreateNetCMDData<pbResInfo>(9015, "请求竞技币/联盟币资源信息");}}
		public static PBNetCMDData<pbResult> CLS_BUY_SKILL_POINT { get { return CreateNetCMDData<pbResult>(9016, "购买英雄技能点");}}
		public static PBNetCMDData<pbResult> CLS_BUY_PLAYER_SKILL_POINT { get { return CreateNetCMDData<pbResult>(9017, "购买神器战神谷");}}
		public static PBNetCMDData<pbOtherBattleList> CLS_GET_OTHER_BATTLE_LIST { get { return CreateNetCMDData<pbOtherBattleList>(9018, "获取对方出战列表");}}
		public static PBNetCMDData<pbRedNotice> CLS_GET_RED_NOTICE { get { return CreateNetCMDData<pbRedNotice>(9019, "获取玩法次数");}}
		public static PBNetCMDData<pbId32R> CLS_GET_BASE_OPEN_LIST { get { return CreateNetCMDData<pbId32R>(9020, "获取已领取的玩法开放奖励列表");}}
		public static PBNetCMDData<pbResult> CLS_GET_BASE_OPEN_AWARD { get { return CreateNetCMDData<pbResult>(9021, "领取的玩法开放奖励");}}
		public static PBNetCMDData<pbResult> CLS_FCM_CHAT { get { return CreateNetCMDData<pbResult>(9022, "防沉迷通知");}}
		public static PBNetCMDData<pbResult> CLS_FCM_SETTING { get { return CreateNetCMDData<pbResult>(9023, "设置防沉迷");}}
		public static PBNetCMDData<pbCodeGoods> CLS_GET_CODE_AWARD { get { return CreateNetCMDData<pbCodeGoods>(9024, "激活码领取奖励");}}
		public static PBNetCMDData<pbChangeGold> CLS_CHANGE_GOLD_MSG { get { return CreateNetCMDData<pbChangeGold>(9025, "通知前端钻石改变");}}
		public static PBNetCMDData<pbResult> CLS_KEEP_HEART { get { return CreateNetCMDData<pbResult>(10001, "心跳包");}}
		public static PBNetCMDData<pbResult> CLS_LOGIN_OK { get { return CreateNetCMDData<pbResult>(10002, "告诉前端登陆成功");}}
		public static PBNetCMDData<pbAccountInit> CLS_CONNECT_INIT_OK { get { return CreateNetCMDData<pbAccountInit>(10003, "初始化初始值和增量");}}
		public static PBNetCMDData<pbResult> CLS_LOGIN_OK_SERVER { get { return CreateNetCMDData<pbResult>(10004, "新进程开启需要到登陆界面");}}
		public static PBNetCMDData<pbResult> CLS_REFLESH_SYS_TIME { get { return CreateNetCMDData<pbResult>(10005, "N点服务器时间刷新了需要重新取界面数据");}}
		public static PBNetCMDData<pbChatRet> CLS_CHAT_INFO { get { return CreateNetCMDData<pbChatRet>(11001, "聊天信息");}}
		public static PBNetCMDData<pbChatTimes> CLS_CHAT_TIMES { get { return CreateNetCMDData<pbChatTimes>(11002, "聊天剩余次数");}}
		public static PBNetCMDData<pbChatPlayer> CLS_CHAT_ADD_SHIELD { get { return CreateNetCMDData<pbChatPlayer>(11003, "增加屏蔽玩家发言");}}
		public static PBNetCMDData<pbShieldRet> CLS_CHAT_DEL_SHIELD { get { return CreateNetCMDData<pbShieldRet>(11004, "取消屏蔽玩家发言");}}
		public static PBNetCMDData<pbChatPlayers> CLS_CHAT_SHIELD_LIST { get { return CreateNetCMDData<pbChatPlayers>(11005, "请求屏蔽玩家列表");}}
		public static PBNetCMDData<pbChatPlayers> CLS_CHAT_SEARCH { get { return CreateNetCMDData<pbChatPlayers>(11006, "搜索聊天");}}
		public static PBNetCMDData<pbBroadcast> CLS_BROADCAST { get { return CreateNetCMDData<pbBroadcast>(11007, "广播信息");}}
		public static PBNetCMDData<pbChatData> CLS_CHAT_LOGIN { get { return CreateNetCMDData<pbChatData>(11008, "登陆显示聊天信息");}}
		public static PBNetCMDData<pbSysBroadcast> CLS_SYS_BROADCAST { get { return CreateNetCMDData<pbSysBroadcast>(11009, "系统后台广播的消息");}}
		public static PBNetCMDData<pbResult> CLS_ENTER_SCENE { get { return CreateNetCMDData<pbResult>(12001, "进入地图场景");}}
		public static PBNetCMDData<pbPlayers> CLS_UPDATA_SCENE_PLAYER { get { return CreateNetCMDData<pbPlayers>(12003, "更新场景中其他角色的数据");}}
		public static PBNetCMDData<pbPlayers> CLS_LEAVE_SCENE { get { return CreateNetCMDData<pbPlayers>(12004, "离开场景");}}
		public static PBNetCMDData<pbPlayers> CLS_PLAYER_ENTER_SCENE { get { return CreateNetCMDData<pbPlayers>(12005, "进入场景");}}
		public static PBNetCMDData<pbPlayers> CLS_SCENE_PLAYER_UPDATE { get { return CreateNetCMDData<pbPlayers>(12007, "场景中召唤师属性更新");}}
		public static PBNetCMDData<pbMatchInfo> CLS_MATCH_START { get { return CreateNetCMDData<pbMatchInfo>(13001, "开始匹配镜像");}}
		public static PBNetCMDData<pbHeroList> CLS_MATCH_SELECT_HERO { get { return CreateNetCMDData<pbHeroList>(13003, "选英雄");}}
		public static PBNetCMDData<pbResult> CLS_MATCH_ENTER { get { return CreateNetCMDData<pbResult>(13006, "进入乱斗场景");}}
		public static PBNetCMDData<pbResult> CLS_MATCH_LEAVE { get { return CreateNetCMDData<pbResult>(13008, "退出乱斗场景");}}
		public static PBNetCMDData<pbMatchHero> CLS_MATCH_BATTLE_HERO { get { return CreateNetCMDData<pbMatchHero>(13010, "选择的英雄列表");}}
		public static PBNetCMDData<pbResult> CLS_MATCH_UNLOCK_BOX { get { return CreateNetCMDData<pbResult>(13012, "单双路解锁宝箱");}}
		public static PBNetCMDData<pbMeleeBoxReward> CLS_MATCH_BOX_REWARD { get { return CreateNetCMDData<pbMeleeBoxReward>(13013, "单双路宝箱奖励");}}
		public static PBNetCMDData<pbMeleeBox> CLS_MATCH_ADD_BOX { get { return CreateNetCMDData<pbMeleeBox>(13014, "单双路新增宝箱");}}
		public static PBNetCMDData<pbMeleeBoxList> CLS_MATCH_REWARD_INFO { get { return CreateNetCMDData<pbMeleeBoxList>(13015, "单双路奖励信息");}}
		public static PBNetCMDData<pbPlayerFriends> CLS_FRIEND_LIST { get { return CreateNetCMDData<pbPlayerFriends>(14001, "好友陌生人列表");}}
		public static PBNetCMDData<pbResult> CLS_ADD_FRIEND { get { return CreateNetCMDData<pbResult>(14002, "按昵称添加好友黑名单");}}
		public static PBNetCMDData<pbResult> CLS_FRIEND_ADD { get { return CreateNetCMDData<pbResult>(14003, "按id添加好友黑名单");}}
		public static PBNetCMDData<pbResult> CLS_FRIEND_DELETE { get { return CreateNetCMDData<pbResult>(14004, "删除好友黑名单");}}
		public static PBNetCMDData<pbFriendNoticeList> CLS_FRIEND_NOTE_LIST { get { return CreateNetCMDData<pbFriendNoticeList>(14005, "通知列表");}}
		public static PBNetCMDData<pbFriendOpNotice> CLS_FRIEND_NOTE_OP { get { return CreateNetCMDData<pbFriendOpNotice>(14006, "通知操作");}}
		public static PBNetCMDData<pbFriend> CLS_FRIEND_UPDATE { get { return CreateNetCMDData<pbFriend>(14007, "更新添加一个好友");}}
		public static PBNetCMDData<pbFriend> CLS_FRIEND_UPDATE_BLACK { get { return CreateNetCMDData<pbFriend>(14008, "更新添加一个黑名单");}}
		public static PBNetCMDData<pbFriendNotice> CLS_FRIEND_UPDATE_NOTE { get { return CreateNetCMDData<pbFriendNotice>(14009, "更新一个通知");}}
		public static PBNetCMDData<pbFriendDelete> CLS_FRIEND_UPDATE_DELETE { get { return CreateNetCMDData<pbFriendDelete>(14010, "更新删除一个好友黑名单");}}
		public static PBNetCMDData<pbFriendState> CLS_FRIEND_STATE { get { return CreateNetCMDData<pbFriendState>(14011, "更新好友上下线状态");}}
		public static PBNetCMDData<pbFriendLookfor> CLS_FRIEND_LOOKFOR { get { return CreateNetCMDData<pbFriendLookfor>(14012, "好友拜访");}}
		public static PBNetCMDData<pbBagInfo> CLS_BAG_INFO { get { return CreateNetCMDData<pbBagInfo>(15001, "背包信息");}}
		public static PBNetCMDData<pbGoodsChanged> CLS_BAG_CHANGED { get { return CreateNetCMDData<pbGoodsChanged>(15002, "背包信息变更");}}
		public static PBNetCMDData<pbPlayerBag> CLS_BAG_ENLARGE { get { return CreateNetCMDData<pbPlayerBag>(15003, "背包扩充");}}
		public static PBNetCMDData<pbSellRet> CLS_SELL_GOODS { get { return CreateNetCMDData<pbSellRet>(15004, "出售物品");}}
		public static PBNetCMDData<pbResult> CLS_USE_GOODS_TO_GOODS { get { return CreateNetCMDData<pbResult>(15008, "兑换物品");}}
		public static PBNetCMDData<pbResult> CLS_GOODS_DIRECT_BUY { get { return CreateNetCMDData<pbResult>(15009, "物品直接购买");}}
		public static PBNetCMDData<pbPlayerMarking> CLS_MARKING_GET_LIST { get { return CreateNetCMDData<pbPlayerMarking>(16001, "获取印记列表");}}
		public static PBNetCMDData<pbPlayerMarkingList> CLS_MARKING_DO_MARKING { get { return CreateNetCMDData<pbPlayerMarkingList>(16002, "生产印记");}}
		public static PBNetCMDData<pbMarkResult> CLS_MARKING_SELL_MARKING { get { return CreateNetCMDData<pbMarkResult>(16003, "出售印记");}}
		public static PBNetCMDData<pbMarkResult> CLS_MARKING_SWALLOW_MARKING { get { return CreateNetCMDData<pbMarkResult>(16004, "吞吃印记");}}
		public static PBNetCMDData<pbNewMarkResult> CLS_MARKING_WEAR_OR_REPLACE { get { return CreateNetCMDData<pbNewMarkResult>(16005, "替换印记和穿上印记");}}
		public static PBNetCMDData<pbMarkResultList> CLS_MARKING_REMOVE { get { return CreateNetCMDData<pbMarkResultList>(16006, "卸下印记");}}
		public static PBNetCMDData<pbMarkIds> CLS_MARKING_BAG_REMOVE { get { return CreateNetCMDData<pbMarkIds>(16007, "删除印记背包中的东西");}}
		public static PBNetCMDData<pbHeroMarkingBag> CLS_MARKING_BAG_ADD { get { return CreateNetCMDData<pbHeroMarkingBag>(16008, "添加印记背包中的东西");}}
		public static PBNetCMDData<pbResult> CLS_MARKING_SETTING { get { return CreateNetCMDData<pbResult>(16009, "设置印记吞吃类型");}}
		public static PBNetCMDData<pbArenaInfo> CLS_ARENA_OPEN { get { return CreateNetCMDData<pbArenaInfo>(17001, "打开竞技场");}}
		public static PBNetCMDData<pbArenaRefresh> CLS_ARENA_REFRESH { get { return CreateNetCMDData<pbArenaRefresh>(17002, "刷新竞技对手");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_BUY_TIMES { get { return CreateNetCMDData<pbResult>(17003, "购买竞技次数");}}
		public static PBNetCMDData<pbArenaBattleRec> CLS_ARENA_BATTLE_REP { get { return CreateNetCMDData<pbArenaBattleRec>(17004, "查看挑战记录");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_BATTLE { get { return CreateNetCMDData<pbResult>(17005, "挑战竞技对手");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_SET_HERO { get { return CreateNetCMDData<pbResult>(17006, "设置竞技阵型");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_GET_BOX { get { return CreateNetCMDData<pbResult>(17007, "领取历史排名奖励");}}
		public static PBNetCMDData<pbArenaBattleOver> CLS_ARENA_BATTLE_OVER { get { return CreateNetCMDData<pbArenaBattleOver>(17008, "竞技战斗通知");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_CLEAN_CD { get { return CreateNetCMDData<pbResult>(17009, "消除挑战cd");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_AGAIN { get { return CreateNetCMDData<pbResult>(17010, "竞技复仇");}}
		public static PBNetCMDData<pbResult> CLS_ARENA_RED_NOTICE { get { return CreateNetCMDData<pbResult>(17011, "战报红点更新");}}
		public static PBNetCMDData<pbId32> CLS_ARENA_HISTORY_REWARD { get { return CreateNetCMDData<pbId32>(17012, "获取历史排名奖励");}}
		public static PBNetCMDData<pbTitleInfo> CLS_TITLE_INFO { get { return CreateNetCMDData<pbTitleInfo>(18001, "请求称号信息");}}
		public static PBNetCMDData<pbResult> CLS_TITLE_USE { get { return CreateNetCMDData<pbResult>(18002, "使用称号");}}
		public static PBNetCMDData<pbResult> CLS_TITLE_CANCEL { get { return CreateNetCMDData<pbResult>(18003, "取消称号");}}
		public static PBNetCMDData<pbResult> CLS_TITLE_SHOW { get { return CreateNetCMDData<pbResult>(18004, "显示称号");}}
		public static PBNetCMDData<pbResult> CLS_TITLE_DELETE { get { return CreateNetCMDData<pbResult>(18005, "摘除称号");}}
		public static PBNetCMDData<pbId32R> CLS_TITLE_NOTICE { get { return CreateNetCMDData<pbId32R>(18006, "称号弹窗提示");}}
		public static PBNetCMDData<pbMailOpResult> CLS_MAIL_READ { get { return CreateNetCMDData<pbMailOpResult>(19002, "读取邮件");}}
		public static PBNetCMDData<pbMailOpResult> CLS_MAIL_DELETE { get { return CreateNetCMDData<pbMailOpResult>(19003, "删除邮件");}}
		public static PBNetCMDData<pbMailOpResult> CLS_MAIL_ATTACHMENT { get { return CreateNetCMDData<pbMailOpResult>(19004, "提取附件");}}
		public static PBNetCMDData<pbMail> CLS_MAIL_ADD { get { return CreateNetCMDData<pbMail>(19005, "新增邮件");}}
		public static PBNetCMDData<pbMails> CLS_MAIL_LIST { get { return CreateNetCMDData<pbMails>(19006, "获取邮件列表");}}
		public static PBNetCMDData<pbId32R> CLS_MAIL_ALL_GET { get { return CreateNetCMDData<pbId32R>(19007, "一键领取邮件");}}
		public static PBNetCMDData<pbPlayerDungeon> CLS_DUNGEON_GET_INFO { get { return CreateNetCMDData<pbPlayerDungeon>(20001, "获取副本信息");}}
		public static PBNetCMDData<pbDungeonEnterInfo> CLS_DUNGEON_ENTER { get { return CreateNetCMDData<pbDungeonEnterInfo>(20002, "进入副本");}}
		public static PBNetCMDData<pbQuitDungeonResult> CLS_DUNGEON_QUIT { get { return CreateNetCMDData<pbQuitDungeonResult>(20003, "退出副本");}}
		public static PBNetCMDData<pbDungeonqid> CLS_DUNGEON_STAR_AWARD { get { return CreateNetCMDData<pbDungeonqid>(20004, "领取宝箱");}}
		public static PBNetCMDData<pbDungeonSweepResult> CLS_DUNGEON_SWEEP { get { return CreateNetCMDData<pbDungeonSweepResult>(20005, "扫荡");}}
		public static PBNetCMDData<pbDungeonRevivalHero> CLS_DUNGEON_REVIVAL_HERO { get { return CreateNetCMDData<pbDungeonRevivalHero>(20006, "复活某英雄");}}
		public static PBNetCMDData<pbDungeonBuy> CLS_DUNGEON_BUY { get { return CreateNetCMDData<pbDungeonBuy>(20007, "购买副本次数");}}
		public static PBNetCMDData<pbDungeonStarSup> CLS_DUNGEON_GET_SMALL_AWARD { get { return CreateNetCMDData<pbDungeonStarSup>(20008, "领取小关卡奖励");}}
		public static PBNetCMDData<pbResult> CLS_DUNGEON_CHAPTER_OPEN { get { return CreateNetCMDData<pbResult>(20009, "开启新章节特效");}}
		public static PBNetCMDData<pbRanking> CLS_GET_RANKING_INFO { get { return CreateNetCMDData<pbRanking>(21001, "获取排行版信息");}}
		public static PBNetCMDData<pbRankSelfAll> CLS_GET_RANKING_TITLE { get { return CreateNetCMDData<pbRankSelfAll>(21002, "获取排行版标签");}}
		public static PBNetCMDData<pbMallInfo> CLS_MALL_INFO { get { return CreateNetCMDData<pbMallInfo>(22001, "登陆请求商城信息");}}
		public static PBNetCMDData<pbMallBuy> CLS_MALL_BUY { get { return CreateNetCMDData<pbMallBuy>(22002, "购买物品");}}
		public static PBNetCMDData<pbMallRefreshRet> CLS_MALL_REFRESH_SELF { get { return CreateNetCMDData<pbMallRefreshRet>(22003, "手动商城刷新");}}
		public static PBNetCMDData<pbMallRefreshRet> CLS_MALL_REFRESH_SYS { get { return CreateNetCMDData<pbMallRefreshRet>(22004, "系统商城刷新");}}
		public static PBNetCMDData<pbMallAnotherInfo> CLS_MALL_INFO_ANOTHER { get { return CreateNetCMDData<pbMallAnotherInfo>(22005, "打开兑换商城");}}
		public static PBNetCMDData<pbMallBuy> CLS_MALL_BUY_ANOTHER { get { return CreateNetCMDData<pbMallBuy>(22006, "购买兑换商城物品");}}
		public static PBNetCMDData<pbMallAnotherInfo> CLS_MALL_ANOTHER_REFLESH { get { return CreateNetCMDData<pbMallAnotherInfo>(22007, "手动以及系统刷新接口");}}
		public static PBNetCMDData<pbMallDiscountInfo> CLS_MALL_DISCOUNT_INFO { get { return CreateNetCMDData<pbMallDiscountInfo>(22009, "获取折扣商城信息");}}
		public static PBNetCMDData<pbDoubleBattleInfo> CLS_DOUBLE_BATTLE_GET_SELF_INFO { get { return CreateNetCMDData<pbDoubleBattleInfo>(23001, "点击获取攻防战自己的信息");}}
		public static PBNetCMDData<pbResult> CLS_DOUBLE_BATTLE_GET_ENEMY_INFO { get { return CreateNetCMDData<pbResult>(23002, "请求匹配对手");}}
		public static PBNetCMDData<pbResult> CLS_DOUBLE_BATTLE_FRIENDS { get { return CreateNetCMDData<pbResult>(23003, "邀请好友列表");}}
		public static PBNetCMDData<pbDoubleBattleFriendRequest> CLS_DOUBLE_BATTLE_GET_FRIENDS_REPLY { get { return CreateNetCMDData<pbDoubleBattleFriendRequest>(23004, "回馈好友邀请");}}
		public static PBNetCMDData<pbDoubleBattleSelectHeroResult> CLS_DOUBLE_BATTLE_CHOOSE_HEROS { get { return CreateNetCMDData<pbDoubleBattleSelectHeroResult>(23005, "选择英雄出战");}}
		public static PBNetCMDData<pbDoubleBattleMsgs> CLS_DOUBLE_BATTLE_MSG { get { return CreateNetCMDData<pbDoubleBattleMsgs>(23007, "战斗数据更新");}}
		public static PBNetCMDData<pbDoubleBattleSpecialMsg> CLS_DOUBLE_BATTLE_SPEIAL_MSG { get { return CreateNetCMDData<pbDoubleBattleSpecialMsg>(23008, "战斗消息更新");}}
		public static PBNetCMDData<pbDoubleBattleSoulChange> CLS_DOUBLE_BATTLE_SOUL_CHANGE { get { return CreateNetCMDData<pbDoubleBattleSoulChange>(23009, "魂值互换");}}
		public static PBNetCMDData<pbDoubleBattleResult> CLS_DOUBLE_BATTLE_END { get { return CreateNetCMDData<pbDoubleBattleResult>(23010, "战斗结束");}}
		public static PBNetCMDData<pbDoubleBattlePlayer> CLS_DOUBLE_BATTLE_GET_ENEMY_REPLY { get { return CreateNetCMDData<pbDoubleBattlePlayer>(23011, "请求匹配对手的返回");}}
		public static PBNetCMDData<pbResult> CLS_DOUBLE_BATTLE_CANCEL { get { return CreateNetCMDData<pbResult>(23012, "取消匹配和取消邀请好友");}}
		public static PBNetCMDData<pbDoubleBattleFriendMsg> CLS_DOUBLE_BATTLE_FRIEND_GET_MSG { get { return CreateNetCMDData<pbDoubleBattleFriendMsg>(23013, "攻防战好友收到的信息");}}
		public static PBNetCMDData<pbResult> CLS_DOUBLE_BATTLE_CHOOSE_ESCAPE { get { return CreateNetCMDData<pbResult>(23014, "选择英雄时逃跑");}}
		public static PBNetCMDData<pbDoubleBattleFriendAll> CLS_DOUBLE_BATTLE_FRIENDS_STATUS { get { return CreateNetCMDData<pbDoubleBattleFriendAll>(23015, "好友段位积分状态性息");}}
		public static PBNetCMDData<pbTaskInfo> CLS_TASK_INFO { get { return CreateNetCMDData<pbTaskInfo>(24001, "获取任务信息");}}
		public static PBNetCMDData<pbTask> CLS_TASK_ACCEPT { get { return CreateNetCMDData<pbTask>(24002, "接取任务");}}
		public static PBNetCMDData<pbTaskChange> CLS_TASK_REWARD { get { return CreateNetCMDData<pbTaskChange>(24003, "领取任务奖励");}}
		public static PBNetCMDData<pbTaskChange> CLS_TASK_CHANGE { get { return CreateNetCMDData<pbTaskChange>(24005, "任务信息改变");}}
		public static PBNetCMDData<pbUnionInfoAll> CLS_UNION_SELECT { get { return CreateNetCMDData<pbUnionInfoAll>(25000, "搜索获取所有联盟信息");}}
		public static PBNetCMDData<pbUnionInfoAll> CLS_UNION_ALL_INFO { get { return CreateNetCMDData<pbUnionInfoAll>(25001, "获取所有联盟信息");}}
		public static PBNetCMDData<pbUnionSelfInfo> CLS_UNION_SELF_INFO { get { return CreateNetCMDData<pbUnionSelfInfo>(25002, "获取当前联盟信息");}}
		public static PBNetCMDData<pbUnionExpInfoMsg> CLS_UNION_EXP_INFO_MSG { get { return CreateNetCMDData<pbUnionExpInfoMsg>(25003, "获取当前联盟今日一览信息");}}
		public static PBNetCMDData<pbUnionMemberList> CLS_UNION_MEMBER_LIST { get { return CreateNetCMDData<pbUnionMemberList>(25004, "获取当前联盟成员列表");}}
		public static PBNetCMDData<pbUnionBossList> CLS_UNION_BOSS_LIST { get { return CreateNetCMDData<pbUnionBossList>(25005, "获取当前联盟BOSS战信息");}}
		public static PBNetCMDData<pbUnionSelfInfo> CLS_UNION_CREATE { get { return CreateNetCMDData<pbUnionSelfInfo>(25006, "创建联盟");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_APPLY { get { return CreateNetCMDData<pbUnionResult>(25007, "申请加入");}}
		public static PBNetCMDData<pbUnionResultList> CLS_UNION_REQUEST { get { return CreateNetCMDData<pbUnionResultList>(25008, "同意申请加入");}}
		public static PBNetCMDData<pbUnionResultList> CLS_UNION_REFUSE { get { return CreateNetCMDData<pbUnionResultList>(25009, "拒绝加入");}}
		public static PBNetCMDData<pbUnionMemberList> CLS_UNION_APPLY_LIST { get { return CreateNetCMDData<pbUnionMemberList>(25010, "审核列表");}}
		public static PBNetCMDData<pbUnionChange> CLS_UNION_CHANGE { get { return CreateNetCMDData<pbUnionChange>(25011, "变更职位");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_QUIT { get { return CreateNetCMDData<pbUnionResult>(25012, "退出联盟");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_QUIT_OUT { get { return CreateNetCMDData<pbUnionResult>(25013, "踢出联盟");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_DISMISS { get { return CreateNetCMDData<pbUnionResult>(25014, "解散联盟");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_ATT_INFO { get { return CreateNetCMDData<pbUnionResult>(25015, "每次战斗伤害");}}
		public static PBNetCMDData<pbUnionString> CLS_UNION_CHANGE_ANN { get { return CreateNetCMDData<pbUnionString>(25016, "修改宣言");}}
		public static PBNetCMDData<pbUnionChatStringResult> CLS_UNION_ADD_MEMBER { get { return CreateNetCMDData<pbUnionChatStringResult>(25017, "成员招揽内容");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_SET_LIMIT_LEVEL { get { return CreateNetCMDData<pbUnionResult>(25018, "等级限制设置");}}
		public static PBNetCMDData<pbUnionBuildInfo> CLS_UNION_ALMS { get { return CreateNetCMDData<pbUnionBuildInfo>(25019, "捐献");}}
		public static PBNetCMDData<pbUnionResultHeroListNew> CLS_UNION_CHOOSE_HERO { get { return CreateNetCMDData<pbUnionResultHeroListNew>(25020, "选择出战英雄");}}
		public static PBNetCMDData<pbUnionResultHeroListNew> CLS_UNION_HAD_HERO_LIST { get { return CreateNetCMDData<pbUnionResultHeroListNew>(25021, "已出战英雄");}}
		public static PBNetCMDData<pbUnionResult> CLS_UNION_GET_BOSS_HP { get { return CreateNetCMDData<pbUnionResult>(25022, "获取当前出BOSS的血量");}}
		public static PBNetCMDData<pbUnionResultList> CLS_UNION_RED_HOT { get { return CreateNetCMDData<pbUnionResultList>(25023, "联盟红点提示");}}
		public static PBNetCMDData<pbSignInfo> CLS_SIGN_INFO { get { return CreateNetCMDData<pbSignInfo>(26001, "获取签到信息");}}
		public static PBNetCMDData<pbSignInfo> CLS_SIGN_GAT_AWARD { get { return CreateNetCMDData<pbSignInfo>(26002, "签到领取");}}
		public static PBNetCMDData<pbSignInfo> CLS_SIGN_ALWAYS_GET_AWARD { get { return CreateNetCMDData<pbSignInfo>(26003, "连续签到领取");}}
		public static PBNetCMDData<pbSignInfo> CLS_SIGN_ALL_DAY_AWARD { get { return CreateNetCMDData<pbSignInfo>(26004, "领取总共几天的奖励");}}
		public static PBNetCMDData<pbSignPlayerSign> CLS_SIGN_7_INFO { get { return CreateNetCMDData<pbSignPlayerSign>(26005, "获取7天信息");}}
		public static PBNetCMDData<pbSignPlayerSign> CLS_SIGN_7_GET_AWARD { get { return CreateNetCMDData<pbSignPlayerSign>(26006, "领取7天奖励");}}
		public static PBNetCMDData<pbSignPlayerSignList> CLS_SIGN_7_INFO_OTHER { get { return CreateNetCMDData<pbSignPlayerSignList>(26007, "获取另一个7天信息");}}
		public static PBNetCMDData<pbSignPlayerSignList> CLS_SIGN_7_GET_AWARD_OTHER { get { return CreateNetCMDData<pbSignPlayerSignList>(26008, "领取另一个7天奖励");}}
		public static PBNetCMDData<pbDrawInfo> CLS_DRAW_LOTTERY_INFO { get { return CreateNetCMDData<pbDrawInfo>(27001, "获取抽奖信息");}}
		public static PBNetCMDData<pbDrawResult> CLS_DRAW_LOTTERY { get { return CreateNetCMDData<pbDrawResult>(27002, "抽奖");}}
		public static PBNetCMDData<pbDrawResult> CLS_DRAW_LOTTERY_EQUIP_STAR { get { return CreateNetCMDData<pbDrawResult>(27003, "抽铸魂材料");}}
		public static PBNetCMDData<pbGuideInfo> CLS_GUIDE_INFO { get { return CreateNetCMDData<pbGuideInfo>(28001, "获取完成引导的id信息");}}
		public static PBNetCMDData<pbGuide> CLS_GUIDE_NOTICE { get { return CreateNetCMDData<pbGuide>(28002, "通知完成引导");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_OPREATE { get { return CreateNetCMDData<pbResult>(29001, "活动操作");}}
		public static PBNetCMDData<pbActiveLogin> CLS_ACTIVE_LOGIN_INFO { get { return CreateNetCMDData<pbActiveLogin>(29002, "活动信息");}}
		public static PBNetCMDData<pbId32> CLS_ACTIVE_PHASE_INFO { get { return CreateNetCMDData<pbId32>(29003, "活动请求段位");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_GOLD_INFO { get { return CreateNetCMDData<pbResult>(29004, "活动钻石信息");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_BUY_GROW_FUND { get { return CreateNetCMDData<pbResult>(29005, "购买成长基金");}}
		public static PBNetCMDData<pbActiveGrowFund> CLS_ACTIVE_GROW_FUND_INFO { get { return CreateNetCMDData<pbActiveGrowFund>(29006, "请求成长基金信息");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_GET_GROW_FUND { get { return CreateNetCMDData<pbResult>(29007, "领取成长基金信息");}}
		public static PBNetCMDData<pbActiveOpen> CLS_ACTIVE_OPEN_SERV_INFO { get { return CreateNetCMDData<pbActiveOpen>(29008, "开服7天活动信息");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_OPEN_REWARD { get { return CreateNetCMDData<pbResult>(29009, "开服7天奖励领取");}}
		public static PBNetCMDData<pbActiveChargeList> CLS_ACTIVE_CHARGE_REWARD_LIST { get { return CreateNetCMDData<pbActiveChargeList>(29010, "充值活动以领取列表");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_CHARGE_REWARD_TODAY { get { return CreateNetCMDData<pbResult>(29011, "充值活动领取当天累计奖励");}}
		public static PBNetCMDData<pbResult> CLS_ACTIVE_CHARGE_REWARD_7DAY { get { return CreateNetCMDData<pbResult>(29012, "充值活动领取7天累计奖励");}}
		public static PBNetCMDData<pbTowerInfo> CLS_TOWER_INFO { get { return CreateNetCMDData<pbTowerInfo>(30001, "请求爬塔信息");}}
		public static PBNetCMDData<pbTowerHeroHp> CLS_TOWER_SELE_HP_LIST { get { return CreateNetCMDData<pbTowerHeroHp>(30003, "请求己方英雄血量列表");}}
		public static PBNetCMDData<pbResult> CLS_TOWER_START_BATTLE { get { return CreateNetCMDData<pbResult>(30005, "开始战斗");}}
		public static PBNetCMDData<pbTowerBox> CLS_TOWER_OPEN_BOX { get { return CreateNetCMDData<pbTowerBox>(30007, "开启宝箱");}}
		public static PBNetCMDData<pbResult> CLS_TOWER_LEAVE_BOX { get { return CreateNetCMDData<pbResult>(30008, "关闭宝箱界面");}}
		public static PBNetCMDData<pbTowerRewardList> CLS_TOWER_SKIP_LAYER { get { return CreateNetCMDData<pbTowerRewardList>(30009, "一键试炼");}}
		public static PBNetCMDData<pbResult> CLS_TOWER_BUY_SCORE { get { return CreateNetCMDData<pbResult>(30012, "购买试炼币");}}
		public static PBNetCMDData<pbTowerRewardList> CLS_TOWER_OPEN_ALL_BOX { get { return CreateNetCMDData<pbTowerRewardList>(30013, "宝箱全开");}}
		public static PBNetCMDData<pbResult> CLS_TOWER_LEAVE_ALL_BOX { get { return CreateNetCMDData<pbResult>(30014, "关闭宝箱全开");}}
		public static PBNetCMDData<pbTowerBoxList> CLS_TOWER_OPEN_BOX_LIST { get { return CreateNetCMDData<pbTowerBoxList>(30015, "请求宝箱全开信息");}}
		public static PBNetCMDData<pbJungleInfo> CLS_JUNGLE_INFO { get { return CreateNetCMDData<pbJungleInfo>(31001, "获取丛林信息");}}
		public static PBNetCMDData<pbResult> CLS_JUNGLE_BATTLE { get { return CreateNetCMDData<pbResult>(31002, "挑战丛林");}}
		public static PBNetCMDData<pbResult> CLS_JUNGLE_SWEEP { get { return CreateNetCMDData<pbResult>(31003, "扫荡丛林");}}
		public static PBNetCMDData<pbResult> CLS_JUNGLE_LOSE { get { return CreateNetCMDData<pbResult>(31004, "投降丛林");}}
		public static PBNetCMDData<pbEscortInfo> CLS_ESCORT_INFO { get { return CreateNetCMDData<pbEscortInfo>(32001, "请求护送信息");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_BUY_ESCORT_TIMES { get { return CreateNetCMDData<pbResult>(32002, "购买护送商船次数");}}
		public static PBNetCMDData<pbEscortRobList> CLS_ESCORT_BATTLE_REP { get { return CreateNetCMDData<pbEscortRobList>(32003, "商船战报列表");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_QUICK_OVER { get { return CreateNetCMDData<pbResult>(32004, "商船加速完成");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_BUY_ROB_TIMES { get { return CreateNetCMDData<pbResult>(32005, "购买抢夺商船次数");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_START { get { return CreateNetCMDData<pbResult>(32006, "商船护送");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_SELF_ROB { get { return CreateNetCMDData<pbResult>(32007, "开始自己掠夺商船");}}
		public static PBNetCMDData<pbEscortUpdateRob> CLS_ESCORT_UPDATE_ROB { get { return CreateNetCMDData<pbEscortUpdateRob>(32011, "更新商船被拦截");}}
		public static PBNetCMDData<pbEscortBoutInfo> CLS_ESCORT_BOUT_INFO { get { return CreateNetCMDData<pbEscortBoutInfo>(32012, "单个商船信息");}}
		public static PBNetCMDData<pbId32> CLS_ESCORT_DELETE { get { return CreateNetCMDData<pbId32>(32013, "更新商船消失");}}
		public static PBNetCMDData<pbEscortOther> CLS_ESCORT_ADD { get { return CreateNetCMDData<pbEscortOther>(32014, "更新商船增加");}}
		public static PBNetCMDData<pbId32> CLS_ESCORT_REFRESH_QUALITY { get { return CreateNetCMDData<pbId32>(32015, "商船刷新品质");}}
		public static PBNetCMDData<pbEscrtQuality> CLS_ESCORT_CURRENT_QUALITY { get { return CreateNetCMDData<pbEscrtQuality>(32016, "请求当前商船刷新品质");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_GET_REWARD { get { return CreateNetCMDData<pbResult>(32017, "商船领取奖励");}}
		public static PBNetCMDData<pbEscortReward> CLS_ESCORT_REWARD_NOTICE { get { return CreateNetCMDData<pbEscortReward>(32018, "商船奖励通知");}}
		public static PBNetCMDData<pbResult> CLS_ESCORT_REP_RED { get { return CreateNetCMDData<pbResult>(32019, "商船战报红点");}}
		public static PBNetCMDData<pbResult> CLS_CHARM_GIVE_ROSE { get { return CreateNetCMDData<pbResult>(33001, "送花");}}
		public static PBNetCMDData<pbResult> CLS_CHARM_WORSHIP { get { return CreateNetCMDData<pbResult>(33002, "膜拜");}}
		public static PBNetCMDData<pbResult> CLS_CHARM_WORSHIP_GET_AWARD { get { return CreateNetCMDData<pbResult>(33003, "领取昨日膜拜奖励");}}
		public static PBNetCMDData<pbResult> CLS_CHARM_WORSHIP_CHANGE_WORD { get { return CreateNetCMDData<pbResult>(33004, "修改宣言");}}
		public static PBNetCMDData<pbResult> CLS_CHARM_WORSHIP_DO_DOUBLE { get { return CreateNetCMDData<pbResult>(33005, "开启双倍经验奖励");}}
		public static PBNetCMDData<pbCharmWorshipAll> CLS_CHARM_WORSHIP_GET_INFO { get { return CreateNetCMDData<pbCharmWorshipAll>(33006, "取主城雕像信息");}}
		public static PBNetCMDData<pbCharmChat> CLS_CHARM_WORSHIP_CHAT { get { return CreateNetCMDData<pbCharmChat>(33007, "魅力发的私聊");}}
		public static PBNetCMDData<pbCharmWorshipNum> CLS_CHARM_WORSHIP_BROADCAST_NUM { get { return CreateNetCMDData<pbCharmWorshipNum>(33008, "广播被膜拜信息更新膜拜次数");}}
		public static PBNetCMDData<pbMineInfo> CLS_MINE_INFO { get { return CreateNetCMDData<pbMineInfo>(34001, "宝藏信息");}}
		public static PBNetCMDData<pbMineDrawResult> CLS_MINE_DRAW { get { return CreateNetCMDData<pbMineDrawResult>(34002, "宝藏抽取");}}
		public static PBNetCMDData<pbPeerageShowList> CLS_PEERAGE_SHOW { get { return CreateNetCMDData<pbPeerageShowList>(35001, "请求王者展示信息");}}
		public static PBNetCMDData<pbPeerageInfo> CLS_PEERAGE_SELF_INFO { get { return CreateNetCMDData<pbPeerageInfo>(35002, "请求自己爵位信息");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_TIME_REWARD { get { return CreateNetCMDData<pbResult>(35003, "定时请求领取时薪");}}
		public static PBNetCMDData<pbPeeragePhase> CLS_PEERAGE_PHASE_INFO { get { return CreateNetCMDData<pbPeeragePhase>(35004, "查看段位爵位信息");}}
		public static PBNetCMDData<pbPeerageEnemy> CLS_PEERAGE_BATTLE_HERO { get { return CreateNetCMDData<pbPeerageEnemy>(35005, "查看挑战出战英雄");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_BUY_TIMES { get { return CreateNetCMDData<pbResult>(35006, "购买挑战次数");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_SET_HERO { get { return CreateNetCMDData<pbResult>(35007, "设置阵型");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_START_BATTLE { get { return CreateNetCMDData<pbResult>(35008, "开始挑战");}}
		public static PBNetCMDData<pbPeerageBattleResult> CLS_PEERAGE_BATTLE_OVER { get { return CreateNetCMDData<pbPeerageBattleResult>(35009, "挑战结果");}}
		public static PBNetCMDData<pbPeerageRepList> CLS_PEERAGE_BATTLE_REP { get { return CreateNetCMDData<pbPeerageRepList>(35010, "请求战报");}}
		public static PBNetCMDData<pbPeeragePhaseList> CLS_PEERAGE_PHASE_ALL { get { return CreateNetCMDData<pbPeeragePhaseList>(35011, "请求所有段位信息");}}
		public static PBNetCMDData<pbId32> CLS_PEERAGE_LOGIN_NOTICE { get { return CreateNetCMDData<pbId32>(35012, "上线段位通知");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_REP_RED { get { return CreateNetCMDData<pbResult>(35013, "爵位战报红点");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_BUY_DOUBLE { get { return CreateNetCMDData<pbResult>(35014, "购买爵位双倍薪资");}}
		public static PBNetCMDData<pbResult> CLS_PEERAGE_SALARY_RED { get { return CreateNetCMDData<pbResult>(35015, "薪资满红点通知");}}
		public static PBNetCMDData<pbHellEnterInfo> CLS_HELL_ENTER { get { return CreateNetCMDData<pbHellEnterInfo>(36001, "进入某个地狱获取当前组队信息");}}
		public static PBNetCMDData<pbHellPveTeamInfo> CLS_HELL_CREAT { get { return CreateNetCMDData<pbHellPveTeamInfo>(36002, "创建队伍");}}
		public static PBNetCMDData<pbHellPveTeamInfo> CLS_HELL_ADD { get { return CreateNetCMDData<pbHellPveTeamInfo>(36003, "加入队伍");}}
		public static PBNetCMDData<pbHellPveTeamInfo> CLS_HELL_QUIT { get { return CreateNetCMDData<pbHellPveTeamInfo>(36004, "退出队伍");}}
		public static PBNetCMDData<pbHellPveTeamInfo> CLS_HELL_CHANGE { get { return CreateNetCMDData<pbHellPveTeamInfo>(36005, "更换队伍英雄");}}
		public static PBNetCMDData<pbHellChatInfo> CLS_HELL_CHAT { get { return CreateNetCMDData<pbHellChatInfo>(36006, "广播邀请");}}
		public static PBNetCMDData<pbResult> CLS_HELL_FIGHT_START { get { return CreateNetCMDData<pbResult>(36007, "开始战斗");}}
		public static PBNetCMDData<pbResult> CLS_HELL_FIGHT_END { get { return CreateNetCMDData<pbResult>(36008, "战斗结果");}}
		public static PBNetCMDData<pbHellPveTeamInfo> CLS_HELL_OUT_TEAM { get { return CreateNetCMDData<pbHellPveTeamInfo>(36009, "踢出队伍");}}
		public static PBNetCMDData<pbResult> CLS_HELL_ADD_FROM_CHAT { get { return CreateNetCMDData<pbResult>(36010, "通过聊天加入队伍成功返回");}}
		public static PBNetCMDData<pbPvpMatchFace> CLS_PVP_ENTER_TEAM_INTERFACE { get { return CreateNetCMDData<pbPvpMatchFace>(37001, "进入pvp组队界面");}}
		public static PBNetCMDData<pbResult> CLS_PVP_INVITE_FRIEND { get { return CreateNetCMDData<pbResult>(37002, "邀请好友");}}
		public static PBNetCMDData<pbPvpInvite> CLS_PVP_INVITE_INFO { get { return CreateNetCMDData<pbPvpInvite>(37003, "邀请信息");}}
		public static PBNetCMDData<pbPvpMatchFace> CLS_PVP_INVITE_ACK { get { return CreateNetCMDData<pbPvpMatchFace>(37004, "邀请回复");}}
		public static PBNetCMDData<pbPvpTeamChange> CLS_PVP_TEAM_CHANGE { get { return CreateNetCMDData<pbPvpTeamChange>(37005, "队伍变化");}}
		public static PBNetCMDData<pbPvpMatchList> CLS_PVP_START_MATCH { get { return CreateNetCMDData<pbPvpMatchList>(37006, "开始pvp匹配");}}
		public static PBNetCMDData<pbResult> CLS_PVP_LEAVE_INTERFACE { get { return CreateNetCMDData<pbResult>(37007, "离开组队界面");}}
		public static PBNetCMDData<pbResult> CLS_PVP_CANCEL { get { return CreateNetCMDData<pbResult>(37008, "取消匹配");}}
		public static PBNetCMDData<pbPvpSelectHero> CLS_PVP_SELECT_HERO { get { return CreateNetCMDData<pbPvpSelectHero>(37009, "选择英雄");}}
		public static PBNetCMDData<pbResult> CLS_PVP_SET_HERO { get { return CreateNetCMDData<pbResult>(37010, "确认英雄");}}
		public static PBNetCMDData<pbResult> CLS_PVP_KICK { get { return CreateNetCMDData<pbResult>(37011, "pvp踢出队伍");}}
		public static PBNetCMDData<pbPvpLoad> CLS_PVP_LOAD { get { return CreateNetCMDData<pbPvpLoad>(37012, "加载广播");}}
		public static PBNetCMDData<pbPvpGiveUp> CLS_PVP_GIVE_UP_START { get { return CreateNetCMDData<pbPvpGiveUp>(37013, "发起投降");}}
		public static PBNetCMDData<pbPvpChat> CLS_PVP_CHAT { get { return CreateNetCMDData<pbPvpChat>(37014, "队伍聊天");}}
		public static PBNetCMDData<pbPvpBattleResult> CLS_PVP_BATTLE_OVER { get { return CreateNetCMDData<pbPvpBattleResult>(37015, "战斗结算");}}
		public static PBNetCMDData<pbPvpSkill> CLS_PVP_CHANGE_SKILL { get { return CreateNetCMDData<pbPvpSkill>(37016, "更换召唤师技能");}}
		public static PBNetCMDData<pbPvpInviteRet> CLS_PVP_INVITE_RETURN { get { return CreateNetCMDData<pbPvpInviteRet>(37017, "pvp邀请回复返回");}}
		public static PBNetCMDData<pbPvpFriendState> CLS_PVP_FRIEND_STATE { get { return CreateNetCMDData<pbPvpFriendState>(37018, "好友状态更新");}}
		public static PBNetCMDData<pbPvpGiveUp> CLS_PVP_GIVE_UP_RESULT { get { return CreateNetCMDData<pbPvpGiveUp>(37019, "投降选择");}}
		public static PBNetCMDData<pbPvpMatchList> CLS_PVP_BATTLE_START { get { return CreateNetCMDData<pbPvpMatchList>(37021, "开始战斗");}}
		public static PBNetCMDData<pbResult> CLS_PVP_MATCH_OP { get { return CreateNetCMDData<pbResult>(37022, "匹配操作");}}
		public static PBNetCMDData<pbResult> CLS_PVP_MAIN_WAKE_UP { get { return CreateNetCMDData<pbResult>(37024, "pvp主机唤醒");}}
		public static PBNetCMDData<pbPvpBroadroom> CLS_PVP_BROADCAST_ROOM { get { return CreateNetCMDData<pbPvpBroadroom>(37025, "pvp战斗广播房间");}}
		public static PBNetCMDData<pbPvpBroadother> CLS_PVP_BROADCAST_OTHER { get { return CreateNetCMDData<pbPvpBroadother>(37026, "pvp战斗广播个人");}}
		public static PBNetCMDData<pbResult> CLS_PVP_DISMISS_TEAM { get { return CreateNetCMDData<pbResult>(37027, "pvp解散队伍");}}
		public static PBNetCMDData<pbPvpSevIp> CLS_PVP_SER_IP { get { return CreateNetCMDData<pbPvpSevIp>(37029, "pvp服务器ip");}}
		public static PBNetCMDData<pbPvpChangeMain> CLS_PVP_CHANGE_MAIN { get { return CreateNetCMDData<pbPvpChangeMain>(37030, "pvp切换主机通知");}}
		public static PBNetCMDData<pbPvpSelectInfo> CLS_PVP_LOGIN_SELECT_HERO { get { return CreateNetCMDData<pbPvpSelectInfo>(37031, "pvp登陆选人界面");}}
		public static PBNetCMDData<pbPvpFriendRankList> CLS_PVP_GET_FRIEND_RANK { get { return CreateNetCMDData<pbPvpFriendRankList>(37032, "pvp查看好友排行");}}
		public static PBNetCMDData<pbResult> CLS_PVP_UNLOCK_BOX { get { return CreateNetCMDData<pbResult>(37034, "pvp解锁宝箱");}}
		public static PBNetCMDData<pbPvpBoxReward> CLS_PVP_OPEN_BOX { get { return CreateNetCMDData<pbPvpBoxReward>(37035, "pvp开启宝箱");}}
		public static PBNetCMDData<pbPvpBox> CLS_PVP_ADD_BOX { get { return CreateNetCMDData<pbPvpBox>(37036, "pvp新增宝箱");}}
		public static PBNetCMDData<pbPvpMainInfo> CLS_PVP_MAIN_INTERFACE_INFO { get { return CreateNetCMDData<pbPvpMainInfo>(37037, "pvp对战主界面信息");}}
		public static PBNetCMDData<pbPvpNoticeEnter> CLS_PVP_NOTICE_ENTER_MATCH { get { return CreateNetCMDData<pbPvpNoticeEnter>(37038, "pvp进入匹配界面广播");}}
		public static PBNetCMDData<pbPvpSeasonReward> CLS_PVP_SEASON_REWARD { get { return CreateNetCMDData<pbPvpSeasonReward>(37039, "pvp赛季奖励");}}
		public static PBNetCMDData<pbResult> CLS_PVP_GET_SEASON_REWARD { get { return CreateNetCMDData<pbResult>(37040, "pvp领取赛季奖励");}}
		public static PBNetCMDData<pbPvpChat> CLS_PVP_TEAM_CHAT { get { return CreateNetCMDData<pbPvpChat>(37041, "pvp组队聊天");}}
		public static PBNetCMDData<pbPvpRoundList> CLS_PVP_ROUND_LIST { get { return CreateNetCMDData<pbPvpRoundList>(37042, "pvp陌生人列表");}}
		public static PBNetCMDData<pbPvpRedNotice> CLS_PVP_RED_NOTICE { get { return CreateNetCMDData<pbPvpRedNotice>(37043, "pvp红点通知");}}
		public static PBNetCMDData<pbRoomData> CLS_ROOM_CREATE { get { return CreateNetCMDData<pbRoomData>(38001, "开房间创建房间");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_INVITE { get { return CreateNetCMDData<pbResult>(38002, "开房间邀请玩家");}}
		public static PBNetCMDData<pbRoomInvite> CLS_ROOM_INVITE_REQ { get { return CreateNetCMDData<pbRoomInvite>(38003, "开房间邀请信息");}}
		public static PBNetCMDData<pbRoomData> CLS_ROOM_INVITE_REPLY { get { return CreateNetCMDData<pbRoomData>(38004, "开房间邀请回复");}}
		public static PBNetCMDData<pbRoomTeamChange> CLS_ROOM_TEAM_CHANGE { get { return CreateNetCMDData<pbRoomTeamChange>(38005, "开房间队伍变化");}}
		public static PBNetCMDData<pbRoomMatchList> CLS_ROOM_START_MATCH { get { return CreateNetCMDData<pbRoomMatchList>(38006, "开房间开始游戏");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_LEAVE_ROOM { get { return CreateNetCMDData<pbResult>(38007, "开房间离开组队界面");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_CANCEL_MATCH { get { return CreateNetCMDData<pbResult>(38008, "开房间取消游戏");}}
		public static PBNetCMDData<pbRoomSelectHero> CLS_ROOM_SELECT_HERO { get { return CreateNetCMDData<pbRoomSelectHero>(38009, "开房间选择英雄");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_SET_HERO { get { return CreateNetCMDData<pbResult>(38010, "开房间确认英雄");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_KICK { get { return CreateNetCMDData<pbResult>(38011, "开房间踢出队伍");}}
		public static PBNetCMDData<pbRoomLoad> CLS_ROOM_LOAD { get { return CreateNetCMDData<pbRoomLoad>(38012, "开房间加载广播");}}
		public static PBNetCMDData<pbRoomGiveUp> CLS_ROOM_GIVE_UP { get { return CreateNetCMDData<pbRoomGiveUp>(38013, "开房间发起投降");}}
		public static PBNetCMDData<pbRoomChat> CLS_ROOM_TEAM_CHAT { get { return CreateNetCMDData<pbRoomChat>(38014, "开房间队伍聊天");}}
		public static PBNetCMDData<pbRoomBattleResult> CLS_ROOM_BATTLE_RESULT { get { return CreateNetCMDData<pbRoomBattleResult>(38015, "开房间战斗结算");}}
		public static PBNetCMDData<pbRoomSkill> CLS_ROOM_UPDATE_SKILL { get { return CreateNetCMDData<pbRoomSkill>(38016, "开房间更换召唤师技能");}}
		public static PBNetCMDData<pbRoomInviteRet> CLS_ROOM_INVITE_RETURN { get { return CreateNetCMDData<pbRoomInviteRet>(38017, "开房间邀请回复邀请者");}}
		public static PBNetCMDData<pbRoomFriendState> CLS_ROOM_FRIEND_STATE { get { return CreateNetCMDData<pbRoomFriendState>(38018, "开房间好友状态更新");}}
		public static PBNetCMDData<pbRoomGiveUp> CLS_ROOM_SELECT_GIVE_UP { get { return CreateNetCMDData<pbRoomGiveUp>(38019, "开房间投降选择");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_ADD_ROBOT { get { return CreateNetCMDData<pbResult>(38020, "开房间添加电脑");}}
		public static PBNetCMDData<pbRoomMatchList> CLS_ROOM_START_BATTLE { get { return CreateNetCMDData<pbRoomMatchList>(38021, "开房间开始战斗");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_WAKE_UP { get { return CreateNetCMDData<pbResult>(38024, "开房间主机唤醒");}}
		public static PBNetCMDData<pbRoomBroad> CLS_ROOM_BROAD_ROOM { get { return CreateNetCMDData<pbRoomBroad>(38025, "开房间战斗广播房间");}}
		public static PBNetCMDData<pbRoomBroadother> CLS_ROOM_BROAD_OTHER { get { return CreateNetCMDData<pbRoomBroadother>(38026, "开房间战斗广播个人");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_DISMISS_TEAM { get { return CreateNetCMDData<pbResult>(38027, "开房间队伍解散");}}
		public static PBNetCMDData<pbRoomSevIp> CLS_ROOM_SERV_IP { get { return CreateNetCMDData<pbRoomSevIp>(38029, "开房间服务器ip");}}
		public static PBNetCMDData<pbRoomChangeMain> CLS_ROOM_CHANGE_MAIN { get { return CreateNetCMDData<pbRoomChangeMain>(38030, "开房间切换主机通知");}}
		public static PBNetCMDData<pbRoomSelectInfo> CLS_ROOM_LOAD_SELECT { get { return CreateNetCMDData<pbRoomSelectInfo>(38031, "开房间登陆选人界面");}}
		public static PBNetCMDData<pbResult> CLS_ROOM_CHANGE_POS_REQ { get { return CreateNetCMDData<pbResult>(38032, "开房间换位请求");}}
		public static PBNetCMDData<pbRoomChange> CLS_ROOM_NOTICE_CHANGE_POS { get { return CreateNetCMDData<pbRoomChange>(38033, "开房间通知换位");}}
		public static PBNetCMDData<pbRoomChangeRet> CLS_ROOM_CHANGE_POS_REPLY { get { return CreateNetCMDData<pbRoomChangeRet>(38034, "开房间回复请求者");}}
		public static PBNetCMDData<pbRoomData> CLS_ROOM_CHANGE_POS_RETURN { get { return CreateNetCMDData<pbRoomData>(38035, "开房间回复返回");}}
		public static PBNetCMDData<pbRoomNoticeEnter> CLS_ROOM_NOTICE_ENTER_MATCH { get { return CreateNetCMDData<pbRoomNoticeEnter>(38038, "开房间进入匹配界面广播");}}
		public static PBNetCMDData<pbRoomRoundList> CLS_ROOM_ROUND_LIST { get { return CreateNetCMDData<pbRoomRoundList>(38042, "开房间陌生人列表");}}
		public static PBNetCMDData<pbNewHeroList> CLS_HERO_GET_ALL_HERO { get { return CreateNetCMDData<pbNewHeroList>(45002, "获取所有已拥有的英雄");}}
		public static PBNetCMDData<pbResult> CLS_HERO_SET_BATTLE_STATE { get { return CreateNetCMDData<pbResult>(45003, "设置英雄出战列表");}}
		public static PBNetCMDData<pbResult> CLS_HERO_ACTIVE_HERO { get { return CreateNetCMDData<pbResult>(45004, "激活某英雄");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_UP_QUALITY { get { return CreateNetCMDData<pbHeroResult>(45005, "某英雄进阶");}}
		public static PBNetCMDData<pbResult> CLS_HERO_EQUIP_MERGE { get { return CreateNetCMDData<pbResult>(45006, "某装备合成");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_UP_STAT { get { return CreateNetCMDData<pbHeroResult>(45007, "某英雄升星");}}
		public static PBNetCMDData<pbHeroList> CLS_HERO_UP_AND_ADD_HERO { get { return CreateNetCMDData<pbHeroList>(45008, "更新或添加英雄");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_WEAR_EQUIP { get { return CreateNetCMDData<pbHeroResult>(45009, "穿装备");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_UP_LV_OR_EXP { get { return CreateNetCMDData<pbHeroResult>(45010, "英雄升级或加经验");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_SKILL_UP { get { return CreateNetCMDData<pbHeroResult>(45011, "英雄技能升级");}}
		public static PBNetCMDData<pbSkillInfo> CLS_HERO_PLAYER_SKILL_UP { get { return CreateNetCMDData<pbSkillInfo>(45012, "召唤师技能升级");}}
		public static PBNetCMDData<pbSkillInfo> CLS_HERO_PLAYER_SKILL_CREAT { get { return CreateNetCMDData<pbSkillInfo>(45013, "召唤师技能激活");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_WEAR_PLAYER_SKILL { get { return CreateNetCMDData<pbHeroResult>(45014, "英雄装备召唤师技能");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_EQUIP_UP_LEVEL { get { return CreateNetCMDData<pbHeroResult>(45015, "英雄装备升级");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_EQUIP_UP_QUALITY { get { return CreateNetCMDData<pbHeroResult>(45016, "英雄装备强化升阶");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_EQUIP_UP_STAR { get { return CreateNetCMDData<pbHeroResult>(45017, "英雄装备铸魂升星");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_DO_UP_GENIUS { get { return CreateNetCMDData<pbHeroResult>(45018, "英雄激活和升级天赋");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_ALL_SKILL_DO_UP { get { return CreateNetCMDData<pbHeroResult>(45019, "英雄技能一键升级");}}
		public static PBNetCMDData<pbHeroResult> CLS_HERO_DEED_UP_STAR { get { return CreateNetCMDData<pbHeroResult>(45020, "英雄契约添加星星");}}
    }

	public interface IPBNetCMDData
	{
		bool HasAction();
		int GetKey();
		void Read(byte[] buff);

	}

    public class PBNetCMDData<T> : IPBNetCMDData where T : new()
    {
        private int mKey;
        private Type mDataType;

        private Action<T> mActionList;
        public IPBNetCMDData AddAction(Action<T> action)
        {
            if (mActionList == null && action != null)
            {
                mActionList = action;

                return this;
            }

            return null;
        }

      
        public PBNetCMDData(int key)
        {
            this.mKey = key;

            mDataType = typeof(T);
        }

        public bool HasAction()
        {
			return false;
        }

        public int GetKey()
        {
            return this.mKey;
        }

        public void Read(byte[] buff)
        {
            if (HasAction())
            {
                mActionList(Deserialize(buff));
            }
        }

      
        private T Deserialize(byte[] buff)
        {
            using (MemoryStream ms = new MemoryStream(buff.Length))
            {
                ms.Write(buff, 0, buff.Length);
                ms.Position = 0;
                return Serializer.Deserialize<T>(ms);
            }
        }
    }

}