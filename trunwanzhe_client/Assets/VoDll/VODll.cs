using System.IO;
                                using System;
                                using System.Collections.Generic;
                                namespace Assets.Scripts.Com.Game.Config
                                { 
 [Serializable]public class SysActiveConst
    {
        public const int BREAK_FAST_ENERGY = 1; //BREAK_FAST_ENERGY
        public const int LUNCH_ENERGY = 2; //LUNCH_ENERGY
        public const int DINNER_ENERGY = 3; //DINNER_ENERGY
        public const int SUPPER_ENERGY = 4; //SUPPER_ENERGY
        public const int ENERGY_PUSH = 5; //ENERGY_PUSH
        public const int BOAT_19 = 6; //BOAT_19
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysEcodeConst
    {
        public const int E_OK = 0; //E_OK
        public const int ERROR_BAD_ARG = 1; //ERROR_BAD_ARG
        public const int ERROR_COIN_NOT_ENOUGH = 2; //ERROR_COIN_NOT_ENOUGH
        public const int ERROR_GOLD_NOT_ENOUGH = 3; //ERROR_GOLD_NOT_ENOUGH
        public const int ERROR_LV_NOT_ENOUGH = 4; //ERROR_LV_NOT_ENOUGH
        public const int ERROR_PLAYER_NOT_EXIST = 5; //ERROR_PLAYER_NOT_EXIST
        public const int ERROR_PLAYER_NOT_ENERGY = 6; //ERROR_PLAYER_NOT_ENERGY
        public const int ERROR_HERO_LV_NOT_ENERGY = 7; //ERROR_HERO_LV_NOT_ENERGY
        public const int ERROR_MAX_LIMIT = 8; //ERROR_MAX_LIMIT
        public const int ERROR_VIP = 9; //ERROR_VIP
        public const int ERROR_LEVEL_MAX = 10; //ERROR_LEVEL_MAX
        public const int ERROR_SKILL_POINT = 11; //ERROR_SKILL_POINT
        public const int ERROR_ENERY_MAX = 12; //ERROR_ENERY_MAX
        public const int ERROR_SKILL_POINT_MAX = 13; //ERROR_SKILL_POINT_MAX
        public const int ERROR_PLAYER_SKILL_POINT_NOT = 14; //ERROR_PLAYER_SKILL_POINT_NOT
        public const int ERROR_FIGHT_COIN_NOT_ENOUGH = 15; //ERROR_FIGHT_COIN_NOT_ENOUGH
        public const int ERROR_EQUIP_STAR_GOODS_NOT_ENOUGH = 16; //ERROR_EQUIP_STAR_GOODS_NOT_ENOUGH
        public const int ERROR_CHARGR_MONEY_NOT_ENOUGH = 17; //ERROR_CHARGR_MONEY_NOT_ENOUGH
        public const int ERROR_PAY_REPEAT = 8001; //ERROR_PAY_REPEAT
        public const int ERROR_APPLY_REBATE_REPEAT = 8002; //ERROR_APPLY_REBATE_REPEAT
        public const int ERROR_CHANGE_NAME_CD = 9001; //ERROR_CHANGE_NAME_CD
        public const int ERROR_HEAD_NOT_USE = 9002; //ERROR_HEAD_NOT_USE
        public const int ERROR_VIP_USE = 9003; //ERROR_VIP_USE
        public const int ERROR_PACK_ERROR = 9004; //ERROR_PACK_ERROR
        public const int ERROR_CODE_NOT_EXIT = 9005; //ERROR_CODE_NOT_EXIT
        public const int ERROR_CODE_HAD_GET = 9006; //ERROR_CODE_HAD_GET
        public const int ERROR_CODE_NOT_PLAT = 9007; //ERROR_CODE_NOT_PLAT
        public const int ERROR_CODE_NOT_SERVER = 9008; //ERROR_CODE_NOT_SERVER
        public const int ERROR_CODE_END = 9009; //ERROR_CODE_END
        public const int ERROR_CODE_HAD_OTHER_GET = 9010; //ERROR_CODE_HAD_OTHER_GET
        public const int ERROR_ACCOUNT_NOT_EXIT = 10001; //ERROR_ACCOUNT_NOT_EXIT
        public const int ERROR_LOGIN = 10002; //ERROR_LOGIN
        public const int ERROR_ROLE_EXIT = 10003; //ERROR_ROLE_EXIT
        public const int ERROR_CREAT_ROLE = 10004; //ERROR_CREAT_ROLE
        public const int ERROR_ROLE_LOGIN_OTHER_MACHINE = 10005; //ERROR_ROLE_LOGIN_OTHER_MACHINE
        public const int ERROR_FREE_HERO_NOT_EXIT = 10006; //ERROR_FREE_HERO_NOT_EXIT
        public const int ERROR_LOGIN_DIFF_DEVICE = 10007; //ERROR_LOGIN_DIFF_DEVICE
        public const int ERROR_LOGIN_TOO_MORE_PLAYER = 10008; //ERROR_LOGIN_TOO_MORE_PLAYER
        public const int ERROR_CHAT_LV_NOT_ENOUGH = 11001; //ERROR_CHAT_LV_NOT_ENOUGH
        public const int ERROR_CHAT_TIMES_OVER = 11002; //ERROR_CHAT_TIMES_OVER
        public const int ERROR_CHAT_OFFLINE = 11003; //ERROR_CHAT_OFFLINE
        public const int ERROR_CHAT_NOT_UNION = 11004; //ERROR_CHAT_NOT_UNION
        public const int ERROR_CHAT_LEAVE_LIMIT = 11005; //ERROR_CHAT_LEAVE_LIMIT
        public const int ERROR_CHAT_SELF = 11006; //ERROR_CHAT_SELF
        public const int ERROR_MATCH_TIME_OUT = 13001; //ERROR_MATCH_TIME_OUT
        public const int ERROR_MATCH_NOT_OPEN = 13002; //ERROR_MATCH_NOT_OPEN
        public const int ERROR_MATCH_HERO_NOT_ENOUGH = 13003; //ERROR_MATCH_HERO_NOT_ENOUGH
        public const int ERROR_MATCH_FIGHT_NOT_ENOUGH = 13004; //ERROR_MATCH_FIGHT_NOT_ENOUGH
        public const int ERROR_MATCH_TIMES_OVER = 13005; //ERROR_MATCH_TIMES_OVER
        public const int ERROR_MATCH_REWARD_GET = 13006; //ERROR_MATCH_REWARD_GET
        public const int ERROR_MATCH_WIN_NOT_ENOUGH = 13007; //ERROR_MATCH_WIN_NOT_ENOUGH
        public const int ERROR_MELEE_BOX_HAS_UNLOCK = 13008; //ERROR_MELEE_BOX_HAS_UNLOCK
        public const int ERROR_MELEE_BOX_UNLOCKING = 13009; //ERROR_MELEE_BOX_UNLOCKING
        public const int ERROR_MELEE_BOX_NOT_EXIST = 13010; //ERROR_MELEE_BOX_NOT_EXIST
        public const int ERROR_FRIEND_APPLY_MAX = 14001; //ERROR_FRIEND_APPLY_MAX
        public const int ERROR_FRIEND_IS_FRIEND = 14002; //ERROR_FRIEND_IS_FRIEND
        public const int ERROR_FRIEND_MAX = 14003; //ERROR_FRIEND_MAX
        public const int ERROR_FRIEND_IS_BLACK = 14004; //ERROR_FRIEND_IS_BLACK
        public const int ERROR_FRIEND_IS_BLACK1 = 14005; //ERROR_FRIEND_IS_BLACK1
        public const int ERROR_FRIEND_BLACK_MAX = 14006; //ERROR_FRIEND_BLACK_MAX
        public const int ERROR_FRIEND_NOTE_WRONG = 14007; //ERROR_FRIEND_NOTE_WRONG
        public const int ERROR_FRIEND_IS_BLACK2 = 14008; //ERROR_FRIEND_IS_BLACK2
        public const int ERROR_FRIEND_IS_BLACK3 = 14009; //ERROR_FRIEND_IS_BLACK3
        public const int ERROR_FRIEND_MAX1 = 14010; //ERROR_FRIEND_MAX1
        public const int ERROR_FRIEND_ADD_SELF = 14011; //ERROR_FRIEND_ADD_SELF
        public const int ERROR_FRIEND_ADD_SELF1 = 14012; //ERROR_FRIEND_ADD_SELF1
        public const int ERROR_FRIEND_HAS_APPLY = 14013; //ERROR_FRIEND_HAS_APPLY
        public const int ERROR_FRIEND_REQ_OK = 14015; //ERROR_FRIEND_REQ_OK
        public const int ERROR_FRIEND_LOOKFOR_MAX = 14016; //ERROR_FRIEND_LOOKFOR_MAX
        public const int ERROR_FRIEND_HAS_LOOK = 14017; //ERROR_FRIEND_HAS_LOOK
        public const int ERROR_GOODS_NOT_OPENED = 15001; //ERROR_GOODS_NOT_OPENED
        public const int ERROR_GOODS_NOT_EXIST = 15002; //ERROR_GOODS_NOT_EXIST
        public const int ERROR_GOODS_NOT_ENOUGH = 15003; //ERROR_GOODS_NOT_ENOUGH
        public const int ERROR_GOODS_ENLARGE_MAX = 15004; //ERROR_GOODS_ENLARGE_MAX
        public const int ERROR_GOODS_NOT_USE = 15005; //ERROR_GOODS_NOT_USE
        public const int ERROR_BAG_NOT_ENOUGH = 15006; //ERROR_BAG_NOT_ENOUGH
        public const int ERROR_GOODS_NOT_COMBINE = 15007; //ERROR_GOODS_NOT_COMBINE
        public const int ERROR_GOODS_NOT_SELL = 15008; //ERROR_GOODS_NOT_SELL
        public const int ERROR_GOODS_NOT_DIRE_BUY = 15009; //ERROR_GOODS_NOT_DIRE_BUY
        public const int ERROR_MARKING_BAG_FULL = 16001; //ERROR_MARKING_BAG_FULL
        public const int ERROR_MARKING_HAD_SAME_TYPE = 16002; //ERROR_MARKING_HAD_SAME_TYPE
        public const int ERROR_MARKING_HAD_SAME_POS = 16003; //ERROR_MARKING_HAD_SAME_POS
        public const int ERROR_MARKING_NOT_HAD_MARKING = 16004; //ERROR_MARKING_NOT_HAD_MARKING
        public const int ERROR_MARKING_Lv_OR_Q = 16005; //ERROR_MARKING_Lv_OR_Q
        public const int ERROR_MARKING_FREE_TIME = 16006; //ERROR_MARKING_FREE_TIME
        public const int ERROR_ARENA_STAR_NOT_ENOUGH = 17001; //ERROR_ARENA_STAR_NOT_ENOUGH
        public const int ERROR_ARENA_BOX_HAS_GET = 17002; //ERROR_ARENA_BOX_HAS_GET
        public const int ERROR_ARENA_NOT_CD = 17003; //ERROR_ARENA_NOT_CD
        public const int ERROR_ARENA_TIMES_OVER = 17004; //ERROR_ARENA_TIMES_OVER
        public const int ERROR_ARENA_RANK_CHANGED = 17005; //ERROR_ARENA_RANK_CHANGED
        public const int ERROR_ARENA_NOT_BATTLE = 17006; //ERROR_ARENA_NOT_BATTLE
        public const int ERROR_ARENA_BATTLE_CD = 17007; //ERROR_ARENA_BATTLE_CD
        public const int ERROR_ARENA_HAS_BATTLE = 17008; //ERROR_ARENA_HAS_BATTLE
        public const int ERROR_ARENA_HAS_BATTLED = 17009; //ERROR_ARENA_HAS_BATTLED
        public const int ERROR_ARENA_NOT_OPEN = 17010; //ERROR_ARENA_NOT_OPEN
        public const int ERROR_ARENA_RANK_LOW = 17011; //ERROR_ARENA_RANK_LOW
        public const int ERROR_ARENA_RANK_HIGH = 17012; //ERROR_ARENA_RANK_HIGH
        public const int ERROR_ARENA_BUY_MAX = 17013; //ERROR_ARENA_BUY_MAX
        public const int ERROR_ARENA_REFRESH_OK = 17014; //ERROR_ARENA_REFRESH_OK
        public const int ERROR_ARENA_BATTLE_SELF = 17015; //ERROR_ARENA_BATTLE_SELF
        public const int ERROR_TITLE_IN_USE = 18001; //ERROR_TITLE_IN_USE
        public const int ERROR_TITLE_NOT_OWN = 18002; //ERROR_TITLE_NOT_OWN
        public const int ERROR_TITLE_NOT_USE = 18003; //ERROR_TITLE_NOT_USE
        public const int ERROR_TITLE_NOT_SHOW = 18004; //ERROR_TITLE_NOT_SHOW
        public const int ERROR_MAIL_GOODS_HAS_GET = 19001; //ERROR_MAIL_GOODS_HAS_GET
        public const int ERROR_DUNGEON_NOT_ENTER = 20001; //ERROR_DUNGEON_NOT_ENTER
        public const int ERROR_DUNGEON_NOT_OPEN = 20002; //ERROR_DUNGEON_NOT_OPEN
        public const int ERROR_DUNGEON_NOT_TIME = 20003; //ERROR_DUNGEON_NOT_TIME
        public const int ERROR_DUNGEON_NOT_STAR = 20004; //ERROR_DUNGEON_NOT_STAR
        public const int ERROR_DUNGEON_HAD_STAR = 20005; //ERROR_DUNGEON_HAD_STAR
        public const int ERROR_DUNGEON_NOT_SWEEP = 20006; //ERROR_DUNGEON_NOT_SWEEP
        public const int ERROR_DUNGEON_IS_FULL = 20007; //ERROR_DUNGEON_IS_FULL
        public const int ERROR_MALL_BUY_LIMIT = 22001; //ERROR_MALL_BUY_LIMIT
        public const int ERROR_MALL_ARENA_LIMIT = 22002; //ERROR_MALL_ARENA_LIMIT
        public const int ERROR_MALL_TIME_LIMIT = 22003; //ERROR_MALL_TIME_LIMIT
        public const int ERROR_MALL_REFRESH_OVER = 22004; //ERROR_MALL_REFRESH_OVER
        public const int ERROR_MALL_UNION_LIMIT = 22005; //ERROR_MALL_UNION_LIMIT
        public const int ERROR_MALL_FIGHT_COIN_LIMIT = 22006; //ERROR_MALL_FIGHT_COIN_LIMIT
        public const int ERROR_MALL_REFRESH_LIMIT = 22007; //ERROR_MALL_REFRESH_LIMIT
        public const int ERROR_DOUBLE_BATTLE_END = 23001; //ERROR_DOUBLE_BATTLE_END
        public const int ERROR_DOUBLE_BATTLE_CLOSE = 23002; //ERROR_DOUBLE_BATTLE_CLOSE
        public const int ERROR_DOUBLE_BATTLE_HAD_OR_CANCEL = 23003; //ERROR_DOUBLE_BATTLE_HAD_OR_CANCEL
        public const int ERROR_DOUBLE_BATTLE_NOT_SOUL = 23004; //ERROR_DOUBLE_BATTLE_NOT_SOUL
        public const int ERROR_TASK_NOT_FINISH = 24001; //ERROR_TASK_NOT_FINISH
        public const int ERROR_TASK_REWARD_HAS_GET = 24002; //ERROR_TASK_REWARD_HAS_GET
        public const int ERROR_TASK_PRE_NOT_FINISH = 24003; //ERROR_TASK_PRE_NOT_FINISH
        public const int ERROR_TASK_TIME_OUT = 24004; //ERROR_TASK_TIME_OUT
        public const int ERROR_UNION = 25001; //ERROR_UNION
        public const int ERROR_UNION_NAME = 25002; //ERROR_UNION_NAME
        public const int ERROR_UNION_MEMBER = 25003; //ERROR_UNION_MEMBER
        public const int ERROR_UNION_CRYSTAL = 25004; //ERROR_UNION_CRYSTAL
        public const int ERROR_UNION_PRV = 25005; //ERROR_UNION_PRV
        public const int ERROR_UNION_OTHER_P = 25006; //ERROR_UNION_OTHER_P
        public const int ERROR_UNION_HAD_UNION = 25007; //ERROR_UNION_HAD_UNION
        public const int ERROR_UNION_HAD_APPLY = 25008; //ERROR_UNION_HAD_APPLY
        public const int ERROR_UNION_FULL = 25009; //ERROR_UNION_FULL
        public const int ERROR_UNION_OUT_TIME = 25010; //ERROR_UNION_OUT_TIME
        public const int ERROR_UNION_MAX_LEVEL = 25011; //ERROR_UNION_MAX_LEVEL
        public const int ERROR_UNION_MAX_DEV = 25012; //ERROR_UNION_MAX_DEV
        public const int ERROR_UNION_OUT_TIME_1 = 25013; //ERROR_UNION_OUT_TIME_1
        public const int ERROR_UNION_MAX_OFFICE = 25014; //ERROR_UNION_MAX_OFFICE
        public const int ERROR_UNION_HAD_UNION_SELF = 25015; //ERROR_UNION_HAD_UNION_SELF
        public const int ERROR_UNION_PRV_1 = 25016; //ERROR_UNION_PRV_1
        public const int ERROR_UNION_NOT_IN_APPLY_LIST = 25017; //ERROR_UNION_NOT_IN_APPLY_LIST
        public const int ERROR_UNION_OUT_TIME_NEW_ADD = 25018; //ERROR_UNION_OUT_TIME_NEW_ADD
        public const int ERROR_UNION_OFFICE_HEADER_TOP = 25020; //ERROR_UNION_OFFICE_HEADER_TOP
        public const int ERROR_UNION_OFFICE_CHANGE_OUT = 25021; //ERROR_UNION_OFFICE_CHANGE_OUT
        public const int ERROR_SIGN_NOT_SIGN = 26001; //ERROR_SIGN_NOT_SIGN
        public const int ERROR_DRAW_LOTTERY_CD = 27001; //ERROR_DRAW_LOTTERY_CD
        public const int ERROR_DRAW_LOTTERY_TIMES_LIMIT = 27002; //ERROR_DRAW_LOTTERY_TIMES_LIMIT
        public const int ERROR_ACTIVE_OVER = 29001; //ERROR_ACTIVE_OVER
        public const int ERROR_ACTIVE_HAS_REWARD = 29002; //ERROR_ACTIVE_HAS_REWARD
        public const int ERROR_ACTIVE_LOGIN_NOT_ENOUGH = 29003; //ERROR_ACTIVE_LOGIN_NOT_ENOUGH
        public const int ERROR_ACTIVE_HERO_OVER = 29004; //ERROR_ACTIVE_HERO_OVER
        public const int ERROR_ACTIVE_VIP_NOT_TIME = 29005; //ERROR_ACTIVE_VIP_NOT_TIME
        public const int ERROR_ACTIVE_VIP_HIGH = 29006; //ERROR_ACTIVE_VIP_HIGH
        public const int ERROR_ACTIVE_FREE_OVER = 29007; //ERROR_ACTIVE_FREE_OVER
        public const int ERROR_ACTIVE_NOT_COMBAT = 29008; //ERROR_ACTIVE_NOT_COMBAT
        public const int ERROR_ACTIVE_NOT_PHASE = 29009; //ERROR_ACTIVE_NOT_PHASE
        public const int ERROR_FUND_HAS_BUY = 29010; //ERROR_FUND_HAS_BUY
        public const int ERROR_FUND_BUY_FIRST = 29011; //ERROR_FUND_BUY_FIRST
        public const int ERROR_FUND_HAS_GET = 29012; //ERROR_FUND_HAS_GET
        public const int ERROR_ACTIVE_NOT_ARENA = 29013; //ERROR_ACTIVE_NOT_ARENA
        public const int ERROR_ACTIVE_NOT_DUNGEON = 29014; //ERROR_ACTIVE_NOT_DUNGEON
        public const int ERROR_TOWER_NOT_OPEN = 30001; //ERROR_TOWER_NOT_OPEN
        public const int ERROR_TOWER_LAYER_NOT_OPEN = 30002; //ERROR_TOWER_LAYER_NOT_OPEN
        public const int ERROR_TOWER_LAYER_HAS_PASS = 30003; //ERROR_TOWER_LAYER_HAS_PASS
        public const int ERROR_TOWER_HERE_DEAD = 30004; //ERROR_TOWER_HERE_DEAD
        public const int ERROR_TOWER_BOX_OVER = 30005; //ERROR_TOWER_BOX_OVER
        public const int ERROR_TOWER_SKIP_OVER = 30006; //ERROR_TOWER_SKIP_OVER
        public const int ERROR_TOWER_RESET_OVER = 30007; //ERROR_TOWER_RESET_OVER
        public const int ERROR_TOWER_BEFORE_PASS = 30008; //ERROR_TOWER_BEFORE_PASS
        public const int ERROR_TOWER_SET_LIMIT = 30009; //ERROR_TOWER_SET_LIMIT
        public const int ERROR_TOWER_SKIP_TOP = 30010; //ERROR_TOWER_SKIP_TOP
        public const int ERROR_TOWER_SKIP_LIMIT = 30011; //ERROR_TOWER_SKIP_LIMIT
        public const int ERROR_TOWER_LOSE_SKIP = 30012; //ERROR_TOWER_LOSE_SKIP
        public const int ERROR_JUNGLE_NOT_OPEN = 31001; //ERROR_JUNGLE_NOT_OPEN
        public const int ERROR_JUNGLE_COPY_NOT_EXIST = 31002; //ERROR_JUNGLE_COPY_NOT_EXIST
        public const int ERROR_JUNGLE_TIMES_OVER = 31003; //ERROR_JUNGLE_TIMES_OVER
        public const int ERROR_JUNGLE_PASS_BEFORE = 31004; //ERROR_JUNGLE_PASS_BEFORE
        public const int ERROR_JUNGLE_NOT_PASS = 31005; //ERROR_JUNGLE_NOT_PASS
        public const int ERROR_ESCORT_NOT_OPEN = 32001; //ERROR_ESCORT_NOT_OPEN
        public const int ERROR_ESCORT_HAS_RENT = 32002; //ERROR_ESCORT_HAS_RENT
        public const int ERROR_ESCORT_IN_CARRY = 32003; //ERROR_ESCORT_IN_CARRY
        public const int ERROR_ESCORT_TIMES_OVER = 32004; //ERROR_ESCORT_TIMES_OVER
        public const int ERROR_ESCORT_NOT_RENT = 32005; //ERROR_ESCORT_NOT_RENT
        public const int ERROR_ESCORT_NOT_START = 32006; //ERROR_ESCORT_NOT_START
        public const int ERROR_ESCORT_HAS_END = 32007; //ERROR_ESCORT_HAS_END
        public const int ERROR_ESCORT_NOT_EXIST = 32008; //ERROR_ESCORT_NOT_EXIST
        public const int ERROR_ESCORT_ROBBED_TIMES_OVER = 32009; //ERROR_ESCORT_ROBBED_TIMES_OVER
        public const int ERROR_ESCORT_ROB_TIMES_OVER = 32010; //ERROR_ESCORT_ROB_TIMES_OVER
        public const int ERROR_ESCORT_IN_ROBBING = 32011; //ERROR_ESCORT_IN_ROBBING
        public const int ERROR_ESCORT_HAS_INVITE_FRIEND = 32012; //ERROR_ESCORT_HAS_INVITE_FRIEND
        public const int ERROR_ESCORT_HAS_GET_REWARD = 32013; //ERROR_ESCORT_HAS_GET_REWARD
        public const int ERROR_ESCORT_SAFE_CD = 32014; //ERROR_ESCORT_SAFE_CD
        public const int ERROR_ESCORT_ROB_SELF = 32015; //ERROR_ESCORT_ROB_SELF
        public const int ERROR_ESCORT_REWARD_FIRST = 32016; //ERROR_ESCORT_REWARD_FIRST
        public const int ERROR_ESCORT_SPEED_OVER = 32017; //ERROR_ESCORT_SPEED_OVER
        public const int ERROR_ESCORT_QUALITY_MAX = 32018; //ERROR_ESCORT_QUALITY_MAX
        public const int ERROR_ESCORT_BUY_MAX = 32019; //ERROR_ESCORT_BUY_MAX
        public const int ERROR_CHARM_WORSHIP_NUM_MAX = 33001; //ERROR_CHARM_WORSHIP_NUM_MAX
        public const int ERROR_CHARM_WORSHIP_NOT_YOU = 33002; //ERROR_CHARM_WORSHIP_NOT_YOU
        public const int ERROR_CHARM_WORSHIP_HAD_GET = 33003; //ERROR_CHARM_WORSHIP_HAD_GET
        public const int ERROR_CHARM_WORSHIP_DOUBLE_USED = 33004; //ERROR_CHARM_WORSHIP_DOUBLE_USED
        public const int ERROR_CHARM_WORSHIP_SELF = 33005; //ERROR_CHARM_WORSHIP_SELF
        public const int ERROR_MINE_NOT_OPEN = 34001; //ERROR_MINE_NOT_OPEN
        public const int ERROR_PEERAGE_TIMES_OVER = 35001; //ERROR_PEERAGE_TIMES_OVER
        public const int ERROR_PEERAGE_BATTLE_SELF = 35002; //ERROR_PEERAGE_BATTLE_SELF
        public const int ERROR_PEERAGE_PHASE_ERROR = 35003; //ERROR_PEERAGE_PHASE_ERROR
        public const int ERROR_PEERAGE_CHANGE = 35004; //ERROR_PEERAGE_CHANGE
        public const int ERROR_PEERAGE_HAS_BATTLE = 35005; //ERROR_PEERAGE_HAS_BATTLE
        public const int ERROR_PEERAGE_HAS_BATTLED = 35006; //ERROR_PEERAGE_HAS_BATTLED
        public const int ERROR_PEERAGE_BUY_MAX = 35007; //ERROR_PEERAGE_BUY_MAX
        public const int ERROR_PEERAGE_NO_PEERAGE = 35008; //ERROR_PEERAGE_NO_PEERAGE
        public const int ERROR_HELL_TEAM_MAX = 36001; //ERROR_HELL_TEAM_MAX
        public const int ERROR_HELL_NUM_MAX = 36002; //ERROR_HELL_NUM_MAX
        public const int ERROR_HELL_HAD_IN_TEAM = 36003; //ERROR_HELL_HAD_IN_TEAM
        public const int ERROR_HELL_CHAT_TOO_FAST = 36004; //ERROR_HELL_CHAT_TOO_FAST
        public const int ERROR_HELL_TEAM_OUT = 36005; //ERROR_HELL_TEAM_OUT
        public const int ERROR_WAR_NOT_OPEN = 37001; //ERROR_WAR_NOT_OPEN
        public const int ERROR_WAR_NOT_HERO = 37002; //ERROR_WAR_NOT_HERO
        public const int ERROR_WAR_FRIEND_NOT_ONLINE = 37003; //ERROR_WAR_FRIEND_NOT_ONLINE
        public const int ERROR_WAR_FRIEND_PLAYING = 37004; //ERROR_WAR_FRIEND_PLAYING
        public const int ERROR_WAR_TEAM_MEM_MAX = 37005; //ERROR_WAR_TEAM_MEM_MAX
        public const int ERROR_WAR_TEAM_PLAYING = 37006; //ERROR_WAR_TEAM_PLAYING
        public const int ERROR_WAR_TEAM_NOT_EXIST = 37007; //ERROR_WAR_TEAM_NOT_EXIST
        public const int ERROR_WAR_MATCH_FAIL = 37008; //ERROR_WAR_MATCH_FAIL
        public const int ERROR_WAR_HAS_MATCH = 37009; //ERROR_WAR_HAS_MATCH
        public const int ERROR_WAR_HERO_HAS_SELECT = 37010; //ERROR_WAR_HERO_HAS_SELECT
        public const int ERROR_WAR_HAS_GIVE_UP = 37011; //ERROR_WAR_HAS_GIVE_UP
        public const int ERROR_WAR_FRIEND_IN_DUNGEON = 37013; //ERROR_WAR_FRIEND_IN_DUNGEON
        public const int ERROR_WAR_FRIEND_NOT_OPEN = 37014; //ERROR_WAR_FRIEND_NOT_OPEN
        public const int ERROR_WAR_NOT_ACCEPT = 37015; //ERROR_WAR_NOT_ACCEPT
        public const int ERROR_WAR_NO_FRIEND_RANK = 37016; //ERROR_WAR_NO_FRIEND_RANK
        public const int ERROR_WAR_BOX_HAS_UNLOCK = 37017; //ERROR_WAR_BOX_HAS_UNLOCK
        public const int ERROR_WAR_BOX_HAS_GET = 37018; //ERROR_WAR_BOX_HAS_GET
        public const int ERROR_WAR_IN_CURRENT_TEAM = 37019; //ERROR_WAR_IN_CURRENT_TEAM
        public const int ERROR_WAR_BOX_UNLOCKING = 37020; //ERROR_WAR_BOX_UNLOCKING
        public const int ERROR_WAR_STTE_IN_TEAM = 37021; //ERROR_WAR_STTE_IN_TEAM
        public const int ERROR_WAR_STTE_IN_DUNGEON = 37022; //ERROR_WAR_STTE_IN_DUNGEON
        public const int ERROR_WAR_BOX_NOT_EXIST = 37023; //ERROR_WAR_BOX_NOT_EXIST
        public const int ERROR_WAR_STTE_IN_PVP = 37033; //ERROR_WAR_STTE_IN_PVP
        public const int ERROR_WAR_TEAM_FULL = 37034; //ERROR_WAR_TEAM_FULL
        public const int ERROR_ROOM_NOT_OPEN = 38001; //ERROR_ROOM_NOT_OPEN
        public const int ERROR_ROOM_NOT_LEADER = 38002; //ERROR_ROOM_NOT_LEADER
        public const int ERROR_ROOM_TEAM_FULL = 38003; //ERROR_ROOM_TEAM_FULL
        public const int ERROR_WAR_STTE_IN_ROOM = 38004; //ERROR_WAR_STTE_IN_ROOM
        public const int ERROR_ROOM_NOT_ACCEPT = 38005; //ERROR_ROOM_NOT_ACCEPT
        public const int ERROR_ROOM_IN_CURRENT_TEAM = 38006; //ERROR_ROOM_IN_CURRENT_TEAM
        public const int ERROR_ROOM_IN_PLAYING = 38007; //ERROR_ROOM_IN_PLAYING
        public const int ERROR_ROOM_NOT_EXIST = 38008; //ERROR_ROOM_NOT_EXIST
        public const int ERROR_ROOM_NOT_KICK = 38009; //ERROR_ROOM_NOT_KICK
        public const int ERROR_ROOM_GAME_START = 38010; //ERROR_ROOM_GAME_START
        public const int ERROR_ROOM_HAS_SELECT = 38011; //ERROR_ROOM_HAS_SELECT
        public const int ERROR_ROOM_HAS_GIVE_UP = 38012; //ERROR_ROOM_HAS_GIVE_UP
        public const int ERROR_ROOM_ENEMY_FIRST = 38013; //ERROR_ROOM_ENEMY_FIRST
        public const int ERROR_ROOM_MEM_FULL = 38014; //ERROR_ROOM_MEM_FULL
        public const int ERROR_HAD_HERO = 45001; //ERROR_HAD_HERO
        public const int ERROR_HERO_NOT_ENOUGH_EQUIPS = 45002; //ERROR_HERO_NOT_ENOUGH_EQUIPS
        public const int ERROR_HERO_NOT_IN_LIST = 45003; //ERROR_HERO_NOT_IN_LIST
        public const int ERROR_HERO_WEAR_EQUIP_ERROR = 45004; //ERROR_HERO_WEAR_EQUIP_ERROR
        public const int ERROR_HERO_QUALITY_EQUIP = 45005; //ERROR_HERO_QUALITY_EQUIP
        public const int ERROR_HERO_EQUIP_HAD = 45006; //ERROR_HERO_EQUIP_HAD
        public const int ERROR_MATERIAL_NOT_ENOUGH = 45007; //ERROR_MATERIAL_NOT_ENOUGH
        public const int ERROR_HERO_STAR_IS_FULL = 45008; //ERROR_HERO_STAR_IS_FULL
        public const int ERROR_HERO_LV_MAX_QU = 45009; //ERROR_HERO_LV_MAX_QU
        public const int ERROR_HERO_SRAR_NOT_ENOUGH = 45010; //ERROR_HERO_SRAR_NOT_ENOUGH
        public const int ERROR_HERO_EQUIP_QUALITY_NOT_ENOUGH = 45011; //ERROR_HERO_EQUIP_QUALITY_NOT_ENOUGH
        public const int ERROR_HERO_EQUIP_QUALITY_MAX_LEVEL = 45012; //ERROR_HERO_EQUIP_QUALITY_MAX_LEVEL
        public const int ERROR_HERO_SKILL_LV_MAX_TOP = 45013; //ERROR_HERO_SKILL_LV_MAX_TOP
        public const int ERROR_HERO_EQUIP_MAX_QUALITY = 45014; //ERROR_HERO_EQUIP_MAX_QUALITY
        public const int ERROR_HERO_EQUIP_MAX_STAR = 45015; //ERROR_HERO_EQUIP_MAX_STAR
        public const int ERROR_HERO_GENIUS_MAX_LV = 45016; //ERROR_HERO_GENIUS_MAX_LV
        public const int ERROR_HERO_MARKING_NOT_LEVEL_ENOUGH = 45017; //ERROR_HERO_MARKING_NOT_LEVEL_ENOUGH
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysGlobalValueConst
    {
        public const int FREE_HERO_1 = 1; //FREE_HERO_1
        public const int FREE_HERO_2 = 2; //FREE_HERO_2
        public const int FREE_HERO_3 = 3; //FREE_HERO_3
        public const int MARKING_SUPER_STATE = 4; //MARKING_SUPER_STATE
        public const int PLAYER_SKILL_LEVEL_USE_GOODS = 5; //PLAYER_SKILL_LEVEL_USE_GOODS
        public const int PLAYER_SKILL_LEVEL_USE_GOLD = 11; //PLAYER_SKILL_LEVEL_USE_GOLD
        public const int PLAYER_SKILL_LEVEL_ADD_POINT1 = 12; //PLAYER_SKILL_LEVEL_ADD_POINT1
        public const int PLAYER_SKILL_INIT_ID = 13; //PLAYER_SKILL_INIT_ID
        public const int PLAYER_SKILL_LEVEL_USE_GOODS_ID = 14; //PLAYER_SKILL_LEVEL_USE_GOODS_ID
        public const int PLAYER_SKILL_LEVEL_ADD_POINT2 = 15; //PLAYER_SKILL_LEVEL_ADD_POINT2
        public const int PLAYER_SKILL_LEVEL_ADD_EXP2 = 16; //PLAYER_SKILL_LEVEL_ADD_EXP2
        public const int INIT_COIN = 17; //INIT_COIN
        public const int INIT_GOLD = 18; //INIT_GOLD
        public const int INIT_PLAYER_X = 19; //INIT_PLAYER_X
        public const int INIT_PLAYER_Y = 20; //INIT_PLAYER_Y
        public const int INIT_PLAYER_Z = 21; //INIT_PLAYER_Z
        public const int MAX_PLAYER_LEVEL = 22; //MAX_PLAYER_LEVEL
        public const int CLIENT_USE_1 = 23; //CLIENT_USE_1
        public const int CLIENT_USE_2 = 24; //CLIENT_USE_2
        public const int CLIENT_USE_3 = 25; //CLIENT_USE_3
        public const int CLIENT_USE_4 = 26; //CLIENT_USE_4
        public const int CLIENT_USE_EXP_1 = 27; //CLIENT_USE_EXP_1
        public const int CLIENT_USE_EXP_2 = 28; //CLIENT_USE_EXP_2
        public const int CLIENT_USE_EXP_3 = 29; //CLIENT_USE_EXP_3
        public const int CLIENT_USE_EXP_4 = 30; //CLIENT_USE_EXP_4
        public const int CLIENT_USE_EXP_5 = 31; //CLIENT_USE_EXP_5
        public const int CLIENT_USE_EXP_6 = 32; //CLIENT_USE_EXP_6
        public const int INIT_ENERGY = 33; //INIT_ENERGY
        public const int HERO_ATTR_QUAL_PARAM = 34; //HERO_ATTR_QUAL_PARAM
        public const int HERO_MAX_QUALITY = 35; //HERO_MAX_QUALITY
        public const int GENIUS_MAX_LV = 36; //GENIUS_MAX_LV
        public const int GENIUS_STAR_LV_2 = 37; //GENIUS_STAR_LV_2
        public const int GENIUS_STAR_LV_3 = 38; //GENIUS_STAR_LV_3
        public const int GENIUS_STAR_LV_4 = 39; //GENIUS_STAR_LV_4
        public const int GENIUS_STAR_LV_5 = 40; //GENIUS_STAR_LV_5
        public const int GENIUS_STAR_LV_6 = 41; //GENIUS_STAR_LV_6
        public const int MALL_SHOW_MAX = 42; //MALL_SHOW_MAX
        public const int MALL_REFRESH_TOTAL_TIMES = 43; //MALL_REFRESH_TOTAL_TIMES
        public const int MARKING_FAIL = 44; //MARKING_FAIL
        public const int MARKING_COIN = 45; //MARKING_COIN
        public const int MARKING_EXP = 46; //MARKING_EXP
        public const int MARKING_FREE_STATE = 47; //MARKING_FREE_STATE
        public const int MAX_MARKING_LEVEL = 48; //MAX_MARKING_LEVEL
        public const int MARKING_USE_COIN_1 = 49; //MARKING_USE_COIN_1
        public const int MARKING_USE_COIN_10 = 50; //MARKING_USE_COIN_10
        public const int MARKING_USE_GOLD_1 = 51; //MARKING_USE_GOLD_1
        public const int MARKING_USE_GOLD_10 = 52; //MARKING_USE_GOLD_10
        public const int MARKING_USE_FREE = 53; //MARKING_USE_FREE
        public const int MARKING_FIRST_GET = 54; //MARKING_FIRST_GET
        public const int MARKING_FIRST_POS = 55; //MARKING_FIRST_POS
        public const int LOTTER_TOTAL_TIMES = 56; //LOTTER_TOTAL_TIMES
        public const int GUIDE_DRAW_LOTTERY = 57; //GUIDE_DRAW_LOTTERY
        public const int GUIDE_HERO_COIN = 58; //GUIDE_HERO_COIN
        public const int GUIDE_HERO_GOLD = 59; //GUIDE_HERO_GOLD
        public const int DRAW_COIN_CD = 60; //DRAW_COIN_CD
        public const int DRAW_COIN_LONG_CD = 61; //DRAW_COIN_LONG_CD
        public const int DRAW_GOLD_CD = 62; //DRAW_GOLD_CD
        public const int DRAW_COIN_FREE_TIMES = 63; //DRAW_COIN_FREE_TIMES
        public const int DRAW_COIN_COST = 64; //DRAW_COIN_COST
        public const int DRAW_COIN_COST2 = 65; //DRAW_COIN_COST2
        public const int DRAW_GOLD_COST = 66; //DRAW_GOLD_COST
        public const int DRAW_GOLD_COST2 = 67; //DRAW_GOLD_COST2
        public const int UNION_NEED_COIN = 68; //UNION_NEED_COIN
        public const int UNION_NEED_GOLD = 69; //UNION_NEED_GOLD
        public const int ARENA_OPEN_DUNGEON = 70; //ARENA_OPEN_DUNGEON
        public const int TOWER_OPEN_DUNGEON = 71; //TOWER_OPEN_DUNGEON
        public const int JUNGLE_OPEN_DUNGEON = 72; //JUNGLE_OPEN_DUNGEON
        public const int ESCORT_OPEN_DUNGEON = 73; //ESCORT_OPEN_DUNGEON
        public const int MINE_OPEN_DUNGEON = 74; //MINE_OPEN_DUNGEON
        public const int MELEE_SINGLE_OPEN = 75; //MELEE_SINGLE_OPEN
        public const int MELEE_DOUBLE_OPEN = 76; //MELEE_DOUBLE_OPEN
        public const int WAR_OPEN_LV = 77; //WAR_OPEN_LV
        public const int PEERAGE_OPEN_DUNGEON = 78; //PEERAGE_OPEN_DUNGEON
        public const int MARS_OPEN_DUNGEON = 79; //MARS_OPEN_DUNGEON
        public const int GENIUS_STAR = 80; //GENIUS_STAR
        public const int DEED_STAR = 81; //DEED_STAR
        public const int DUNGEON_OPEN_LV = 82; //DUNGEON_OPEN_LV
        public const int ROOM_OPEN = 83; //ROOM_OPEN
        public const int TOWER_TOP_LAYER = 84; //TOWER_TOP_LAYER
        public const int TOWER_BOX_TIMES = 85; //TOWER_BOX_TIMES
        public const int TOWER_RESET = 86; //TOWER_RESET
        public const int JUNGLE_EXP_TIMES = 87; //JUNGLE_EXP_TIMES
        public const int JUNGLE_COIN_TIMES = 88; //JUNGLE_COIN_TIMES
        public const int CHARM_WORSHIP_DOUBLE_USE_GOLD = 89; //CHARM_WORSHIP_DOUBLE_USE_GOLD
        public const int CHARM_WORSHIP_MAX_NUM = 90; //CHARM_WORSHIP_MAX_NUM
        public const int CHARM_WORSHIP_MAX_DOUBLE_NUM = 91; //CHARM_WORSHIP_MAX_DOUBLE_NUM
        public const int CHARM_ROSE_ID = 92; //CHARM_ROSE_ID
        public const int FRIEND_NUM_MAX = 93; //FRIEND_NUM_MAX
        public const int BLACK_NUM_MAX = 94; //BLACK_NUM_MAX
        public const int FRIEND_APPLY_MAX = 95; //FRIEND_APPLY_MAX
        public const int FRIEND_LOOKFOR_MAX = 96; //FRIEND_LOOKFOR_MAX
        public const int CHAT_TIMES_LIMIT = 97; //CHAT_TIMES_LIMIT
        public const int CHAT_BROADCAST_COST = 98; //CHAT_BROADCAST_COST
        public const int CHAT_OPEN_LV = 99; //CHAT_OPEN_LV
        public const int CHAT_LOGIN_NUM = 100; //CHAT_LOGIN_NUM
        public const int CHAT_MESSAGE_LIMIT = 101; //CHAT_MESSAGE_LIMIT
        public const int PEERAGE_FREE_TIMES = 102; //PEERAGE_FREE_TIMES
        public const int PEERAGE_SHOW_NUM = 103; //PEERAGE_SHOW_NUM
        public const int PEERAGE_BROADCAST = 104; //PEERAGE_BROADCAST
        public const int PEERAGE_MAX_COIN = 105; //PEERAGE_MAX_COIN
        public const int PEERAGE_OPEN_LV = 106; //PEERAGE_OPEN_LV
        public const int PEERAGE_TALK_PRE = 107; //PEERAGE_TALK_PRE
        public const int SHENGMING_HUIFU = 108; //SHENGMING_HUIFU
        public const int PVP_ROUND_NUM = 109; //PVP_ROUND_NUM
        public const int MELEE_HOLDING_TIME = 110; //MELEE_HOLDING_TIME
        public const int PVP_JXCS = 111; //PVP_JXCS
        public const int PVP_COMBAT_BUFF = 112; //PVP_COMBAT_BUFF
        public const int PVP_TP_TIME = 113; //PVP_TP_TIME
        public const int PVP_LV = 114; //PVP_LV
        public const int PVP_COMBAT_PLUS = 115; //PVP_COMBAT_PLUS
        public const int PVP_STAR_PLUS = 116; //PVP_STAR_PLUS
        public const int MELEE_PRE_TIMES = 117; //MELEE_PRE_TIMES
        public const int ACTIVE_GROW_FUND_COST = 118; //ACTIVE_GROW_FUND_COST
        public const int ARENA_WIN_COIN = 119; //ARENA_WIN_COIN
        public const int ARENA_LOSE_COIN = 120; //ARENA_LOSE_COIN
        public const int PVE_COMBAT_PLUS = 121; //PVE_COMBAT_PLUS
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysGuideConst
    {
        public const int GUIDE_ID_TUTORIAL = 301; //"对战教学"
        public const int GUIDE_ID_NEWBEE = 1; //"初副本指引"
        public const int GUIDE_ID_TASK = 2; //"强制任务"
        public const int GUIDE_ID_DUNGEON_HERO = 3; //"副本切换英雄"
        public const int GUIDE_ID_ACTIVE_HERO = 5; //"英雄激活"
        public const int GUIDE_ID_PVP = 7; //"实时对战"
        public const int GUIDE_ID_MATCH_BOX_OPEN = 8; //"解锁匹配宝箱"
        public const int GUIDE_ID_DUNGEON_OPERATE = 9; //"副本操作英雄"
        public const int GUIDE_ID_DoubleWay = 10; //"匹配三路"
        public const int GUIDE_ID_ACTIVITY = 11; //"活动"
        public const int GUIDE_ID_EQUIP = 12; //"装备升级"
        public const int GUIDE_ID_ELITE = 101; //"精英副本"
        public const int GUIDE_ID_ARENA = 102; //"竞技场"
        public const int GUIDE_ID_UP_QUALITY = 103; //"英雄进阶"
        public const int GUIDE_ID_STAR = 104; //"英雄升星"
        public const int GUIDE_ID_TITLE = 112; //"称号"
        public const int GUIDE_ID_PEERAGE = 113; //"王城争霸"
        public const int GUIDE_ID_JUNGLE = 114; //"丛林追击"
        public const int GUIDE_ID_HELL = 115; //"血色地狱"
        public const int GUIDE_ID_TRAIN = 116; //"英雄试炼"
        public const int GUIDE_ID_ESCORT = 117; //"征服之海"
        public const int GUIDE_ID_LEAGUE = 118; //"联盟"
        public const int GUIDE_ID_EQUIP_CASTSOUL = 119; //"装备铸魂"
        public const int GUIDE_ID_STAMP = 120; //"印记/装备印记"
        public const int GUIDE_ID_TALENT = 121; //"英雄天赋"
        public const int GUIDE_ID_SWEEP = 122; //"副本扫荡"
        public const int GUIDE_ID_EXP_GOODS = 123; //"使用经验药水"
        public const int GUIDE_ID_MELEE = 201; //"单路大乱斗"
        public const int GUIDE_ID_JUNGLE_SKILL = 202; //"丛林追击捕兽夹"
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysManualConst
    {
        public const int HELL = 1; //HELL
        public const int WCZB = 2; //WCZB
        public const int LEAGUE = 3; //LEAGUE
        public const int JUNGLE = 4; //JUNGLE
        public const int MELEE = 5; //MELEE
        public const int TRAIN = 6; //TRAIN
        public const int ZHANLIBANG = 8; //ZHANLIBANG
        public const int SHOUJIBANG = 9; //SHOUJIBANG
        public const int CHUANGGUANBANG = 10; //CHUANGGUANBANG
        public const int JUEWEIBANG = 11; //JUEWEIBANG
        public const int DUANWEIBANG = 12; //DUANWEIBANG
        public const int JINGJIBANG = 13; //JINGJIBANG
        public const int MEILIBANG = 14; //MEILIBANG
        public const int LIANMENGBANG = 15; //LIANMENGBANG
        public const int ZHENGFUZHIHAI = 16; //ZHENGFUZHIHAI
        public const int SHANGGUSHENGQI = 17; //SHANGGUSHENGQI
        public const int JINGJICHANG = 18; //JINGJICHANG
        public const int YINJI = 20; //YINJI
        public const int YINJI_MAOPAO1 = 21; //YINJI_MAOPAO1
        public const int YINJI_MAOPAO2 = 22; //YINJI_MAOPAO2
        public const int YINJI_MAOPAO3 = 23; //YINJI_MAOPAO3
        public const int TRAIN_SKIP = 19; //TRAIN_SKIP
        public const int TRAIN_DONE_SKIP = 24; //TRAIN_DONE_SKIP
        public const int TRAIN_NO_SKIP = 25; //TRAIN_NO_SKIP
        public const int ATHLETICS = 26; //ATHLETICS
        public const int PVP = 27; //PVP
        public const int BLOOD = 28; //BLOOD
        public const int ROOM = 29; //ROOM
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysSceneConst
    {
        public const int RELOGIN = 0; //RELOGIN
        public const int LOGIN = 1; //LOGIN
        public const int GAME = 2; //GAME
        public const int MELEE = 3; //MELEE
        public const int ARENA = 4; //ARENA
        public const int DUNGRON = 5; //DUNGRON
        public const int TUTORIAL = 200500; //TUTORIAL
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class SysSoundConst
    {
        public const int S_LOGIN_BGM = 1001; //S_LOGIN_BGM
        public const int S_MAIN_BGM = 1002; //S_MAIN_BGM
        public const int S_DUNGEON_BGM1 = 1003; //S_DUNGEON_BGM1
        public const int S_DUNGEON_BGM2 = 1004; //S_DUNGEON_BGM2
        public const int S_FIGHTING_BGM1 = 1005; //S_FIGHTING_BGM1
        public const int S_FIGHTING_BGM2 = 1006; //S_FIGHTING_BGM2
        public const int S_FIGHTING_WIN = 1007; //S_FIGHTING_WIN
        public const int S_FIGHTING_LOSE = 1008; //S_FIGHTING_LOSE
        public const int S_LOADING_BGM = 1009; //S_LOADING_BGM
        public const int S_HERO_CCL_BATTLE1 = 2001; //S_HERO_CCL_BATTLE1
        public const int S_HERO_CCL_BATTLE2 = 2002; //S_HERO_CCL_BATTLE2
        public const int S_HERO_CCL_DIE = 2003; //S_HERO_CCL_DIE
        public const int S_HERO_BG_BATTLE1 = 2004; //S_HERO_BG_BATTLE1
        public const int S_HERO_BG_BATTLE2 = 2005; //S_HERO_BG_BATTLE2
        public const int S_HERO_BG_DIE = 2006; //S_HERO_BG_DIE
        public const int S_HERO_GH_BATTLE1 = 2007; //S_HERO_GH_BATTLE1
        public const int S_HERO_GH_BATTLE2 = 2008; //S_HERO_GH_BATTLE2
        public const int S_HERO_GH_DIE = 2009; //S_HERO_GH_DIE
        public const int S_HERO_STR_BATTLE1 = 2010; //S_HERO_STR_BATTLE1
        public const int S_HERO_STR_BATTLE2 = 2011; //S_HERO_STR_BATTLE2
        public const int S_HERO_STR_DIE = 2012; //S_HERO_STR_DIE
        public const int S_HERO_DHZ_BATTLE1 = 2013; //S_HERO_DHZ_BATTLE1
        public const int S_HERO_DHZ_BATTLE2 = 2014; //S_HERO_DHZ_BATTLE2
        public const int S_HERO_DHZ_DIE = 2015; //S_HERO_DHZ_DIE
        public const int S_HERO_ZSG_BATTLE1 = 2016; //S_HERO_ZSG_BATTLE1
        public const int S_HERO_ZSG_BATTLE2 = 2017; //S_HERO_ZSG_BATTLE2
        public const int S_HERO_ZSG_DIE = 2018; //S_HERO_ZSG_DIE
        public const int S_HERO_HZ_BATTLE1 = 2019; //S_HERO_HZ_BATTLE1
        public const int S_HERO_HZ_BATTLE2 = 2020; //S_HERO_HZ_BATTLE2
        public const int S_HERO_HZ_DIE = 2021; //S_HERO_HZ_DIE
        public const int S_HERO_SWK_BATTLE1 = 2022; //S_HERO_SWK_BATTLE1
        public const int S_HERO_SWK_BATTLE2 = 2023; //S_HERO_SWK_BATTLE2
        public const int S_HERO_SWK_DIE = 2024; //S_HERO_SWK_DIE
        public const int S_HERO_FN_BATTLE1 = 2025; //S_HERO_FN_BATTLE1
        public const int S_HERO_FN_BATTLE2 = 2026; //S_HERO_FN_BATTLE2
        public const int S_HERO_FN_DIE = 2027; //S_HERO_FN_DIE
        public const int S_HERO_JS_BATTLE1 = 2028; //S_HERO_JS_BATTLE1
        public const int S_HERO_JS_BATTLE2 = 2029; //S_HERO_JS_BATTLE2
        public const int S_HERO_JS_DIE = 2030; //S_HERO_JS_DIE
        public const int S_HERO_NTR_BATTLE1 = 2031; //S_HERO_NTR_BATTLE1
        public const int S_HERO_NTR_BATTLE2 = 2032; //S_HERO_NTR_BATTLE2
        public const int S_HERO_NTR_DIE = 2033; //S_HERO_NTR_DIE
        public const int S_HERO_XP_BATTLE1 = 2034; //S_HERO_XP_BATTLE1
        public const int S_HERO_XP_BATTLE2 = 2035; //S_HERO_XP_BATTLE2
        public const int S_HERO_XP_DIE = 2036; //S_HERO_XP_DIE
        public const int S_HERO_HN_BATTLE1 = 2037; //S_HERO_HN_BATTLE1
        public const int S_HERO_HN_BATTLE2 = 2038; //S_HERO_HN_BATTLE2
        public const int S_HERO_HN_DIE = 2039; //S_HERO_HN_DIE
        public const int S_HERO_NQ_BATTLE1 = 2040; //S_HERO_NQ_BATTLE1
        public const int S_HERO_NQ_BATTLE2 = 2041; //S_HERO_NQ_BATTLE2
        public const int S_HERO_NQ_DIE = 2042; //S_HERO_NQ_DIE
        public const int S_HERO_LL_BATTLE1 = 2043; //S_HERO_LL_BATTLE1
        public const int S_HERO_LL_BATTLE2 = 2044; //S_HERO_LL_BATTLE2
        public const int S_HERO_LL_DIE = 2045; //S_HERO_LL_DIE
        public const int S_HERO_XM_BATTLE1 = 2046; //S_HERO_XM_BATTLE1
        public const int S_HERO_XM_BATTLE2 = 2047; //S_HERO_XM_BATTLE2
        public const int S_HERO_XM_DIE = 2048; //S_HERO_XM_DIE
        public const int S_HERO_KT_BATTLE1 = 2049; //S_HERO_KT_BATTLE1
        public const int S_HERO_KT_BATTLE2 = 2050; //S_HERO_KT_BATTLE2
        public const int S_HERO_KT_DIE = 2051; //S_HERO_KT_DIE
        public const int S_HERO_TXJ_BATTLE1 = 2052; //S_HERO_TXJ_BATTLE1
        public const int S_HERO_TXJ_BATTLE2 = 2053; //S_HERO_TXJ_BATTLE2
        public const int S_HERO_TXJ_DIE = 2054; //S_HERO_TXJ_DIE
        public const int S_HERO_CZ_BATTLE1 = 2055; //S_HERO_CZ_BATTLE1
        public const int S_HERO_CZ_BATTLE2 = 2056; //S_HERO_CZ_BATTLE2
        public const int S_HERO_CZ_DIE = 2057; //S_HERO_CZ_DIE
        public const int S_HERO_ZDR_BATTLE1 = 2058; //S_HERO_ZDR_BATTLE1
        public const int S_HERO_ZDR_BATTLE2 = 2059; //S_HERO_ZDR_BATTLE2
        public const int S_HERO_ZDR_DIE = 2060; //S_HERO_ZDR_DIE
        public const int S_HERO_MM_BATTLE1 = 2061; //S_HERO_MM_BATTLE1
        public const int S_HERO_MM_BATTLE2 = 2062; //S_HERO_MM_BATTLE2
        public const int S_HERO_MM_DIE = 2063; //S_HERO_MM_DIE
        public const int S_HERO_SG_BATTLE1 = 2064; //S_HERO_SG_BATTLE1
        public const int S_HERO_SG_BATTLE2 = 2065; //S_HERO_SG_BATTLE2
        public const int S_HERO_SG_DIE = 2066; //S_HERO_SG_DIE
        public const int S_HERO_JT_BATTLE1 = 2067; //S_HERO_JT_BATTLE1
        public const int S_HERO_JT_BATTLE2 = 2068; //S_HERO_JT_BATTLE2
        public const int S_HERO_JT_DIE = 2069; //S_HERO_JT_DIE
        public const int S_HERO_NJ_BATTLE1 = 2070; //S_HERO_NJ_BATTLE1
        public const int S_HERO_NJ_BATTLE2 = 2071; //S_HERO_NJ_BATTLE2
        public const int S_HERO_NJ_DIE = 2072; //S_HERO_NJ_DIE
        public const int S_HERO_QN_BATTLE1 = 2073; //S_HERO_QN_BATTLE1
        public const int S_HERO_QN_BATTLE2 = 2074; //S_HERO_QN_BATTLE2
        public const int S_HERO_QN_DIE = 2075; //S_HERO_QN_DIE
        public const int S_HERO_DF_BATTLE1 = 2076; //S_HERO_DF_BATTLE1
        public const int S_HERO_DF_BATTLE2 = 2077; //S_HERO_DF_BATTLE2
        public const int S_HERO_DF_DIE = 2078; //S_HERO_DF_DIE
        public const int S_HERO_WE_BATTLE1 = 2079; //S_HERO_WE_BATTLE1
        public const int S_HERO_WE_BATTLE2 = 2080; //S_HERO_WE_BATTLE2
        public const int S_HERO_WE_DIE = 2081; //S_HERO_WE_DIE
        public const int S_HERO_MW_BATTLE1 = 2082; //S_HERO_MW_BATTLE1
        public const int S_HERO_MW_BATTLE2 = 2083; //S_HERO_MW_BATTLE2
        public const int S_HERO_MW_DIE = 2084; //S_HERO_MW_DIE
        public const int S_HERO_MRY_BATTLE1 = 2085; //S_HERO_MRY_BATTLE1
        public const int S_HERO_MRY_BATTLE2 = 2086; //S_HERO_MRY_BATTLE2
        public const int S_HERO_MRY_DIE = 2087; //S_HERO_MRY_DIE
        public const int S_HERO_AKL_BATTLE1 = 2088; //S_HERO_AKL_BATTLE1
        public const int S_HERO_AKL_BATTLE2 = 2089; //S_HERO_AKL_BATTLE2
        public const int S_HERO_AKL_DIE = 2090; //S_HERO_AKL_DIE
        public const int S_NPC_001 = 2091; //S_NPC_001
        public const int S_NPC_002 = 2092; //S_NPC_002
        public const int S_NPC_003 = 2093; //S_NPC_003
        public const int S_NPC_004 = 2094; //S_NPC_004
        public const int S_NPC_005 = 2095; //S_NPC_005
        public const int S_NPC_006 = 2096; //S_NPC_006
        public const int S_NPC_007 = 2097; //S_NPC_007
        public const int S_SYS_DESTROY_ENEMY_TOWER = 3001; //S_SYS_DESTROY_ENEMY_TOWER
        public const int S_SYS_DESTROY_OUR_TOWER = 3002; //S_SYS_DESTROY_OUR_TOWER
        public const int S_SYS_DESTROY_ENEMY_CRYSTAL = 3003; //S_SYS_DESTROY_ENEMY_CRYSTAL
        public const int S_SYS_DESTROY_OUR_CRYSTAL = 3004; //S_SYS_DESTROY_OUR_CRYSTAL
        public const int S_SYS_DOUBLE_KILL = 3005; //S_SYS_DOUBLE_KILL
        public const int S_SYS_TRIBLE_KILL = 3006; //S_SYS_TRIBLE_KILL
        public const int S_SYS_LEGENDARY = 3007; //S_SYS_LEGENDARY
        public const int S_SYS_DESTROY_ENEMY_HERO = 3008; //S_SYS_DESTROY_ENEMY_HERO
        public const int S_SYS_DESTROY_OUR_HERO = 3009; //S_SYS_DESTROY_OUR_HERO
        public const int S_SYS_WELCOME1 = 3010; //S_SYS_WELCOME1
        public const int S_SYS_TOWER_EXPLODE = 3011; //S_SYS_TOWER_EXPLODE
        public const int S_SYS_CRYSTAL_EXPLODE = 3012; //S_SYS_CRYSTAL_EXPLODE
        public const int S_SYS_XT_013 = 3013; //S_SYS_XT_013
        public const int S_SYS_XT_014 = 3014; //S_SYS_XT_014
        public const int S_SYS_XT_015 = 3015; //S_SYS_XT_015
        public const int S_SYS_XT_018 = 3018; //S_SYS_XT_018
        public const int S_SYS_XT_019 = 3019; //S_SYS_XT_019
        public const int S_SYS_XT_020 = 3020; //S_SYS_XT_020
        public const int S_SYS_XT_021 = 3021; //S_SYS_XT_021
        public const int S_SYS_XT_022 = 3022; //S_SYS_XT_022
        public const int S_SYS_XT_023 = 3023; //S_SYS_XT_023
        public const int S_SYS_XT_024 = 3024; //S_SYS_XT_024
        public const int S_SYS_XT_025 = 3025; //S_SYS_XT_025
        public const int S_SYS_XT_026 = 3026; //S_SYS_XT_026
        public const int S_SYS_WELCOME2 = 3027; //S_SYS_WELCOME2
        public const int S_XF_01 = 3028; //S_XF_01
        public const int S_XF_02 = 3029; //S_XF_02
        public const int S_XF_03 = 3030; //S_XF_03
        public const int S_XF_04 = 3031; //S_XF_04
        public const int S_XF_05 = 3032; //S_XF_05
        public const int S_XF_06 = 3033; //S_XF_06
        public const int S_XF_07 = 3034; //S_XF_07
        public const int S_XF_08 = 3035; //S_XF_08
        public const int S_XF_09 = 3036; //S_XF_09
        public const int S_XY_010 = 3037; //S_XY_010
        public const int S_XY_011 = 3038; //S_XY_011
        public const int S_XY_012 = 3039; //S_XY_012
        public const int S_XY_013 = 3040; //S_XY_013
        public const int S_XY_014 = 3041; //S_XY_014
        public const int S_XY_015 = 3042; //S_XY_015
        public const int S_XY_016 = 3043; //S_XY_016
        public const int S_XY_017 = 3044; //S_XY_017
        public const int S_XY_018 = 3045; //S_XY_018
        public const int S_XY_404 = 3046; //S_XY_404
        public const int S_XY_405 = 3047; //S_XY_405
        public const int S_XY_020 = 3048; //S_XY_020
        public const int S_XY_021 = 3049; //S_XY_021
        public const int S_XY_022 = 3050; //S_XY_022
        public const int S_XY_023 = 3051; //S_XY_023
        public const int S_XY_024 = 3052; //S_XY_024
        public const int S_XY_025 = 3053; //S_XY_025
        public const int S_XY_026 = 3054; //S_XY_026
        public const int S_XY_027 = 3055; //S_XY_027
        public const int S_XY_028 = 3056; //S_XY_028
        public const int S_XY_029 = 3057; //S_XY_029
        public const int S_XY_030 = 3058; //S_XY_030
        public const int S_XY_031 = 3059; //S_XY_031
        public const int S_XY_032 = 3060; //S_XY_032
        public const int S_XY_033 = 3061; //S_XY_033
        public const int S_XY_034 = 3062; //S_XY_034
        public const int S_XY_035 = 3063; //S_XY_035
        public const int S_XY_036 = 3064; //S_XY_036
        public const int S_XY_037 = 3065; //S_XY_037
        public const int S_XY_038 = 3066; //S_XY_038
        public const int S_XY_039 = 3067; //S_XY_039
        public const int S_XY_040 = 3068; //S_XY_040
        public const int S_XY_041 = 3069; //S_XY_041
        public const int S_XY_042 = 3070; //S_XY_042
        public const int S_XY_043 = 3071; //S_XY_043
        public const int S_XY_044 = 3072; //S_XY_044
        public const int S_XY_045 = 3073; //S_XY_045
        public const int S_XY_046 = 3074; //S_XY_046
        public const int S_XY_047 = 3075; //S_XY_047
        public const int S_XY_048 = 3076; //S_XY_048
        public const int S_XY_049 = 3077; //S_XY_049
        public const int S_XY_050 = 3078; //S_XY_050
        public const int S_XY_051 = 3079; //S_XY_051
        public const int S_XY_052 = 3080; //S_XY_052
        public const int S_XY_053 = 3081; //S_XY_053
        public const int S_XY_054 = 3082; //S_XY_054
        public const int S_XY_055 = 3083; //S_XY_055
        public const int S_XY_056 = 3084; //S_XY_056
        public const int S_XY_057 = 3085; //S_XY_057
        public const int S_XY_058 = 3086; //S_XY_058
        public const int S_XY_059 = 3087; //S_XY_059
        public const int S_XY_060 = 3088; //S_XY_060
        public const int S_XY_061 = 3089; //S_XY_061
        public const int S_XY_062 = 3090; //S_XY_062
        public const int S_XY_063 = 3091; //S_XY_063
        public const int S_XY_064 = 3092; //S_XY_064
        public const int S_XY_065 = 3093; //S_XY_065
        public const int S_XY_066 = 3094; //S_XY_066
        public const int S_XY_067 = 3095; //S_XY_067
        public const int S_UI_SYSBUTTON = 4001; //S_UI_SYSBUTTON
        public const int S_UI_CLOSE_VIEW = 4002; //S_UI_CLOSE_VIEW
        public const int S_UI_OKBUTTON_BGM = 4003; //S_UI_OKBUTTON_BGM
        public const int S_UI_WARNING_BTN = 4004; //S_UI_WARNING_BTN
        public const int S_UI_SELECT_HERO = 4005; //S_UI_SELECT_HERO
        public const int S_UI_OPEN_VIEW = 4006; //S_UI_OPEN_VIEW
        public const int S_UI_UPGRADE = 4007; //S_UI_UPGRADE
        public const int S_UI_ACTIVE_SKILL = 4008; //S_UI_ACTIVE_SKILL
        public const int S_UI_UPSTAR = 4009; //S_UI_UPSTAR
        public const int S_UI_EXP_ADD = 4010; //S_UI_EXP_ADD
        public const int S_UI_UPSTAGE = 4011; //S_UI_UPSTAGE
        public const int S_UI_EQUIP_COMPOSE = 4012; //S_UI_EQUIP_COMPOSE
        public const int S_UI_EQUIP_WEAR = 4013; //S_UI_EQUIP_WEAR
        public const int S_UI_STAMP_SKILL = 4014; //S_UI_STAMP_SKILL
        public const int S_UI_STAMP_CHANGE = 4015; //S_UI_STAMP_CHANGE
        public const int S_UI_STAMP_MAKE = 4016; //S_UI_STAMP_MAKE
        public const int S_UI_STAMP_SELECT = 4017; //S_UI_STAMP_SELECT
        public const int S_UI_STAMP_SELL = 4018; //S_UI_STAMP_SELL
        public const int S_UI_STAMP_COMPOSE = 4019; //S_UI_STAMP_COMPOSE
        public const int S_UI_STAMP_INLAY = 4020; //S_UI_STAMP_INLAY
        public const int S_UI_STAMP_UNLOAD = 4021; //S_UI_STAMP_UNLOAD
        public const int S_UI_DRAW_GET_ITEM = 4022; //S_UI_DRAW_GET_ITEM
        public const int S_UI_OPEN_MATCH_VIEW = 4023; //S_UI_OPEN_MATCH_VIEW
        public const int S_UI_HERO_CARD_HE = 4024; //S_UI_HERO_CARD_HE
        public const int S_UI_SECOND_BEATING = 4025; //S_UI_SECOND_BEATING
        public const int S_UI_MATCH_HERO_CHANGE = 4026; //S_UI_MATCH_HERO_CHANGE
        public const int S_COMBAT_TOWER_BE_ATTACK = 4027; //S_COMBAT_TOWER_BE_ATTACK
        public const int S_COMBAT_TOWER_BE_DESTROY = 4028; //S_COMBAT_TOWER_BE_DESTROY
        public const int S_COMBAT_BASE_BE_DESTROY = 4029; //S_COMBAT_BASE_BE_DESTROY
        public const int S_COMBAT_GET_BUFF = 4030; //S_COMBAT_GET_BUFF
        public const int S_AD_TOWER_BE_DESTROY = 4031; //S_AD_TOWER_BE_DESTROY
        public const int S_UI_HERO_CARD_SHE = 4032; //S_UI_HERO_CARD_SHE
        public const int S_UI_HERO_CARD_FLY = 4033; //S_UI_HERO_CARD_FLY
        public const int S_UI_HERO_CARD_DF = 4034; //S_UI_HERO_CARD_DF
        public const int S_UI_HERO_CARD_BALANCE = 4035; //S_UI_HERO_CARD_BALANCE
        public const int S_UI_DRAW_GET_ITEM_0 = 4036; //S_UI_DRAW_GET_ITEM_0
        public const int S_UI_MARKING_ON = 4037; //S_UI_MARKING_ON
        public const int S_UI_MARKING_DEVOUR = 4038; //S_UI_MARKING_DEVOUR
        public const int S_SKILL_CCL_E_A = 5012; //S_SKILL_CCL_E_A
        public const int S_SKILL_CCL_Q_A = 5013; //S_SKILL_CCL_Q_A
        public const int S_SKILL_CCL_W_B = 5014; //S_SKILL_CCL_W_B
        public const int S_SKILL_JN_010 = 5017; //S_SKILL_JN_010
        public const int S_SKILL_JN_011 = 5018; //S_SKILL_JN_011
        public const int S_SKILL_JN_012 = 5019; //S_SKILL_JN_012
        public const int S_SKILL_JN_014 = 5020; //S_SKILL_JN_014
        public const int S_SKILL_JN_015 = 5021; //S_SKILL_JN_015
        public const int S_SKILL_JN_018 = 5023; //S_SKILL_JN_018
        public const int S_SKILL_JN_019 = 5024; //S_SKILL_JN_019
        public const int S_SKILL_JN_020 = 5025; //S_SKILL_JN_020
        public const int S_SKILL_JN_022 = 5026; //S_SKILL_JN_022
        public const int S_SKILL_JN_023 = 5027; //S_SKILL_JN_023
        public const int S_SKILL_JN_026 = 5029; //S_SKILL_JN_026
        public const int S_SKILL_JN_027 = 5030; //S_SKILL_JN_027
        public const int S_SKILL_JN_028 = 5031; //S_SKILL_JN_028
        public const int S_SKILL_JN_030 = 5032; //S_SKILL_JN_030
        public const int S_SKILL_JN_031 = 5033; //S_SKILL_JN_031
        public const int S_SKILL_JN_032 = 5034; //S_SKILL_JN_032
        public const int S_SKILL_JN_034 = 5035; //S_SKILL_JN_034
        public const int S_SKILL_JN_035 = 5036; //S_SKILL_JN_035
        public const int S_SKILL_JN_036 = 5037; //S_SKILL_JN_036
        public const int S_SKILL_JN_038 = 5038; //S_SKILL_JN_038
        public const int S_SKILL_JN_039 = 5039; //S_SKILL_JN_039
        public const int S_SKILL_JN_040 = 5040; //S_SKILL_JN_040
        public const int S_SKILL_JN_042 = 5041; //S_SKILL_JN_042
        public const int S_SKILL_JN_044 = 5043; //S_SKILL_JN_044
        public const int S_SKILL_JN_046 = 5044; //S_SKILL_JN_046
        public const int S_SKILL_JN_047 = 5045; //S_SKILL_JN_047
        public const int S_SKILL_JN_048 = 5046; //S_SKILL_JN_048
        public const int S_SKILL_JN_050 = 5047; //S_SKILL_JN_050
        public const int S_SKILL_JN_052 = 5049; //S_SKILL_JN_052
        public const int S_SKILL_JN_054 = 5050; //S_SKILL_JN_054
        public const int S_SKILL_JN_055 = 5051; //S_SKILL_JN_055
        public const int S_SKILL_JN_058 = 5053; //S_SKILL_JN_058
        public const int S_SKILL_JN_059 = 5054; //S_SKILL_JN_059
        public const int S_SKILL_JN_060 = 5055; //S_SKILL_JN_060
        public const int S_SKILL_JN_062 = 5056; //S_SKILL_JN_062
        public const int S_SKILL_JN_063 = 5057; //S_SKILL_JN_063
        public const int S_SKILL_JN_065 = 5058; //S_SKILL_JN_065
        public const int S_SKILL_JN_066 = 5059; //S_SKILL_JN_066
        public const int S_SKILL_JN_067 = 5060; //S_SKILL_JN_067
        public const int S_SKILL_JN_069 = 5061; //S_SKILL_JN_069
        public const int S_SKILL_JN_070 = 5062; //S_SKILL_JN_070
        public const int S_SKILL_JN_073 = 5064; //S_SKILL_JN_073
        public const int S_SKILL_JN_074 = 5065; //S_SKILL_JN_074
        public const int S_SKILL_JN_075 = 5066; //S_SKILL_JN_075
        public const int S_SKILL_JN_079 = 5068; //S_SKILL_JN_079
        public const int S_SKILL_JN_081 = 5069; //S_SKILL_JN_081
        public const int S_SKILL_JN_082 = 5070; //S_SKILL_JN_082
        public const int S_SKILL_JN_083 = 5071; //S_SKILL_JN_083
        public const int S_SKILL_JN_085 = 5072; //S_SKILL_JN_085
        public const int S_SKILL_JN_089 = 5073; //S_SKILL_JN_089
        public const int S_SKILL_JN_090 = 5074; //S_SKILL_JN_090
        public const int S_SKILL_JN_091 = 5075; //S_SKILL_JN_091
        public const int S_SKILL_JN_093 = 5076; //S_SKILL_JN_093
        public const int S_SKILL_JN_094 = 5077; //S_SKILL_JN_094
        public const int S_SKILL_JN_095 = 5078; //S_SKILL_JN_095
        public const int S_SKILL_JN_097 = 5079; //S_SKILL_JN_097
        public const int S_SKILL_JN_098 = 5080; //S_SKILL_JN_098
        public const int S_SKILL_JN_099 = 5081; //S_SKILL_JN_099
        public const int S_SKILL_JN_101 = 5082; //S_SKILL_JN_101
        public const int S_SKILL_JN_103 = 5084; //S_SKILL_JN_103
        public const int S_SKILL_JN_105 = 5085; //S_SKILL_JN_105
        public const int S_SKILL_JN_107 = 5087; //S_SKILL_JN_107
        public const int S_SKILL_JN_109 = 5088; //S_SKILL_JN_109
        public const int S_SKILL_JN_110 = 5089; //S_SKILL_JN_110
        public const int S_SKILL_JN_111 = 5090; //S_SKILL_JN_111
        public const int S_SKILL_JN_113 = 5091; //S_SKILL_JN_113
        public const int S_SKILL_JN_114 = 5092; //S_SKILL_JN_114
        public const int S_SKILL_JN_115 = 5093; //S_SKILL_JN_115
        public const int S_SKILL_JN_117 = 5094; //S_SKILL_JN_117
        public const int S_SKILL_JN_118 = 5095; //S_SKILL_JN_118
        public const int S_SKILL_JN_119 = 5096; //S_SKILL_JN_119
        public const int S_SKILL_JN_121 = 5097; //S_SKILL_JN_121
        public const int S_SKILL_JN_122 = 5098; //S_SKILL_JN_122
        public const int S_SKILL_JN_123 = 5099; //S_SKILL_JN_123
        public const int S_SKILL_JN_125 = 5100; //S_SKILL_JN_125
        public const int S_SKILL_JN_127 = 5102; //S_SKILL_JN_127
        public const int S_SKILL_JN_129 = 5103; //S_SKILL_JN_129
        public const int S_SKILL_JN_130 = 5104; //S_SKILL_JN_130
        public const int S_SKILL_JN_131 = 5105; //S_SKILL_JN_131
        public const int S_SKILL_JN_133 = 5106; //S_SKILL_JN_133
        public const int S_SKILL_JN_134 = 5107; //S_SKILL_JN_134
        public const int S_SKILL_JN_135 = 5108; //S_SKILL_JN_135
        public const int S_SKILL_JN_137 = 5109; //S_SKILL_JN_137
        public const int S_SKILL_JN_138 = 5110; //S_SKILL_JN_138
        public const int S_SKILL_JN_139 = 5111; //S_SKILL_JN_139
        public const int S_SKILL_JN_141 = 5112; //S_SKILL_JN_141
        public const int S_SKILL_JN_142 = 5113; //S_SKILL_JN_142
        public const int S_SKILL_JN_143 = 5114; //S_SKILL_JN_143
        public const int S_SKILL_JN_145 = 5115; //S_SKILL_JN_145
        public const int S_SKILL_JN_146 = 5116; //S_SKILL_JN_146
        public const int S_SKILL_JN_149 = 5118; //S_SKILL_JN_149
        public const int S_SKILL_JN_150 = 5119; //S_SKILL_JN_150
        public const int S_SKILL_JN_151 = 5120; //S_SKILL_JN_151
        public const int S_SKILL_JN_153 = 5121; //S_SKILL_JN_153
        public const int S_SKILL_JN_154 = 5122; //S_SKILL_JN_154
        public const int S_SKILL_JN_157 = 5124; //S_SKILL_JN_157
        public const int S_SKILL_JN_158 = 5125; //S_SKILL_JN_158
        public const int S_SKILL_JN_159 = 5126; //S_SKILL_JN_159
        public const int S_SKILL_JN_161 = 5127; //S_SKILL_JN_161
        public const int S_SKILL_JN_162 = 5128; //S_SKILL_JN_162
        public const int S_SKILL_JN_163 = 5129; //S_SKILL_JN_163
        public const int S_SKILL_JN_165 = 5130; //S_SKILL_JN_165
        public const int S_SKILL_JN_166 = 5131; //S_SKILL_JN_166
        public const int S_SKILL_JN_167 = 5132; //S_SKILL_JN_167
        public const int S_SKILL_JN_169 = 5133; //S_SKILL_JN_169
        public const int S_SKILL_JN_170 = 5134; //S_SKILL_JN_170
        public const int S_SKILL_JN_171 = 5135; //S_SKILL_JN_171
        public const int S_SKILL_JN_174 = 5137; //S_SKILL_JN_174
        public const int S_SKILL_JN_175 = 5138; //S_SKILL_JN_175
        public const int S_SKILL_JN_177 = 5139; //S_SKILL_JN_177
        public const int S_SKILL_JN_178 = 5140; //S_SKILL_JN_178
        public const int S_SKILL_JN_179 = 5141; //S_SKILL_JN_179
        public const int S_SKILL_JN_181 = 5142; //S_SKILL_JN_181
        public const int S_SKILL_JN_182 = 5143; //S_SKILL_JN_182
        public const int S_SKILL_JN_183 = 5144; //S_SKILL_JN_183
        public const int S_SKILL_JN_185 = 5145; //S_SKILL_JN_185
        public const int S_SKILL_JN_186 = 5146; //S_SKILL_JN_186
        public const int S_SKILL_JN_187 = 5147; //S_SKILL_JN_187
        public const int S_SKILL_JN_189 = 5148; //S_SKILL_JN_189
        public const int S_SKILL_JN_190 = 5149; //S_SKILL_JN_190
        public const int S_SKILL_JN_191 = 5150; //S_SKILL_JN_191
        public const int S_SKILL_JN_193 = 5151; //S_SKILL_JN_193
        public const int S_SKILL_JN_194 = 5152; //S_SKILL_JN_194
        public const int S_SKILL_JN_195 = 5153; //S_SKILL_JN_195
        public const int S_SKILL_JN_197 = 5154; //S_SKILL_JN_197
        public const int S_SKILL_JN_198 = 5155; //S_SKILL_JN_198
        public const int S_SKILL_JN_199 = 5156; //S_SKILL_JN_199
        public const int S_SKILL_JN_201 = 5157; //S_SKILL_JN_201
        public const int S_SKILL_JN_202 = 5158; //S_SKILL_JN_202
        public const int S_SKILL_JN_203 = 5159; //S_SKILL_JN_203
        public const int S_SKILL_JN_205 = 5160; //S_SKILL_JN_205
        public const int S_SKILL_JN_206 = 5161; //S_SKILL_JN_206
        public const int S_SKILL_JN_207 = 5162; //S_SKILL_JN_207
        public const int S_SKILL_JN_209 = 5163; //S_SKILL_JN_209
        public const int S_SKILL_JN_210 = 5164; //S_SKILL_JN_210
        public const int S_SKILL_JN_211 = 5165; //S_SKILL_JN_211
        public const int S_SKILL_JN_213 = 5166; //S_SKILL_JN_213
        public const int S_SKILL_JN_214 = 5167; //S_SKILL_JN_214
        public const int S_SKILL_JN_215 = 5168; //S_SKILL_JN_215
        public const int S_SKILL_JN_217 = 5169; //S_SKILL_JN_217
        public const int S_SKILL_JN_218 = 5170; //S_SKILL_JN_218
        public const int S_SKILL_JN_219 = 5171; //S_SKILL_JN_219
        public const int S_SKILL_JN_221 = 5172; //S_SKILL_JN_221
        public const int S_SKILL_JN_222 = 5173; //S_SKILL_JN_222
        public const int S_SKILL_JN_223 = 5174; //S_SKILL_JN_223
        public const int S_SKILL_JN_225 = 5175; //S_SKILL_JN_225
        public const int S_SKILL_JN_226 = 5176; //S_SKILL_JN_226
        public const int S_SKILL_JN_227 = 5177; //S_SKILL_JN_227
        public const int S_SKILL_JN_229 = 5178; //S_SKILL_JN_229
        public const int S_SKILL_JN_230 = 5179; //S_SKILL_JN_230
        public const int S_SKILL_JN_231 = 5180; //S_SKILL_JN_231
        public const int S_SKILL_JN_233 = 5181; //S_SKILL_JN_233
        public const int S_SKILL_JN_234 = 5182; //S_SKILL_JN_234
        public const int S_SKILL_JN_235 = 5183; //S_SKILL_JN_235
        public const int S_SKILL_JN_237 = 5184; //S_SKILL_JN_237
        public const int S_SKILL_JN_238 = 5185; //S_SKILL_JN_238
        public const int S_SKILL_JN_239 = 5186; //S_SKILL_JN_239
        public const int S_NORMAL_QT_SF_001 = 6001; //S_NORMAL_QT_SF_001
        public const int S_NORMAL_QT_SF_002 = 6002; //S_NORMAL_QT_SF_002
        public const int S_NORMAL_QT_SF_003 = 6003; //S_NORMAL_QT_SF_003
        public const int S_NORMAL_TB_SF_001 = 6004; //S_NORMAL_TB_SF_001
        public const int S_NORMAL_TB_SF_002 = 6005; //S_NORMAL_TB_SF_002
        public const int S_NORMAL_TB_SF_003 = 6006; //S_NORMAL_TB_SF_003
        public const int S_NORMAL_DD_SF_001 = 6007; //S_NORMAL_DD_SF_001
        public const int S_NORMAL_DD_SF_002 = 6008; //S_NORMAL_DD_SF_002
        public const int S_NORMAL_DD_SF_003 = 6009; //S_NORMAL_DD_SF_003
        public const int S_NORMAL_DJ_SF_001 = 6010; //S_NORMAL_DJ_SF_001
        public const int S_NORMAL_DJ_SF_002 = 6011; //S_NORMAL_DJ_SF_002
        public const int S_NORMAL_DJ_SF_003 = 6012; //S_NORMAL_DJ_SF_003
        public const int S_NORMAL_CM_SF_001 = 6013; //S_NORMAL_CM_SF_001
        public const int S_NORMAL_CM_SF_002 = 6014; //S_NORMAL_CM_SF_002
        public const int S_NORMAL_CM_SF_003 = 6015; //S_NORMAL_CM_SF_003
        public const int S_NORMAL_CG_SF_001 = 6016; //S_NORMAL_CG_SF_001
        public const int S_NORMAL_CG_SF_002 = 6017; //S_NORMAL_CG_SF_002
        public const int S_NORMAL_CG_SF_003 = 6018; //S_NORMAL_CG_SF_003
        public const int S_NORMAL_DGB_SF_001 = 6019; //S_NORMAL_DGB_SF_001
        public const int S_NORMAL_DGB_SF_002 = 6020; //S_NORMAL_DGB_SF_002
        public const int S_NORMAL_DGB_SF_003 = 6021; //S_NORMAL_DGB_SF_003
        public const int S_NORMAL_SD_SF_001 = 6022; //S_NORMAL_SD_SF_001
        public const int S_NORMAL_SD_SF_002 = 6023; //S_NORMAL_SD_SF_002
        public const int S_NORMAL_SD_SF_003 = 6024; //S_NORMAL_SD_SF_003
        public const int S_NORMAL_XD_SF_001 = 6025; //S_NORMAL_XD_SF_001
        public const int S_NORMAL_XD_SF_002 = 6026; //S_NORMAL_XD_SF_002
        public const int S_NORMAL_XD_SF_003 = 6027; //S_NORMAL_XD_SF_003
        public const int S_NORMAL_XJ_SF_001 = 6028; //S_NORMAL_XJ_SF_001
        public const int S_NORMAL_XJ_SF_002 = 6029; //S_NORMAL_XJ_SF_002
        public const int S_NORMAL_XJ_SF_003 = 6030; //S_NORMAL_XJ_SF_003
        public const int S_NORMAL_BS_SF_001 = 6031; //S_NORMAL_BS_SF_001
        public const int S_NORMAL_BS_SF_002 = 6032; //S_NORMAL_BS_SF_002
        public const int S_NORMAL_BS_SF_003 = 6033; //S_NORMAL_BS_SF_003
        public const int S_NORMAL_LD_SF_001 = 6034; //S_NORMAL_LD_SF_001
        public const int S_NORMAL_LD_SF_002 = 6035; //S_NORMAL_LD_SF_002
        public const int S_NORMAL_LD_SF_003 = 6036; //S_NORMAL_LD_SF_003
        public const int S_NORMAL_G_SF_001 = 6037; //S_NORMAL_G_SF_001
        public const int S_NORMAL_G_SF_002 = 6038; //S_NORMAL_G_SF_002
        public const int S_NORMAL_G_SF_003 = 6039; //S_NORMAL_G_SF_003
        public const int S_NORMAL_N_SF_001 = 6040; //S_NORMAL_N_SF_001
        public const int S_NORMAL_N_SF_002 = 6041; //S_NORMAL_N_SF_002
        public const int S_NORMAL_N_SF_003 = 6042; //S_NORMAL_N_SF_003
        public const int S_NORMAL_Q_SF_001 = 6043; //S_NORMAL_Q_SF_001
        public const int S_NORMAL_Q_SF_002 = 6044; //S_NORMAL_Q_SF_002
        public const int S_NORMAL_Q_SF_003 = 6045; //S_NORMAL_Q_SF_003
        public const int S_NORMAL_P_SF_001 = 6046; //S_NORMAL_P_SF_001
        public const int S_NORMAL_P_SF_002 = 6047; //S_NORMAL_P_SF_002
        public const int S_NORMAL_P_SF_003 = 6048; //S_NORMAL_P_SF_003
        public const int S_NORMAL_MF_SF_001 = 6049; //S_NORMAL_MF_SF_001
        public const int S_NORMAL_MF_SF_002 = 6050; //S_NORMAL_MF_SF_002
        public const int S_NORMAL_MF_SF_003 = 6051; //S_NORMAL_MF_SF_003
        public const int S_NORMAL_FB_SF_001 = 6052; //S_NORMAL_FB_SF_001
        public const int S_NORMAL_FB_SF_002 = 6053; //S_NORMAL_FB_SF_002
        public const int S_NORMAL_FB_SF_003 = 6054; //S_NORMAL_FB_SF_003
        public const int S_NORMAL_MJT_SF_001 = 6055; //S_NORMAL_MJT_SF_001
        public const int S_NORMAL_MJT_SF_002 = 6056; //S_NORMAL_MJT_SF_002
        public const int S_NORMAL_MJT_SF_003 = 6057; //S_NORMAL_MJT_SF_003
        public const int S_NORMAL_XDL_SF_001 = 6058; //S_NORMAL_XDL_SF_001
        public const int S_NORMAL_XDL_SF_002 = 6059; //S_NORMAL_XDL_SF_002
        public const int S_NORMAL_XDL_SF_003 = 6060; //S_NORMAL_XDL_SF_003
        public const int S_NORMAL_QT_SJ_001 = 6061; //S_NORMAL_QT_SJ_001
        public const int S_NORMAL_QT_SJ_002 = 6062; //S_NORMAL_QT_SJ_002
        public const int S_NORMAL_TB_SJ_001 = 6064; //S_NORMAL_TB_SJ_001
        public const int S_NORMAL_TB_SJ_002 = 6065; //S_NORMAL_TB_SJ_002
        public const int S_NORMAL_TB_SJ_003 = 6066; //S_NORMAL_TB_SJ_003
        public const int S_NORMAL_DD_SJ_001 = 6067; //S_NORMAL_DD_SJ_001
        public const int S_NORMAL_DD_SJ_002 = 6068; //S_NORMAL_DD_SJ_002
        public const int S_NORMAL_DJ_SJ_001 = 6070; //S_NORMAL_DJ_SJ_001
        public const int S_NORMAL_DJ_SJ_002 = 6071; //S_NORMAL_DJ_SJ_002
        public const int S_NORMAL_DJ_SJ_003 = 6072; //S_NORMAL_DJ_SJ_003
        public const int S_NORMAL_CM_SJ_001 = 6073; //S_NORMAL_CM_SJ_001
        public const int S_NORMAL_CM_SJ_002 = 6074; //S_NORMAL_CM_SJ_002
        public const int S_NORMAL_CG_SJ_001 = 6076; //S_NORMAL_CG_SJ_001
        public const int S_NORMAL_CG_SJ_002 = 6077; //S_NORMAL_CG_SJ_002
        public const int S_NORMAL_CG_SJ_003 = 6078; //S_NORMAL_CG_SJ_003
        public const int S_NORMAL_DGB_SJ_001 = 6079; //S_NORMAL_DGB_SJ_001
        public const int S_NORMAL_DGB_SJ_002 = 6080; //S_NORMAL_DGB_SJ_002
        public const int S_NORMAL_SD_SJ_001 = 6082; //S_NORMAL_SD_SJ_001
        public const int S_NORMAL_SD_SJ_002 = 6083; //S_NORMAL_SD_SJ_002
        public const int S_NORMAL_SD_SJ_003 = 6084; //S_NORMAL_SD_SJ_003
        public const int S_NORMAL_XD_SJ_001 = 6085; //S_NORMAL_XD_SJ_001
        public const int S_NORMAL_XD_SJ_002 = 6086; //S_NORMAL_XD_SJ_002
        public const int S_NORMAL_XD_SJ_003 = 6087; //S_NORMAL_XD_SJ_003
        public const int S_NORMAL_XJ_SJ_001 = 6088; //S_NORMAL_XJ_SJ_001
        public const int S_NORMAL_XJ_SJ_002 = 6089; //S_NORMAL_XJ_SJ_002
        public const int S_NORMAL_XJ_SJ_003 = 6090; //S_NORMAL_XJ_SJ_003
        public const int S_NORMAL_BS_SJ_001 = 6091; //S_NORMAL_BS_SJ_001
        public const int S_NORMAL_BS_SJ_002 = 6092; //S_NORMAL_BS_SJ_002
        public const int S_NORMAL_BS_SJ_003 = 6093; //S_NORMAL_BS_SJ_003
        public const int S_NORMAL_LD_SJ_001 = 6094; //S_NORMAL_LD_SJ_001
        public const int S_NORMAL_LD_SJ_002 = 6095; //S_NORMAL_LD_SJ_002
        public const int S_NORMAL_LD_SJ_003 = 6096; //S_NORMAL_LD_SJ_003
        public const int S_NORMAL_G_SJ_001 = 6097; //S_NORMAL_G_SJ_001
        public const int S_NORMAL_G_SJ_002 = 6098; //S_NORMAL_G_SJ_002
        public const int S_NORMAL_G_SJ_003 = 6099; //S_NORMAL_G_SJ_003
        public const int S_NORMAL_N_SJ_001 = 6100; //S_NORMAL_N_SJ_001
        public const int S_NORMAL_N_SJ_002 = 6101; //S_NORMAL_N_SJ_002
        public const int S_NORMAL_N_SJ_003 = 6102; //S_NORMAL_N_SJ_003
        public const int S_NORMAL_Q_SJ_001 = 6103; //S_NORMAL_Q_SJ_001
        public const int S_NORMAL_Q_SJ_002 = 6104; //S_NORMAL_Q_SJ_002
        public const int S_NORMAL_Q_SJ_003 = 6105; //S_NORMAL_Q_SJ_003
        public const int S_NORMAL_P_SJ_001 = 6106; //S_NORMAL_P_SJ_001
        public const int S_NORMAL_P_SJ_002 = 6107; //S_NORMAL_P_SJ_002
        public const int S_NORMAL_P_SJ_003 = 6108; //S_NORMAL_P_SJ_003
        public const int S_NORMAL_MF_SJ_001 = 6109; //S_NORMAL_MF_SJ_001
        public const int S_NORMAL_MF_SJ_002 = 6110; //S_NORMAL_MF_SJ_002
        public const int S_NORMAL_MF_SJ_003 = 6111; //S_NORMAL_MF_SJ_003
        public const int S_NORMAL_FB_SJ_001 = 6112; //S_NORMAL_FB_SJ_001
        public const int S_NORMAL_FB_SJ_002 = 6113; //S_NORMAL_FB_SJ_002
        public const int S_NORMAL_FB_SJ_003 = 6114; //S_NORMAL_FB_SJ_003
        public const int S_NORMAL_MJT_SJ_001 = 6115; //S_NORMAL_MJT_SJ_001
        public const int S_NORMAL_MJT_SJ_002 = 6116; //S_NORMAL_MJT_SJ_002
        public const int S_NORMAL_XDL_SJ_001 = 6118; //S_NORMAL_XDL_SJ_001
        public const int S_NORMAL_XDL_SJ_002 = 6119; //S_NORMAL_XDL_SJ_002
        public const int S_NORMAL_XDL_SJ_003 = 6120; //S_NORMAL_XDL_SJ_003
        public const int S_SKILL_JN_002_1 = 5187; //S_SKILL_JN_002_1
        public const int S_SKILL_JN_002_2 = 5188; //S_SKILL_JN_002_2
        public const int S_SKILL_JN_043_1 = 5189; //S_SKILL_JN_043_1
        public const int S_SKILL_JN_043_2 = 5190; //S_SKILL_JN_043_2
        public const int S_SKILL_JN_043_3 = 5191; //S_SKILL_JN_043_3
        public const int S_SKILL_JN_051_1 = 5192; //S_SKILL_JN_051_1
        public const int S_SKILL_JN_051_2 = 5193; //S_SKILL_JN_051_2
        public const int S_SKILL_JN_240 = 5194; //S_SKILL_JN_240
        public const int S_SKILL_JN_241 = 5195; //S_SKILL_JN_241
        public const int S_SKILL_JN_242 = 5196; //S_SKILL_JN_242
        public const int S_SKILL_JN_243 = 5197; //S_SKILL_JN_243
        public const int S_SKILL_JN_135_2 = 5198; //S_SKILL_JN_135_2
        public const int S_SKILL_JN_135_3 = 5199; //S_SKILL_JN_135_3
        public const int S_SKILL_JN_002_3 = 5200; //S_SKILL_JN_002_3
        public const int S_SKILL_XZ_001 = 7001; //S_SKILL_XZ_001
        public const int S_SKILL_XZ_002 = 7002; //S_SKILL_XZ_002
        public const int S_SKILL_XZ_003 = 7003; //S_SKILL_XZ_003
        public const int S_SKILL_GW_001 = 7004; //S_SKILL_GW_001
        public const int S_SKILL_GW_002 = 7005; //S_SKILL_GW_002
        public const int S_SKILL_GW_003 = 7006; //S_SKILL_GW_003
        public const int S_SKILL_GW_004 = 7007; //S_SKILL_GW_004
        public const int S_SKILL_GW_005 = 7008; //S_SKILL_GW_005
        public const int S_SKILL_GW_006 = 7009; //S_SKILL_GW_006
        public const int S_SKILL_GW_007 = 7010; //S_SKILL_GW_007
        public const int S_SKILL_GW_008 = 7011; //S_SKILL_GW_008
        public const int S_SKILL_GW_009 = 7012; //S_SKILL_GW_009
        public const int S_SKILL_GW_010 = 7013; //S_SKILL_GW_010
        public const int S_SKILL_GW_011 = 7014; //S_SKILL_GW_011
        public const int S_SKILL_GW_012 = 7015; //S_SKILL_GW_012
        public const int S_SKILL_GW_013 = 7016; //S_SKILL_GW_013
        public const int S_SKILL_GW_014 = 7017; //S_SKILL_GW_014
        public const int S_SKILL_GW_015 = 7018; //S_SKILL_GW_015
        public const int S_SKILL_GW_JN_001 = 7101; //S_SKILL_GW_JN_001
        public const int S_SKILL_GW_JN_002 = 7102; //S_SKILL_GW_JN_002
        public const int S_SKILL_GW_JN_003 = 7103; //S_SKILL_GW_JN_003
        public const int S_SKILL_GW_JN_004 = 7104; //S_SKILL_GW_JN_004
        public const int S_SKILL_GW_JN_005 = 7105; //S_SKILL_GW_JN_005
        public const int S_SKILL_GW_JN_006 = 7106; //S_SKILL_GW_JN_006
        public const int S_SKILL_GW_JN_007 = 7107; //S_SKILL_GW_JN_007
        public const int S_SKILL_GW_JN_008 = 7108; //S_SKILL_GW_JN_008
        public const int S_SKILL_GW_JN_009 = 7109; //S_SKILL_GW_JN_009
    public void Serializer(MemoryStream ms){

}
public int Deserializer(byte[] bytes, int offset = 0){

return offset;
        }
} 
 [Serializable]public class Sysactive
    {
		public string unikey;
		public int id; //活动id
		public string name; //活动名
		public List<int> hour_b; //时_开始
		public List<int> min_b; //分_开始
		public List<int> hour_e; //时_结束
		public List<int> min_e; //分_结束
		public string content; //内容
		public string push_content; //推送显示内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(hour_b==null)hour_b = new List<int>();
byte[] hour_bCountBytes = BitConverter.GetBytes(hour_b.Count);
            ms.Write(hour_bCountBytes,0,hour_bCountBytes.Length);
for (int i = 0; i < hour_b.Count; i++){
byte[] hour_bBytes = BitConverter.GetBytes(hour_b[i]);
            ms.Write(hour_bBytes,0,hour_bBytes.Length);
}
if(min_b==null)min_b = new List<int>();
byte[] min_bCountBytes = BitConverter.GetBytes(min_b.Count);
            ms.Write(min_bCountBytes,0,min_bCountBytes.Length);
for (int i = 0; i < min_b.Count; i++){
byte[] min_bBytes = BitConverter.GetBytes(min_b[i]);
            ms.Write(min_bBytes,0,min_bBytes.Length);
}
if(hour_e==null)hour_e = new List<int>();
byte[] hour_eCountBytes = BitConverter.GetBytes(hour_e.Count);
            ms.Write(hour_eCountBytes,0,hour_eCountBytes.Length);
for (int i = 0; i < hour_e.Count; i++){
byte[] hour_eBytes = BitConverter.GetBytes(hour_e[i]);
            ms.Write(hour_eBytes,0,hour_eBytes.Length);
}
if(min_e==null)min_e = new List<int>();
byte[] min_eCountBytes = BitConverter.GetBytes(min_e.Count);
            ms.Write(min_eCountBytes,0,min_eCountBytes.Length);
for (int i = 0; i < min_e.Count; i++){
byte[] min_eBytes = BitConverter.GetBytes(min_e[i]);
            ms.Write(min_eBytes,0,min_eBytes.Length);
}
if(string.IsNullOrEmpty(content))content = string.Empty;
            byte[] contentBytes = System.Text.Encoding.UTF8.GetBytes(content);
            byte[] contentBytesLen = BitConverter.GetBytes(contentBytes.Length);
            ms.Write(contentBytesLen, 0, contentBytesLen.Length);
            ms.Write(contentBytes, 0, contentBytes.Length);
if(string.IsNullOrEmpty(push_content))push_content = string.Empty;
            byte[] push_contentBytes = System.Text.Encoding.UTF8.GetBytes(push_content);
            byte[] push_contentBytesLen = BitConverter.GetBytes(push_contentBytes.Length);
            ms.Write(push_contentBytesLen, 0, push_contentBytesLen.Length);
            ms.Write(push_contentBytes, 0, push_contentBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int hour_bCount;
hour_bCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hour_b = new List<int>(hour_bCount);
for (int i = 0; i < hour_bCount; i++){
hour_b.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int min_bCount;
min_bCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
min_b = new List<int>(min_bCount);
for (int i = 0; i < min_bCount; i++){
min_b.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int hour_eCount;
hour_eCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hour_e = new List<int>(hour_eCount);
for (int i = 0; i < hour_eCount; i++){
hour_e.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int min_eCount;
min_eCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
min_e = new List<int>(min_eCount);
for (int i = 0; i < min_eCount; i++){
min_e.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int content_count;content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;content = System.Text.Encoding.UTF8.GetString(bytes, offset, content_count);offset += content_count;
int push_content_count;push_content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;push_content = System.Text.Encoding.UTF8.GetString(bytes, offset, push_content_count);offset += push_content_count;
return offset;
        }
} 
 [Serializable]public class Sysactive_charge
    {
		public string unikey;
		public int charge; //累计达到金额
		public List<Syscharge_goods> day7; //7天累计奖励
		public List<Syscharge_goods> day1; //当天累计奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] chargeBytes = BitConverter.GetBytes(charge);
            ms.Write(chargeBytes,0,chargeBytes.Length);
if(day7==null)day7 = new List<Syscharge_goods>();
byte[] day7CountBytes = BitConverter.GetBytes(day7.Count);
            ms.Write(day7CountBytes,0,day7CountBytes.Length);
for (int i = 0; i < day7.Count; i++){
if(day7[i] == null)day7[i] = new Syscharge_goods();day7[i].Serializer(ms);
}
if(day1==null)day1 = new List<Syscharge_goods>();
byte[] day1CountBytes = BitConverter.GetBytes(day1.Count);
            ms.Write(day1CountBytes,0,day1CountBytes.Length);
for (int i = 0; i < day1.Count; i++){
if(day1[i] == null)day1[i] = new Syscharge_goods();day1[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
charge = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int day7Count;
day7Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
day7 = new List<Syscharge_goods>(day7Count);
for (int i = 0; i < day7Count; i++){
day7.Add(new Syscharge_goods());offset = day7[i].Deserializer(bytes,offset);
}

int day1Count;
day1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
day1 = new List<Syscharge_goods>(day1Count);
for (int i = 0; i < day1Count; i++){
day1.Add(new Syscharge_goods());offset = day1[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_combat
    {
		public string unikey;
		public int id; //唯一id
		public int combat; //战力
		public List<Sysrank_goods> combat_goods; //战力奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] combatBytes = BitConverter.GetBytes(combat);
            ms.Write(combatBytes,0,combatBytes.Length);
if(combat_goods==null)combat_goods = new List<Sysrank_goods>();
byte[] combat_goodsCountBytes = BitConverter.GetBytes(combat_goods.Count);
            ms.Write(combat_goodsCountBytes,0,combat_goodsCountBytes.Length);
for (int i = 0; i < combat_goods.Count; i++){
if(combat_goods[i] == null)combat_goods[i] = new Sysrank_goods();combat_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int combat_goodsCount;
combat_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_goods = new List<Sysrank_goods>(combat_goodsCount);
for (int i = 0; i < combat_goodsCount; i++){
combat_goods.Add(new Sysrank_goods());offset = combat_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_grow_fund
    {
		public string unikey;
		public int lv; //等级
		public int gold_num; //等级领取钻石
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] gold_numBytes = BitConverter.GetBytes(gold_num);
            ms.Write(gold_numBytes,0,gold_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_hero
    {
		public string unikey;
		public int hero_id; //英雄id
		public int sell_price; //出售价格
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] hero_idBytes = BitConverter.GetBytes(hero_id);
            ms.Write(hero_idBytes,0,hero_idBytes.Length);
byte[] sell_priceBytes = BitConverter.GetBytes(sell_price);
            ms.Write(sell_priceBytes,0,sell_priceBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sell_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_login
    {
		public string unikey;
		public int day; //登陆天数
		public List<Syslogin_goods> goods; //登陆天数奖励物品
		public List<Syslogin_goods> goods2; //登陆天数奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dayBytes = BitConverter.GetBytes(day);
            ms.Write(dayBytes,0,dayBytes.Length);
if(goods==null)goods = new List<Syslogin_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syslogin_goods();goods[i].Serializer(ms);
}
if(goods2==null)goods2 = new List<Syslogin_goods>();
byte[] goods2CountBytes = BitConverter.GetBytes(goods2.Count);
            ms.Write(goods2CountBytes,0,goods2CountBytes.Length);
for (int i = 0; i < goods2.Count; i++){
if(goods2[i] == null)goods2[i] = new Syslogin_goods();goods2[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
day = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syslogin_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syslogin_goods());offset = goods[i].Deserializer(bytes,offset);
}

int goods2Count;
goods2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods2 = new List<Syslogin_goods>(goods2Count);
for (int i = 0; i < goods2Count; i++){
goods2.Add(new Syslogin_goods());offset = goods2[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_lv
    {
		public string unikey;
		public int lv; //等级
		public List<Syslv_goods> goods; //等级奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(goods==null)goods = new List<Syslv_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syslv_goods();goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syslv_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syslv_goods());offset = goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_phase
    {
		public string unikey;
		public int phase; //段位
		public List<int> score; //段位积分
		public List<Sysrank_goods> phase_goods; //段位奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] phaseBytes = BitConverter.GetBytes(phase);
            ms.Write(phaseBytes,0,phaseBytes.Length);
if(score==null)score = new List<int>();
byte[] scoreCountBytes = BitConverter.GetBytes(score.Count);
            ms.Write(scoreCountBytes,0,scoreCountBytes.Length);
for (int i = 0; i < score.Count; i++){
byte[] scoreBytes = BitConverter.GetBytes(score[i]);
            ms.Write(scoreBytes,0,scoreBytes.Length);
}
if(phase_goods==null)phase_goods = new List<Sysrank_goods>();
byte[] phase_goodsCountBytes = BitConverter.GetBytes(phase_goods.Count);
            ms.Write(phase_goodsCountBytes,0,phase_goodsCountBytes.Length);
for (int i = 0; i < phase_goods.Count; i++){
if(phase_goods[i] == null)phase_goods[i] = new Sysrank_goods();phase_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
phase = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int scoreCount;
scoreCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
score = new List<int>(scoreCount);
for (int i = 0; i < scoreCount; i++){
score.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int phase_goodsCount;
phase_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase_goods = new List<Sysrank_goods>(phase_goodsCount);
for (int i = 0; i < phase_goodsCount; i++){
phase_goods.Add(new Sysrank_goods());offset = phase_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_rank
    {
		public string unikey;
		public int id; //rank_id
		public List<Sysrank_goods> dungeon_reward; //闯关奖励(实际发的)
		public List<Sysrank_goods> dungeon_extra_reward; //闯关奖励(显示用)
		public List<Sysrank_goods> combat_reward; //战力奖励(实际发的)
		public List<Sysrank_goods> combat_extra_reward; //战力奖励(显示用)
		public List<Sysrank_goods> arena_reward; //竞技场奖励(实际发的)
		public List<Sysrank_goods> arena_extra_reward; //竞技场奖励(显示用)
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(dungeon_reward==null)dungeon_reward = new List<Sysrank_goods>();
byte[] dungeon_rewardCountBytes = BitConverter.GetBytes(dungeon_reward.Count);
            ms.Write(dungeon_rewardCountBytes,0,dungeon_rewardCountBytes.Length);
for (int i = 0; i < dungeon_reward.Count; i++){
if(dungeon_reward[i] == null)dungeon_reward[i] = new Sysrank_goods();dungeon_reward[i].Serializer(ms);
}
if(dungeon_extra_reward==null)dungeon_extra_reward = new List<Sysrank_goods>();
byte[] dungeon_extra_rewardCountBytes = BitConverter.GetBytes(dungeon_extra_reward.Count);
            ms.Write(dungeon_extra_rewardCountBytes,0,dungeon_extra_rewardCountBytes.Length);
for (int i = 0; i < dungeon_extra_reward.Count; i++){
if(dungeon_extra_reward[i] == null)dungeon_extra_reward[i] = new Sysrank_goods();dungeon_extra_reward[i].Serializer(ms);
}
if(combat_reward==null)combat_reward = new List<Sysrank_goods>();
byte[] combat_rewardCountBytes = BitConverter.GetBytes(combat_reward.Count);
            ms.Write(combat_rewardCountBytes,0,combat_rewardCountBytes.Length);
for (int i = 0; i < combat_reward.Count; i++){
if(combat_reward[i] == null)combat_reward[i] = new Sysrank_goods();combat_reward[i].Serializer(ms);
}
if(combat_extra_reward==null)combat_extra_reward = new List<Sysrank_goods>();
byte[] combat_extra_rewardCountBytes = BitConverter.GetBytes(combat_extra_reward.Count);
            ms.Write(combat_extra_rewardCountBytes,0,combat_extra_rewardCountBytes.Length);
for (int i = 0; i < combat_extra_reward.Count; i++){
if(combat_extra_reward[i] == null)combat_extra_reward[i] = new Sysrank_goods();combat_extra_reward[i].Serializer(ms);
}
if(arena_reward==null)arena_reward = new List<Sysrank_goods>();
byte[] arena_rewardCountBytes = BitConverter.GetBytes(arena_reward.Count);
            ms.Write(arena_rewardCountBytes,0,arena_rewardCountBytes.Length);
for (int i = 0; i < arena_reward.Count; i++){
if(arena_reward[i] == null)arena_reward[i] = new Sysrank_goods();arena_reward[i].Serializer(ms);
}
if(arena_extra_reward==null)arena_extra_reward = new List<Sysrank_goods>();
byte[] arena_extra_rewardCountBytes = BitConverter.GetBytes(arena_extra_reward.Count);
            ms.Write(arena_extra_rewardCountBytes,0,arena_extra_rewardCountBytes.Length);
for (int i = 0; i < arena_extra_reward.Count; i++){
if(arena_extra_reward[i] == null)arena_extra_reward[i] = new Sysrank_goods();arena_extra_reward[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dungeon_rewardCount;
dungeon_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_reward = new List<Sysrank_goods>(dungeon_rewardCount);
for (int i = 0; i < dungeon_rewardCount; i++){
dungeon_reward.Add(new Sysrank_goods());offset = dungeon_reward[i].Deserializer(bytes,offset);
}

int dungeon_extra_rewardCount;
dungeon_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_extra_reward = new List<Sysrank_goods>(dungeon_extra_rewardCount);
for (int i = 0; i < dungeon_extra_rewardCount; i++){
dungeon_extra_reward.Add(new Sysrank_goods());offset = dungeon_extra_reward[i].Deserializer(bytes,offset);
}

int combat_rewardCount;
combat_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_reward = new List<Sysrank_goods>(combat_rewardCount);
for (int i = 0; i < combat_rewardCount; i++){
combat_reward.Add(new Sysrank_goods());offset = combat_reward[i].Deserializer(bytes,offset);
}

int combat_extra_rewardCount;
combat_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_extra_reward = new List<Sysrank_goods>(combat_extra_rewardCount);
for (int i = 0; i < combat_extra_rewardCount; i++){
combat_extra_reward.Add(new Sysrank_goods());offset = combat_extra_reward[i].Deserializer(bytes,offset);
}

int arena_rewardCount;
arena_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_reward = new List<Sysrank_goods>(arena_rewardCount);
for (int i = 0; i < arena_rewardCount; i++){
arena_reward.Add(new Sysrank_goods());offset = arena_reward[i].Deserializer(bytes,offset);
}

int arena_extra_rewardCount;
arena_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_extra_reward = new List<Sysrank_goods>(arena_extra_rewardCount);
for (int i = 0; i < arena_extra_rewardCount; i++){
arena_extra_reward.Add(new Sysrank_goods());offset = arena_extra_reward[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_vip
    {
		public string unikey;
		public int vip_lv; //vip等级
		public int online_time; //在线时长
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] vip_lvBytes = BitConverter.GetBytes(vip_lv);
            ms.Write(vip_lvBytes,0,vip_lvBytes.Length);
byte[] online_timeBytes = BitConverter.GetBytes(online_time);
            ms.Write(online_timeBytes,0,online_timeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
vip_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
online_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_welfare
    {
		public string unikey;
		public int id; //id
		public int finish_limit; //完成条件
		public List<Sysrank_goods> reward; //奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] finish_limitBytes = BitConverter.GetBytes(finish_limit);
            ms.Write(finish_limitBytes,0,finish_limitBytes.Length);
if(reward==null)reward = new List<Sysrank_goods>();
byte[] rewardCountBytes = BitConverter.GetBytes(reward.Count);
            ms.Write(rewardCountBytes,0,rewardCountBytes.Length);
for (int i = 0; i < reward.Count; i++){
if(reward[i] == null)reward[i] = new Sysrank_goods();reward[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
finish_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rewardCount;
rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward = new List<Sysrank_goods>(rewardCount);
for (int i = 0; i < rewardCount; i++){
reward.Add(new Sysrank_goods());offset = reward[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysai
    {
		public string unikey;
		public int id; //id
		public string file; //file
		public string name; //名字
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(file))file = string.Empty;
            byte[] fileBytes = System.Text.Encoding.UTF8.GetBytes(file);
            byte[] fileBytesLen = BitConverter.GetBytes(fileBytes.Length);
            ms.Write(fileBytesLen, 0, fileBytesLen.Length);
            ms.Write(fileBytes, 0, fileBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int file_count;file_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;file = System.Text.Encoding.UTF8.GetString(bytes, offset, file_count);offset += file_count;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
return offset;
        }
} 
 [Serializable]public class Sysanimation_effect
    {
		public string unikey;
		public int id; //动画特效
		public string effect; //特效资源
		public string state; //对应的动画状态
		public float deactive_delay; //动画结束后持续时间
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(effect))effect = string.Empty;
            byte[] effectBytes = System.Text.Encoding.UTF8.GetBytes(effect);
            byte[] effectBytesLen = BitConverter.GetBytes(effectBytes.Length);
            ms.Write(effectBytesLen, 0, effectBytesLen.Length);
            ms.Write(effectBytes, 0, effectBytes.Length);
if(string.IsNullOrEmpty(state))state = string.Empty;
            byte[] stateBytes = System.Text.Encoding.UTF8.GetBytes(state);
            byte[] stateBytesLen = BitConverter.GetBytes(stateBytes.Length);
            ms.Write(stateBytesLen, 0, stateBytesLen.Length);
            ms.Write(stateBytes, 0, stateBytes.Length);
byte[] deactive_delayBytes = BitConverter.GetBytes(deactive_delay);
            ms.Write(deactive_delayBytes,0,deactive_delayBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int effect_count;effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effect = System.Text.Encoding.UTF8.GetString(bytes, offset, effect_count);offset += effect_count;
int state_count;state_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;state = System.Text.Encoding.UTF8.GetString(bytes, offset, state_count);offset += state_count;
deactive_delay = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysarena
    {
		public string unikey;
		public int id; //竞技场ID
		public int refresh_diamond; //刷新排名消耗钻石
		public string arena_name; //关卡名称
		public string map; //场景地图
		public int lv; //等级限制
		public int time; //时间限制
		public List<Sysdesc_rule> rule_desc; //规则描述，显示用
		public int can_auto; //托管战斗
		public int times; //每日免费竞技次数
		public int hero_limit; //英雄进入数限制
		public List<Syswin_rule> win_rule; //胜利条件
		public List<Sysfail_rule> fail_rule; //失败规则
		public string map_load; //关卡loading图片
		public int hero_ai1; //主英雄ai调用
		public int hero_ai2; //副英雄ai调用
		public int enemy_ai1; //敌对匹配主英雄ai调用
		public int enemy_ai2; //敌对匹配副英雄ai调用
		public int cd_time; //冷却时间
		public int clear_cd; //解除冷却时间消耗钻石
		public int field_of_view; //视野
		public float offset_x; //x偏移
		public float offset_y; //y偏移
		public float offset_z; //z偏移
		public List<float> camera0; //镜头过渡前
		public List<float> camera1; //镜头过渡后
		public string camera_animate; //镜头动画
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] refresh_diamondBytes = BitConverter.GetBytes(refresh_diamond);
            ms.Write(refresh_diamondBytes,0,refresh_diamondBytes.Length);
if(string.IsNullOrEmpty(arena_name))arena_name = string.Empty;
            byte[] arena_nameBytes = System.Text.Encoding.UTF8.GetBytes(arena_name);
            byte[] arena_nameBytesLen = BitConverter.GetBytes(arena_nameBytes.Length);
            ms.Write(arena_nameBytesLen, 0, arena_nameBytesLen.Length);
            ms.Write(arena_nameBytes, 0, arena_nameBytes.Length);
if(string.IsNullOrEmpty(map))map = string.Empty;
            byte[] mapBytes = System.Text.Encoding.UTF8.GetBytes(map);
            byte[] mapBytesLen = BitConverter.GetBytes(mapBytes.Length);
            ms.Write(mapBytesLen, 0, mapBytesLen.Length);
            ms.Write(mapBytes, 0, mapBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] timeBytes = BitConverter.GetBytes(time);
            ms.Write(timeBytes,0,timeBytes.Length);
if(rule_desc==null)rule_desc = new List<Sysdesc_rule>();
byte[] rule_descCountBytes = BitConverter.GetBytes(rule_desc.Count);
            ms.Write(rule_descCountBytes,0,rule_descCountBytes.Length);
for (int i = 0; i < rule_desc.Count; i++){
if(rule_desc[i] == null)rule_desc[i] = new Sysdesc_rule();rule_desc[i].Serializer(ms);
}
byte[] can_autoBytes = BitConverter.GetBytes(can_auto);
            ms.Write(can_autoBytes,0,can_autoBytes.Length);
byte[] timesBytes = BitConverter.GetBytes(times);
            ms.Write(timesBytes,0,timesBytes.Length);
byte[] hero_limitBytes = BitConverter.GetBytes(hero_limit);
            ms.Write(hero_limitBytes,0,hero_limitBytes.Length);
if(win_rule==null)win_rule = new List<Syswin_rule>();
byte[] win_ruleCountBytes = BitConverter.GetBytes(win_rule.Count);
            ms.Write(win_ruleCountBytes,0,win_ruleCountBytes.Length);
for (int i = 0; i < win_rule.Count; i++){
if(win_rule[i] == null)win_rule[i] = new Syswin_rule();win_rule[i].Serializer(ms);
}
if(fail_rule==null)fail_rule = new List<Sysfail_rule>();
byte[] fail_ruleCountBytes = BitConverter.GetBytes(fail_rule.Count);
            ms.Write(fail_ruleCountBytes,0,fail_ruleCountBytes.Length);
for (int i = 0; i < fail_rule.Count; i++){
if(fail_rule[i] == null)fail_rule[i] = new Sysfail_rule();fail_rule[i].Serializer(ms);
}
if(string.IsNullOrEmpty(map_load))map_load = string.Empty;
            byte[] map_loadBytes = System.Text.Encoding.UTF8.GetBytes(map_load);
            byte[] map_loadBytesLen = BitConverter.GetBytes(map_loadBytes.Length);
            ms.Write(map_loadBytesLen, 0, map_loadBytesLen.Length);
            ms.Write(map_loadBytes, 0, map_loadBytes.Length);
byte[] hero_ai1Bytes = BitConverter.GetBytes(hero_ai1);
            ms.Write(hero_ai1Bytes,0,hero_ai1Bytes.Length);
byte[] hero_ai2Bytes = BitConverter.GetBytes(hero_ai2);
            ms.Write(hero_ai2Bytes,0,hero_ai2Bytes.Length);
byte[] enemy_ai1Bytes = BitConverter.GetBytes(enemy_ai1);
            ms.Write(enemy_ai1Bytes,0,enemy_ai1Bytes.Length);
byte[] enemy_ai2Bytes = BitConverter.GetBytes(enemy_ai2);
            ms.Write(enemy_ai2Bytes,0,enemy_ai2Bytes.Length);
byte[] cd_timeBytes = BitConverter.GetBytes(cd_time);
            ms.Write(cd_timeBytes,0,cd_timeBytes.Length);
byte[] clear_cdBytes = BitConverter.GetBytes(clear_cd);
            ms.Write(clear_cdBytes,0,clear_cdBytes.Length);
byte[] field_of_viewBytes = BitConverter.GetBytes(field_of_view);
            ms.Write(field_of_viewBytes,0,field_of_viewBytes.Length);
byte[] offset_xBytes = BitConverter.GetBytes(offset_x);
            ms.Write(offset_xBytes,0,offset_xBytes.Length);
byte[] offset_yBytes = BitConverter.GetBytes(offset_y);
            ms.Write(offset_yBytes,0,offset_yBytes.Length);
byte[] offset_zBytes = BitConverter.GetBytes(offset_z);
            ms.Write(offset_zBytes,0,offset_zBytes.Length);
if(camera0==null)camera0 = new List<float>();
byte[] camera0CountBytes = BitConverter.GetBytes(camera0.Count);
            ms.Write(camera0CountBytes,0,camera0CountBytes.Length);
for (int i = 0; i < camera0.Count; i++){
byte[] camera0Bytes = BitConverter.GetBytes(camera0[i]);
            ms.Write(camera0Bytes,0,camera0Bytes.Length);
}
if(camera1==null)camera1 = new List<float>();
byte[] camera1CountBytes = BitConverter.GetBytes(camera1.Count);
            ms.Write(camera1CountBytes,0,camera1CountBytes.Length);
for (int i = 0; i < camera1.Count; i++){
byte[] camera1Bytes = BitConverter.GetBytes(camera1[i]);
            ms.Write(camera1Bytes,0,camera1Bytes.Length);
}
if(string.IsNullOrEmpty(camera_animate))camera_animate = string.Empty;
            byte[] camera_animateBytes = System.Text.Encoding.UTF8.GetBytes(camera_animate);
            byte[] camera_animateBytesLen = BitConverter.GetBytes(camera_animateBytes.Length);
            ms.Write(camera_animateBytesLen, 0, camera_animateBytesLen.Length);
            ms.Write(camera_animateBytes, 0, camera_animateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
refresh_diamond = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int arena_name_count;arena_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;arena_name = System.Text.Encoding.UTF8.GetString(bytes, offset, arena_name_count);offset += arena_name_count;
int map_count;map_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map = System.Text.Encoding.UTF8.GetString(bytes, offset, map_count);offset += map_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
time = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rule_descCount;
rule_descCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rule_desc = new List<Sysdesc_rule>(rule_descCount);
for (int i = 0; i < rule_descCount; i++){
rule_desc.Add(new Sysdesc_rule());offset = rule_desc[i].Deserializer(bytes,offset);
}
can_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int win_ruleCount;
win_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
win_rule = new List<Syswin_rule>(win_ruleCount);
for (int i = 0; i < win_ruleCount; i++){
win_rule.Add(new Syswin_rule());offset = win_rule[i].Deserializer(bytes,offset);
}

int fail_ruleCount;
fail_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fail_rule = new List<Sysfail_rule>(fail_ruleCount);
for (int i = 0; i < fail_ruleCount; i++){
fail_rule.Add(new Sysfail_rule());offset = fail_rule[i].Deserializer(bytes,offset);
}
int map_load_count;map_load_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map_load = System.Text.Encoding.UTF8.GetString(bytes, offset, map_load_count);offset += map_load_count;
hero_ai1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_ai2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
enemy_ai1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
enemy_ai2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cd_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
clear_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
field_of_view = BitConverter.ToInt32(bytes, offset);
            offset += 4;
offset_x = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_y = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_z = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int camera0Count;
camera0Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
camera0 = new List<float>(camera0Count);
for (int i = 0; i < camera0Count; i++){
camera0.Add( BitConverter.ToSingle(bytes, offset));
            offset += 4;
}

int camera1Count;
camera1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
camera1 = new List<float>(camera1Count);
for (int i = 0; i < camera1Count; i++){
camera1.Add( BitConverter.ToSingle(bytes, offset));
            offset += 4;
}
int camera_animate_count;camera_animate_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;camera_animate = System.Text.Encoding.UTF8.GetString(bytes, offset, camera_animate_count);offset += camera_animate_count;
return offset;
        }
} 
 [Serializable]public class Sysarena_enemy
    {
		public string unikey;
		public int id; //编号
		public List<int> rank_id; //排名段
		public List<int> pos1; //第一个位置
		public List<int> pos2; //第二个位置
		public List<int> pos3; //第三个位置
		public List<int> pos4; //第四个位置
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(rank_id==null)rank_id = new List<int>();
byte[] rank_idCountBytes = BitConverter.GetBytes(rank_id.Count);
            ms.Write(rank_idCountBytes,0,rank_idCountBytes.Length);
for (int i = 0; i < rank_id.Count; i++){
byte[] rank_idBytes = BitConverter.GetBytes(rank_id[i]);
            ms.Write(rank_idBytes,0,rank_idBytes.Length);
}
if(pos1==null)pos1 = new List<int>();
byte[] pos1CountBytes = BitConverter.GetBytes(pos1.Count);
            ms.Write(pos1CountBytes,0,pos1CountBytes.Length);
for (int i = 0; i < pos1.Count; i++){
byte[] pos1Bytes = BitConverter.GetBytes(pos1[i]);
            ms.Write(pos1Bytes,0,pos1Bytes.Length);
}
if(pos2==null)pos2 = new List<int>();
byte[] pos2CountBytes = BitConverter.GetBytes(pos2.Count);
            ms.Write(pos2CountBytes,0,pos2CountBytes.Length);
for (int i = 0; i < pos2.Count; i++){
byte[] pos2Bytes = BitConverter.GetBytes(pos2[i]);
            ms.Write(pos2Bytes,0,pos2Bytes.Length);
}
if(pos3==null)pos3 = new List<int>();
byte[] pos3CountBytes = BitConverter.GetBytes(pos3.Count);
            ms.Write(pos3CountBytes,0,pos3CountBytes.Length);
for (int i = 0; i < pos3.Count; i++){
byte[] pos3Bytes = BitConverter.GetBytes(pos3[i]);
            ms.Write(pos3Bytes,0,pos3Bytes.Length);
}
if(pos4==null)pos4 = new List<int>();
byte[] pos4CountBytes = BitConverter.GetBytes(pos4.Count);
            ms.Write(pos4CountBytes,0,pos4CountBytes.Length);
for (int i = 0; i < pos4.Count; i++){
byte[] pos4Bytes = BitConverter.GetBytes(pos4[i]);
            ms.Write(pos4Bytes,0,pos4Bytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rank_idCount;
rank_idCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rank_id = new List<int>(rank_idCount);
for (int i = 0; i < rank_idCount; i++){
rank_id.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int pos1Count;
pos1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos1 = new List<int>(pos1Count);
for (int i = 0; i < pos1Count; i++){
pos1.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int pos2Count;
pos2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos2 = new List<int>(pos2Count);
for (int i = 0; i < pos2Count; i++){
pos2.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int pos3Count;
pos3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos3 = new List<int>(pos3Count);
for (int i = 0; i < pos3Count; i++){
pos3.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int pos4Count;
pos4Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos4 = new List<int>(pos4Count);
for (int i = 0; i < pos4Count; i++){
pos4.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysarena_rank_reward
    {
		public string unikey;
		public int id; //编号
		public List<int> rank_id; //排名段
		public float gold_rate; //钻石系数
		public int gold_total; //钻石总数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(rank_id==null)rank_id = new List<int>();
byte[] rank_idCountBytes = BitConverter.GetBytes(rank_id.Count);
            ms.Write(rank_idCountBytes,0,rank_idCountBytes.Length);
for (int i = 0; i < rank_id.Count; i++){
byte[] rank_idBytes = BitConverter.GetBytes(rank_id[i]);
            ms.Write(rank_idBytes,0,rank_idBytes.Length);
}
byte[] gold_rateBytes = BitConverter.GetBytes(gold_rate);
            ms.Write(gold_rateBytes,0,gold_rateBytes.Length);
byte[] gold_totalBytes = BitConverter.GetBytes(gold_total);
            ms.Write(gold_totalBytes,0,gold_totalBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rank_idCount;
rank_idCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rank_id = new List<int>(rank_idCount);
for (int i = 0; i < rank_idCount; i++){
rank_id.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
gold_rate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
gold_total = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysarena_reward
    {
		public string unikey;
		public int rank_id; //排名
		public int gold; //钻石
		public int coin; //金币
		public int arena_coin; //竞技币
		public List<int> num; //经验丹数量
		public int extra_award; //五星额外奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] rank_idBytes = BitConverter.GetBytes(rank_id);
            ms.Write(rank_idBytes,0,rank_idBytes.Length);
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] arena_coinBytes = BitConverter.GetBytes(arena_coin);
            ms.Write(arena_coinBytes,0,arena_coinBytes.Length);
if(num==null)num = new List<int>();
byte[] numCountBytes = BitConverter.GetBytes(num.Count);
            ms.Write(numCountBytes,0,numCountBytes.Length);
for (int i = 0; i < num.Count; i++){
byte[] numBytes = BitConverter.GetBytes(num[i]);
            ms.Write(numBytes,0,numBytes.Length);
}
byte[] extra_awardBytes = BitConverter.GetBytes(extra_award);
            ms.Write(extra_awardBytes,0,extra_awardBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
rank_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int numCount;
numCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = new List<int>(numCount);
for (int i = 0; i < numCount; i++){
num.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
extra_award = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattach_affect
    {
		public string unikey;
		public int id; //id
		public string name; //名称
		public List<int> buffs; //附带buff
		public float attr_value_per; //属性基础值(百分比)
		public float attr_grow_per; //属性成长值(百分比)
		public float attr_value; //属性基础值
		public float attr_grow; //属性成长值
		public int max_attach_count; //最大次数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(buffs==null)buffs = new List<int>();
byte[] buffsCountBytes = BitConverter.GetBytes(buffs.Count);
            ms.Write(buffsCountBytes,0,buffsCountBytes.Length);
for (int i = 0; i < buffs.Count; i++){
byte[] buffsBytes = BitConverter.GetBytes(buffs[i]);
            ms.Write(buffsBytes,0,buffsBytes.Length);
}
byte[] attr_value_perBytes = BitConverter.GetBytes(attr_value_per);
            ms.Write(attr_value_perBytes,0,attr_value_perBytes.Length);
byte[] attr_grow_perBytes = BitConverter.GetBytes(attr_grow_per);
            ms.Write(attr_grow_perBytes,0,attr_grow_perBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
byte[] attr_growBytes = BitConverter.GetBytes(attr_grow);
            ms.Write(attr_growBytes,0,attr_growBytes.Length);
byte[] max_attach_countBytes = BitConverter.GetBytes(max_attach_count);
            ms.Write(max_attach_countBytes,0,max_attach_countBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int buffsCount;
buffsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffs = new List<int>(buffsCount);
for (int i = 0; i < buffsCount; i++){
buffs.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
attr_value_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
max_attach_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattach_affect_grow
    {
		public string unikey;
		public int id; //buff id
		public int lv; //技能等级
		public float attr_value; //属性值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattribute
    {
		public string unikey;
		public int id; //英雄id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //吸血抗性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
		public float move_speed2; //主城移速
		public float min_hurt_coefficient; //不破防系数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
byte[] move_speed2Bytes = BitConverter.GetBytes(move_speed2);
            ms.Write(move_speed2Bytes,0,move_speed2Bytes.Length);
byte[] min_hurt_coefficientBytes = BitConverter.GetBytes(min_hurt_coefficient);
            ms.Write(min_hurt_coefficientBytes,0,min_hurt_coefficientBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
min_hurt_coefficient = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattribute_lev
    {
		public string unikey;
		public int id; //英雄id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattribute_qual
    {
		public string unikey;
		public int id; //英雄ID
		public int quality; //品质
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public float pdef_ignore; //忽略护甲%
		public float mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysattribute_star
    {
		public string unikey;
		public int star; //星级
		public float parament; //成长值增长比
		public int soul_num; //英雄转换灵魂石
		public string tip; //提示
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] paramentBytes = BitConverter.GetBytes(parament);
            ms.Write(paramentBytes,0,paramentBytes.Length);
byte[] soul_numBytes = BitConverter.GetBytes(soul_num);
            ms.Write(soul_numBytes,0,soul_numBytes.Length);
if(string.IsNullOrEmpty(tip))tip = string.Empty;
            byte[] tipBytes = System.Text.Encoding.UTF8.GetBytes(tip);
            byte[] tipBytesLen = BitConverter.GetBytes(tipBytes.Length);
            ms.Write(tipBytesLen, 0, tipBytesLen.Length);
            ms.Write(tipBytes, 0, tipBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
parament = BitConverter.ToSingle(bytes, offset);
            offset += 4;
soul_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int tip_count;tip_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;tip = System.Text.Encoding.UTF8.GetString(bytes, offset, tip_count);offset += tip_count;
return offset;
        }
} 
 [Serializable]public class Sysbattle_event
    {
		public string unikey;
		public int id; //ID
		public int event_type; //事件类型
		public List<int> intParameters; //参数2
		public string stringParameter; //参数3
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] event_typeBytes = BitConverter.GetBytes(event_type);
            ms.Write(event_typeBytes,0,event_typeBytes.Length);
if(intParameters==null)intParameters = new List<int>();
byte[] intParametersCountBytes = BitConverter.GetBytes(intParameters.Count);
            ms.Write(intParametersCountBytes,0,intParametersCountBytes.Length);
for (int i = 0; i < intParameters.Count; i++){
byte[] intParametersBytes = BitConverter.GetBytes(intParameters[i]);
            ms.Write(intParametersBytes,0,intParametersBytes.Length);
}
if(string.IsNullOrEmpty(stringParameter))stringParameter = string.Empty;
            byte[] stringParameterBytes = System.Text.Encoding.UTF8.GetBytes(stringParameter);
            byte[] stringParameterBytesLen = BitConverter.GetBytes(stringParameterBytes.Length);
            ms.Write(stringParameterBytesLen, 0, stringParameterBytesLen.Length);
            ms.Write(stringParameterBytes, 0, stringParameterBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
event_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int intParametersCount;
intParametersCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
intParameters = new List<int>(intParametersCount);
for (int i = 0; i < intParametersCount; i++){
intParameters.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int stringParameter_count;stringParameter_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;stringParameter = System.Text.Encoding.UTF8.GetString(bytes, offset, stringParameter_count);offset += stringParameter_count;
return offset;
        }
} 
 [Serializable]public class Sysbroadcast
    {
		public string unikey;
		public int id; //id
		public int priority; //优先级
		public string content; //内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] priorityBytes = BitConverter.GetBytes(priority);
            ms.Write(priorityBytes,0,priorityBytes.Length);
if(string.IsNullOrEmpty(content))content = string.Empty;
            byte[] contentBytes = System.Text.Encoding.UTF8.GetBytes(content);
            byte[] contentBytesLen = BitConverter.GetBytes(contentBytes.Length);
            ms.Write(contentBytesLen, 0, contentBytesLen.Length);
            ms.Write(contentBytes, 0, contentBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
priority = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int content_count;content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;content = System.Text.Encoding.UTF8.GetString(bytes, offset, content_count);offset += content_count;
return offset;
        }
} 
 [Serializable]public class Sysbroadcast_rand
    {
		public string unikey;
		public int id; //id
		public string content; //内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(content))content = string.Empty;
            byte[] contentBytes = System.Text.Encoding.UTF8.GetBytes(content);
            byte[] contentBytesLen = BitConverter.GetBytes(contentBytes.Length);
            ms.Write(contentBytesLen, 0, contentBytesLen.Length);
            ms.Write(contentBytes, 0, contentBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int content_count;content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;content = System.Text.Encoding.UTF8.GetString(bytes, offset, content_count);offset += content_count;
return offset;
        }
} 
 [Serializable]public class Sysbuff
    {
		public string unikey;
		public int id; //buff id
		public string name; //buff名称
		public List<string> effects; //buff特效
		public string exitEffect; //buff退出特效
		public float duration; //持续时间
		public float interval; //持续伤害类型BUFF的时间间隔
		public float controlledValue; //击飞高度或击退距离
		public string logicClass; //逻辑类名
		public List<int> triggers; //触发条件
		public int state; //buff产生的状态
		public List<int> remove_states; //移除当前状态
		public List<int> ignore_states; //免疫状态
		public string buff_btn; //Buff激活的按键
		public string attr_type; //属性类型
		public float attr_value_per; //属性基础值(百分比)
		public float attr_grow_per; //属性成长值(百分比)
		public float attr_value; //属性基础值
		public float attr_grow; //属性成长值
		public int attr_blend_mode; //属性混合模式
		public int sole; //是否唯一buff
		public int remove_when_dead; //死亡后是否清除
		public int per_value_base; //百分比基于攻还是受
		public int attach_affect; //使其他技能附带效果
		public string buff_icon; //buff图标
		public string buff_des; //buff描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(effects==null)effects = new List<string>();
byte[] effectsCountBytes = BitConverter.GetBytes(effects.Count);
            ms.Write(effectsCountBytes,0,effectsCountBytes.Length);
for (int i = 0; i < effects.Count; i++){
if(string.IsNullOrEmpty(effects[i]))effects[i] = string.Empty;
            byte[] effectsBytes = System.Text.Encoding.UTF8.GetBytes(effects[i]);
            byte[] effectsBytesLen = BitConverter.GetBytes(effectsBytes.Length);
            ms.Write(effectsBytesLen, 0, effectsBytesLen.Length);
            ms.Write(effectsBytes, 0, effectsBytes.Length);
}
if(string.IsNullOrEmpty(exitEffect))exitEffect = string.Empty;
            byte[] exitEffectBytes = System.Text.Encoding.UTF8.GetBytes(exitEffect);
            byte[] exitEffectBytesLen = BitConverter.GetBytes(exitEffectBytes.Length);
            ms.Write(exitEffectBytesLen, 0, exitEffectBytesLen.Length);
            ms.Write(exitEffectBytes, 0, exitEffectBytes.Length);
byte[] durationBytes = BitConverter.GetBytes(duration);
            ms.Write(durationBytes,0,durationBytes.Length);
byte[] intervalBytes = BitConverter.GetBytes(interval);
            ms.Write(intervalBytes,0,intervalBytes.Length);
byte[] controlledValueBytes = BitConverter.GetBytes(controlledValue);
            ms.Write(controlledValueBytes,0,controlledValueBytes.Length);
if(string.IsNullOrEmpty(logicClass))logicClass = string.Empty;
            byte[] logicClassBytes = System.Text.Encoding.UTF8.GetBytes(logicClass);
            byte[] logicClassBytesLen = BitConverter.GetBytes(logicClassBytes.Length);
            ms.Write(logicClassBytesLen, 0, logicClassBytesLen.Length);
            ms.Write(logicClassBytes, 0, logicClassBytes.Length);
if(triggers==null)triggers = new List<int>();
byte[] triggersCountBytes = BitConverter.GetBytes(triggers.Count);
            ms.Write(triggersCountBytes,0,triggersCountBytes.Length);
for (int i = 0; i < triggers.Count; i++){
byte[] triggersBytes = BitConverter.GetBytes(triggers[i]);
            ms.Write(triggersBytes,0,triggersBytes.Length);
}
byte[] stateBytes = BitConverter.GetBytes(state);
            ms.Write(stateBytes,0,stateBytes.Length);
if(remove_states==null)remove_states = new List<int>();
byte[] remove_statesCountBytes = BitConverter.GetBytes(remove_states.Count);
            ms.Write(remove_statesCountBytes,0,remove_statesCountBytes.Length);
for (int i = 0; i < remove_states.Count; i++){
byte[] remove_statesBytes = BitConverter.GetBytes(remove_states[i]);
            ms.Write(remove_statesBytes,0,remove_statesBytes.Length);
}
if(ignore_states==null)ignore_states = new List<int>();
byte[] ignore_statesCountBytes = BitConverter.GetBytes(ignore_states.Count);
            ms.Write(ignore_statesCountBytes,0,ignore_statesCountBytes.Length);
for (int i = 0; i < ignore_states.Count; i++){
byte[] ignore_statesBytes = BitConverter.GetBytes(ignore_states[i]);
            ms.Write(ignore_statesBytes,0,ignore_statesBytes.Length);
}
if(string.IsNullOrEmpty(buff_btn))buff_btn = string.Empty;
            byte[] buff_btnBytes = System.Text.Encoding.UTF8.GetBytes(buff_btn);
            byte[] buff_btnBytesLen = BitConverter.GetBytes(buff_btnBytes.Length);
            ms.Write(buff_btnBytesLen, 0, buff_btnBytesLen.Length);
            ms.Write(buff_btnBytes, 0, buff_btnBytes.Length);
if(string.IsNullOrEmpty(attr_type))attr_type = string.Empty;
            byte[] attr_typeBytes = System.Text.Encoding.UTF8.GetBytes(attr_type);
            byte[] attr_typeBytesLen = BitConverter.GetBytes(attr_typeBytes.Length);
            ms.Write(attr_typeBytesLen, 0, attr_typeBytesLen.Length);
            ms.Write(attr_typeBytes, 0, attr_typeBytes.Length);
byte[] attr_value_perBytes = BitConverter.GetBytes(attr_value_per);
            ms.Write(attr_value_perBytes,0,attr_value_perBytes.Length);
byte[] attr_grow_perBytes = BitConverter.GetBytes(attr_grow_per);
            ms.Write(attr_grow_perBytes,0,attr_grow_perBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
byte[] attr_growBytes = BitConverter.GetBytes(attr_grow);
            ms.Write(attr_growBytes,0,attr_growBytes.Length);
byte[] attr_blend_modeBytes = BitConverter.GetBytes(attr_blend_mode);
            ms.Write(attr_blend_modeBytes,0,attr_blend_modeBytes.Length);
byte[] soleBytes = BitConverter.GetBytes(sole);
            ms.Write(soleBytes,0,soleBytes.Length);
byte[] remove_when_deadBytes = BitConverter.GetBytes(remove_when_dead);
            ms.Write(remove_when_deadBytes,0,remove_when_deadBytes.Length);
byte[] per_value_baseBytes = BitConverter.GetBytes(per_value_base);
            ms.Write(per_value_baseBytes,0,per_value_baseBytes.Length);
byte[] attach_affectBytes = BitConverter.GetBytes(attach_affect);
            ms.Write(attach_affectBytes,0,attach_affectBytes.Length);
if(string.IsNullOrEmpty(buff_icon))buff_icon = string.Empty;
            byte[] buff_iconBytes = System.Text.Encoding.UTF8.GetBytes(buff_icon);
            byte[] buff_iconBytesLen = BitConverter.GetBytes(buff_iconBytes.Length);
            ms.Write(buff_iconBytesLen, 0, buff_iconBytesLen.Length);
            ms.Write(buff_iconBytes, 0, buff_iconBytes.Length);
if(string.IsNullOrEmpty(buff_des))buff_des = string.Empty;
            byte[] buff_desBytes = System.Text.Encoding.UTF8.GetBytes(buff_des);
            byte[] buff_desBytesLen = BitConverter.GetBytes(buff_desBytes.Length);
            ms.Write(buff_desBytesLen, 0, buff_desBytesLen.Length);
            ms.Write(buff_desBytes, 0, buff_desBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int effectsCount;
effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effects = new List<string>(effectsCount);
for (int i = 0; i < effectsCount; i++){
int effects_count;effects_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effects.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, effects_count));offset += effects_count;
}
int exitEffect_count;exitEffect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;exitEffect = System.Text.Encoding.UTF8.GetString(bytes, offset, exitEffect_count);offset += exitEffect_count;
duration = BitConverter.ToSingle(bytes, offset);
            offset += 4;
interval = BitConverter.ToSingle(bytes, offset);
            offset += 4;
controlledValue = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int logicClass_count;logicClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;logicClass = System.Text.Encoding.UTF8.GetString(bytes, offset, logicClass_count);offset += logicClass_count;

int triggersCount;
triggersCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
triggers = new List<int>(triggersCount);
for (int i = 0; i < triggersCount; i++){
triggers.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
state = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int remove_statesCount;
remove_statesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
remove_states = new List<int>(remove_statesCount);
for (int i = 0; i < remove_statesCount; i++){
remove_states.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int ignore_statesCount;
ignore_statesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ignore_states = new List<int>(ignore_statesCount);
for (int i = 0; i < ignore_statesCount; i++){
ignore_states.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int buff_btn_count;buff_btn_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buff_btn = System.Text.Encoding.UTF8.GetString(bytes, offset, buff_btn_count);offset += buff_btn_count;
int attr_type_count;attr_type_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;attr_type = System.Text.Encoding.UTF8.GetString(bytes, offset, attr_type_count);offset += attr_type_count;
attr_value_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_blend_mode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sole = BitConverter.ToInt32(bytes, offset);
            offset += 4;
remove_when_dead = BitConverter.ToInt32(bytes, offset);
            offset += 4;
per_value_base = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attach_affect = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int buff_icon_count;buff_icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buff_icon = System.Text.Encoding.UTF8.GetString(bytes, offset, buff_icon_count);offset += buff_icon_count;
int buff_des_count;buff_des_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buff_des = System.Text.Encoding.UTF8.GetString(bytes, offset, buff_des_count);offset += buff_des_count;
return offset;
        }
} 
 [Serializable]public class Sysbuff_grow
    {
		public string unikey;
		public int id; //buff id
		public int lv; //技能等级
		public float attr_value; //属性值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscg
    {
		public string unikey;
		public int id; //过场动画ID
		public int group; //过场动画角色分组
		public string cgClass; //类型
		public string state; //动画
		public Syscgcamera camera; //镜头
		public string modle; //出场模型
		public Sysrender renderSetting; //渲染设置
		public List<int> effects; //特效
		public int adjust_position; //位置调整
		public float constant_x; //调整到固定位置z
		public float constant_y; //调整到固定位置y
		public float constant_z; //调整到固定位置z
		public float constant_r; //调整到固定位置r
		public float delay; //延迟
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] groupBytes = BitConverter.GetBytes(group);
            ms.Write(groupBytes,0,groupBytes.Length);
if(string.IsNullOrEmpty(cgClass))cgClass = string.Empty;
            byte[] cgClassBytes = System.Text.Encoding.UTF8.GetBytes(cgClass);
            byte[] cgClassBytesLen = BitConverter.GetBytes(cgClassBytes.Length);
            ms.Write(cgClassBytesLen, 0, cgClassBytesLen.Length);
            ms.Write(cgClassBytes, 0, cgClassBytes.Length);
if(string.IsNullOrEmpty(state))state = string.Empty;
            byte[] stateBytes = System.Text.Encoding.UTF8.GetBytes(state);
            byte[] stateBytesLen = BitConverter.GetBytes(stateBytes.Length);
            ms.Write(stateBytesLen, 0, stateBytesLen.Length);
            ms.Write(stateBytes, 0, stateBytes.Length);
if(camera == null)camera = new Syscgcamera();camera.Serializer(ms);
if(string.IsNullOrEmpty(modle))modle = string.Empty;
            byte[] modleBytes = System.Text.Encoding.UTF8.GetBytes(modle);
            byte[] modleBytesLen = BitConverter.GetBytes(modleBytes.Length);
            ms.Write(modleBytesLen, 0, modleBytesLen.Length);
            ms.Write(modleBytes, 0, modleBytes.Length);
if(renderSetting == null)renderSetting = new Sysrender();renderSetting.Serializer(ms);
if(effects==null)effects = new List<int>();
byte[] effectsCountBytes = BitConverter.GetBytes(effects.Count);
            ms.Write(effectsCountBytes,0,effectsCountBytes.Length);
for (int i = 0; i < effects.Count; i++){
byte[] effectsBytes = BitConverter.GetBytes(effects[i]);
            ms.Write(effectsBytes,0,effectsBytes.Length);
}
byte[] adjust_positionBytes = BitConverter.GetBytes(adjust_position);
            ms.Write(adjust_positionBytes,0,adjust_positionBytes.Length);
byte[] constant_xBytes = BitConverter.GetBytes(constant_x);
            ms.Write(constant_xBytes,0,constant_xBytes.Length);
byte[] constant_yBytes = BitConverter.GetBytes(constant_y);
            ms.Write(constant_yBytes,0,constant_yBytes.Length);
byte[] constant_zBytes = BitConverter.GetBytes(constant_z);
            ms.Write(constant_zBytes,0,constant_zBytes.Length);
byte[] constant_rBytes = BitConverter.GetBytes(constant_r);
            ms.Write(constant_rBytes,0,constant_rBytes.Length);
byte[] delayBytes = BitConverter.GetBytes(delay);
            ms.Write(delayBytes,0,delayBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
group = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int cgClass_count;cgClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;cgClass = System.Text.Encoding.UTF8.GetString(bytes, offset, cgClass_count);offset += cgClass_count;
int state_count;state_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;state = System.Text.Encoding.UTF8.GetString(bytes, offset, state_count);offset += state_count;
camera = new Syscgcamera();offset = camera.Deserializer(bytes,offset);
int modle_count;modle_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;modle = System.Text.Encoding.UTF8.GetString(bytes, offset, modle_count);offset += modle_count;
renderSetting = new Sysrender();offset = renderSetting.Deserializer(bytes,offset);

int effectsCount;
effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effects = new List<int>(effectsCount);
for (int i = 0; i < effectsCount; i++){
effects.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
adjust_position = BitConverter.ToInt32(bytes, offset);
            offset += 4;
constant_x = BitConverter.ToSingle(bytes, offset);
            offset += 4;
constant_y = BitConverter.ToSingle(bytes, offset);
            offset += 4;
constant_z = BitConverter.ToSingle(bytes, offset);
            offset += 4;
constant_r = BitConverter.ToSingle(bytes, offset);
            offset += 4;
delay = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscgcamera
    {
		public int id; //镜头ID
		public string cgClass; //类型
		public string state; //镜头动画动画
		public float lerpSpeed; //开始时位置过渡速度
		public float lookLerpSpeed; //开始时视点过渡速度
		public float lerpSpeed_1; //退出时位置过渡速度
		public float lookLerpSpeed_1; //退出时视点过渡速度
		public float fov; //视野调整
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(cgClass))cgClass = string.Empty;
            byte[] cgClassBytes = System.Text.Encoding.UTF8.GetBytes(cgClass);
            byte[] cgClassBytesLen = BitConverter.GetBytes(cgClassBytes.Length);
            ms.Write(cgClassBytesLen, 0, cgClassBytesLen.Length);
            ms.Write(cgClassBytes, 0, cgClassBytes.Length);
if(string.IsNullOrEmpty(state))state = string.Empty;
            byte[] stateBytes = System.Text.Encoding.UTF8.GetBytes(state);
            byte[] stateBytesLen = BitConverter.GetBytes(stateBytes.Length);
            ms.Write(stateBytesLen, 0, stateBytesLen.Length);
            ms.Write(stateBytes, 0, stateBytes.Length);
byte[] lerpSpeedBytes = BitConverter.GetBytes(lerpSpeed);
            ms.Write(lerpSpeedBytes,0,lerpSpeedBytes.Length);
byte[] lookLerpSpeedBytes = BitConverter.GetBytes(lookLerpSpeed);
            ms.Write(lookLerpSpeedBytes,0,lookLerpSpeedBytes.Length);
byte[] lerpSpeed_1Bytes = BitConverter.GetBytes(lerpSpeed_1);
            ms.Write(lerpSpeed_1Bytes,0,lerpSpeed_1Bytes.Length);
byte[] lookLerpSpeed_1Bytes = BitConverter.GetBytes(lookLerpSpeed_1);
            ms.Write(lookLerpSpeed_1Bytes,0,lookLerpSpeed_1Bytes.Length);
byte[] fovBytes = BitConverter.GetBytes(fov);
            ms.Write(fovBytes,0,fovBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int cgClass_count;cgClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;cgClass = System.Text.Encoding.UTF8.GetString(bytes, offset, cgClass_count);offset += cgClass_count;
int state_count;state_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;state = System.Text.Encoding.UTF8.GetString(bytes, offset, state_count);offset += state_count;
lerpSpeed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
lookLerpSpeed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
lerpSpeed_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
lookLerpSpeed_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fov = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syschapter
    {
		public string unikey;
		public int chapter_id; //章节ID
		public string chapter_name; //章节名字
		public string map; //章节地图资源
		public int lv; //章节等级限制
		public int pre_chapter; //上一章节ID
		public int next_chapter; //下一章节ID
		public int star_condition1; //星级条件1
		public List<Sysstar_reward> star_reward1; //星级奖励1
		public int star_condition2; //星级条件2
		public List<Sysstar_reward> star_reward2; //星级奖励2
		public int star_condition3; //星级条件3
		public List<Sysstar_reward> star_reward3; //星级奖励3
		public int type; //章节类型
		public string miniIcon; //章节滚动所使用素材
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] chapter_idBytes = BitConverter.GetBytes(chapter_id);
            ms.Write(chapter_idBytes,0,chapter_idBytes.Length);
if(string.IsNullOrEmpty(chapter_name))chapter_name = string.Empty;
            byte[] chapter_nameBytes = System.Text.Encoding.UTF8.GetBytes(chapter_name);
            byte[] chapter_nameBytesLen = BitConverter.GetBytes(chapter_nameBytes.Length);
            ms.Write(chapter_nameBytesLen, 0, chapter_nameBytesLen.Length);
            ms.Write(chapter_nameBytes, 0, chapter_nameBytes.Length);
if(string.IsNullOrEmpty(map))map = string.Empty;
            byte[] mapBytes = System.Text.Encoding.UTF8.GetBytes(map);
            byte[] mapBytesLen = BitConverter.GetBytes(mapBytes.Length);
            ms.Write(mapBytesLen, 0, mapBytesLen.Length);
            ms.Write(mapBytes, 0, mapBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] pre_chapterBytes = BitConverter.GetBytes(pre_chapter);
            ms.Write(pre_chapterBytes,0,pre_chapterBytes.Length);
byte[] next_chapterBytes = BitConverter.GetBytes(next_chapter);
            ms.Write(next_chapterBytes,0,next_chapterBytes.Length);
byte[] star_condition1Bytes = BitConverter.GetBytes(star_condition1);
            ms.Write(star_condition1Bytes,0,star_condition1Bytes.Length);
if(star_reward1==null)star_reward1 = new List<Sysstar_reward>();
byte[] star_reward1CountBytes = BitConverter.GetBytes(star_reward1.Count);
            ms.Write(star_reward1CountBytes,0,star_reward1CountBytes.Length);
for (int i = 0; i < star_reward1.Count; i++){
if(star_reward1[i] == null)star_reward1[i] = new Sysstar_reward();star_reward1[i].Serializer(ms);
}
byte[] star_condition2Bytes = BitConverter.GetBytes(star_condition2);
            ms.Write(star_condition2Bytes,0,star_condition2Bytes.Length);
if(star_reward2==null)star_reward2 = new List<Sysstar_reward>();
byte[] star_reward2CountBytes = BitConverter.GetBytes(star_reward2.Count);
            ms.Write(star_reward2CountBytes,0,star_reward2CountBytes.Length);
for (int i = 0; i < star_reward2.Count; i++){
if(star_reward2[i] == null)star_reward2[i] = new Sysstar_reward();star_reward2[i].Serializer(ms);
}
byte[] star_condition3Bytes = BitConverter.GetBytes(star_condition3);
            ms.Write(star_condition3Bytes,0,star_condition3Bytes.Length);
if(star_reward3==null)star_reward3 = new List<Sysstar_reward>();
byte[] star_reward3CountBytes = BitConverter.GetBytes(star_reward3.Count);
            ms.Write(star_reward3CountBytes,0,star_reward3CountBytes.Length);
for (int i = 0; i < star_reward3.Count; i++){
if(star_reward3[i] == null)star_reward3[i] = new Sysstar_reward();star_reward3[i].Serializer(ms);
}
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(miniIcon))miniIcon = string.Empty;
            byte[] miniIconBytes = System.Text.Encoding.UTF8.GetBytes(miniIcon);
            byte[] miniIconBytesLen = BitConverter.GetBytes(miniIconBytes.Length);
            ms.Write(miniIconBytesLen, 0, miniIconBytesLen.Length);
            ms.Write(miniIconBytes, 0, miniIconBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
chapter_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int chapter_name_count;chapter_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;chapter_name = System.Text.Encoding.UTF8.GetString(bytes, offset, chapter_name_count);offset += chapter_name_count;
int map_count;map_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map = System.Text.Encoding.UTF8.GetString(bytes, offset, map_count);offset += map_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_chapter = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_chapter = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_condition1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int star_reward1Count;
star_reward1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_reward1 = new List<Sysstar_reward>(star_reward1Count);
for (int i = 0; i < star_reward1Count; i++){
star_reward1.Add(new Sysstar_reward());offset = star_reward1[i].Deserializer(bytes,offset);
}
star_condition2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int star_reward2Count;
star_reward2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_reward2 = new List<Sysstar_reward>(star_reward2Count);
for (int i = 0; i < star_reward2Count; i++){
star_reward2.Add(new Sysstar_reward());offset = star_reward2[i].Deserializer(bytes,offset);
}
star_condition3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int star_reward3Count;
star_reward3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_reward3 = new List<Sysstar_reward>(star_reward3Count);
for (int i = 0; i < star_reward3Count; i++){
star_reward3.Add(new Sysstar_reward());offset = star_reward3[i].Deserializer(bytes,offset);
}
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int miniIcon_count;miniIcon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;miniIcon = System.Text.Encoding.UTF8.GetString(bytes, offset, miniIcon_count);offset += miniIcon_count;
return offset;
        }
} 
 [Serializable]public class Syscharge_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscharm_num_to_energy
    {
		public string unikey;
		public int num; //送花数
		public int use_gold; //使用的钻石
		public int add_energy; //增加的体力
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] use_goldBytes = BitConverter.GetBytes(use_gold);
            ms.Write(use_goldBytes,0,use_goldBytes.Length);
byte[] add_energyBytes = BitConverter.GetBytes(add_energy);
            ms.Write(add_energyBytes,0,add_energyBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
use_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
add_energy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscheck
    {
		public string unikey;
		public int id; //id
		public string name; //名称
		public int shape; //检测范围的形状
		public int pivot; //形状锚点
		public float shapeValue1; //参数1
		public float shapeValue2; //参数2
		public float shapeValue3; //参数3
		public int targetCount; //作用单位数
		public float viewRadius; //定点技能显示的范围
		public float viewWidth; //技能显示的范围
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] shapeBytes = BitConverter.GetBytes(shape);
            ms.Write(shapeBytes,0,shapeBytes.Length);
byte[] pivotBytes = BitConverter.GetBytes(pivot);
            ms.Write(pivotBytes,0,pivotBytes.Length);
byte[] shapeValue1Bytes = BitConverter.GetBytes(shapeValue1);
            ms.Write(shapeValue1Bytes,0,shapeValue1Bytes.Length);
byte[] shapeValue2Bytes = BitConverter.GetBytes(shapeValue2);
            ms.Write(shapeValue2Bytes,0,shapeValue2Bytes.Length);
byte[] shapeValue3Bytes = BitConverter.GetBytes(shapeValue3);
            ms.Write(shapeValue3Bytes,0,shapeValue3Bytes.Length);
byte[] targetCountBytes = BitConverter.GetBytes(targetCount);
            ms.Write(targetCountBytes,0,targetCountBytes.Length);
byte[] viewRadiusBytes = BitConverter.GetBytes(viewRadius);
            ms.Write(viewRadiusBytes,0,viewRadiusBytes.Length);
byte[] viewWidthBytes = BitConverter.GetBytes(viewWidth);
            ms.Write(viewWidthBytes,0,viewWidthBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
shape = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pivot = BitConverter.ToInt32(bytes, offset);
            offset += 4;
shapeValue1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
shapeValue2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
shapeValue3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
targetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
viewRadius = BitConverter.ToSingle(bytes, offset);
            offset += 4;
viewWidth = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class SysCommon_Goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscondition
    {
		public string unikey;
		public int id; //条件id
		public string name; //条件名称
		public string conditionParameter; //条件类型
		public string conditionMode; //条件公式
		public float floatValue; //浮点参数
		public int boolValue; //布尔参数
		public int intValue; //整形参数
		public List<int> bitValue; //位参数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(conditionParameter))conditionParameter = string.Empty;
            byte[] conditionParameterBytes = System.Text.Encoding.UTF8.GetBytes(conditionParameter);
            byte[] conditionParameterBytesLen = BitConverter.GetBytes(conditionParameterBytes.Length);
            ms.Write(conditionParameterBytesLen, 0, conditionParameterBytesLen.Length);
            ms.Write(conditionParameterBytes, 0, conditionParameterBytes.Length);
if(string.IsNullOrEmpty(conditionMode))conditionMode = string.Empty;
            byte[] conditionModeBytes = System.Text.Encoding.UTF8.GetBytes(conditionMode);
            byte[] conditionModeBytesLen = BitConverter.GetBytes(conditionModeBytes.Length);
            ms.Write(conditionModeBytesLen, 0, conditionModeBytesLen.Length);
            ms.Write(conditionModeBytes, 0, conditionModeBytes.Length);
byte[] floatValueBytes = BitConverter.GetBytes(floatValue);
            ms.Write(floatValueBytes,0,floatValueBytes.Length);
byte[] boolValueBytes = BitConverter.GetBytes(boolValue);
            ms.Write(boolValueBytes,0,boolValueBytes.Length);
byte[] intValueBytes = BitConverter.GetBytes(intValue);
            ms.Write(intValueBytes,0,intValueBytes.Length);
if(bitValue==null)bitValue = new List<int>();
byte[] bitValueCountBytes = BitConverter.GetBytes(bitValue.Count);
            ms.Write(bitValueCountBytes,0,bitValueCountBytes.Length);
for (int i = 0; i < bitValue.Count; i++){
byte[] bitValueBytes = BitConverter.GetBytes(bitValue[i]);
            ms.Write(bitValueBytes,0,bitValueBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int conditionParameter_count;conditionParameter_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;conditionParameter = System.Text.Encoding.UTF8.GetString(bytes, offset, conditionParameter_count);offset += conditionParameter_count;
int conditionMode_count;conditionMode_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;conditionMode = System.Text.Encoding.UTF8.GetString(bytes, offset, conditionMode_count);offset += conditionMode_count;
floatValue = BitConverter.ToSingle(bytes, offset);
            offset += 4;
boolValue = BitConverter.ToInt32(bytes, offset);
            offset += 4;
intValue = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int bitValueCount;
bitValueCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bitValue = new List<int>(bitValueCount);
for (int i = 0; i < bitValueCount; i++){
bitValue.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Syscost
    {
		public string unikey;
		public int times; //次数
		public int arena_refresh_cost; //竞技场刷新消耗
		public int arena_clean_cost; //竞技场清除cd消耗
		public int arena_buy_cost; //竞技场购买消耗 
		public int mall_refresh_cost; //商城刷新消耗
		public int escort_buy_plunder; //购买护送次数消耗
		public int escort_buy_rob; //购买掠夺次数消耗
		public int peerage_buy_cost; //爵位挑战购买消耗
		public int tower_box_cost; //神秘宝箱开启消耗
		public int fight_coin_cost; //试炼币购买消耗
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] timesBytes = BitConverter.GetBytes(times);
            ms.Write(timesBytes,0,timesBytes.Length);
byte[] arena_refresh_costBytes = BitConverter.GetBytes(arena_refresh_cost);
            ms.Write(arena_refresh_costBytes,0,arena_refresh_costBytes.Length);
byte[] arena_clean_costBytes = BitConverter.GetBytes(arena_clean_cost);
            ms.Write(arena_clean_costBytes,0,arena_clean_costBytes.Length);
byte[] arena_buy_costBytes = BitConverter.GetBytes(arena_buy_cost);
            ms.Write(arena_buy_costBytes,0,arena_buy_costBytes.Length);
byte[] mall_refresh_costBytes = BitConverter.GetBytes(mall_refresh_cost);
            ms.Write(mall_refresh_costBytes,0,mall_refresh_costBytes.Length);
byte[] escort_buy_plunderBytes = BitConverter.GetBytes(escort_buy_plunder);
            ms.Write(escort_buy_plunderBytes,0,escort_buy_plunderBytes.Length);
byte[] escort_buy_robBytes = BitConverter.GetBytes(escort_buy_rob);
            ms.Write(escort_buy_robBytes,0,escort_buy_robBytes.Length);
byte[] peerage_buy_costBytes = BitConverter.GetBytes(peerage_buy_cost);
            ms.Write(peerage_buy_costBytes,0,peerage_buy_costBytes.Length);
byte[] tower_box_costBytes = BitConverter.GetBytes(tower_box_cost);
            ms.Write(tower_box_costBytes,0,tower_box_costBytes.Length);
byte[] fight_coin_costBytes = BitConverter.GetBytes(fight_coin_cost);
            ms.Write(fight_coin_costBytes,0,fight_coin_costBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_refresh_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_clean_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_buy_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mall_refresh_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_buy_plunder = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_buy_rob = BitConverter.ToInt32(bytes, offset);
            offset += 4;
peerage_buy_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tower_box_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fight_coin_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syscreate_hero
    {
		public string unikey;
		public int id; //对应的索引
		public int hero_id; //英雄id
		public int model; //头像
		public int patk; //攻击
		public int matk; //法强
		public int pdef; //护甲
		public int mdef; //法抗
		public int hp; //生命
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hero_idBytes = BitConverter.GetBytes(hero_id);
            ms.Write(hero_idBytes,0,hero_idBytes.Length);
byte[] modelBytes = BitConverter.GetBytes(model);
            ms.Write(modelBytes,0,modelBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
model = BitConverter.ToInt32(bytes, offset);
            offset += 4;
patk = BitConverter.ToInt32(bytes, offset);
            offset += 4;
matk = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pdef = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysdeed
    {
		public string unikey;
		public int id; //契约id
		public string deed_disc; //契约描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(deed_disc))deed_disc = string.Empty;
            byte[] deed_discBytes = System.Text.Encoding.UTF8.GetBytes(deed_disc);
            byte[] deed_discBytesLen = BitConverter.GetBytes(deed_discBytes.Length);
            ms.Write(deed_discBytesLen, 0, deed_discBytesLen.Length);
            ms.Write(deed_discBytes, 0, deed_discBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int deed_disc_count;deed_disc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;deed_disc = System.Text.Encoding.UTF8.GetString(bytes, offset, deed_disc_count);offset += deed_disc_count;
return offset;
        }
} 
 [Serializable]public class Sysdeed_arg
    {
		public int id; //属性id
		public float num; //属性值
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysdeed_lv
    {
		public string unikey;
		public int id; //契约id
		public int deed_star; //契约英雄的星级
		public List<Sysdeed_arg> arg; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] deed_starBytes = BitConverter.GetBytes(deed_star);
            ms.Write(deed_starBytes,0,deed_starBytes.Length);
if(arg==null)arg = new List<Sysdeed_arg>();
byte[] argCountBytes = BitConverter.GetBytes(arg.Count);
            ms.Write(argCountBytes,0,argCountBytes.Length);
for (int i = 0; i < arg.Count; i++){
if(arg[i] == null)arg[i] = new Sysdeed_arg();arg[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
deed_star = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int argCount;
argCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = new List<Sysdeed_arg>(argCount);
for (int i = 0; i < argCount; i++){
arg.Add(new Sysdeed_arg());offset = arg[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysdesc_rule
    {
		public string desc; //规则描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Sysdialog
    {
		public string unikey;
		public int dialog_id; //索引
		public int role_id; //角色ID
		public List<int> word_id; //对话内容
		public int direction; //显示位置
		public int animation; //动画
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dialog_idBytes = BitConverter.GetBytes(dialog_id);
            ms.Write(dialog_idBytes,0,dialog_idBytes.Length);
byte[] role_idBytes = BitConverter.GetBytes(role_id);
            ms.Write(role_idBytes,0,role_idBytes.Length);
if(word_id==null)word_id = new List<int>();
byte[] word_idCountBytes = BitConverter.GetBytes(word_id.Count);
            ms.Write(word_idCountBytes,0,word_idCountBytes.Length);
for (int i = 0; i < word_id.Count; i++){
byte[] word_idBytes = BitConverter.GetBytes(word_id[i]);
            ms.Write(word_idBytes,0,word_idBytes.Length);
}
byte[] directionBytes = BitConverter.GetBytes(direction);
            ms.Write(directionBytes,0,directionBytes.Length);
byte[] animationBytes = BitConverter.GetBytes(animation);
            ms.Write(animationBytes,0,animationBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
dialog_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
role_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int word_idCount;
word_idCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
word_id = new List<int>(word_idCount);
for (int i = 0; i < word_idCount; i++){
word_id.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
direction = BitConverter.ToInt32(bytes, offset);
            offset += 4;
animation = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysdld_layer_matrix
    {
		public string unikey;
		public int dld_layer; //ID
		public List<int> dld_layers; //对应层
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dld_layerBytes = BitConverter.GetBytes(dld_layer);
            ms.Write(dld_layerBytes,0,dld_layerBytes.Length);
if(dld_layers==null)dld_layers = new List<int>();
byte[] dld_layersCountBytes = BitConverter.GetBytes(dld_layers.Count);
            ms.Write(dld_layersCountBytes,0,dld_layersCountBytes.Length);
for (int i = 0; i < dld_layers.Count; i++){
byte[] dld_layersBytes = BitConverter.GetBytes(dld_layers[i]);
            ms.Write(dld_layersBytes,0,dld_layersBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
dld_layer = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dld_layersCount;
dld_layersCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dld_layers = new List<int>(dld_layersCount);
for (int i = 0; i < dld_layersCount; i++){
dld_layers.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysdouble_battle_lv
    {
		public string unikey;
		public int lv; //段位
		public int min; //最小积分
		public int max; //最大积分
		public string name; //段位名称
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] minBytes = BitConverter.GetBytes(min);
            ms.Write(minBytes,0,minBytes.Length);
byte[] maxBytes = BitConverter.GetBytes(max);
            ms.Write(maxBytes,0,maxBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
min = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
return offset;
        }
} 
 [Serializable]public class Sysdungeon
    {
		public string unikey;
		public int dungeon_id; //关卡ID
		public string dungeon_name; //关卡名称
		public string map; //场景地图
		public int xml; //场景配置
		public int chapter_id; //章节ID
		public int pre_dungeon; //前置关卡ID
		public int pre_nomal_dungeon; //前置普通副本关卡id
		public int next_dungeon; //下一关关卡ID
		public int type; //关卡类型
		public int strength_w; //挑战胜利消耗体力
		public int strength_f; //挑战失败消耗体力
		public int strength_s; //扫荡消耗体力
		public int lv; //等级限制
		public int advise_lv; //推荐等级
		public int advise_combat; //推荐战力
		public int time; //时间限制
		public int monster_limit; //野怪数量限制
		public List<Sysstar_rule> rule; //星数规则
		public List<Sysdesc_rule> rule_desc; //规则描述，显示用
		public string reward; //挑战胜利奖励
		public int star; //最高星数
		public int can_auto; //托管战斗
		public int times; //每日可通关次数
		public List<int> drop; //副本掉落前端显示
		public int hero_limit; //英雄进入数限制
		public List<Sysdungeon_position> target_pos; //角色下一个目标点
		public List<int> icon_pos; //小关卡在UI上的位置
		public List<Syswin_rule> win_rule; //胜利条件
		public List<Sysfail_rule> fail_rule; //失败规则
		public string map_load; //关卡loading图片
		public int hero_ai1; //副本主英雄ai调用
		public int hero_ai2; //副本副英雄ai调用
		public int field_of_view; //视野
		public float offset_x; //x偏移
		public float offset_y; //y偏移
		public float offset_z; //z偏移
		public int joystick_direction; //摇杆方向
		public string fog_color; //雾颜色
		public float fog_start; //雾开始位置
		public float fog_end; //雾结束位置
		public float fog_density; //雾的强度
		public string camera_effect; //
		public List<Sysstory> story; //剧情
		public List<Sysmons_dialog> mons_dialog; //野怪对话
		public string dungeon_desc; //副本攻略
		public int iconType; //副本icon类型
		public int show_guid; //是否显示指引
		public int difficulty_level; //难度系数
		public string buff_desc; //BOSS描述
		public List<int> scene_skill; //场景技能
		public int early_spawn_monster; //提前刷怪
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dungeon_idBytes = BitConverter.GetBytes(dungeon_id);
            ms.Write(dungeon_idBytes,0,dungeon_idBytes.Length);
if(string.IsNullOrEmpty(dungeon_name))dungeon_name = string.Empty;
            byte[] dungeon_nameBytes = System.Text.Encoding.UTF8.GetBytes(dungeon_name);
            byte[] dungeon_nameBytesLen = BitConverter.GetBytes(dungeon_nameBytes.Length);
            ms.Write(dungeon_nameBytesLen, 0, dungeon_nameBytesLen.Length);
            ms.Write(dungeon_nameBytes, 0, dungeon_nameBytes.Length);
if(string.IsNullOrEmpty(map))map = string.Empty;
            byte[] mapBytes = System.Text.Encoding.UTF8.GetBytes(map);
            byte[] mapBytesLen = BitConverter.GetBytes(mapBytes.Length);
            ms.Write(mapBytesLen, 0, mapBytesLen.Length);
            ms.Write(mapBytes, 0, mapBytes.Length);
byte[] xmlBytes = BitConverter.GetBytes(xml);
            ms.Write(xmlBytes,0,xmlBytes.Length);
byte[] chapter_idBytes = BitConverter.GetBytes(chapter_id);
            ms.Write(chapter_idBytes,0,chapter_idBytes.Length);
byte[] pre_dungeonBytes = BitConverter.GetBytes(pre_dungeon);
            ms.Write(pre_dungeonBytes,0,pre_dungeonBytes.Length);
byte[] pre_nomal_dungeonBytes = BitConverter.GetBytes(pre_nomal_dungeon);
            ms.Write(pre_nomal_dungeonBytes,0,pre_nomal_dungeonBytes.Length);
byte[] next_dungeonBytes = BitConverter.GetBytes(next_dungeon);
            ms.Write(next_dungeonBytes,0,next_dungeonBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] strength_wBytes = BitConverter.GetBytes(strength_w);
            ms.Write(strength_wBytes,0,strength_wBytes.Length);
byte[] strength_fBytes = BitConverter.GetBytes(strength_f);
            ms.Write(strength_fBytes,0,strength_fBytes.Length);
byte[] strength_sBytes = BitConverter.GetBytes(strength_s);
            ms.Write(strength_sBytes,0,strength_sBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] advise_lvBytes = BitConverter.GetBytes(advise_lv);
            ms.Write(advise_lvBytes,0,advise_lvBytes.Length);
byte[] advise_combatBytes = BitConverter.GetBytes(advise_combat);
            ms.Write(advise_combatBytes,0,advise_combatBytes.Length);
byte[] timeBytes = BitConverter.GetBytes(time);
            ms.Write(timeBytes,0,timeBytes.Length);
byte[] monster_limitBytes = BitConverter.GetBytes(monster_limit);
            ms.Write(monster_limitBytes,0,monster_limitBytes.Length);
if(rule==null)rule = new List<Sysstar_rule>();
byte[] ruleCountBytes = BitConverter.GetBytes(rule.Count);
            ms.Write(ruleCountBytes,0,ruleCountBytes.Length);
for (int i = 0; i < rule.Count; i++){
if(rule[i] == null)rule[i] = new Sysstar_rule();rule[i].Serializer(ms);
}
if(rule_desc==null)rule_desc = new List<Sysdesc_rule>();
byte[] rule_descCountBytes = BitConverter.GetBytes(rule_desc.Count);
            ms.Write(rule_descCountBytes,0,rule_descCountBytes.Length);
for (int i = 0; i < rule_desc.Count; i++){
if(rule_desc[i] == null)rule_desc[i] = new Sysdesc_rule();rule_desc[i].Serializer(ms);
}
if(string.IsNullOrEmpty(reward))reward = string.Empty;
            byte[] rewardBytes = System.Text.Encoding.UTF8.GetBytes(reward);
            byte[] rewardBytesLen = BitConverter.GetBytes(rewardBytes.Length);
            ms.Write(rewardBytesLen, 0, rewardBytesLen.Length);
            ms.Write(rewardBytes, 0, rewardBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] can_autoBytes = BitConverter.GetBytes(can_auto);
            ms.Write(can_autoBytes,0,can_autoBytes.Length);
byte[] timesBytes = BitConverter.GetBytes(times);
            ms.Write(timesBytes,0,timesBytes.Length);
if(drop==null)drop = new List<int>();
byte[] dropCountBytes = BitConverter.GetBytes(drop.Count);
            ms.Write(dropCountBytes,0,dropCountBytes.Length);
for (int i = 0; i < drop.Count; i++){
byte[] dropBytes = BitConverter.GetBytes(drop[i]);
            ms.Write(dropBytes,0,dropBytes.Length);
}
byte[] hero_limitBytes = BitConverter.GetBytes(hero_limit);
            ms.Write(hero_limitBytes,0,hero_limitBytes.Length);
if(target_pos==null)target_pos = new List<Sysdungeon_position>();
byte[] target_posCountBytes = BitConverter.GetBytes(target_pos.Count);
            ms.Write(target_posCountBytes,0,target_posCountBytes.Length);
for (int i = 0; i < target_pos.Count; i++){
if(target_pos[i] == null)target_pos[i] = new Sysdungeon_position();target_pos[i].Serializer(ms);
}
if(icon_pos==null)icon_pos = new List<int>();
byte[] icon_posCountBytes = BitConverter.GetBytes(icon_pos.Count);
            ms.Write(icon_posCountBytes,0,icon_posCountBytes.Length);
for (int i = 0; i < icon_pos.Count; i++){
byte[] icon_posBytes = BitConverter.GetBytes(icon_pos[i]);
            ms.Write(icon_posBytes,0,icon_posBytes.Length);
}
if(win_rule==null)win_rule = new List<Syswin_rule>();
byte[] win_ruleCountBytes = BitConverter.GetBytes(win_rule.Count);
            ms.Write(win_ruleCountBytes,0,win_ruleCountBytes.Length);
for (int i = 0; i < win_rule.Count; i++){
if(win_rule[i] == null)win_rule[i] = new Syswin_rule();win_rule[i].Serializer(ms);
}
if(fail_rule==null)fail_rule = new List<Sysfail_rule>();
byte[] fail_ruleCountBytes = BitConverter.GetBytes(fail_rule.Count);
            ms.Write(fail_ruleCountBytes,0,fail_ruleCountBytes.Length);
for (int i = 0; i < fail_rule.Count; i++){
if(fail_rule[i] == null)fail_rule[i] = new Sysfail_rule();fail_rule[i].Serializer(ms);
}
if(string.IsNullOrEmpty(map_load))map_load = string.Empty;
            byte[] map_loadBytes = System.Text.Encoding.UTF8.GetBytes(map_load);
            byte[] map_loadBytesLen = BitConverter.GetBytes(map_loadBytes.Length);
            ms.Write(map_loadBytesLen, 0, map_loadBytesLen.Length);
            ms.Write(map_loadBytes, 0, map_loadBytes.Length);
byte[] hero_ai1Bytes = BitConverter.GetBytes(hero_ai1);
            ms.Write(hero_ai1Bytes,0,hero_ai1Bytes.Length);
byte[] hero_ai2Bytes = BitConverter.GetBytes(hero_ai2);
            ms.Write(hero_ai2Bytes,0,hero_ai2Bytes.Length);
byte[] field_of_viewBytes = BitConverter.GetBytes(field_of_view);
            ms.Write(field_of_viewBytes,0,field_of_viewBytes.Length);
byte[] offset_xBytes = BitConverter.GetBytes(offset_x);
            ms.Write(offset_xBytes,0,offset_xBytes.Length);
byte[] offset_yBytes = BitConverter.GetBytes(offset_y);
            ms.Write(offset_yBytes,0,offset_yBytes.Length);
byte[] offset_zBytes = BitConverter.GetBytes(offset_z);
            ms.Write(offset_zBytes,0,offset_zBytes.Length);
byte[] joystick_directionBytes = BitConverter.GetBytes(joystick_direction);
            ms.Write(joystick_directionBytes,0,joystick_directionBytes.Length);
if(string.IsNullOrEmpty(fog_color))fog_color = string.Empty;
            byte[] fog_colorBytes = System.Text.Encoding.UTF8.GetBytes(fog_color);
            byte[] fog_colorBytesLen = BitConverter.GetBytes(fog_colorBytes.Length);
            ms.Write(fog_colorBytesLen, 0, fog_colorBytesLen.Length);
            ms.Write(fog_colorBytes, 0, fog_colorBytes.Length);
byte[] fog_startBytes = BitConverter.GetBytes(fog_start);
            ms.Write(fog_startBytes,0,fog_startBytes.Length);
byte[] fog_endBytes = BitConverter.GetBytes(fog_end);
            ms.Write(fog_endBytes,0,fog_endBytes.Length);
byte[] fog_densityBytes = BitConverter.GetBytes(fog_density);
            ms.Write(fog_densityBytes,0,fog_densityBytes.Length);
if(string.IsNullOrEmpty(camera_effect))camera_effect = string.Empty;
            byte[] camera_effectBytes = System.Text.Encoding.UTF8.GetBytes(camera_effect);
            byte[] camera_effectBytesLen = BitConverter.GetBytes(camera_effectBytes.Length);
            ms.Write(camera_effectBytesLen, 0, camera_effectBytesLen.Length);
            ms.Write(camera_effectBytes, 0, camera_effectBytes.Length);
if(story==null)story = new List<Sysstory>();
byte[] storyCountBytes = BitConverter.GetBytes(story.Count);
            ms.Write(storyCountBytes,0,storyCountBytes.Length);
for (int i = 0; i < story.Count; i++){
if(story[i] == null)story[i] = new Sysstory();story[i].Serializer(ms);
}
if(mons_dialog==null)mons_dialog = new List<Sysmons_dialog>();
byte[] mons_dialogCountBytes = BitConverter.GetBytes(mons_dialog.Count);
            ms.Write(mons_dialogCountBytes,0,mons_dialogCountBytes.Length);
for (int i = 0; i < mons_dialog.Count; i++){
if(mons_dialog[i] == null)mons_dialog[i] = new Sysmons_dialog();mons_dialog[i].Serializer(ms);
}
if(string.IsNullOrEmpty(dungeon_desc))dungeon_desc = string.Empty;
            byte[] dungeon_descBytes = System.Text.Encoding.UTF8.GetBytes(dungeon_desc);
            byte[] dungeon_descBytesLen = BitConverter.GetBytes(dungeon_descBytes.Length);
            ms.Write(dungeon_descBytesLen, 0, dungeon_descBytesLen.Length);
            ms.Write(dungeon_descBytes, 0, dungeon_descBytes.Length);
byte[] iconTypeBytes = BitConverter.GetBytes(iconType);
            ms.Write(iconTypeBytes,0,iconTypeBytes.Length);
byte[] show_guidBytes = BitConverter.GetBytes(show_guid);
            ms.Write(show_guidBytes,0,show_guidBytes.Length);
byte[] difficulty_levelBytes = BitConverter.GetBytes(difficulty_level);
            ms.Write(difficulty_levelBytes,0,difficulty_levelBytes.Length);
if(string.IsNullOrEmpty(buff_desc))buff_desc = string.Empty;
            byte[] buff_descBytes = System.Text.Encoding.UTF8.GetBytes(buff_desc);
            byte[] buff_descBytesLen = BitConverter.GetBytes(buff_descBytes.Length);
            ms.Write(buff_descBytesLen, 0, buff_descBytesLen.Length);
            ms.Write(buff_descBytes, 0, buff_descBytes.Length);
if(scene_skill==null)scene_skill = new List<int>();
byte[] scene_skillCountBytes = BitConverter.GetBytes(scene_skill.Count);
            ms.Write(scene_skillCountBytes,0,scene_skillCountBytes.Length);
for (int i = 0; i < scene_skill.Count; i++){
byte[] scene_skillBytes = BitConverter.GetBytes(scene_skill[i]);
            ms.Write(scene_skillBytes,0,scene_skillBytes.Length);
}
byte[] early_spawn_monsterBytes = BitConverter.GetBytes(early_spawn_monster);
            ms.Write(early_spawn_monsterBytes,0,early_spawn_monsterBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
dungeon_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int dungeon_name_count;dungeon_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;dungeon_name = System.Text.Encoding.UTF8.GetString(bytes, offset, dungeon_name_count);offset += dungeon_name_count;
int map_count;map_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map = System.Text.Encoding.UTF8.GetString(bytes, offset, map_count);offset += map_count;
xml = BitConverter.ToInt32(bytes, offset);
            offset += 4;
chapter_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_nomal_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_w = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_f = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_s = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
advise_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
advise_combat = BitConverter.ToInt32(bytes, offset);
            offset += 4;
time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int ruleCount;
ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rule = new List<Sysstar_rule>(ruleCount);
for (int i = 0; i < ruleCount; i++){
rule.Add(new Sysstar_rule());offset = rule[i].Deserializer(bytes,offset);
}

int rule_descCount;
rule_descCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rule_desc = new List<Sysdesc_rule>(rule_descCount);
for (int i = 0; i < rule_descCount; i++){
rule_desc.Add(new Sysdesc_rule());offset = rule_desc[i].Deserializer(bytes,offset);
}
int reward_count;reward_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;reward = System.Text.Encoding.UTF8.GetString(bytes, offset, reward_count);offset += reward_count;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
can_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
times = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dropCount;
dropCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
drop = new List<int>(dropCount);
for (int i = 0; i < dropCount; i++){
drop.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
hero_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int target_posCount;
target_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
target_pos = new List<Sysdungeon_position>(target_posCount);
for (int i = 0; i < target_posCount; i++){
target_pos.Add(new Sysdungeon_position());offset = target_pos[i].Deserializer(bytes,offset);
}

int icon_posCount;
icon_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
icon_pos = new List<int>(icon_posCount);
for (int i = 0; i < icon_posCount; i++){
icon_pos.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int win_ruleCount;
win_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
win_rule = new List<Syswin_rule>(win_ruleCount);
for (int i = 0; i < win_ruleCount; i++){
win_rule.Add(new Syswin_rule());offset = win_rule[i].Deserializer(bytes,offset);
}

int fail_ruleCount;
fail_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fail_rule = new List<Sysfail_rule>(fail_ruleCount);
for (int i = 0; i < fail_ruleCount; i++){
fail_rule.Add(new Sysfail_rule());offset = fail_rule[i].Deserializer(bytes,offset);
}
int map_load_count;map_load_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map_load = System.Text.Encoding.UTF8.GetString(bytes, offset, map_load_count);offset += map_load_count;
hero_ai1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_ai2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
field_of_view = BitConverter.ToInt32(bytes, offset);
            offset += 4;
offset_x = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_y = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_z = BitConverter.ToSingle(bytes, offset);
            offset += 4;
joystick_direction = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int fog_color_count;fog_color_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;fog_color = System.Text.Encoding.UTF8.GetString(bytes, offset, fog_color_count);offset += fog_color_count;
fog_start = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fog_end = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fog_density = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int camera_effect_count;camera_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;camera_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, camera_effect_count);offset += camera_effect_count;

int storyCount;
storyCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
story = new List<Sysstory>(storyCount);
for (int i = 0; i < storyCount; i++){
story.Add(new Sysstory());offset = story[i].Deserializer(bytes,offset);
}

int mons_dialogCount;
mons_dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mons_dialog = new List<Sysmons_dialog>(mons_dialogCount);
for (int i = 0; i < mons_dialogCount; i++){
mons_dialog.Add(new Sysmons_dialog());offset = mons_dialog[i].Deserializer(bytes,offset);
}
int dungeon_desc_count;dungeon_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;dungeon_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, dungeon_desc_count);offset += dungeon_desc_count;
iconType = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_guid = BitConverter.ToInt32(bytes, offset);
            offset += 4;
difficulty_level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int buff_desc_count;buff_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buff_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, buff_desc_count);offset += buff_desc_count;

int scene_skillCount;
scene_skillCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
scene_skill = new List<int>(scene_skillCount);
for (int i = 0; i < scene_skillCount; i++){
scene_skill.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
early_spawn_monster = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysdungeon_position
    {
		public int x; //X
		public int y; //Y
		public int z; //Z
		public int room; //范围
		public int rotate; //方向
    public void Serializer(MemoryStream ms){

byte[] xBytes = BitConverter.GetBytes(x);
            ms.Write(xBytes,0,xBytes.Length);
byte[] yBytes = BitConverter.GetBytes(y);
            ms.Write(yBytes,0,yBytes.Length);
byte[] zBytes = BitConverter.GetBytes(z);
            ms.Write(zBytes,0,zBytes.Length);
byte[] roomBytes = BitConverter.GetBytes(room);
            ms.Write(roomBytes,0,roomBytes.Length);
byte[] rotateBytes = BitConverter.GetBytes(rotate);
            ms.Write(rotateBytes,0,rotateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

x = BitConverter.ToInt32(bytes, offset);
            offset += 4;
y = BitConverter.ToInt32(bytes, offset);
            offset += 4;
z = BitConverter.ToInt32(bytes, offset);
            offset += 4;
room = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rotate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysecode
    {
		public string unikey;
		public int error_code; //错误号
		public string error_tips; //错误提示
		public Sysecode_view view; //错误界面表现
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] error_codeBytes = BitConverter.GetBytes(error_code);
            ms.Write(error_codeBytes,0,error_codeBytes.Length);
if(string.IsNullOrEmpty(error_tips))error_tips = string.Empty;
            byte[] error_tipsBytes = System.Text.Encoding.UTF8.GetBytes(error_tips);
            byte[] error_tipsBytesLen = BitConverter.GetBytes(error_tipsBytes.Length);
            ms.Write(error_tipsBytesLen, 0, error_tipsBytesLen.Length);
            ms.Write(error_tipsBytes, 0, error_tipsBytes.Length);
if(view == null)view = new Sysecode_view();view.Serializer(ms);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
error_code = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int error_tips_count;error_tips_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;error_tips = System.Text.Encoding.UTF8.GetString(bytes, offset, error_tips_count);offset += error_tips_count;
view = new Sysecode_view();offset = view.Deserializer(bytes,offset);
return offset;
        }
} 
 [Serializable]public class Sysecode_view
    {
		public int index; //索引号
		public string left_str; //左按钮
		public string right_str; //右按钮
		public string title; //标题
    public void Serializer(MemoryStream ms){

byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
if(string.IsNullOrEmpty(left_str))left_str = string.Empty;
            byte[] left_strBytes = System.Text.Encoding.UTF8.GetBytes(left_str);
            byte[] left_strBytesLen = BitConverter.GetBytes(left_strBytes.Length);
            ms.Write(left_strBytesLen, 0, left_strBytesLen.Length);
            ms.Write(left_strBytes, 0, left_strBytes.Length);
if(string.IsNullOrEmpty(right_str))right_str = string.Empty;
            byte[] right_strBytes = System.Text.Encoding.UTF8.GetBytes(right_str);
            byte[] right_strBytesLen = BitConverter.GetBytes(right_strBytes.Length);
            ms.Write(right_strBytesLen, 0, right_strBytesLen.Length);
            ms.Write(right_strBytes, 0, right_strBytes.Length);
if(string.IsNullOrEmpty(title))title = string.Empty;
            byte[] titleBytes = System.Text.Encoding.UTF8.GetBytes(title);
            byte[] titleBytesLen = BitConverter.GetBytes(titleBytes.Length);
            ms.Write(titleBytesLen, 0, titleBytesLen.Length);
            ms.Write(titleBytes, 0, titleBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

index = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int left_str_count;left_str_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;left_str = System.Text.Encoding.UTF8.GetString(bytes, offset, left_str_count);offset += left_str_count;
int right_str_count;right_str_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;right_str = System.Text.Encoding.UTF8.GetString(bytes, offset, right_str_count);offset += right_str_count;
int title_count;title_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;title = System.Text.Encoding.UTF8.GetString(bytes, offset, title_count);offset += title_count;
return offset;
        }
} 
 [Serializable]public class Sysenergy_buy_use_gold
    {
		public string unikey;
		public int num; //第N次购买
		public int gold; //购买体力消耗钻石
		public int energy; //添加的体力
		public int need_gold; //购买金币消耗钻石
		public int coin; //添加的金币
		public int need_gold_skill; //购买技能点消耗钻石
		public int skill_point; //添加的技能点
		public int dun_gold; //购买精英副本消耗钻石
		public int hero_deed_star; //契约消耗金币
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
byte[] energyBytes = BitConverter.GetBytes(energy);
            ms.Write(energyBytes,0,energyBytes.Length);
byte[] need_goldBytes = BitConverter.GetBytes(need_gold);
            ms.Write(need_goldBytes,0,need_goldBytes.Length);
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] need_gold_skillBytes = BitConverter.GetBytes(need_gold_skill);
            ms.Write(need_gold_skillBytes,0,need_gold_skillBytes.Length);
byte[] skill_pointBytes = BitConverter.GetBytes(skill_point);
            ms.Write(skill_pointBytes,0,skill_pointBytes.Length);
byte[] dun_goldBytes = BitConverter.GetBytes(dun_gold);
            ms.Write(dun_goldBytes,0,dun_goldBytes.Length);
byte[] hero_deed_starBytes = BitConverter.GetBytes(hero_deed_star);
            ms.Write(hero_deed_starBytes,0,hero_deed_starBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
energy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_gold_skill = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill_point = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dun_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_deed_star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequip
    {
		public string unikey;
		public int id; //装备id
		public string name; //装备名称
		public string icon; //装备图标
		public int star; //装备初始星级（铸魂）
		public int quality; //装备初始品质（强化）
		public string desc; //装备简介
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float hp_grow; //生命
		public float patk_grow; //攻击
		public float pdef_grow; //护甲
		public float matk_grow; //法强
		public float mdef_grow; //魔抗
		public float ppenetrate_grow; //护甲穿透
		public float mpenetrate_grow; //法术穿透
		public float recover_grow; //生命回复
		public float cri_odds_grow; //物理暴击值
		public float cri_offset_grow; //物理抗暴值
		public float mcri_odds_grow; //法术暴击值
		public float mcri_offset_grow; //法术抗暴值
		public float pconvert_life_grow; //物理吸血%
		public float mconvert_life_grow; //法术吸血%
		public float preturn_damage_grow; //物理反伤%
		public float mreturn_damage_grow; //法术反伤%
		public float cri_hurt_grow; //暴击伤害%
		public float cri_resist_grow; //暴伤减免%
		public int pdef_ignore_grow; //忽略护甲%
		public int mdef_ignore_grow; //忽略魔抗%
		public float tenacity_grow; //韧性%
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] hp_growBytes = BitConverter.GetBytes(hp_grow);
            ms.Write(hp_growBytes,0,hp_growBytes.Length);
byte[] patk_growBytes = BitConverter.GetBytes(patk_grow);
            ms.Write(patk_growBytes,0,patk_growBytes.Length);
byte[] pdef_growBytes = BitConverter.GetBytes(pdef_grow);
            ms.Write(pdef_growBytes,0,pdef_growBytes.Length);
byte[] matk_growBytes = BitConverter.GetBytes(matk_grow);
            ms.Write(matk_growBytes,0,matk_growBytes.Length);
byte[] mdef_growBytes = BitConverter.GetBytes(mdef_grow);
            ms.Write(mdef_growBytes,0,mdef_growBytes.Length);
byte[] ppenetrate_growBytes = BitConverter.GetBytes(ppenetrate_grow);
            ms.Write(ppenetrate_growBytes,0,ppenetrate_growBytes.Length);
byte[] mpenetrate_growBytes = BitConverter.GetBytes(mpenetrate_grow);
            ms.Write(mpenetrate_growBytes,0,mpenetrate_growBytes.Length);
byte[] recover_growBytes = BitConverter.GetBytes(recover_grow);
            ms.Write(recover_growBytes,0,recover_growBytes.Length);
byte[] cri_odds_growBytes = BitConverter.GetBytes(cri_odds_grow);
            ms.Write(cri_odds_growBytes,0,cri_odds_growBytes.Length);
byte[] cri_offset_growBytes = BitConverter.GetBytes(cri_offset_grow);
            ms.Write(cri_offset_growBytes,0,cri_offset_growBytes.Length);
byte[] mcri_odds_growBytes = BitConverter.GetBytes(mcri_odds_grow);
            ms.Write(mcri_odds_growBytes,0,mcri_odds_growBytes.Length);
byte[] mcri_offset_growBytes = BitConverter.GetBytes(mcri_offset_grow);
            ms.Write(mcri_offset_growBytes,0,mcri_offset_growBytes.Length);
byte[] pconvert_life_growBytes = BitConverter.GetBytes(pconvert_life_grow);
            ms.Write(pconvert_life_growBytes,0,pconvert_life_growBytes.Length);
byte[] mconvert_life_growBytes = BitConverter.GetBytes(mconvert_life_grow);
            ms.Write(mconvert_life_growBytes,0,mconvert_life_growBytes.Length);
byte[] preturn_damage_growBytes = BitConverter.GetBytes(preturn_damage_grow);
            ms.Write(preturn_damage_growBytes,0,preturn_damage_growBytes.Length);
byte[] mreturn_damage_growBytes = BitConverter.GetBytes(mreturn_damage_grow);
            ms.Write(mreturn_damage_growBytes,0,mreturn_damage_growBytes.Length);
byte[] cri_hurt_growBytes = BitConverter.GetBytes(cri_hurt_grow);
            ms.Write(cri_hurt_growBytes,0,cri_hurt_growBytes.Length);
byte[] cri_resist_growBytes = BitConverter.GetBytes(cri_resist_grow);
            ms.Write(cri_resist_growBytes,0,cri_resist_growBytes.Length);
byte[] pdef_ignore_growBytes = BitConverter.GetBytes(pdef_ignore_grow);
            ms.Write(pdef_ignore_growBytes,0,pdef_ignore_growBytes.Length);
byte[] mdef_ignore_growBytes = BitConverter.GetBytes(mdef_ignore_grow);
            ms.Write(mdef_ignore_growBytes,0,mdef_ignore_growBytes.Length);
byte[] tenacity_growBytes = BitConverter.GetBytes(tenacity_grow);
            ms.Write(tenacity_growBytes,0,tenacity_growBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
hp_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore_grow = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore_grow = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_quality
    {
		public string unikey;
		public int id; //装备id
		public int quality; //装备品质（强化）
		public List<Sysequips_quality_material> material; //强化需要的材料
		public int coin; //强化需要的金币
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
if(material==null)material = new List<Sysequips_quality_material>();
byte[] materialCountBytes = BitConverter.GetBytes(material.Count);
            ms.Write(materialCountBytes,0,materialCountBytes.Length);
for (int i = 0; i < material.Count; i++){
if(material[i] == null)material[i] = new Sysequips_quality_material();material[i].Serializer(ms);
}
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int materialCount;
materialCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
material = new List<Sysequips_quality_material>(materialCount);
for (int i = 0; i < materialCount; i++){
material.Add(new Sysequips_quality_material());offset = material[i].Deserializer(bytes,offset);
}
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_quality_material
    {
		public int id; //物品id
		public int num; //数量
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_quality_to_level
    {
		public string unikey;
		public int quality; //装备品质（强化）
		public int level; //强化到达的最高等级
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_star
    {
		public string unikey;
		public int id; //装备id
		public int star; //装备升星（铸魂）
		public List<Sysequips_star_material> material; //铸魂需要的材料
		public int coin; //铸魂需要的金币
		public float args; //铸魂增加的属性成长值
		public string misc; //铸魂增加的技能描述
		public string skill_name; //铸魂增加的技能名字
		public List<Sysequips_star_args> skill_args; //铸魂技能增加的属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
if(material==null)material = new List<Sysequips_star_material>();
byte[] materialCountBytes = BitConverter.GetBytes(material.Count);
            ms.Write(materialCountBytes,0,materialCountBytes.Length);
for (int i = 0; i < material.Count; i++){
if(material[i] == null)material[i] = new Sysequips_star_material();material[i].Serializer(ms);
}
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] argsBytes = BitConverter.GetBytes(args);
            ms.Write(argsBytes,0,argsBytes.Length);
if(string.IsNullOrEmpty(misc))misc = string.Empty;
            byte[] miscBytes = System.Text.Encoding.UTF8.GetBytes(misc);
            byte[] miscBytesLen = BitConverter.GetBytes(miscBytes.Length);
            ms.Write(miscBytesLen, 0, miscBytesLen.Length);
            ms.Write(miscBytes, 0, miscBytes.Length);
if(string.IsNullOrEmpty(skill_name))skill_name = string.Empty;
            byte[] skill_nameBytes = System.Text.Encoding.UTF8.GetBytes(skill_name);
            byte[] skill_nameBytesLen = BitConverter.GetBytes(skill_nameBytes.Length);
            ms.Write(skill_nameBytesLen, 0, skill_nameBytesLen.Length);
            ms.Write(skill_nameBytes, 0, skill_nameBytes.Length);
if(skill_args==null)skill_args = new List<Sysequips_star_args>();
byte[] skill_argsCountBytes = BitConverter.GetBytes(skill_args.Count);
            ms.Write(skill_argsCountBytes,0,skill_argsCountBytes.Length);
for (int i = 0; i < skill_args.Count; i++){
if(skill_args[i] == null)skill_args[i] = new Sysequips_star_args();skill_args[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int materialCount;
materialCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
material = new List<Sysequips_star_material>(materialCount);
for (int i = 0; i < materialCount; i++){
material.Add(new Sysequips_star_material());offset = material[i].Deserializer(bytes,offset);
}
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
args = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int misc_count;misc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;misc = System.Text.Encoding.UTF8.GetString(bytes, offset, misc_count);offset += misc_count;
int skill_name_count;skill_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;skill_name = System.Text.Encoding.UTF8.GetString(bytes, offset, skill_name_count);offset += skill_name_count;

int skill_argsCount;
skill_argsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill_args = new List<Sysequips_star_args>(skill_argsCount);
for (int i = 0; i < skill_argsCount; i++){
skill_args.Add(new Sysequips_star_args());offset = skill_args[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysequips_star_args
    {
		public int id; //属性id
		public float num; //属性值
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_star_material
    {
		public int id; //物品id
		public int num; //数量
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequips_up_level_use_coin
    {
		public string unikey;
		public int level; //装备升级
		public int coin; //升级需要的金币
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequip_level
    {
		public string unikey;
		public int id; //装备id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysequip_star_material
    {
		public string unikey;
		public int id; //次数
		public List<Sysequip_star_material_goods> normal_goods; //铸抽奖普通物品
		public List<Sysequip_star_material_goods> super_goods; //铸魂抽奖特殊逼得物品
		public int gold; //钻石花费
		public int get_money; //获得碎片
		public List<int> reward_show; //界面显示奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(normal_goods==null)normal_goods = new List<Sysequip_star_material_goods>();
byte[] normal_goodsCountBytes = BitConverter.GetBytes(normal_goods.Count);
            ms.Write(normal_goodsCountBytes,0,normal_goodsCountBytes.Length);
for (int i = 0; i < normal_goods.Count; i++){
if(normal_goods[i] == null)normal_goods[i] = new Sysequip_star_material_goods();normal_goods[i].Serializer(ms);
}
if(super_goods==null)super_goods = new List<Sysequip_star_material_goods>();
byte[] super_goodsCountBytes = BitConverter.GetBytes(super_goods.Count);
            ms.Write(super_goodsCountBytes,0,super_goodsCountBytes.Length);
for (int i = 0; i < super_goods.Count; i++){
if(super_goods[i] == null)super_goods[i] = new Sysequip_star_material_goods();super_goods[i].Serializer(ms);
}
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
byte[] get_moneyBytes = BitConverter.GetBytes(get_money);
            ms.Write(get_moneyBytes,0,get_moneyBytes.Length);
if(reward_show==null)reward_show = new List<int>();
byte[] reward_showCountBytes = BitConverter.GetBytes(reward_show.Count);
            ms.Write(reward_showCountBytes,0,reward_showCountBytes.Length);
for (int i = 0; i < reward_show.Count; i++){
byte[] reward_showBytes = BitConverter.GetBytes(reward_show[i]);
            ms.Write(reward_showBytes,0,reward_showBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int normal_goodsCount;
normal_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
normal_goods = new List<Sysequip_star_material_goods>(normal_goodsCount);
for (int i = 0; i < normal_goodsCount; i++){
normal_goods.Add(new Sysequip_star_material_goods());offset = normal_goods[i].Deserializer(bytes,offset);
}

int super_goodsCount;
super_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
super_goods = new List<Sysequip_star_material_goods>(super_goodsCount);
for (int i = 0; i < super_goodsCount; i++){
super_goods.Add(new Sysequip_star_material_goods());offset = super_goods[i].Deserializer(bytes,offset);
}
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
get_money = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int reward_showCount;
reward_showCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward_show = new List<int>(reward_showCount);
for (int i = 0; i < reward_showCount; i++){
reward_show.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysequip_star_material_goods
    {
		public int id; //主表索引ID
		public int goods_id; //物品1D
		public int goods_num; //物品数量
		public int rank; //产生的几率
		public int goods_type; //物品类型
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
byte[] rankBytes = BitConverter.GetBytes(rank);
            ms.Write(rankBytes,0,rankBytes.Length);
byte[] goods_typeBytes = BitConverter.GetBytes(goods_type);
            ms.Write(goods_typeBytes,0,goods_typeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rank = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysescort
    {
		public string unikey;
		public int id; //护送
		public int free_times; //每日免费护送次数
		public int escort_time; //护送需要时间
		public List<int> double_begin; //增益开始时间
		public List<int> double_end; //增益结束时间
		public int protected_cd; //被拦截保护CD
		public int free_plunder_times; //免费拦截次数
		public int rob_info_limit; //抢夺信息条数
		public List<int> boat_show_limit; //最多显示船数量
		public int robbed_limit; //可被掠夺次数
		public int speed_cost; //清除CD消费钻石
		public int boat_up_quality; //刷新船只品质
		public int free_refresh_times; //每日免费刷新次数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] free_timesBytes = BitConverter.GetBytes(free_times);
            ms.Write(free_timesBytes,0,free_timesBytes.Length);
byte[] escort_timeBytes = BitConverter.GetBytes(escort_time);
            ms.Write(escort_timeBytes,0,escort_timeBytes.Length);
if(double_begin==null)double_begin = new List<int>();
byte[] double_beginCountBytes = BitConverter.GetBytes(double_begin.Count);
            ms.Write(double_beginCountBytes,0,double_beginCountBytes.Length);
for (int i = 0; i < double_begin.Count; i++){
byte[] double_beginBytes = BitConverter.GetBytes(double_begin[i]);
            ms.Write(double_beginBytes,0,double_beginBytes.Length);
}
if(double_end==null)double_end = new List<int>();
byte[] double_endCountBytes = BitConverter.GetBytes(double_end.Count);
            ms.Write(double_endCountBytes,0,double_endCountBytes.Length);
for (int i = 0; i < double_end.Count; i++){
byte[] double_endBytes = BitConverter.GetBytes(double_end[i]);
            ms.Write(double_endBytes,0,double_endBytes.Length);
}
byte[] protected_cdBytes = BitConverter.GetBytes(protected_cd);
            ms.Write(protected_cdBytes,0,protected_cdBytes.Length);
byte[] free_plunder_timesBytes = BitConverter.GetBytes(free_plunder_times);
            ms.Write(free_plunder_timesBytes,0,free_plunder_timesBytes.Length);
byte[] rob_info_limitBytes = BitConverter.GetBytes(rob_info_limit);
            ms.Write(rob_info_limitBytes,0,rob_info_limitBytes.Length);
if(boat_show_limit==null)boat_show_limit = new List<int>();
byte[] boat_show_limitCountBytes = BitConverter.GetBytes(boat_show_limit.Count);
            ms.Write(boat_show_limitCountBytes,0,boat_show_limitCountBytes.Length);
for (int i = 0; i < boat_show_limit.Count; i++){
byte[] boat_show_limitBytes = BitConverter.GetBytes(boat_show_limit[i]);
            ms.Write(boat_show_limitBytes,0,boat_show_limitBytes.Length);
}
byte[] robbed_limitBytes = BitConverter.GetBytes(robbed_limit);
            ms.Write(robbed_limitBytes,0,robbed_limitBytes.Length);
byte[] speed_costBytes = BitConverter.GetBytes(speed_cost);
            ms.Write(speed_costBytes,0,speed_costBytes.Length);
byte[] boat_up_qualityBytes = BitConverter.GetBytes(boat_up_quality);
            ms.Write(boat_up_qualityBytes,0,boat_up_qualityBytes.Length);
byte[] free_refresh_timesBytes = BitConverter.GetBytes(free_refresh_times);
            ms.Write(free_refresh_timesBytes,0,free_refresh_timesBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
free_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int double_beginCount;
double_beginCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
double_begin = new List<int>(double_beginCount);
for (int i = 0; i < double_beginCount; i++){
double_begin.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int double_endCount;
double_endCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
double_end = new List<int>(double_endCount);
for (int i = 0; i < double_endCount; i++){
double_end.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
protected_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
free_plunder_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rob_info_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int boat_show_limitCount;
boat_show_limitCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
boat_show_limit = new List<int>(boat_show_limitCount);
for (int i = 0; i < boat_show_limitCount; i++){
boat_show_limit.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
robbed_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;
speed_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
boat_up_quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
free_refresh_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysescort_boat
    {
		public string unikey;
		public int qulity; //品质
		public List<Sysrefresh_rate> gold_refresh; //钻石刷新概率
		public List<Sysrefresh_rate> free_refresh; //免费刷新概率
		public List<Sysescort_goods> common_reward; //正常收益
		public List<Sysescort_goods> active_reward; //增益活动收益
		public List<Sysescort_goods> robbed_reward; //被抢夺收益
		public string name; //名字
		public string icon; //图标
		public string texture; //原画
		public string model; //模型
		public float scale; //缩放
		public float x_rotate; //x旋转
		public float y_rotate; //y旋转
		public float z_rotate; //z旋转
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] qulityBytes = BitConverter.GetBytes(qulity);
            ms.Write(qulityBytes,0,qulityBytes.Length);
if(gold_refresh==null)gold_refresh = new List<Sysrefresh_rate>();
byte[] gold_refreshCountBytes = BitConverter.GetBytes(gold_refresh.Count);
            ms.Write(gold_refreshCountBytes,0,gold_refreshCountBytes.Length);
for (int i = 0; i < gold_refresh.Count; i++){
if(gold_refresh[i] == null)gold_refresh[i] = new Sysrefresh_rate();gold_refresh[i].Serializer(ms);
}
if(free_refresh==null)free_refresh = new List<Sysrefresh_rate>();
byte[] free_refreshCountBytes = BitConverter.GetBytes(free_refresh.Count);
            ms.Write(free_refreshCountBytes,0,free_refreshCountBytes.Length);
for (int i = 0; i < free_refresh.Count; i++){
if(free_refresh[i] == null)free_refresh[i] = new Sysrefresh_rate();free_refresh[i].Serializer(ms);
}
if(common_reward==null)common_reward = new List<Sysescort_goods>();
byte[] common_rewardCountBytes = BitConverter.GetBytes(common_reward.Count);
            ms.Write(common_rewardCountBytes,0,common_rewardCountBytes.Length);
for (int i = 0; i < common_reward.Count; i++){
if(common_reward[i] == null)common_reward[i] = new Sysescort_goods();common_reward[i].Serializer(ms);
}
if(active_reward==null)active_reward = new List<Sysescort_goods>();
byte[] active_rewardCountBytes = BitConverter.GetBytes(active_reward.Count);
            ms.Write(active_rewardCountBytes,0,active_rewardCountBytes.Length);
for (int i = 0; i < active_reward.Count; i++){
if(active_reward[i] == null)active_reward[i] = new Sysescort_goods();active_reward[i].Serializer(ms);
}
if(robbed_reward==null)robbed_reward = new List<Sysescort_goods>();
byte[] robbed_rewardCountBytes = BitConverter.GetBytes(robbed_reward.Count);
            ms.Write(robbed_rewardCountBytes,0,robbed_rewardCountBytes.Length);
for (int i = 0; i < robbed_reward.Count; i++){
if(robbed_reward[i] == null)robbed_reward[i] = new Sysescort_goods();robbed_reward[i].Serializer(ms);
}
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(texture))texture = string.Empty;
            byte[] textureBytes = System.Text.Encoding.UTF8.GetBytes(texture);
            byte[] textureBytesLen = BitConverter.GetBytes(textureBytes.Length);
            ms.Write(textureBytesLen, 0, textureBytesLen.Length);
            ms.Write(textureBytes, 0, textureBytes.Length);
if(string.IsNullOrEmpty(model))model = string.Empty;
            byte[] modelBytes = System.Text.Encoding.UTF8.GetBytes(model);
            byte[] modelBytesLen = BitConverter.GetBytes(modelBytes.Length);
            ms.Write(modelBytesLen, 0, modelBytesLen.Length);
            ms.Write(modelBytes, 0, modelBytes.Length);
byte[] scaleBytes = BitConverter.GetBytes(scale);
            ms.Write(scaleBytes,0,scaleBytes.Length);
byte[] x_rotateBytes = BitConverter.GetBytes(x_rotate);
            ms.Write(x_rotateBytes,0,x_rotateBytes.Length);
byte[] y_rotateBytes = BitConverter.GetBytes(y_rotate);
            ms.Write(y_rotateBytes,0,y_rotateBytes.Length);
byte[] z_rotateBytes = BitConverter.GetBytes(z_rotate);
            ms.Write(z_rotateBytes,0,z_rotateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
qulity = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int gold_refreshCount;
gold_refreshCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_refresh = new List<Sysrefresh_rate>(gold_refreshCount);
for (int i = 0; i < gold_refreshCount; i++){
gold_refresh.Add(new Sysrefresh_rate());offset = gold_refresh[i].Deserializer(bytes,offset);
}

int free_refreshCount;
free_refreshCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
free_refresh = new List<Sysrefresh_rate>(free_refreshCount);
for (int i = 0; i < free_refreshCount; i++){
free_refresh.Add(new Sysrefresh_rate());offset = free_refresh[i].Deserializer(bytes,offset);
}

int common_rewardCount;
common_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
common_reward = new List<Sysescort_goods>(common_rewardCount);
for (int i = 0; i < common_rewardCount; i++){
common_reward.Add(new Sysescort_goods());offset = common_reward[i].Deserializer(bytes,offset);
}

int active_rewardCount;
active_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
active_reward = new List<Sysescort_goods>(active_rewardCount);
for (int i = 0; i < active_rewardCount; i++){
active_reward.Add(new Sysescort_goods());offset = active_reward[i].Deserializer(bytes,offset);
}

int robbed_rewardCount;
robbed_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
robbed_reward = new List<Sysescort_goods>(robbed_rewardCount);
for (int i = 0; i < robbed_rewardCount; i++){
robbed_reward.Add(new Sysescort_goods());offset = robbed_reward[i].Deserializer(bytes,offset);
}
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int texture_count;texture_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;texture = System.Text.Encoding.UTF8.GetString(bytes, offset, texture_count);offset += texture_count;
int model_count;model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;model = System.Text.Encoding.UTF8.GetString(bytes, offset, model_count);offset += model_count;
scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;
x_rotate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
y_rotate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
z_rotate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysescort_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysexp
    {
		public string unikey;
		public int lv; //人物等级
		public int exp; //人物经验
		public int energy; //人物体力
		public int fight_coin; //斗币
		public List<Syslv_goods> goods; //等级奖励物品
		public List<string> function; //召唤师升级获得奖励描述及系统开启描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] energyBytes = BitConverter.GetBytes(energy);
            ms.Write(energyBytes,0,energyBytes.Length);
byte[] fight_coinBytes = BitConverter.GetBytes(fight_coin);
            ms.Write(fight_coinBytes,0,fight_coinBytes.Length);
if(goods==null)goods = new List<Syslv_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syslv_goods();goods[i].Serializer(ms);
}
if(function==null)function = new List<string>();
byte[] functionCountBytes = BitConverter.GetBytes(function.Count);
            ms.Write(functionCountBytes,0,functionCountBytes.Length);
for (int i = 0; i < function.Count; i++){
if(string.IsNullOrEmpty(function[i]))function[i] = string.Empty;
            byte[] functionBytes = System.Text.Encoding.UTF8.GetBytes(function[i]);
            byte[] functionBytesLen = BitConverter.GetBytes(functionBytes.Length);
            ms.Write(functionBytesLen, 0, functionBytesLen.Length);
            ms.Write(functionBytes, 0, functionBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
energy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fight_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syslv_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syslv_goods());offset = goods[i].Deserializer(bytes,offset);
}

int functionCount;
functionCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
function = new List<string>(functionCount);
for (int i = 0; i < functionCount; i++){
int function_count;function_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;function.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, function_count));offset += function_count;
}
return offset;
        }
} 
 [Serializable]public class Sysexp_player_skill
    {
		public string unikey;
		public int lv; //人物铜像等级
		public int exp; //人物铜像经验
		public float arg; //加成比例
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] argBytes = BitConverter.GetBytes(arg);
            ms.Write(argBytes,0,argBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysextra_hurt
    {
		public int id; //额外伤害 id
		public string name; //buff名称
		public List<int> triggers; //触发条件
		public string hurt_type; //属性类型
		public float attr_value_per; //属性基础值(百分比)
		public float attr_grow_per; //属性成长值(百分比)
		public float attr_value; //属性基础值
		public float attr_grow; //属性成长值
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(triggers==null)triggers = new List<int>();
byte[] triggersCountBytes = BitConverter.GetBytes(triggers.Count);
            ms.Write(triggersCountBytes,0,triggersCountBytes.Length);
for (int i = 0; i < triggers.Count; i++){
byte[] triggersBytes = BitConverter.GetBytes(triggers[i]);
            ms.Write(triggersBytes,0,triggersBytes.Length);
}
if(string.IsNullOrEmpty(hurt_type))hurt_type = string.Empty;
            byte[] hurt_typeBytes = System.Text.Encoding.UTF8.GetBytes(hurt_type);
            byte[] hurt_typeBytesLen = BitConverter.GetBytes(hurt_typeBytes.Length);
            ms.Write(hurt_typeBytesLen, 0, hurt_typeBytesLen.Length);
            ms.Write(hurt_typeBytes, 0, hurt_typeBytes.Length);
byte[] attr_value_perBytes = BitConverter.GetBytes(attr_value_per);
            ms.Write(attr_value_perBytes,0,attr_value_perBytes.Length);
byte[] attr_grow_perBytes = BitConverter.GetBytes(attr_grow_per);
            ms.Write(attr_grow_perBytes,0,attr_grow_perBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
byte[] attr_growBytes = BitConverter.GetBytes(attr_grow);
            ms.Write(attr_growBytes,0,attr_growBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int triggersCount;
triggersCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
triggers = new List<int>(triggersCount);
for (int i = 0; i < triggersCount; i++){
triggers.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int hurt_type_count;hurt_type_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;hurt_type = System.Text.Encoding.UTF8.GetString(bytes, offset, hurt_type_count);offset += hurt_type_count;
attr_value_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow_per = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_grow = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysfail_rule
    {
		public int type; //类型
		public List<int> param; //参数
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(param==null)param = new List<int>();
byte[] paramCountBytes = BitConverter.GetBytes(param.Count);
            ms.Write(paramCountBytes,0,paramCountBytes.Length);
for (int i = 0; i < param.Count; i++){
byte[] paramBytes = BitConverter.GetBytes(param[i]);
            ms.Write(paramBytes,0,paramBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int paramCount;
paramCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
param = new List<int>(paramCount);
for (int i = 0; i < paramCount; i++){
param.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysfriend_lookfor
    {
		public string unikey;
		public int id; //编号
		public List<Syslookfor_goods> lookfor_goods; //道具奖励
		public int mail_type; //关联邮件
		public string desc; //奖励描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(lookfor_goods==null)lookfor_goods = new List<Syslookfor_goods>();
byte[] lookfor_goodsCountBytes = BitConverter.GetBytes(lookfor_goods.Count);
            ms.Write(lookfor_goodsCountBytes,0,lookfor_goodsCountBytes.Length);
for (int i = 0; i < lookfor_goods.Count; i++){
if(lookfor_goods[i] == null)lookfor_goods[i] = new Syslookfor_goods();lookfor_goods[i].Serializer(ms);
}
byte[] mail_typeBytes = BitConverter.GetBytes(mail_type);
            ms.Write(mail_typeBytes,0,mail_typeBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int lookfor_goodsCount;
lookfor_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lookfor_goods = new List<Syslookfor_goods>(lookfor_goodsCount);
for (int i = 0; i < lookfor_goodsCount; i++){
lookfor_goods.Add(new Syslookfor_goods());offset = lookfor_goods[i].Deserializer(bytes,offset);
}
mail_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Sysfunction_open
    {
		public string unikey;
		public int id; //功能id
		public string name; //名称
		public int level; //开放等级
		public string anchor; //排布的位置
		public int pos; //从右到左的排序位置
		public string icon; //图标
		public int show; //是否为功能
		public List<Sysopen_condition> add_condition; //附加条件
		public int index; //功能开启一览索引
		public List<Sysopen_award> award; //功能开启一览奖励
		public string guide_btn_default; //指引用按钮名称一
		public string guide_btn_open; //指引用按钮名称二
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
if(string.IsNullOrEmpty(anchor))anchor = string.Empty;
            byte[] anchorBytes = System.Text.Encoding.UTF8.GetBytes(anchor);
            byte[] anchorBytesLen = BitConverter.GetBytes(anchorBytes.Length);
            ms.Write(anchorBytesLen, 0, anchorBytesLen.Length);
            ms.Write(anchorBytes, 0, anchorBytes.Length);
byte[] posBytes = BitConverter.GetBytes(pos);
            ms.Write(posBytes,0,posBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
byte[] showBytes = BitConverter.GetBytes(show);
            ms.Write(showBytes,0,showBytes.Length);
if(add_condition==null)add_condition = new List<Sysopen_condition>();
byte[] add_conditionCountBytes = BitConverter.GetBytes(add_condition.Count);
            ms.Write(add_conditionCountBytes,0,add_conditionCountBytes.Length);
for (int i = 0; i < add_condition.Count; i++){
if(add_condition[i] == null)add_condition[i] = new Sysopen_condition();add_condition[i].Serializer(ms);
}
byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
if(award==null)award = new List<Sysopen_award>();
byte[] awardCountBytes = BitConverter.GetBytes(award.Count);
            ms.Write(awardCountBytes,0,awardCountBytes.Length);
for (int i = 0; i < award.Count; i++){
if(award[i] == null)award[i] = new Sysopen_award();award[i].Serializer(ms);
}
if(string.IsNullOrEmpty(guide_btn_default))guide_btn_default = string.Empty;
            byte[] guide_btn_defaultBytes = System.Text.Encoding.UTF8.GetBytes(guide_btn_default);
            byte[] guide_btn_defaultBytesLen = BitConverter.GetBytes(guide_btn_defaultBytes.Length);
            ms.Write(guide_btn_defaultBytesLen, 0, guide_btn_defaultBytesLen.Length);
            ms.Write(guide_btn_defaultBytes, 0, guide_btn_defaultBytes.Length);
if(string.IsNullOrEmpty(guide_btn_open))guide_btn_open = string.Empty;
            byte[] guide_btn_openBytes = System.Text.Encoding.UTF8.GetBytes(guide_btn_open);
            byte[] guide_btn_openBytesLen = BitConverter.GetBytes(guide_btn_openBytes.Length);
            ms.Write(guide_btn_openBytesLen, 0, guide_btn_openBytesLen.Length);
            ms.Write(guide_btn_openBytes, 0, guide_btn_openBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int anchor_count;anchor_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;anchor = System.Text.Encoding.UTF8.GetString(bytes, offset, anchor_count);offset += anchor_count;
pos = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
show = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int add_conditionCount;
add_conditionCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
add_condition = new List<Sysopen_condition>(add_conditionCount);
for (int i = 0; i < add_conditionCount; i++){
add_condition.Add(new Sysopen_condition());offset = add_condition[i].Deserializer(bytes,offset);
}
index = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int awardCount;
awardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
award = new List<Sysopen_award>(awardCount);
for (int i = 0; i < awardCount; i++){
award.Add(new Sysopen_award());offset = award[i].Deserializer(bytes,offset);
}
int guide_btn_default_count;guide_btn_default_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;guide_btn_default = System.Text.Encoding.UTF8.GetString(bytes, offset, guide_btn_default_count);offset += guide_btn_default_count;
int guide_btn_open_count;guide_btn_open_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;guide_btn_open = System.Text.Encoding.UTF8.GetString(bytes, offset, guide_btn_open_count);offset += guide_btn_open_count;
return offset;
        }
} 
 [Serializable]public class Sysgenius
    {
		public string unikey;
		public int id; //天赋id
		public string genius_disc; //天赋描述
		public string genius_name; //天赋名称
		public string icon; //图标
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(genius_disc))genius_disc = string.Empty;
            byte[] genius_discBytes = System.Text.Encoding.UTF8.GetBytes(genius_disc);
            byte[] genius_discBytesLen = BitConverter.GetBytes(genius_discBytes.Length);
            ms.Write(genius_discBytesLen, 0, genius_discBytesLen.Length);
            ms.Write(genius_discBytes, 0, genius_discBytes.Length);
if(string.IsNullOrEmpty(genius_name))genius_name = string.Empty;
            byte[] genius_nameBytes = System.Text.Encoding.UTF8.GetBytes(genius_name);
            byte[] genius_nameBytesLen = BitConverter.GetBytes(genius_nameBytes.Length);
            ms.Write(genius_nameBytesLen, 0, genius_nameBytesLen.Length);
            ms.Write(genius_nameBytes, 0, genius_nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int genius_disc_count;genius_disc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;genius_disc = System.Text.Encoding.UTF8.GetString(bytes, offset, genius_disc_count);offset += genius_disc_count;
int genius_name_count;genius_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;genius_name = System.Text.Encoding.UTF8.GetString(bytes, offset, genius_name_count);offset += genius_name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
return offset;
        }
} 
 [Serializable]public class Sysgenius_arg
    {
		public int id; //属性id
		public float num; //属性值
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysgenius_lv
    {
		public string unikey;
		public int id; //天赋技能id
		public int genius_lv; //天赋技能等级
		public List<Sysgenius_arg> arg; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] genius_lvBytes = BitConverter.GetBytes(genius_lv);
            ms.Write(genius_lvBytes,0,genius_lvBytes.Length);
if(arg==null)arg = new List<Sysgenius_arg>();
byte[] argCountBytes = BitConverter.GetBytes(arg.Count);
            ms.Write(argCountBytes,0,argCountBytes.Length);
for (int i = 0; i < arg.Count; i++){
if(arg[i] == null)arg[i] = new Sysgenius_arg();arg[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
genius_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int argCount;
argCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = new List<Sysgenius_arg>(argCount);
for (int i = 0; i < argCount; i++){
arg.Add(new Sysgenius_arg());offset = arg[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysgenius_lv_attr
    {
		public string unikey;
		public int lv; //天赋等级
		public int exp; //天赋升级需要的经验
		public int pos; //天赋等级开放的天赋技能位置
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] posBytes = BitConverter.GetBytes(pos);
            ms.Write(posBytes,0,posBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysgenius_lv_attr_hero
    {
		public string unikey;
		public int id; //英雄ID
		public int lv; //天赋等级
		public List<Sysgenius_arg> arg; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(arg==null)arg = new List<Sysgenius_arg>();
byte[] argCountBytes = BitConverter.GetBytes(arg.Count);
            ms.Write(argCountBytes,0,argCountBytes.Length);
for (int i = 0; i < arg.Count; i++){
if(arg[i] == null)arg[i] = new Sysgenius_arg();arg[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int argCount;
argCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = new List<Sysgenius_arg>(argCount);
for (int i = 0; i < argCount; i++){
arg.Add(new Sysgenius_arg());offset = arg[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysglobal_value
    {
		public string unikey;
		public int id; //唯一id
		public int value; //整型数值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysgoods
    {
		public string unikey;
		public int goods_id; //道具id
		public string goods_name; //道具名称
		public string icon; //物品图标
		public int type; //道具类型
		public int subtype; //子类型
		public int coin; //出售价格
		public int quality; //物品品质
		public List<Sysgoods_buy> buy; //直接购买
		public string desc; //描述
		public int stack; //叠加上限
		public int canuse; //是否使用
		public int use_turn; //点击使用跳转
		public int show_detail; //是否显示详情   
		public List<Sysgoods_getway> get_way; //获得途径
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
if(string.IsNullOrEmpty(goods_name))goods_name = string.Empty;
            byte[] goods_nameBytes = System.Text.Encoding.UTF8.GetBytes(goods_name);
            byte[] goods_nameBytesLen = BitConverter.GetBytes(goods_nameBytes.Length);
            ms.Write(goods_nameBytesLen, 0, goods_nameBytesLen.Length);
            ms.Write(goods_nameBytes, 0, goods_nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] subtypeBytes = BitConverter.GetBytes(subtype);
            ms.Write(subtypeBytes,0,subtypeBytes.Length);
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
if(buy==null)buy = new List<Sysgoods_buy>();
byte[] buyCountBytes = BitConverter.GetBytes(buy.Count);
            ms.Write(buyCountBytes,0,buyCountBytes.Length);
for (int i = 0; i < buy.Count; i++){
if(buy[i] == null)buy[i] = new Sysgoods_buy();buy[i].Serializer(ms);
}
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] stackBytes = BitConverter.GetBytes(stack);
            ms.Write(stackBytes,0,stackBytes.Length);
byte[] canuseBytes = BitConverter.GetBytes(canuse);
            ms.Write(canuseBytes,0,canuseBytes.Length);
byte[] use_turnBytes = BitConverter.GetBytes(use_turn);
            ms.Write(use_turnBytes,0,use_turnBytes.Length);
byte[] show_detailBytes = BitConverter.GetBytes(show_detail);
            ms.Write(show_detailBytes,0,show_detailBytes.Length);
if(get_way==null)get_way = new List<Sysgoods_getway>();
byte[] get_wayCountBytes = BitConverter.GetBytes(get_way.Count);
            ms.Write(get_wayCountBytes,0,get_wayCountBytes.Length);
for (int i = 0; i < get_way.Count; i++){
if(get_way[i] == null)get_way[i] = new Sysgoods_getway();get_way[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int goods_name_count;goods_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;goods_name = System.Text.Encoding.UTF8.GetString(bytes, offset, goods_name_count);offset += goods_name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
subtype = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int buyCount;
buyCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy = new List<Sysgoods_buy>(buyCount);
for (int i = 0; i < buyCount; i++){
buy.Add(new Sysgoods_buy());offset = buy[i].Deserializer(bytes,offset);
}
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
stack = BitConverter.ToInt32(bytes, offset);
            offset += 4;
canuse = BitConverter.ToInt32(bytes, offset);
            offset += 4;
use_turn = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_detail = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int get_wayCount;
get_wayCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
get_way = new List<Sysgoods_getway>(get_wayCount);
for (int i = 0; i < get_wayCount; i++){
get_way.Add(new Sysgoods_getway());offset = get_way[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysgoods_buy
    {
		public int buy_type; //购买类型
		public int buy_price; //购买价格
    public void Serializer(MemoryStream ms){

byte[] buy_typeBytes = BitConverter.GetBytes(buy_type);
            ms.Write(buy_typeBytes,0,buy_typeBytes.Length);
byte[] buy_priceBytes = BitConverter.GetBytes(buy_price);
            ms.Write(buy_priceBytes,0,buy_priceBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

buy_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysgoods_func
    {
		public string unikey;
		public int goods_id; //道具id
		public string goods_name; //道具名称
		public int effect_type; //效果类型
		public List<int> effect_value; //效果值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
if(string.IsNullOrEmpty(goods_name))goods_name = string.Empty;
            byte[] goods_nameBytes = System.Text.Encoding.UTF8.GetBytes(goods_name);
            byte[] goods_nameBytesLen = BitConverter.GetBytes(goods_nameBytes.Length);
            ms.Write(goods_nameBytesLen, 0, goods_nameBytesLen.Length);
            ms.Write(goods_nameBytes, 0, goods_nameBytes.Length);
byte[] effect_typeBytes = BitConverter.GetBytes(effect_type);
            ms.Write(effect_typeBytes,0,effect_typeBytes.Length);
if(effect_value==null)effect_value = new List<int>();
byte[] effect_valueCountBytes = BitConverter.GetBytes(effect_value.Count);
            ms.Write(effect_valueCountBytes,0,effect_valueCountBytes.Length);
for (int i = 0; i < effect_value.Count; i++){
byte[] effect_valueBytes = BitConverter.GetBytes(effect_value[i]);
            ms.Write(effect_valueBytes,0,effect_valueBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int goods_name_count;goods_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;goods_name = System.Text.Encoding.UTF8.GetString(bytes, offset, goods_name_count);offset += goods_name_count;
effect_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int effect_valueCount;
effect_valueCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effect_value = new List<int>(effect_valueCount);
for (int i = 0; i < effect_valueCount; i++){
effect_value.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysgoods_getway
    {
		public int type; //类型
		public string desc; //描述
		public List<int> param; //参数
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(param==null)param = new List<int>();
byte[] paramCountBytes = BitConverter.GetBytes(param.Count);
            ms.Write(paramCountBytes,0,paramCountBytes.Length);
for (int i = 0; i < param.Count; i++){
byte[] paramBytes = BitConverter.GetBytes(param[i]);
            ms.Write(paramBytes,0,paramBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;

int paramCount;
paramCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
param = new List<int>(paramCount);
for (int i = 0; i < paramCount; i++){
param.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysgoods_to_goods
    {
		public string unikey;
		public int goods_id; //物品ID
		public int arg_id; //材料物品ID
		public int arg_num; //材料数量
		public int goods_num; //兑换数量
		public int hero_id; //英雄ID
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] arg_idBytes = BitConverter.GetBytes(arg_id);
            ms.Write(arg_idBytes,0,arg_idBytes.Length);
byte[] arg_numBytes = BitConverter.GetBytes(arg_num);
            ms.Write(arg_numBytes,0,arg_numBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
byte[] hero_idBytes = BitConverter.GetBytes(hero_id);
            ms.Write(hero_idBytes,0,hero_idBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysgrow_detail
    {
		public int index; //索引
		public string icon; //界面icon
		public List<int> icon_pixel; //icon位置大小
		public string desc; //描述
		public int star; //推荐星级
		public int guide_type; //按钮功能
		public string view; //功能界面
		public int function_id; //功能开启id
		public List<int> function_params; //功能参数
    public void Serializer(MemoryStream ms){

byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(icon_pixel==null)icon_pixel = new List<int>();
byte[] icon_pixelCountBytes = BitConverter.GetBytes(icon_pixel.Count);
            ms.Write(icon_pixelCountBytes,0,icon_pixelCountBytes.Length);
for (int i = 0; i < icon_pixel.Count; i++){
byte[] icon_pixelBytes = BitConverter.GetBytes(icon_pixel[i]);
            ms.Write(icon_pixelBytes,0,icon_pixelBytes.Length);
}
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] guide_typeBytes = BitConverter.GetBytes(guide_type);
            ms.Write(guide_typeBytes,0,guide_typeBytes.Length);
if(string.IsNullOrEmpty(view))view = string.Empty;
            byte[] viewBytes = System.Text.Encoding.UTF8.GetBytes(view);
            byte[] viewBytesLen = BitConverter.GetBytes(viewBytes.Length);
            ms.Write(viewBytesLen, 0, viewBytesLen.Length);
            ms.Write(viewBytes, 0, viewBytes.Length);
byte[] function_idBytes = BitConverter.GetBytes(function_id);
            ms.Write(function_idBytes,0,function_idBytes.Length);
if(function_params==null)function_params = new List<int>();
byte[] function_paramsCountBytes = BitConverter.GetBytes(function_params.Count);
            ms.Write(function_paramsCountBytes,0,function_paramsCountBytes.Length);
for (int i = 0; i < function_params.Count; i++){
byte[] function_paramsBytes = BitConverter.GetBytes(function_params[i]);
            ms.Write(function_paramsBytes,0,function_paramsBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

index = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;

int icon_pixelCount;
icon_pixelCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
icon_pixel = new List<int>(icon_pixelCount);
for (int i = 0; i < icon_pixelCount; i++){
icon_pixel.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
guide_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int view_count;view_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;view = System.Text.Encoding.UTF8.GetString(bytes, offset, view_count);offset += view_count;
function_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int function_paramsCount;
function_paramsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
function_params = new List<int>(function_paramsCount);
for (int i = 0; i < function_paramsCount; i++){
function_params.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysgrow_guide
    {
		public string unikey;
		public int id; //成长指引id
		public string name; //名称
		public List<Sysgrow_detail> details; //详细内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(details==null)details = new List<Sysgrow_detail>();
byte[] detailsCountBytes = BitConverter.GetBytes(details.Count);
            ms.Write(detailsCountBytes,0,detailsCountBytes.Length);
for (int i = 0; i < details.Count; i++){
if(details[i] == null)details[i] = new Sysgrow_detail();details[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int detailsCount;
detailsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
details = new List<Sysgrow_detail>(detailsCount);
for (int i = 0; i < detailsCount; i++){
details.Add(new Sysgrow_detail());offset = details[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysguide
    {
		public string unikey;
		public int id; //指引id
		public string guide_name; //备注名称
		public int type; //类型
		public List<int> flag; //促发条件
		public List<Sysguide_step> steps; //步骤
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(guide_name))guide_name = string.Empty;
            byte[] guide_nameBytes = System.Text.Encoding.UTF8.GetBytes(guide_name);
            byte[] guide_nameBytesLen = BitConverter.GetBytes(guide_nameBytes.Length);
            ms.Write(guide_nameBytesLen, 0, guide_nameBytesLen.Length);
            ms.Write(guide_nameBytes, 0, guide_nameBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(flag==null)flag = new List<int>();
byte[] flagCountBytes = BitConverter.GetBytes(flag.Count);
            ms.Write(flagCountBytes,0,flagCountBytes.Length);
for (int i = 0; i < flag.Count; i++){
byte[] flagBytes = BitConverter.GetBytes(flag[i]);
            ms.Write(flagBytes,0,flagBytes.Length);
}
if(steps==null)steps = new List<Sysguide_step>();
byte[] stepsCountBytes = BitConverter.GetBytes(steps.Count);
            ms.Write(stepsCountBytes,0,stepsCountBytes.Length);
for (int i = 0; i < steps.Count; i++){
if(steps[i] == null)steps[i] = new Sysguide_step();steps[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int guide_name_count;guide_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;guide_name = System.Text.Encoding.UTF8.GetString(bytes, offset, guide_name_count);offset += guide_name_count;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int flagCount;
flagCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
flag = new List<int>(flagCount);
for (int i = 0; i < flagCount; i++){
flag.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int stepsCount;
stepsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
steps = new List<Sysguide_step>(stepsCount);
for (int i = 0; i < stepsCount; i++){
steps.Add(new Sysguide_step());offset = steps[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysguide_special
    {
		public string unikey;
		public int id; //id
		public int guide_type; //指引类型
		public int guide_object; //指引对象
		public int guide_id; //指引id
		public int guide_step; //指引步骤
		public string guide_desc; //指引描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] guide_typeBytes = BitConverter.GetBytes(guide_type);
            ms.Write(guide_typeBytes,0,guide_typeBytes.Length);
byte[] guide_objectBytes = BitConverter.GetBytes(guide_object);
            ms.Write(guide_objectBytes,0,guide_objectBytes.Length);
byte[] guide_idBytes = BitConverter.GetBytes(guide_id);
            ms.Write(guide_idBytes,0,guide_idBytes.Length);
byte[] guide_stepBytes = BitConverter.GetBytes(guide_step);
            ms.Write(guide_stepBytes,0,guide_stepBytes.Length);
if(string.IsNullOrEmpty(guide_desc))guide_desc = string.Empty;
            byte[] guide_descBytes = System.Text.Encoding.UTF8.GetBytes(guide_desc);
            byte[] guide_descBytesLen = BitConverter.GetBytes(guide_descBytes.Length);
            ms.Write(guide_descBytesLen, 0, guide_descBytesLen.Length);
            ms.Write(guide_descBytes, 0, guide_descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
guide_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
guide_object = BitConverter.ToInt32(bytes, offset);
            offset += 4;
guide_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
guide_step = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int guide_desc_count;guide_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;guide_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, guide_desc_count);offset += guide_desc_count;
return offset;
        }
} 
 [Serializable]public class Sysguide_step
    {
		public int index; //索引
		public int step; //步骤
		public int type; //步骤类型
		public List<int> type_ids; //步骤类型附加
		public int save_step; //保存步骤
		public int next_step; //跳转步骤
		public int auto_next; //自动下一步
		public List<int> flags; //步骤附加条件
		public List<int> monster_trigger; //刷怪附加条件
		public string view; //界面
		public string button; //按钮
		public int arrow; //箭头显示
		public List<int> arrow_offset; //箭头位置偏移
		public int has_story; //剧情显示
		public List<int> story_offset; //剧情位置偏移
		public string story_desc; //剧情对白
		public List<string> story_color; //剧情对白
		public string scene_effect; //场景特效
		public List<int> scene_effect_pos; //场景特效位置
		public int ui_enable; //屏蔽UI点击
		public int delay_show; //延迟显示
		public int ui_effect_size; //按钮特效大小
		public int is_circle; //圆形遮罩
		public float cicle_scale; //圆形遮罩大小
		public float bg_alpha; //背景透明度
		public int sound1; //音效1
		public int sound2; //音效2
    public void Serializer(MemoryStream ms){

byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
byte[] stepBytes = BitConverter.GetBytes(step);
            ms.Write(stepBytes,0,stepBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(type_ids==null)type_ids = new List<int>();
byte[] type_idsCountBytes = BitConverter.GetBytes(type_ids.Count);
            ms.Write(type_idsCountBytes,0,type_idsCountBytes.Length);
for (int i = 0; i < type_ids.Count; i++){
byte[] type_idsBytes = BitConverter.GetBytes(type_ids[i]);
            ms.Write(type_idsBytes,0,type_idsBytes.Length);
}
byte[] save_stepBytes = BitConverter.GetBytes(save_step);
            ms.Write(save_stepBytes,0,save_stepBytes.Length);
byte[] next_stepBytes = BitConverter.GetBytes(next_step);
            ms.Write(next_stepBytes,0,next_stepBytes.Length);
byte[] auto_nextBytes = BitConverter.GetBytes(auto_next);
            ms.Write(auto_nextBytes,0,auto_nextBytes.Length);
if(flags==null)flags = new List<int>();
byte[] flagsCountBytes = BitConverter.GetBytes(flags.Count);
            ms.Write(flagsCountBytes,0,flagsCountBytes.Length);
for (int i = 0; i < flags.Count; i++){
byte[] flagsBytes = BitConverter.GetBytes(flags[i]);
            ms.Write(flagsBytes,0,flagsBytes.Length);
}
if(monster_trigger==null)monster_trigger = new List<int>();
byte[] monster_triggerCountBytes = BitConverter.GetBytes(monster_trigger.Count);
            ms.Write(monster_triggerCountBytes,0,monster_triggerCountBytes.Length);
for (int i = 0; i < monster_trigger.Count; i++){
byte[] monster_triggerBytes = BitConverter.GetBytes(monster_trigger[i]);
            ms.Write(monster_triggerBytes,0,monster_triggerBytes.Length);
}
if(string.IsNullOrEmpty(view))view = string.Empty;
            byte[] viewBytes = System.Text.Encoding.UTF8.GetBytes(view);
            byte[] viewBytesLen = BitConverter.GetBytes(viewBytes.Length);
            ms.Write(viewBytesLen, 0, viewBytesLen.Length);
            ms.Write(viewBytes, 0, viewBytes.Length);
if(string.IsNullOrEmpty(button))button = string.Empty;
            byte[] buttonBytes = System.Text.Encoding.UTF8.GetBytes(button);
            byte[] buttonBytesLen = BitConverter.GetBytes(buttonBytes.Length);
            ms.Write(buttonBytesLen, 0, buttonBytesLen.Length);
            ms.Write(buttonBytes, 0, buttonBytes.Length);
byte[] arrowBytes = BitConverter.GetBytes(arrow);
            ms.Write(arrowBytes,0,arrowBytes.Length);
if(arrow_offset==null)arrow_offset = new List<int>();
byte[] arrow_offsetCountBytes = BitConverter.GetBytes(arrow_offset.Count);
            ms.Write(arrow_offsetCountBytes,0,arrow_offsetCountBytes.Length);
for (int i = 0; i < arrow_offset.Count; i++){
byte[] arrow_offsetBytes = BitConverter.GetBytes(arrow_offset[i]);
            ms.Write(arrow_offsetBytes,0,arrow_offsetBytes.Length);
}
byte[] has_storyBytes = BitConverter.GetBytes(has_story);
            ms.Write(has_storyBytes,0,has_storyBytes.Length);
if(story_offset==null)story_offset = new List<int>();
byte[] story_offsetCountBytes = BitConverter.GetBytes(story_offset.Count);
            ms.Write(story_offsetCountBytes,0,story_offsetCountBytes.Length);
for (int i = 0; i < story_offset.Count; i++){
byte[] story_offsetBytes = BitConverter.GetBytes(story_offset[i]);
            ms.Write(story_offsetBytes,0,story_offsetBytes.Length);
}
if(string.IsNullOrEmpty(story_desc))story_desc = string.Empty;
            byte[] story_descBytes = System.Text.Encoding.UTF8.GetBytes(story_desc);
            byte[] story_descBytesLen = BitConverter.GetBytes(story_descBytes.Length);
            ms.Write(story_descBytesLen, 0, story_descBytesLen.Length);
            ms.Write(story_descBytes, 0, story_descBytes.Length);
if(story_color==null)story_color = new List<string>();
byte[] story_colorCountBytes = BitConverter.GetBytes(story_color.Count);
            ms.Write(story_colorCountBytes,0,story_colorCountBytes.Length);
for (int i = 0; i < story_color.Count; i++){
if(string.IsNullOrEmpty(story_color[i]))story_color[i] = string.Empty;
            byte[] story_colorBytes = System.Text.Encoding.UTF8.GetBytes(story_color[i]);
            byte[] story_colorBytesLen = BitConverter.GetBytes(story_colorBytes.Length);
            ms.Write(story_colorBytesLen, 0, story_colorBytesLen.Length);
            ms.Write(story_colorBytes, 0, story_colorBytes.Length);
}
if(string.IsNullOrEmpty(scene_effect))scene_effect = string.Empty;
            byte[] scene_effectBytes = System.Text.Encoding.UTF8.GetBytes(scene_effect);
            byte[] scene_effectBytesLen = BitConverter.GetBytes(scene_effectBytes.Length);
            ms.Write(scene_effectBytesLen, 0, scene_effectBytesLen.Length);
            ms.Write(scene_effectBytes, 0, scene_effectBytes.Length);
if(scene_effect_pos==null)scene_effect_pos = new List<int>();
byte[] scene_effect_posCountBytes = BitConverter.GetBytes(scene_effect_pos.Count);
            ms.Write(scene_effect_posCountBytes,0,scene_effect_posCountBytes.Length);
for (int i = 0; i < scene_effect_pos.Count; i++){
byte[] scene_effect_posBytes = BitConverter.GetBytes(scene_effect_pos[i]);
            ms.Write(scene_effect_posBytes,0,scene_effect_posBytes.Length);
}
byte[] ui_enableBytes = BitConverter.GetBytes(ui_enable);
            ms.Write(ui_enableBytes,0,ui_enableBytes.Length);
byte[] delay_showBytes = BitConverter.GetBytes(delay_show);
            ms.Write(delay_showBytes,0,delay_showBytes.Length);
byte[] ui_effect_sizeBytes = BitConverter.GetBytes(ui_effect_size);
            ms.Write(ui_effect_sizeBytes,0,ui_effect_sizeBytes.Length);
byte[] is_circleBytes = BitConverter.GetBytes(is_circle);
            ms.Write(is_circleBytes,0,is_circleBytes.Length);
byte[] cicle_scaleBytes = BitConverter.GetBytes(cicle_scale);
            ms.Write(cicle_scaleBytes,0,cicle_scaleBytes.Length);
byte[] bg_alphaBytes = BitConverter.GetBytes(bg_alpha);
            ms.Write(bg_alphaBytes,0,bg_alphaBytes.Length);
byte[] sound1Bytes = BitConverter.GetBytes(sound1);
            ms.Write(sound1Bytes,0,sound1Bytes.Length);
byte[] sound2Bytes = BitConverter.GetBytes(sound2);
            ms.Write(sound2Bytes,0,sound2Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

index = BitConverter.ToInt32(bytes, offset);
            offset += 4;
step = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int type_idsCount;
type_idsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type_ids = new List<int>(type_idsCount);
for (int i = 0; i < type_idsCount; i++){
type_ids.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
save_step = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_step = BitConverter.ToInt32(bytes, offset);
            offset += 4;
auto_next = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int flagsCount;
flagsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
flags = new List<int>(flagsCount);
for (int i = 0; i < flagsCount; i++){
flags.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int monster_triggerCount;
monster_triggerCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster_trigger = new List<int>(monster_triggerCount);
for (int i = 0; i < monster_triggerCount; i++){
monster_trigger.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int view_count;view_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;view = System.Text.Encoding.UTF8.GetString(bytes, offset, view_count);offset += view_count;
int button_count;button_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;button = System.Text.Encoding.UTF8.GetString(bytes, offset, button_count);offset += button_count;
arrow = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int arrow_offsetCount;
arrow_offsetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arrow_offset = new List<int>(arrow_offsetCount);
for (int i = 0; i < arrow_offsetCount; i++){
arrow_offset.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
has_story = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int story_offsetCount;
story_offsetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
story_offset = new List<int>(story_offsetCount);
for (int i = 0; i < story_offsetCount; i++){
story_offset.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int story_desc_count;story_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;story_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, story_desc_count);offset += story_desc_count;

int story_colorCount;
story_colorCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
story_color = new List<string>(story_colorCount);
for (int i = 0; i < story_colorCount; i++){
int story_color_count;story_color_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;story_color.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, story_color_count));offset += story_color_count;
}
int scene_effect_count;scene_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;scene_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, scene_effect_count);offset += scene_effect_count;

int scene_effect_posCount;
scene_effect_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
scene_effect_pos = new List<int>(scene_effect_posCount);
for (int i = 0; i < scene_effect_posCount; i++){
scene_effect_pos.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
ui_enable = BitConverter.ToInt32(bytes, offset);
            offset += 4;
delay_show = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ui_effect_size = BitConverter.ToInt32(bytes, offset);
            offset += 4;
is_circle = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cicle_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;
bg_alpha = BitConverter.ToSingle(bytes, offset);
            offset += 4;
sound1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sound2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshell
    {
		public string unikey;
		public int id; //地狱
		public int level; //开启等级
		public string desc; //描述
		public string link; //超链接
		public int limit; //最少人数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(link))link = string.Empty;
            byte[] linkBytes = System.Text.Encoding.UTF8.GetBytes(link);
            byte[] linkBytesLen = BitConverter.GetBytes(linkBytes.Length);
            ms.Write(linkBytesLen, 0, linkBytesLen.Length);
            ms.Write(linkBytes, 0, linkBytes.Length);
byte[] limitBytes = BitConverter.GetBytes(limit);
            ms.Write(limitBytes,0,limitBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int link_count;link_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;link = System.Text.Encoding.UTF8.GetString(bytes, offset, link_count);offset += link_count;
limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshell_level
    {
		public string unikey;
		public int id; //关卡id
		public string name; //关卡名称
		public int open_level; //开启等级
		public int pre_dungeon; //前置副本
		public int dungoen; //副本id
		public string icon; //图标
		public List<Syshell_reward_goods> show_reward; //显示奖励
		public int need_level; //推荐等级
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] open_levelBytes = BitConverter.GetBytes(open_level);
            ms.Write(open_levelBytes,0,open_levelBytes.Length);
byte[] pre_dungeonBytes = BitConverter.GetBytes(pre_dungeon);
            ms.Write(pre_dungeonBytes,0,pre_dungeonBytes.Length);
byte[] dungoenBytes = BitConverter.GetBytes(dungoen);
            ms.Write(dungoenBytes,0,dungoenBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(show_reward==null)show_reward = new List<Syshell_reward_goods>();
byte[] show_rewardCountBytes = BitConverter.GetBytes(show_reward.Count);
            ms.Write(show_rewardCountBytes,0,show_rewardCountBytes.Length);
for (int i = 0; i < show_reward.Count; i++){
if(show_reward[i] == null)show_reward[i] = new Syshell_reward_goods();show_reward[i].Serializer(ms);
}
byte[] need_levelBytes = BitConverter.GetBytes(need_level);
            ms.Write(need_levelBytes,0,need_levelBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
open_level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungoen = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;

int show_rewardCount;
show_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_reward = new List<Syshell_reward_goods>(show_rewardCount);
for (int i = 0; i < show_rewardCount; i++){
show_reward.Add(new Syshell_reward_goods());offset = show_reward[i].Deserializer(bytes,offset);
}
need_level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshell_reward
    {
		public string unikey;
		public int hell_id; //关卡id
		public int small_id; //波数id
		public List<Syshell_reward_goods> rewards; //奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] hell_idBytes = BitConverter.GetBytes(hell_id);
            ms.Write(hell_idBytes,0,hell_idBytes.Length);
byte[] small_idBytes = BitConverter.GetBytes(small_id);
            ms.Write(small_idBytes,0,small_idBytes.Length);
if(rewards==null)rewards = new List<Syshell_reward_goods>();
byte[] rewardsCountBytes = BitConverter.GetBytes(rewards.Count);
            ms.Write(rewardsCountBytes,0,rewardsCountBytes.Length);
for (int i = 0; i < rewards.Count; i++){
if(rewards[i] == null)rewards[i] = new Syshell_reward_goods();rewards[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
hell_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
small_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rewardsCount;
rewardsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rewards = new List<Syshell_reward_goods>(rewardsCount);
for (int i = 0; i < rewardsCount; i++){
rewards.Add(new Syshell_reward_goods());offset = rewards[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syshell_reward_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero
    {
		public string unikey;
		public int id; //英雄id
		public int level; //英雄初始等级
		public string name; //英雄名称
		public int career; //英雄定位职业
		public int attaktype; //英雄攻击类型
		public int star; //英雄初始星级
		public List<int> marking; //英雄印记位置对应类型
		public int quality; //英雄初始品质
		public List<int> skills; //技能 
		public int item_id; //激活需要的材料
		public int item_num; //激活需要的数量
		public string icon; //头像图标1(正方形)
		public string icon_round; //头像图标2（圆形）
		public string bust; //英雄半身像
		public string desc; //英雄简介
		public List<int> skins; //英雄的皮肤列表
		public string model; //英雄模型
		public List<string> effects; //英雄特效
		public string showeffect; //英雄展示特效
		public string idleeffect; //英雄待机特效
		public List<string> special_states; //英雄个性动作
		public float idle_to_special; //英雄个性动作
		public int attr_id; //属性模板id
		public string logicClass; //类型
		public List<int> hero_ai; //英雄ai列表
		public int npc_id; //对应的npc
		public int search_range; //视野范围
		public List<int> hero_sound; //英雄配音
		public List<string> intro; //英雄简介
		public int hard; //英雄难度
		public int pvp_attr; //pvp属性id
		public List<int> hero_dingwei; //英雄定位
		public string biography_name; //英雄传记英雄名称
		public string biography; //英雄传记
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] careerBytes = BitConverter.GetBytes(career);
            ms.Write(careerBytes,0,careerBytes.Length);
byte[] attaktypeBytes = BitConverter.GetBytes(attaktype);
            ms.Write(attaktypeBytes,0,attaktypeBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
if(marking==null)marking = new List<int>();
byte[] markingCountBytes = BitConverter.GetBytes(marking.Count);
            ms.Write(markingCountBytes,0,markingCountBytes.Length);
for (int i = 0; i < marking.Count; i++){
byte[] markingBytes = BitConverter.GetBytes(marking[i]);
            ms.Write(markingBytes,0,markingBytes.Length);
}
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
if(skills==null)skills = new List<int>();
byte[] skillsCountBytes = BitConverter.GetBytes(skills.Count);
            ms.Write(skillsCountBytes,0,skillsCountBytes.Length);
for (int i = 0; i < skills.Count; i++){
byte[] skillsBytes = BitConverter.GetBytes(skills[i]);
            ms.Write(skillsBytes,0,skillsBytes.Length);
}
byte[] item_idBytes = BitConverter.GetBytes(item_id);
            ms.Write(item_idBytes,0,item_idBytes.Length);
byte[] item_numBytes = BitConverter.GetBytes(item_num);
            ms.Write(item_numBytes,0,item_numBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(icon_round))icon_round = string.Empty;
            byte[] icon_roundBytes = System.Text.Encoding.UTF8.GetBytes(icon_round);
            byte[] icon_roundBytesLen = BitConverter.GetBytes(icon_roundBytes.Length);
            ms.Write(icon_roundBytesLen, 0, icon_roundBytesLen.Length);
            ms.Write(icon_roundBytes, 0, icon_roundBytes.Length);
if(string.IsNullOrEmpty(bust))bust = string.Empty;
            byte[] bustBytes = System.Text.Encoding.UTF8.GetBytes(bust);
            byte[] bustBytesLen = BitConverter.GetBytes(bustBytes.Length);
            ms.Write(bustBytesLen, 0, bustBytesLen.Length);
            ms.Write(bustBytes, 0, bustBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(skins==null)skins = new List<int>();
byte[] skinsCountBytes = BitConverter.GetBytes(skins.Count);
            ms.Write(skinsCountBytes,0,skinsCountBytes.Length);
for (int i = 0; i < skins.Count; i++){
byte[] skinsBytes = BitConverter.GetBytes(skins[i]);
            ms.Write(skinsBytes,0,skinsBytes.Length);
}
if(string.IsNullOrEmpty(model))model = string.Empty;
            byte[] modelBytes = System.Text.Encoding.UTF8.GetBytes(model);
            byte[] modelBytesLen = BitConverter.GetBytes(modelBytes.Length);
            ms.Write(modelBytesLen, 0, modelBytesLen.Length);
            ms.Write(modelBytes, 0, modelBytes.Length);
if(effects==null)effects = new List<string>();
byte[] effectsCountBytes = BitConverter.GetBytes(effects.Count);
            ms.Write(effectsCountBytes,0,effectsCountBytes.Length);
for (int i = 0; i < effects.Count; i++){
if(string.IsNullOrEmpty(effects[i]))effects[i] = string.Empty;
            byte[] effectsBytes = System.Text.Encoding.UTF8.GetBytes(effects[i]);
            byte[] effectsBytesLen = BitConverter.GetBytes(effectsBytes.Length);
            ms.Write(effectsBytesLen, 0, effectsBytesLen.Length);
            ms.Write(effectsBytes, 0, effectsBytes.Length);
}
if(string.IsNullOrEmpty(showeffect))showeffect = string.Empty;
            byte[] showeffectBytes = System.Text.Encoding.UTF8.GetBytes(showeffect);
            byte[] showeffectBytesLen = BitConverter.GetBytes(showeffectBytes.Length);
            ms.Write(showeffectBytesLen, 0, showeffectBytesLen.Length);
            ms.Write(showeffectBytes, 0, showeffectBytes.Length);
if(string.IsNullOrEmpty(idleeffect))idleeffect = string.Empty;
            byte[] idleeffectBytes = System.Text.Encoding.UTF8.GetBytes(idleeffect);
            byte[] idleeffectBytesLen = BitConverter.GetBytes(idleeffectBytes.Length);
            ms.Write(idleeffectBytesLen, 0, idleeffectBytesLen.Length);
            ms.Write(idleeffectBytes, 0, idleeffectBytes.Length);
if(special_states==null)special_states = new List<string>();
byte[] special_statesCountBytes = BitConverter.GetBytes(special_states.Count);
            ms.Write(special_statesCountBytes,0,special_statesCountBytes.Length);
for (int i = 0; i < special_states.Count; i++){
if(string.IsNullOrEmpty(special_states[i]))special_states[i] = string.Empty;
            byte[] special_statesBytes = System.Text.Encoding.UTF8.GetBytes(special_states[i]);
            byte[] special_statesBytesLen = BitConverter.GetBytes(special_statesBytes.Length);
            ms.Write(special_statesBytesLen, 0, special_statesBytesLen.Length);
            ms.Write(special_statesBytes, 0, special_statesBytes.Length);
}
byte[] idle_to_specialBytes = BitConverter.GetBytes(idle_to_special);
            ms.Write(idle_to_specialBytes,0,idle_to_specialBytes.Length);
byte[] attr_idBytes = BitConverter.GetBytes(attr_id);
            ms.Write(attr_idBytes,0,attr_idBytes.Length);
if(string.IsNullOrEmpty(logicClass))logicClass = string.Empty;
            byte[] logicClassBytes = System.Text.Encoding.UTF8.GetBytes(logicClass);
            byte[] logicClassBytesLen = BitConverter.GetBytes(logicClassBytes.Length);
            ms.Write(logicClassBytesLen, 0, logicClassBytesLen.Length);
            ms.Write(logicClassBytes, 0, logicClassBytes.Length);
if(hero_ai==null)hero_ai = new List<int>();
byte[] hero_aiCountBytes = BitConverter.GetBytes(hero_ai.Count);
            ms.Write(hero_aiCountBytes,0,hero_aiCountBytes.Length);
for (int i = 0; i < hero_ai.Count; i++){
byte[] hero_aiBytes = BitConverter.GetBytes(hero_ai[i]);
            ms.Write(hero_aiBytes,0,hero_aiBytes.Length);
}
byte[] npc_idBytes = BitConverter.GetBytes(npc_id);
            ms.Write(npc_idBytes,0,npc_idBytes.Length);
byte[] search_rangeBytes = BitConverter.GetBytes(search_range);
            ms.Write(search_rangeBytes,0,search_rangeBytes.Length);
if(hero_sound==null)hero_sound = new List<int>();
byte[] hero_soundCountBytes = BitConverter.GetBytes(hero_sound.Count);
            ms.Write(hero_soundCountBytes,0,hero_soundCountBytes.Length);
for (int i = 0; i < hero_sound.Count; i++){
byte[] hero_soundBytes = BitConverter.GetBytes(hero_sound[i]);
            ms.Write(hero_soundBytes,0,hero_soundBytes.Length);
}
if(intro==null)intro = new List<string>();
byte[] introCountBytes = BitConverter.GetBytes(intro.Count);
            ms.Write(introCountBytes,0,introCountBytes.Length);
for (int i = 0; i < intro.Count; i++){
if(string.IsNullOrEmpty(intro[i]))intro[i] = string.Empty;
            byte[] introBytes = System.Text.Encoding.UTF8.GetBytes(intro[i]);
            byte[] introBytesLen = BitConverter.GetBytes(introBytes.Length);
            ms.Write(introBytesLen, 0, introBytesLen.Length);
            ms.Write(introBytes, 0, introBytes.Length);
}
byte[] hardBytes = BitConverter.GetBytes(hard);
            ms.Write(hardBytes,0,hardBytes.Length);
byte[] pvp_attrBytes = BitConverter.GetBytes(pvp_attr);
            ms.Write(pvp_attrBytes,0,pvp_attrBytes.Length);
if(hero_dingwei==null)hero_dingwei = new List<int>();
byte[] hero_dingweiCountBytes = BitConverter.GetBytes(hero_dingwei.Count);
            ms.Write(hero_dingweiCountBytes,0,hero_dingweiCountBytes.Length);
for (int i = 0; i < hero_dingwei.Count; i++){
byte[] hero_dingweiBytes = BitConverter.GetBytes(hero_dingwei[i]);
            ms.Write(hero_dingweiBytes,0,hero_dingweiBytes.Length);
}
if(string.IsNullOrEmpty(biography_name))biography_name = string.Empty;
            byte[] biography_nameBytes = System.Text.Encoding.UTF8.GetBytes(biography_name);
            byte[] biography_nameBytesLen = BitConverter.GetBytes(biography_nameBytes.Length);
            ms.Write(biography_nameBytesLen, 0, biography_nameBytesLen.Length);
            ms.Write(biography_nameBytes, 0, biography_nameBytes.Length);
if(string.IsNullOrEmpty(biography))biography = string.Empty;
            byte[] biographyBytes = System.Text.Encoding.UTF8.GetBytes(biography);
            byte[] biographyBytesLen = BitConverter.GetBytes(biographyBytes.Length);
            ms.Write(biographyBytesLen, 0, biographyBytesLen.Length);
            ms.Write(biographyBytes, 0, biographyBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
career = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attaktype = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int markingCount;
markingCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
marking = new List<int>(markingCount);
for (int i = 0; i < markingCount; i++){
marking.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int skillsCount;
skillsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skills = new List<int>(skillsCount);
for (int i = 0; i < skillsCount; i++){
skills.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
item_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
item_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int icon_round_count;icon_round_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon_round = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_round_count);offset += icon_round_count;
int bust_count;bust_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bust = System.Text.Encoding.UTF8.GetString(bytes, offset, bust_count);offset += bust_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;

int skinsCount;
skinsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skins = new List<int>(skinsCount);
for (int i = 0; i < skinsCount; i++){
skins.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int model_count;model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;model = System.Text.Encoding.UTF8.GetString(bytes, offset, model_count);offset += model_count;

int effectsCount;
effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effects = new List<string>(effectsCount);
for (int i = 0; i < effectsCount; i++){
int effects_count;effects_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effects.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, effects_count));offset += effects_count;
}
int showeffect_count;showeffect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;showeffect = System.Text.Encoding.UTF8.GetString(bytes, offset, showeffect_count);offset += showeffect_count;
int idleeffect_count;idleeffect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;idleeffect = System.Text.Encoding.UTF8.GetString(bytes, offset, idleeffect_count);offset += idleeffect_count;

int special_statesCount;
special_statesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
special_states = new List<string>(special_statesCount);
for (int i = 0; i < special_statesCount; i++){
int special_states_count;special_states_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;special_states.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, special_states_count));offset += special_states_count;
}
idle_to_special = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int logicClass_count;logicClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;logicClass = System.Text.Encoding.UTF8.GetString(bytes, offset, logicClass_count);offset += logicClass_count;

int hero_aiCount;
hero_aiCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_ai = new List<int>(hero_aiCount);
for (int i = 0; i < hero_aiCount; i++){
hero_ai.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
npc_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
search_range = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int hero_soundCount;
hero_soundCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_sound = new List<int>(hero_soundCount);
for (int i = 0; i < hero_soundCount; i++){
hero_sound.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int introCount;
introCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
intro = new List<string>(introCount);
for (int i = 0; i < introCount; i++){
int intro_count;intro_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;intro.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, intro_count));offset += intro_count;
}
hard = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pvp_attr = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int hero_dingweiCount;
hero_dingweiCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_dingwei = new List<int>(hero_dingweiCount);
for (int i = 0; i < hero_dingweiCount; i++){
hero_dingwei.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int biography_name_count;biography_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;biography_name = System.Text.Encoding.UTF8.GetString(bytes, offset, biography_name_count);offset += biography_name_count;
int biography_count;biography_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;biography = System.Text.Encoding.UTF8.GetString(bytes, offset, biography_count);offset += biography_count;
return offset;
        }
} 
 [Serializable]public class Syshero_deed
    {
		public string unikey;
		public int id; //英雄id
		public List<Syshero_deed_data> deed; //契约英雄
		public List<int> belong; //归属于的契约英雄ID
		public List<int> size; //半身像大小
		public float pos_x; //x坐标
		public float pos_y; //y坐标
		public int reversal; //是否反转
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(deed==null)deed = new List<Syshero_deed_data>();
byte[] deedCountBytes = BitConverter.GetBytes(deed.Count);
            ms.Write(deedCountBytes,0,deedCountBytes.Length);
for (int i = 0; i < deed.Count; i++){
if(deed[i] == null)deed[i] = new Syshero_deed_data();deed[i].Serializer(ms);
}
if(belong==null)belong = new List<int>();
byte[] belongCountBytes = BitConverter.GetBytes(belong.Count);
            ms.Write(belongCountBytes,0,belongCountBytes.Length);
for (int i = 0; i < belong.Count; i++){
byte[] belongBytes = BitConverter.GetBytes(belong[i]);
            ms.Write(belongBytes,0,belongBytes.Length);
}
if(size==null)size = new List<int>();
byte[] sizeCountBytes = BitConverter.GetBytes(size.Count);
            ms.Write(sizeCountBytes,0,sizeCountBytes.Length);
for (int i = 0; i < size.Count; i++){
byte[] sizeBytes = BitConverter.GetBytes(size[i]);
            ms.Write(sizeBytes,0,sizeBytes.Length);
}
byte[] pos_xBytes = BitConverter.GetBytes(pos_x);
            ms.Write(pos_xBytes,0,pos_xBytes.Length);
byte[] pos_yBytes = BitConverter.GetBytes(pos_y);
            ms.Write(pos_yBytes,0,pos_yBytes.Length);
byte[] reversalBytes = BitConverter.GetBytes(reversal);
            ms.Write(reversalBytes,0,reversalBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int deedCount;
deedCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
deed = new List<Syshero_deed_data>(deedCount);
for (int i = 0; i < deedCount; i++){
deed.Add(new Syshero_deed_data());offset = deed[i].Deserializer(bytes,offset);
}

int belongCount;
belongCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
belong = new List<int>(belongCount);
for (int i = 0; i < belongCount; i++){
belong.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int sizeCount;
sizeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
size = new List<int>(sizeCount);
for (int i = 0; i < sizeCount; i++){
size.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
pos_x = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pos_y = BitConverter.ToSingle(bytes, offset);
            offset += 4;
reversal = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero_deed_data
    {
		public int deed_hero_id; //契约英雄id
		public int deed_id; //契约id
    public void Serializer(MemoryStream ms){

byte[] deed_hero_idBytes = BitConverter.GetBytes(deed_hero_id);
            ms.Write(deed_hero_idBytes,0,deed_hero_idBytes.Length);
byte[] deed_idBytes = BitConverter.GetBytes(deed_id);
            ms.Write(deed_idBytes,0,deed_idBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

deed_hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
deed_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero_exp
    {
		public string unikey;
		public int lv; //英雄等级
		public int exp; //英雄经验
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero_genius
    {
		public string unikey;
		public int id; //英雄id
		public List<int> genius; //天赋id
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(genius==null)genius = new List<int>();
byte[] geniusCountBytes = BitConverter.GetBytes(genius.Count);
            ms.Write(geniusCountBytes,0,geniusCountBytes.Length);
for (int i = 0; i < genius.Count; i++){
byte[] geniusBytes = BitConverter.GetBytes(genius[i]);
            ms.Write(geniusBytes,0,geniusBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int geniusCount;
geniusCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
genius = new List<int>(geniusCount);
for (int i = 0; i < geniusCount; i++){
genius.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Syshero_quality_to_lv
    {
		public string unikey;
		public int quality; //英雄当前阶级
		public int next_lv; //下一次进阶需要的等级
		public int lowest_lv; //当前阶需要的最低等级
		public string color; //品阶颜色
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] next_lvBytes = BitConverter.GetBytes(next_lv);
            ms.Write(next_lvBytes,0,next_lvBytes.Length);
byte[] lowest_lvBytes = BitConverter.GetBytes(lowest_lv);
            ms.Write(lowest_lvBytes,0,lowest_lvBytes.Length);
if(string.IsNullOrEmpty(color))color = string.Empty;
            byte[] colorBytes = System.Text.Encoding.UTF8.GetBytes(color);
            byte[] colorBytesLen = BitConverter.GetBytes(colorBytes.Length);
            ms.Write(colorBytesLen, 0, colorBytesLen.Length);
            ms.Write(colorBytes, 0, colorBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lowest_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int color_count;color_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;color = System.Text.Encoding.UTF8.GetString(bytes, offset, color_count);offset += color_count;
return offset;
        }
} 
 [Serializable]public class Syshero_revival
    {
		public string unikey;
		public int id; //复活次数
		public int num; //消耗的砖石
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero_skin
    {
		public string unikey;
		public int id; //皮肤ID
		public string model; //皮肤对应的模型名字
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(model))model = string.Empty;
            byte[] modelBytes = System.Text.Encoding.UTF8.GetBytes(model);
            byte[] modelBytesLen = BitConverter.GetBytes(modelBytes.Length);
            ms.Write(modelBytesLen, 0, modelBytesLen.Length);
            ms.Write(modelBytes, 0, modelBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int model_count;model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;model = System.Text.Encoding.UTF8.GetString(bytes, offset, model_count);offset += model_count;
return offset;
        }
} 
 [Serializable]public class Syshero_up_quality
    {
		public string unikey;
		public int id; //英雄id
		public int level; //英雄阶数
		public int need_money; //需要的金钱
		public List<Syshero_up_quality_goods> need_goods; //需要的材料
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
byte[] need_moneyBytes = BitConverter.GetBytes(need_money);
            ms.Write(need_moneyBytes,0,need_moneyBytes.Length);
if(need_goods==null)need_goods = new List<Syshero_up_quality_goods>();
byte[] need_goodsCountBytes = BitConverter.GetBytes(need_goods.Count);
            ms.Write(need_goodsCountBytes,0,need_goodsCountBytes.Length);
for (int i = 0; i < need_goods.Count; i++){
if(need_goods[i] == null)need_goods[i] = new Syshero_up_quality_goods();need_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_money = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int need_goodsCount;
need_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_goods = new List<Syshero_up_quality_goods>(need_goodsCount);
for (int i = 0; i < need_goodsCount; i++){
need_goods.Add(new Syshero_up_quality_goods());offset = need_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syshero_up_quality_goods
    {
		public int id; //物品id
		public int num; //数量
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshero_up_star
    {
		public string unikey;
		public int id; //英雄id
		public int star; //英雄星数
		public int need_money; //需要的金钱
		public int item_id; //需要的材料
		public int item_num; //需要的材料数量
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] need_moneyBytes = BitConverter.GetBytes(need_money);
            ms.Write(need_moneyBytes,0,need_moneyBytes.Length);
byte[] item_idBytes = BitConverter.GetBytes(item_id);
            ms.Write(item_idBytes,0,item_idBytes.Length);
byte[] item_numBytes = BitConverter.GetBytes(item_num);
            ms.Write(item_numBytes,0,item_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_money = BitConverter.ToInt32(bytes, offset);
            offset += 4;
item_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
item_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syshit_effect
    {
		public int id; //id
		public string name; //特效名
		public string effect; //特效资源
		public List<int> conditions; //触发条件
		public int priority; //优先级
		public string effectClass; //类型
		public int show_in_melee; //是否在对战中屏蔽
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(effect))effect = string.Empty;
            byte[] effectBytes = System.Text.Encoding.UTF8.GetBytes(effect);
            byte[] effectBytesLen = BitConverter.GetBytes(effectBytes.Length);
            ms.Write(effectBytesLen, 0, effectBytesLen.Length);
            ms.Write(effectBytes, 0, effectBytes.Length);
if(conditions==null)conditions = new List<int>();
byte[] conditionsCountBytes = BitConverter.GetBytes(conditions.Count);
            ms.Write(conditionsCountBytes,0,conditionsCountBytes.Length);
for (int i = 0; i < conditions.Count; i++){
byte[] conditionsBytes = BitConverter.GetBytes(conditions[i]);
            ms.Write(conditionsBytes,0,conditionsBytes.Length);
}
byte[] priorityBytes = BitConverter.GetBytes(priority);
            ms.Write(priorityBytes,0,priorityBytes.Length);
if(string.IsNullOrEmpty(effectClass))effectClass = string.Empty;
            byte[] effectClassBytes = System.Text.Encoding.UTF8.GetBytes(effectClass);
            byte[] effectClassBytesLen = BitConverter.GetBytes(effectClassBytes.Length);
            ms.Write(effectClassBytesLen, 0, effectClassBytesLen.Length);
            ms.Write(effectClassBytes, 0, effectClassBytes.Length);
byte[] show_in_meleeBytes = BitConverter.GetBytes(show_in_melee);
            ms.Write(show_in_meleeBytes,0,show_in_meleeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int effect_count;effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effect = System.Text.Encoding.UTF8.GetString(bytes, offset, effect_count);offset += effect_count;

int conditionsCount;
conditionsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
conditions = new List<int>(conditionsCount);
for (int i = 0; i < conditionsCount; i++){
conditions.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
priority = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int effectClass_count;effectClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effectClass = System.Text.Encoding.UTF8.GetString(bytes, offset, effectClass_count);offset += effectClass_count;
show_in_melee = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysjungle_boss
    {
		public string unikey;
		public int id; //副本id
		public int type; //读表难度
		public int boss_hp; //boss血量
		public int dungeon_id; //副本id
		public List<SysCommon_Goods> show_goods; //显示关卡奖励
		public int bossID; //boss唯一id
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] boss_hpBytes = BitConverter.GetBytes(boss_hp);
            ms.Write(boss_hpBytes,0,boss_hpBytes.Length);
byte[] dungeon_idBytes = BitConverter.GetBytes(dungeon_id);
            ms.Write(dungeon_idBytes,0,dungeon_idBytes.Length);
if(show_goods==null)show_goods = new List<SysCommon_Goods>();
byte[] show_goodsCountBytes = BitConverter.GetBytes(show_goods.Count);
            ms.Write(show_goodsCountBytes,0,show_goodsCountBytes.Length);
for (int i = 0; i < show_goods.Count; i++){
if(show_goods[i] == null)show_goods[i] = new SysCommon_Goods();show_goods[i].Serializer(ms);
}
byte[] bossIDBytes = BitConverter.GetBytes(bossID);
            ms.Write(bossIDBytes,0,bossIDBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
boss_hp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int show_goodsCount;
show_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_goods = new List<SysCommon_Goods>(show_goodsCount);
for (int i = 0; i < show_goodsCount; i++){
show_goods.Add(new SysCommon_Goods());offset = show_goods[i].Deserializer(bytes,offset);
}
bossID = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysjungle_exp
    {
		public string unikey;
		public int lv; //难度等级
		public List<Sysjungle_goods> hurt_0; //0%伤害值
		public List<Sysjungle_goods> hurt_5; //5%伤害值
		public List<Sysjungle_goods> hurt_10; //10%伤害值
		public List<Sysjungle_goods> hurt_15; //15%伤害值
		public List<Sysjungle_goods> hurt_20; //20%伤害值
		public List<Sysjungle_goods> hurt_25; //25%伤害值
		public List<Sysjungle_goods> hurt_30; //30%伤害值
		public List<Sysjungle_goods> hurt_35; //35%伤害值
		public List<Sysjungle_goods> hurt_40; //40%伤害值
		public List<Sysjungle_goods> hurt_45; //45%伤害值
		public List<Sysjungle_goods> hurt_50; //50%伤害值
		public List<Sysjungle_goods> hurt_55; //55%伤害值
		public List<Sysjungle_goods> hurt_60; //60%伤害值
		public List<Sysjungle_goods> hurt_65; //65%伤害值
		public List<Sysjungle_goods> hurt_70; //70%伤害值
		public List<Sysjungle_goods> hurt_75; //75%伤害值
		public List<Sysjungle_goods> hurt_80; //80%伤害值
		public List<Sysjungle_goods> hurt_85; //85%伤害值
		public List<Sysjungle_goods> hurt_90; //90%伤害值
		public List<Sysjungle_goods> hurt_95; //95%伤害值
		public List<Sysjungle_goods> hurt_100; //100%伤害值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(hurt_0==null)hurt_0 = new List<Sysjungle_goods>();
byte[] hurt_0CountBytes = BitConverter.GetBytes(hurt_0.Count);
            ms.Write(hurt_0CountBytes,0,hurt_0CountBytes.Length);
for (int i = 0; i < hurt_0.Count; i++){
if(hurt_0[i] == null)hurt_0[i] = new Sysjungle_goods();hurt_0[i].Serializer(ms);
}
if(hurt_5==null)hurt_5 = new List<Sysjungle_goods>();
byte[] hurt_5CountBytes = BitConverter.GetBytes(hurt_5.Count);
            ms.Write(hurt_5CountBytes,0,hurt_5CountBytes.Length);
for (int i = 0; i < hurt_5.Count; i++){
if(hurt_5[i] == null)hurt_5[i] = new Sysjungle_goods();hurt_5[i].Serializer(ms);
}
if(hurt_10==null)hurt_10 = new List<Sysjungle_goods>();
byte[] hurt_10CountBytes = BitConverter.GetBytes(hurt_10.Count);
            ms.Write(hurt_10CountBytes,0,hurt_10CountBytes.Length);
for (int i = 0; i < hurt_10.Count; i++){
if(hurt_10[i] == null)hurt_10[i] = new Sysjungle_goods();hurt_10[i].Serializer(ms);
}
if(hurt_15==null)hurt_15 = new List<Sysjungle_goods>();
byte[] hurt_15CountBytes = BitConverter.GetBytes(hurt_15.Count);
            ms.Write(hurt_15CountBytes,0,hurt_15CountBytes.Length);
for (int i = 0; i < hurt_15.Count; i++){
if(hurt_15[i] == null)hurt_15[i] = new Sysjungle_goods();hurt_15[i].Serializer(ms);
}
if(hurt_20==null)hurt_20 = new List<Sysjungle_goods>();
byte[] hurt_20CountBytes = BitConverter.GetBytes(hurt_20.Count);
            ms.Write(hurt_20CountBytes,0,hurt_20CountBytes.Length);
for (int i = 0; i < hurt_20.Count; i++){
if(hurt_20[i] == null)hurt_20[i] = new Sysjungle_goods();hurt_20[i].Serializer(ms);
}
if(hurt_25==null)hurt_25 = new List<Sysjungle_goods>();
byte[] hurt_25CountBytes = BitConverter.GetBytes(hurt_25.Count);
            ms.Write(hurt_25CountBytes,0,hurt_25CountBytes.Length);
for (int i = 0; i < hurt_25.Count; i++){
if(hurt_25[i] == null)hurt_25[i] = new Sysjungle_goods();hurt_25[i].Serializer(ms);
}
if(hurt_30==null)hurt_30 = new List<Sysjungle_goods>();
byte[] hurt_30CountBytes = BitConverter.GetBytes(hurt_30.Count);
            ms.Write(hurt_30CountBytes,0,hurt_30CountBytes.Length);
for (int i = 0; i < hurt_30.Count; i++){
if(hurt_30[i] == null)hurt_30[i] = new Sysjungle_goods();hurt_30[i].Serializer(ms);
}
if(hurt_35==null)hurt_35 = new List<Sysjungle_goods>();
byte[] hurt_35CountBytes = BitConverter.GetBytes(hurt_35.Count);
            ms.Write(hurt_35CountBytes,0,hurt_35CountBytes.Length);
for (int i = 0; i < hurt_35.Count; i++){
if(hurt_35[i] == null)hurt_35[i] = new Sysjungle_goods();hurt_35[i].Serializer(ms);
}
if(hurt_40==null)hurt_40 = new List<Sysjungle_goods>();
byte[] hurt_40CountBytes = BitConverter.GetBytes(hurt_40.Count);
            ms.Write(hurt_40CountBytes,0,hurt_40CountBytes.Length);
for (int i = 0; i < hurt_40.Count; i++){
if(hurt_40[i] == null)hurt_40[i] = new Sysjungle_goods();hurt_40[i].Serializer(ms);
}
if(hurt_45==null)hurt_45 = new List<Sysjungle_goods>();
byte[] hurt_45CountBytes = BitConverter.GetBytes(hurt_45.Count);
            ms.Write(hurt_45CountBytes,0,hurt_45CountBytes.Length);
for (int i = 0; i < hurt_45.Count; i++){
if(hurt_45[i] == null)hurt_45[i] = new Sysjungle_goods();hurt_45[i].Serializer(ms);
}
if(hurt_50==null)hurt_50 = new List<Sysjungle_goods>();
byte[] hurt_50CountBytes = BitConverter.GetBytes(hurt_50.Count);
            ms.Write(hurt_50CountBytes,0,hurt_50CountBytes.Length);
for (int i = 0; i < hurt_50.Count; i++){
if(hurt_50[i] == null)hurt_50[i] = new Sysjungle_goods();hurt_50[i].Serializer(ms);
}
if(hurt_55==null)hurt_55 = new List<Sysjungle_goods>();
byte[] hurt_55CountBytes = BitConverter.GetBytes(hurt_55.Count);
            ms.Write(hurt_55CountBytes,0,hurt_55CountBytes.Length);
for (int i = 0; i < hurt_55.Count; i++){
if(hurt_55[i] == null)hurt_55[i] = new Sysjungle_goods();hurt_55[i].Serializer(ms);
}
if(hurt_60==null)hurt_60 = new List<Sysjungle_goods>();
byte[] hurt_60CountBytes = BitConverter.GetBytes(hurt_60.Count);
            ms.Write(hurt_60CountBytes,0,hurt_60CountBytes.Length);
for (int i = 0; i < hurt_60.Count; i++){
if(hurt_60[i] == null)hurt_60[i] = new Sysjungle_goods();hurt_60[i].Serializer(ms);
}
if(hurt_65==null)hurt_65 = new List<Sysjungle_goods>();
byte[] hurt_65CountBytes = BitConverter.GetBytes(hurt_65.Count);
            ms.Write(hurt_65CountBytes,0,hurt_65CountBytes.Length);
for (int i = 0; i < hurt_65.Count; i++){
if(hurt_65[i] == null)hurt_65[i] = new Sysjungle_goods();hurt_65[i].Serializer(ms);
}
if(hurt_70==null)hurt_70 = new List<Sysjungle_goods>();
byte[] hurt_70CountBytes = BitConverter.GetBytes(hurt_70.Count);
            ms.Write(hurt_70CountBytes,0,hurt_70CountBytes.Length);
for (int i = 0; i < hurt_70.Count; i++){
if(hurt_70[i] == null)hurt_70[i] = new Sysjungle_goods();hurt_70[i].Serializer(ms);
}
if(hurt_75==null)hurt_75 = new List<Sysjungle_goods>();
byte[] hurt_75CountBytes = BitConverter.GetBytes(hurt_75.Count);
            ms.Write(hurt_75CountBytes,0,hurt_75CountBytes.Length);
for (int i = 0; i < hurt_75.Count; i++){
if(hurt_75[i] == null)hurt_75[i] = new Sysjungle_goods();hurt_75[i].Serializer(ms);
}
if(hurt_80==null)hurt_80 = new List<Sysjungle_goods>();
byte[] hurt_80CountBytes = BitConverter.GetBytes(hurt_80.Count);
            ms.Write(hurt_80CountBytes,0,hurt_80CountBytes.Length);
for (int i = 0; i < hurt_80.Count; i++){
if(hurt_80[i] == null)hurt_80[i] = new Sysjungle_goods();hurt_80[i].Serializer(ms);
}
if(hurt_85==null)hurt_85 = new List<Sysjungle_goods>();
byte[] hurt_85CountBytes = BitConverter.GetBytes(hurt_85.Count);
            ms.Write(hurt_85CountBytes,0,hurt_85CountBytes.Length);
for (int i = 0; i < hurt_85.Count; i++){
if(hurt_85[i] == null)hurt_85[i] = new Sysjungle_goods();hurt_85[i].Serializer(ms);
}
if(hurt_90==null)hurt_90 = new List<Sysjungle_goods>();
byte[] hurt_90CountBytes = BitConverter.GetBytes(hurt_90.Count);
            ms.Write(hurt_90CountBytes,0,hurt_90CountBytes.Length);
for (int i = 0; i < hurt_90.Count; i++){
if(hurt_90[i] == null)hurt_90[i] = new Sysjungle_goods();hurt_90[i].Serializer(ms);
}
if(hurt_95==null)hurt_95 = new List<Sysjungle_goods>();
byte[] hurt_95CountBytes = BitConverter.GetBytes(hurt_95.Count);
            ms.Write(hurt_95CountBytes,0,hurt_95CountBytes.Length);
for (int i = 0; i < hurt_95.Count; i++){
if(hurt_95[i] == null)hurt_95[i] = new Sysjungle_goods();hurt_95[i].Serializer(ms);
}
if(hurt_100==null)hurt_100 = new List<Sysjungle_goods>();
byte[] hurt_100CountBytes = BitConverter.GetBytes(hurt_100.Count);
            ms.Write(hurt_100CountBytes,0,hurt_100CountBytes.Length);
for (int i = 0; i < hurt_100.Count; i++){
if(hurt_100[i] == null)hurt_100[i] = new Sysjungle_goods();hurt_100[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int hurt_0Count;
hurt_0Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_0 = new List<Sysjungle_goods>(hurt_0Count);
for (int i = 0; i < hurt_0Count; i++){
hurt_0.Add(new Sysjungle_goods());offset = hurt_0[i].Deserializer(bytes,offset);
}

int hurt_5Count;
hurt_5Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_5 = new List<Sysjungle_goods>(hurt_5Count);
for (int i = 0; i < hurt_5Count; i++){
hurt_5.Add(new Sysjungle_goods());offset = hurt_5[i].Deserializer(bytes,offset);
}

int hurt_10Count;
hurt_10Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_10 = new List<Sysjungle_goods>(hurt_10Count);
for (int i = 0; i < hurt_10Count; i++){
hurt_10.Add(new Sysjungle_goods());offset = hurt_10[i].Deserializer(bytes,offset);
}

int hurt_15Count;
hurt_15Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_15 = new List<Sysjungle_goods>(hurt_15Count);
for (int i = 0; i < hurt_15Count; i++){
hurt_15.Add(new Sysjungle_goods());offset = hurt_15[i].Deserializer(bytes,offset);
}

int hurt_20Count;
hurt_20Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_20 = new List<Sysjungle_goods>(hurt_20Count);
for (int i = 0; i < hurt_20Count; i++){
hurt_20.Add(new Sysjungle_goods());offset = hurt_20[i].Deserializer(bytes,offset);
}

int hurt_25Count;
hurt_25Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_25 = new List<Sysjungle_goods>(hurt_25Count);
for (int i = 0; i < hurt_25Count; i++){
hurt_25.Add(new Sysjungle_goods());offset = hurt_25[i].Deserializer(bytes,offset);
}

int hurt_30Count;
hurt_30Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_30 = new List<Sysjungle_goods>(hurt_30Count);
for (int i = 0; i < hurt_30Count; i++){
hurt_30.Add(new Sysjungle_goods());offset = hurt_30[i].Deserializer(bytes,offset);
}

int hurt_35Count;
hurt_35Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_35 = new List<Sysjungle_goods>(hurt_35Count);
for (int i = 0; i < hurt_35Count; i++){
hurt_35.Add(new Sysjungle_goods());offset = hurt_35[i].Deserializer(bytes,offset);
}

int hurt_40Count;
hurt_40Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_40 = new List<Sysjungle_goods>(hurt_40Count);
for (int i = 0; i < hurt_40Count; i++){
hurt_40.Add(new Sysjungle_goods());offset = hurt_40[i].Deserializer(bytes,offset);
}

int hurt_45Count;
hurt_45Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_45 = new List<Sysjungle_goods>(hurt_45Count);
for (int i = 0; i < hurt_45Count; i++){
hurt_45.Add(new Sysjungle_goods());offset = hurt_45[i].Deserializer(bytes,offset);
}

int hurt_50Count;
hurt_50Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_50 = new List<Sysjungle_goods>(hurt_50Count);
for (int i = 0; i < hurt_50Count; i++){
hurt_50.Add(new Sysjungle_goods());offset = hurt_50[i].Deserializer(bytes,offset);
}

int hurt_55Count;
hurt_55Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_55 = new List<Sysjungle_goods>(hurt_55Count);
for (int i = 0; i < hurt_55Count; i++){
hurt_55.Add(new Sysjungle_goods());offset = hurt_55[i].Deserializer(bytes,offset);
}

int hurt_60Count;
hurt_60Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_60 = new List<Sysjungle_goods>(hurt_60Count);
for (int i = 0; i < hurt_60Count; i++){
hurt_60.Add(new Sysjungle_goods());offset = hurt_60[i].Deserializer(bytes,offset);
}

int hurt_65Count;
hurt_65Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_65 = new List<Sysjungle_goods>(hurt_65Count);
for (int i = 0; i < hurt_65Count; i++){
hurt_65.Add(new Sysjungle_goods());offset = hurt_65[i].Deserializer(bytes,offset);
}

int hurt_70Count;
hurt_70Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_70 = new List<Sysjungle_goods>(hurt_70Count);
for (int i = 0; i < hurt_70Count; i++){
hurt_70.Add(new Sysjungle_goods());offset = hurt_70[i].Deserializer(bytes,offset);
}

int hurt_75Count;
hurt_75Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_75 = new List<Sysjungle_goods>(hurt_75Count);
for (int i = 0; i < hurt_75Count; i++){
hurt_75.Add(new Sysjungle_goods());offset = hurt_75[i].Deserializer(bytes,offset);
}

int hurt_80Count;
hurt_80Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_80 = new List<Sysjungle_goods>(hurt_80Count);
for (int i = 0; i < hurt_80Count; i++){
hurt_80.Add(new Sysjungle_goods());offset = hurt_80[i].Deserializer(bytes,offset);
}

int hurt_85Count;
hurt_85Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_85 = new List<Sysjungle_goods>(hurt_85Count);
for (int i = 0; i < hurt_85Count; i++){
hurt_85.Add(new Sysjungle_goods());offset = hurt_85[i].Deserializer(bytes,offset);
}

int hurt_90Count;
hurt_90Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_90 = new List<Sysjungle_goods>(hurt_90Count);
for (int i = 0; i < hurt_90Count; i++){
hurt_90.Add(new Sysjungle_goods());offset = hurt_90[i].Deserializer(bytes,offset);
}

int hurt_95Count;
hurt_95Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_95 = new List<Sysjungle_goods>(hurt_95Count);
for (int i = 0; i < hurt_95Count; i++){
hurt_95.Add(new Sysjungle_goods());offset = hurt_95[i].Deserializer(bytes,offset);
}

int hurt_100Count;
hurt_100Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_100 = new List<Sysjungle_goods>(hurt_100Count);
for (int i = 0; i < hurt_100Count; i++){
hurt_100.Add(new Sysjungle_goods());offset = hurt_100[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysjungle_gold
    {
		public string unikey;
		public int lv; //难度等级
		public int hurt_0; //0%伤害值
		public int hurt_5; //5%伤害值
		public int hurt_10; //10%伤害值
		public int hurt_15; //15%伤害值
		public int hurt_20; //20%伤害值
		public int hurt_25; //25%伤害值
		public int hurt_30; //30%伤害值
		public int hurt_35; //35%伤害值
		public int hurt_40; //40%伤害值
		public int hurt_45; //45%伤害值
		public int hurt_50; //50%伤害值
		public int hurt_55; //55%伤害值
		public int hurt_60; //60%伤害值
		public int hurt_65; //65%伤害值
		public int hurt_70; //70%伤害值
		public int hurt_75; //75%伤害值
		public int hurt_80; //80%伤害值
		public int hurt_85; //85%伤害值
		public int hurt_90; //90%伤害值
		public int hurt_95; //95%伤害值
		public int hurt_100; //100%伤害值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] hurt_0Bytes = BitConverter.GetBytes(hurt_0);
            ms.Write(hurt_0Bytes,0,hurt_0Bytes.Length);
byte[] hurt_5Bytes = BitConverter.GetBytes(hurt_5);
            ms.Write(hurt_5Bytes,0,hurt_5Bytes.Length);
byte[] hurt_10Bytes = BitConverter.GetBytes(hurt_10);
            ms.Write(hurt_10Bytes,0,hurt_10Bytes.Length);
byte[] hurt_15Bytes = BitConverter.GetBytes(hurt_15);
            ms.Write(hurt_15Bytes,0,hurt_15Bytes.Length);
byte[] hurt_20Bytes = BitConverter.GetBytes(hurt_20);
            ms.Write(hurt_20Bytes,0,hurt_20Bytes.Length);
byte[] hurt_25Bytes = BitConverter.GetBytes(hurt_25);
            ms.Write(hurt_25Bytes,0,hurt_25Bytes.Length);
byte[] hurt_30Bytes = BitConverter.GetBytes(hurt_30);
            ms.Write(hurt_30Bytes,0,hurt_30Bytes.Length);
byte[] hurt_35Bytes = BitConverter.GetBytes(hurt_35);
            ms.Write(hurt_35Bytes,0,hurt_35Bytes.Length);
byte[] hurt_40Bytes = BitConverter.GetBytes(hurt_40);
            ms.Write(hurt_40Bytes,0,hurt_40Bytes.Length);
byte[] hurt_45Bytes = BitConverter.GetBytes(hurt_45);
            ms.Write(hurt_45Bytes,0,hurt_45Bytes.Length);
byte[] hurt_50Bytes = BitConverter.GetBytes(hurt_50);
            ms.Write(hurt_50Bytes,0,hurt_50Bytes.Length);
byte[] hurt_55Bytes = BitConverter.GetBytes(hurt_55);
            ms.Write(hurt_55Bytes,0,hurt_55Bytes.Length);
byte[] hurt_60Bytes = BitConverter.GetBytes(hurt_60);
            ms.Write(hurt_60Bytes,0,hurt_60Bytes.Length);
byte[] hurt_65Bytes = BitConverter.GetBytes(hurt_65);
            ms.Write(hurt_65Bytes,0,hurt_65Bytes.Length);
byte[] hurt_70Bytes = BitConverter.GetBytes(hurt_70);
            ms.Write(hurt_70Bytes,0,hurt_70Bytes.Length);
byte[] hurt_75Bytes = BitConverter.GetBytes(hurt_75);
            ms.Write(hurt_75Bytes,0,hurt_75Bytes.Length);
byte[] hurt_80Bytes = BitConverter.GetBytes(hurt_80);
            ms.Write(hurt_80Bytes,0,hurt_80Bytes.Length);
byte[] hurt_85Bytes = BitConverter.GetBytes(hurt_85);
            ms.Write(hurt_85Bytes,0,hurt_85Bytes.Length);
byte[] hurt_90Bytes = BitConverter.GetBytes(hurt_90);
            ms.Write(hurt_90Bytes,0,hurt_90Bytes.Length);
byte[] hurt_95Bytes = BitConverter.GetBytes(hurt_95);
            ms.Write(hurt_95Bytes,0,hurt_95Bytes.Length);
byte[] hurt_100Bytes = BitConverter.GetBytes(hurt_100);
            ms.Write(hurt_100Bytes,0,hurt_100Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_0 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_5 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_10 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_15 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_20 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_25 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_30 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_35 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_40 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_45 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_50 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_55 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_60 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_65 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_70 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_75 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_80 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_85 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_90 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_95 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hurt_100 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysjungle_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslanguages
    {
		public string unikey;
		public string key; //编号
		public string chinese; //中文名称
		public string english; //英语名称
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
if(string.IsNullOrEmpty(key))key = string.Empty;
            byte[] keyBytes = System.Text.Encoding.UTF8.GetBytes(key);
            byte[] keyBytesLen = BitConverter.GetBytes(keyBytes.Length);
            ms.Write(keyBytesLen, 0, keyBytesLen.Length);
            ms.Write(keyBytes, 0, keyBytes.Length);
if(string.IsNullOrEmpty(chinese))chinese = string.Empty;
            byte[] chineseBytes = System.Text.Encoding.UTF8.GetBytes(chinese);
            byte[] chineseBytesLen = BitConverter.GetBytes(chineseBytes.Length);
            ms.Write(chineseBytesLen, 0, chineseBytesLen.Length);
            ms.Write(chineseBytes, 0, chineseBytes.Length);
if(string.IsNullOrEmpty(english))english = string.Empty;
            byte[] englishBytes = System.Text.Encoding.UTF8.GetBytes(english);
            byte[] englishBytesLen = BitConverter.GetBytes(englishBytes.Length);
            ms.Write(englishBytesLen, 0, englishBytesLen.Length);
            ms.Write(englishBytes, 0, englishBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
int key_count;key_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;key = System.Text.Encoding.UTF8.GetString(bytes, offset, key_count);offset += key_count;
int chinese_count;chinese_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;chinese = System.Text.Encoding.UTF8.GetString(bytes, offset, chinese_count);offset += chinese_count;
int english_count;english_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;english = System.Text.Encoding.UTF8.GetString(bytes, offset, english_count);offset += english_count;
return offset;
        }
} 
 [Serializable]public class Syslogin_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslookfor_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
		public int goods_rate; //物品概率
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
byte[] goods_rateBytes = BitConverter.GetBytes(goods_rate);
            ms.Write(goods_rateBytes,0,goods_rateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslottery
    {
		public string unikey;
		public int id; //编号
		public List<int> lv; //等级段
		public int type; //类型
		public List<Syslottery_struct> coin_one; //金币单抽
		public List<Syslottery_struct> coin_ten; //金币十抽
		public List<Syslottery_struct> coin_one2; //金币单抽十次必得
		public List<Syslottery_struct> coin_ten2; //金币十抽必得物品
		public List<Syslottery_struct> gold_one; //钻石单抽
		public List<Syslottery_struct> gold_ten; //钻石十抽
		public List<Syslottery_struct> gold_one2; //钻石单抽十次必得
		public List<Syslottery_struct> gold_ten2; //钻石十抽必得英雄
		public List<Syslottery_struct> gold_ten3; //钻石十抽封顶库
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(lv==null)lv = new List<int>();
byte[] lvCountBytes = BitConverter.GetBytes(lv.Count);
            ms.Write(lvCountBytes,0,lvCountBytes.Length);
for (int i = 0; i < lv.Count; i++){
byte[] lvBytes = BitConverter.GetBytes(lv[i]);
            ms.Write(lvBytes,0,lvBytes.Length);
}
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(coin_one==null)coin_one = new List<Syslottery_struct>();
byte[] coin_oneCountBytes = BitConverter.GetBytes(coin_one.Count);
            ms.Write(coin_oneCountBytes,0,coin_oneCountBytes.Length);
for (int i = 0; i < coin_one.Count; i++){
if(coin_one[i] == null)coin_one[i] = new Syslottery_struct();coin_one[i].Serializer(ms);
}
if(coin_ten==null)coin_ten = new List<Syslottery_struct>();
byte[] coin_tenCountBytes = BitConverter.GetBytes(coin_ten.Count);
            ms.Write(coin_tenCountBytes,0,coin_tenCountBytes.Length);
for (int i = 0; i < coin_ten.Count; i++){
if(coin_ten[i] == null)coin_ten[i] = new Syslottery_struct();coin_ten[i].Serializer(ms);
}
if(coin_one2==null)coin_one2 = new List<Syslottery_struct>();
byte[] coin_one2CountBytes = BitConverter.GetBytes(coin_one2.Count);
            ms.Write(coin_one2CountBytes,0,coin_one2CountBytes.Length);
for (int i = 0; i < coin_one2.Count; i++){
if(coin_one2[i] == null)coin_one2[i] = new Syslottery_struct();coin_one2[i].Serializer(ms);
}
if(coin_ten2==null)coin_ten2 = new List<Syslottery_struct>();
byte[] coin_ten2CountBytes = BitConverter.GetBytes(coin_ten2.Count);
            ms.Write(coin_ten2CountBytes,0,coin_ten2CountBytes.Length);
for (int i = 0; i < coin_ten2.Count; i++){
if(coin_ten2[i] == null)coin_ten2[i] = new Syslottery_struct();coin_ten2[i].Serializer(ms);
}
if(gold_one==null)gold_one = new List<Syslottery_struct>();
byte[] gold_oneCountBytes = BitConverter.GetBytes(gold_one.Count);
            ms.Write(gold_oneCountBytes,0,gold_oneCountBytes.Length);
for (int i = 0; i < gold_one.Count; i++){
if(gold_one[i] == null)gold_one[i] = new Syslottery_struct();gold_one[i].Serializer(ms);
}
if(gold_ten==null)gold_ten = new List<Syslottery_struct>();
byte[] gold_tenCountBytes = BitConverter.GetBytes(gold_ten.Count);
            ms.Write(gold_tenCountBytes,0,gold_tenCountBytes.Length);
for (int i = 0; i < gold_ten.Count; i++){
if(gold_ten[i] == null)gold_ten[i] = new Syslottery_struct();gold_ten[i].Serializer(ms);
}
if(gold_one2==null)gold_one2 = new List<Syslottery_struct>();
byte[] gold_one2CountBytes = BitConverter.GetBytes(gold_one2.Count);
            ms.Write(gold_one2CountBytes,0,gold_one2CountBytes.Length);
for (int i = 0; i < gold_one2.Count; i++){
if(gold_one2[i] == null)gold_one2[i] = new Syslottery_struct();gold_one2[i].Serializer(ms);
}
if(gold_ten2==null)gold_ten2 = new List<Syslottery_struct>();
byte[] gold_ten2CountBytes = BitConverter.GetBytes(gold_ten2.Count);
            ms.Write(gold_ten2CountBytes,0,gold_ten2CountBytes.Length);
for (int i = 0; i < gold_ten2.Count; i++){
if(gold_ten2[i] == null)gold_ten2[i] = new Syslottery_struct();gold_ten2[i].Serializer(ms);
}
if(gold_ten3==null)gold_ten3 = new List<Syslottery_struct>();
byte[] gold_ten3CountBytes = BitConverter.GetBytes(gold_ten3.Count);
            ms.Write(gold_ten3CountBytes,0,gold_ten3CountBytes.Length);
for (int i = 0; i < gold_ten3.Count; i++){
if(gold_ten3[i] == null)gold_ten3[i] = new Syslottery_struct();gold_ten3[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int lvCount;
lvCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = new List<int>(lvCount);
for (int i = 0; i < lvCount; i++){
lv.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int coin_oneCount;
coin_oneCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_one = new List<Syslottery_struct>(coin_oneCount);
for (int i = 0; i < coin_oneCount; i++){
coin_one.Add(new Syslottery_struct());offset = coin_one[i].Deserializer(bytes,offset);
}

int coin_tenCount;
coin_tenCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_ten = new List<Syslottery_struct>(coin_tenCount);
for (int i = 0; i < coin_tenCount; i++){
coin_ten.Add(new Syslottery_struct());offset = coin_ten[i].Deserializer(bytes,offset);
}

int coin_one2Count;
coin_one2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_one2 = new List<Syslottery_struct>(coin_one2Count);
for (int i = 0; i < coin_one2Count; i++){
coin_one2.Add(new Syslottery_struct());offset = coin_one2[i].Deserializer(bytes,offset);
}

int coin_ten2Count;
coin_ten2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_ten2 = new List<Syslottery_struct>(coin_ten2Count);
for (int i = 0; i < coin_ten2Count; i++){
coin_ten2.Add(new Syslottery_struct());offset = coin_ten2[i].Deserializer(bytes,offset);
}

int gold_oneCount;
gold_oneCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_one = new List<Syslottery_struct>(gold_oneCount);
for (int i = 0; i < gold_oneCount; i++){
gold_one.Add(new Syslottery_struct());offset = gold_one[i].Deserializer(bytes,offset);
}

int gold_tenCount;
gold_tenCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_ten = new List<Syslottery_struct>(gold_tenCount);
for (int i = 0; i < gold_tenCount; i++){
gold_ten.Add(new Syslottery_struct());offset = gold_ten[i].Deserializer(bytes,offset);
}

int gold_one2Count;
gold_one2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_one2 = new List<Syslottery_struct>(gold_one2Count);
for (int i = 0; i < gold_one2Count; i++){
gold_one2.Add(new Syslottery_struct());offset = gold_one2[i].Deserializer(bytes,offset);
}

int gold_ten2Count;
gold_ten2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_ten2 = new List<Syslottery_struct>(gold_ten2Count);
for (int i = 0; i < gold_ten2Count; i++){
gold_ten2.Add(new Syslottery_struct());offset = gold_ten2[i].Deserializer(bytes,offset);
}

int gold_ten3Count;
gold_ten3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_ten3 = new List<Syslottery_struct>(gold_ten3Count);
for (int i = 0; i < gold_ten3Count; i++){
gold_ten3.Add(new Syslottery_struct());offset = gold_ten3[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syslottery_struct
    {
		public int id; //物品或英雄Id
		public int num; //物品数量或英雄星级
		public int rate; //概率
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] rateBytes = BitConverter.GetBytes(rate);
            ms.Write(rateBytes,0,rateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslv_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmail
    {
		public string unikey;
		public int type; //邮件类型
		public string title; //邮件标题
		public string content; //邮件内容
		public string sender; //发送人
		public int time; //有效期
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(title))title = string.Empty;
            byte[] titleBytes = System.Text.Encoding.UTF8.GetBytes(title);
            byte[] titleBytesLen = BitConverter.GetBytes(titleBytes.Length);
            ms.Write(titleBytesLen, 0, titleBytesLen.Length);
            ms.Write(titleBytes, 0, titleBytes.Length);
if(string.IsNullOrEmpty(content))content = string.Empty;
            byte[] contentBytes = System.Text.Encoding.UTF8.GetBytes(content);
            byte[] contentBytesLen = BitConverter.GetBytes(contentBytes.Length);
            ms.Write(contentBytesLen, 0, contentBytesLen.Length);
            ms.Write(contentBytes, 0, contentBytes.Length);
if(string.IsNullOrEmpty(sender))sender = string.Empty;
            byte[] senderBytes = System.Text.Encoding.UTF8.GetBytes(sender);
            byte[] senderBytesLen = BitConverter.GetBytes(senderBytes.Length);
            ms.Write(senderBytesLen, 0, senderBytesLen.Length);
            ms.Write(senderBytes, 0, senderBytes.Length);
byte[] timeBytes = BitConverter.GetBytes(time);
            ms.Write(timeBytes,0,timeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int title_count;title_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;title = System.Text.Encoding.UTF8.GetString(bytes, offset, title_count);offset += title_count;
int content_count;content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;content = System.Text.Encoding.UTF8.GetString(bytes, offset, content_count);offset += content_count;
int sender_count;sender_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;sender = System.Text.Encoding.UTF8.GetString(bytes, offset, sender_count);offset += sender_count;
time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmall
    {
		public string unikey;
		public int id; //唯一id
		public int goods_id; //物品id
		public int mall_type; //商城类型
		public List<int> lv; //等级段
		public int goods_type; //道具类型
		public int cost_type; //货币类型
		public int old_price; //原价
		public int new_price; //现价
		public int limit_total; //限购总个数
		public int limit_once; //单次限购个数
		public List<int> date_num; //周几出现
		public int rate; //出现概率
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] mall_typeBytes = BitConverter.GetBytes(mall_type);
            ms.Write(mall_typeBytes,0,mall_typeBytes.Length);
if(lv==null)lv = new List<int>();
byte[] lvCountBytes = BitConverter.GetBytes(lv.Count);
            ms.Write(lvCountBytes,0,lvCountBytes.Length);
for (int i = 0; i < lv.Count; i++){
byte[] lvBytes = BitConverter.GetBytes(lv[i]);
            ms.Write(lvBytes,0,lvBytes.Length);
}
byte[] goods_typeBytes = BitConverter.GetBytes(goods_type);
            ms.Write(goods_typeBytes,0,goods_typeBytes.Length);
byte[] cost_typeBytes = BitConverter.GetBytes(cost_type);
            ms.Write(cost_typeBytes,0,cost_typeBytes.Length);
byte[] old_priceBytes = BitConverter.GetBytes(old_price);
            ms.Write(old_priceBytes,0,old_priceBytes.Length);
byte[] new_priceBytes = BitConverter.GetBytes(new_price);
            ms.Write(new_priceBytes,0,new_priceBytes.Length);
byte[] limit_totalBytes = BitConverter.GetBytes(limit_total);
            ms.Write(limit_totalBytes,0,limit_totalBytes.Length);
byte[] limit_onceBytes = BitConverter.GetBytes(limit_once);
            ms.Write(limit_onceBytes,0,limit_onceBytes.Length);
if(date_num==null)date_num = new List<int>();
byte[] date_numCountBytes = BitConverter.GetBytes(date_num.Count);
            ms.Write(date_numCountBytes,0,date_numCountBytes.Length);
for (int i = 0; i < date_num.Count; i++){
byte[] date_numBytes = BitConverter.GetBytes(date_num[i]);
            ms.Write(date_numBytes,0,date_numBytes.Length);
}
byte[] rateBytes = BitConverter.GetBytes(rate);
            ms.Write(rateBytes,0,rateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mall_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int lvCount;
lvCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = new List<int>(lvCount);
for (int i = 0; i < lvCount; i++){
lv.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
goods_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cost_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
old_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
new_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
limit_total = BitConverter.ToInt32(bytes, offset);
            offset += 4;
limit_once = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int date_numCount;
date_numCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
date_num = new List<int>(date_numCount);
for (int i = 0; i < date_numCount; i++){
date_num.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmall_another
    {
		public string unikey;
		public int id; //唯一id
		public int goods_id; //物品id
		public int mall_type; //商城类型
		public int type_1; //货币类型
		public int type_2; //货币值
		public int price; //价格
		public int limit_buy; //限购次数
		public int num; //单次购买个数
		public int goods_type; //道具类型
		public int goods_position; //物品位置
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] mall_typeBytes = BitConverter.GetBytes(mall_type);
            ms.Write(mall_typeBytes,0,mall_typeBytes.Length);
byte[] type_1Bytes = BitConverter.GetBytes(type_1);
            ms.Write(type_1Bytes,0,type_1Bytes.Length);
byte[] type_2Bytes = BitConverter.GetBytes(type_2);
            ms.Write(type_2Bytes,0,type_2Bytes.Length);
byte[] priceBytes = BitConverter.GetBytes(price);
            ms.Write(priceBytes,0,priceBytes.Length);
byte[] limit_buyBytes = BitConverter.GetBytes(limit_buy);
            ms.Write(limit_buyBytes,0,limit_buyBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] goods_typeBytes = BitConverter.GetBytes(goods_type);
            ms.Write(goods_typeBytes,0,goods_typeBytes.Length);
byte[] goods_positionBytes = BitConverter.GetBytes(goods_position);
            ms.Write(goods_positionBytes,0,goods_positionBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mall_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type_2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
limit_buy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_position = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmall_discount
    {
		public string unikey;
		public int id; //唯一id
		public int type_1; //货币类型
		public int limit_buy; //每周限购次数
		public int old_price; //原价
		public int new_price; //现价
		public List<Sysmall_discount_goods> goods_list; //物品列表
		public string name; //物品名称
		public int qulity; //颜色框
		public string icon; //物品图标
		public string desc; //物品描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] type_1Bytes = BitConverter.GetBytes(type_1);
            ms.Write(type_1Bytes,0,type_1Bytes.Length);
byte[] limit_buyBytes = BitConverter.GetBytes(limit_buy);
            ms.Write(limit_buyBytes,0,limit_buyBytes.Length);
byte[] old_priceBytes = BitConverter.GetBytes(old_price);
            ms.Write(old_priceBytes,0,old_priceBytes.Length);
byte[] new_priceBytes = BitConverter.GetBytes(new_price);
            ms.Write(new_priceBytes,0,new_priceBytes.Length);
if(goods_list==null)goods_list = new List<Sysmall_discount_goods>();
byte[] goods_listCountBytes = BitConverter.GetBytes(goods_list.Count);
            ms.Write(goods_listCountBytes,0,goods_listCountBytes.Length);
for (int i = 0; i < goods_list.Count; i++){
if(goods_list[i] == null)goods_list[i] = new Sysmall_discount_goods();goods_list[i].Serializer(ms);
}
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] qulityBytes = BitConverter.GetBytes(qulity);
            ms.Write(qulityBytes,0,qulityBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
limit_buy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
old_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
new_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goods_listCount;
goods_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_list = new List<Sysmall_discount_goods>(goods_listCount);
for (int i = 0; i < goods_listCount; i++){
goods_list.Add(new Sysmall_discount_goods());offset = goods_list[i].Deserializer(bytes,offset);
}
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
qulity = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Sysmall_discount_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmanual
    {
		public string unikey;
		public int id; //系统id
		public string title; //标题
		public string desc; //规则描述
		public string link; //超链接
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(title))title = string.Empty;
            byte[] titleBytes = System.Text.Encoding.UTF8.GetBytes(title);
            byte[] titleBytesLen = BitConverter.GetBytes(titleBytes.Length);
            ms.Write(titleBytesLen, 0, titleBytesLen.Length);
            ms.Write(titleBytes, 0, titleBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(link))link = string.Empty;
            byte[] linkBytes = System.Text.Encoding.UTF8.GetBytes(link);
            byte[] linkBytesLen = BitConverter.GetBytes(linkBytes.Length);
            ms.Write(linkBytesLen, 0, linkBytesLen.Length);
            ms.Write(linkBytes, 0, linkBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int title_count;title_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;title = System.Text.Encoding.UTF8.GetString(bytes, offset, title_count);offset += title_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int link_count;link_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;link = System.Text.Encoding.UTF8.GetString(bytes, offset, link_count);offset += link_count;
return offset;
        }
} 
 [Serializable]public class Sysmarking
    {
		public string unikey;
		public int mark_id; //印记id
		public string mark_name; //道具名称
		public int base_exp; //基础经验
		public int quality; //基础颜色
		public int sell; //基础售价
		public int type; //属性类型
		public float value; //属性数值
		public string icon; //图标
		public string desc; //描述
		public List<Sysmarking_getway> get_way; //获得途径
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] mark_idBytes = BitConverter.GetBytes(mark_id);
            ms.Write(mark_idBytes,0,mark_idBytes.Length);
if(string.IsNullOrEmpty(mark_name))mark_name = string.Empty;
            byte[] mark_nameBytes = System.Text.Encoding.UTF8.GetBytes(mark_name);
            byte[] mark_nameBytesLen = BitConverter.GetBytes(mark_nameBytes.Length);
            ms.Write(mark_nameBytesLen, 0, mark_nameBytesLen.Length);
            ms.Write(mark_nameBytes, 0, mark_nameBytes.Length);
byte[] base_expBytes = BitConverter.GetBytes(base_exp);
            ms.Write(base_expBytes,0,base_expBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] sellBytes = BitConverter.GetBytes(sell);
            ms.Write(sellBytes,0,sellBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(get_way==null)get_way = new List<Sysmarking_getway>();
byte[] get_wayCountBytes = BitConverter.GetBytes(get_way.Count);
            ms.Write(get_wayCountBytes,0,get_wayCountBytes.Length);
for (int i = 0; i < get_way.Count; i++){
if(get_way[i] == null)get_way[i] = new Sysmarking_getway();get_way[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
mark_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int mark_name_count;mark_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;mark_name = System.Text.Encoding.UTF8.GetString(bytes, offset, mark_name_count);offset += mark_name_count;
base_exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sell = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;

int get_wayCount;
get_wayCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
get_way = new List<Sysmarking_getway>(get_wayCount);
for (int i = 0; i < get_wayCount; i++){
get_way.Add(new Sysmarking_getway());offset = get_way[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysmarking_attr
    {
		public int type; //属性
		public float value; //数值
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmarking_exp
    {
		public string unikey;
		public int quality; //品质
		public int lv; //符文等级
		public int exp; //符文经验
		public int parn; //被吞吃换算系数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] parnBytes = BitConverter.GetBytes(parn);
            ms.Write(parnBytes,0,parnBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
parn = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmarking_getway
    {
		public int type; //类型
		public string desc; //描述
		public List<int> param; //参数
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(param==null)param = new List<int>();
byte[] paramCountBytes = BitConverter.GetBytes(param.Count);
            ms.Write(paramCountBytes,0,paramCountBytes.Length);
for (int i = 0; i < param.Count; i++){
byte[] paramBytes = BitConverter.GetBytes(param[i]);
            ms.Write(paramBytes,0,paramBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;

int paramCount;
paramCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
param = new List<int>(paramCount);
for (int i = 0; i < paramCount; i++){
param.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysmarking_LevUp
    {
		public string unikey;
		public int id; //印记id
		public int lev; //等级
		public List<Sysmarking_attr> attr; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] levBytes = BitConverter.GetBytes(lev);
            ms.Write(levBytes,0,levBytes.Length);
if(attr==null)attr = new List<Sysmarking_attr>();
byte[] attrCountBytes = BitConverter.GetBytes(attr.Count);
            ms.Write(attrCountBytes,0,attrCountBytes.Length);
for (int i = 0; i < attr.Count; i++){
if(attr[i] == null)attr[i] = new Sysmarking_attr();attr[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lev = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int attrCount;
attrCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr = new List<Sysmarking_attr>(attrCount);
for (int i = 0; i < attrCount; i++){
attr.Add(new Sysmarking_attr());offset = attr[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysmarking_magic
    {
		public string unikey;
		public int id; //法师id
		public string name; //道具名称
		public string desc; //     能力描述
		public int quality; //当前可召唤的最高品质
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmarking_type
    {
		public string unikey;
		public int type; //属性类型
		public string name; //名称
		public string icon; //图标
		public List<int> attr; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(attr==null)attr = new List<int>();
byte[] attrCountBytes = BitConverter.GetBytes(attr.Count);
            ms.Write(attrCountBytes,0,attrCountBytes.Length);
for (int i = 0; i < attr.Count; i++){
byte[] attrBytes = BitConverter.GetBytes(attr[i]);
            ms.Write(attrBytes,0,attrBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;

int attrCount;
attrCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr = new List<int>(attrCount);
for (int i = 0; i < attrCount; i++){
attr.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysmars
    {
		public string unikey;
		public int id; //id
		public int speed_up_time; //可加速次数
		public int speed_up_acitivity; //一次加速增加活跃点
		public string mars_desc1; //描述1
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] speed_up_timeBytes = BitConverter.GetBytes(speed_up_time);
            ms.Write(speed_up_timeBytes,0,speed_up_timeBytes.Length);
byte[] speed_up_acitivityBytes = BitConverter.GetBytes(speed_up_acitivity);
            ms.Write(speed_up_acitivityBytes,0,speed_up_acitivityBytes.Length);
if(string.IsNullOrEmpty(mars_desc1))mars_desc1 = string.Empty;
            byte[] mars_desc1Bytes = System.Text.Encoding.UTF8.GetBytes(mars_desc1);
            byte[] mars_desc1BytesLen = BitConverter.GetBytes(mars_desc1Bytes.Length);
            ms.Write(mars_desc1BytesLen, 0, mars_desc1BytesLen.Length);
            ms.Write(mars_desc1Bytes, 0, mars_desc1Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
speed_up_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
speed_up_acitivity = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int mars_desc1_count;mars_desc1_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;mars_desc1 = System.Text.Encoding.UTF8.GetString(bytes, offset, mars_desc1_count);offset += mars_desc1_count;
return offset;
        }
} 
 [Serializable]public class Sysmars_activity
    {
		public string unikey;
		public int task_id; //对应的任务id
		public string function_name; //功能名称
		public int times; //完成次数
		public int reward; //完成奖励(活跃度)
		public int function_open_id; //对应function_open
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] task_idBytes = BitConverter.GetBytes(task_id);
            ms.Write(task_idBytes,0,task_idBytes.Length);
if(string.IsNullOrEmpty(function_name))function_name = string.Empty;
            byte[] function_nameBytes = System.Text.Encoding.UTF8.GetBytes(function_name);
            byte[] function_nameBytesLen = BitConverter.GetBytes(function_nameBytes.Length);
            ms.Write(function_nameBytesLen, 0, function_nameBytesLen.Length);
            ms.Write(function_nameBytes, 0, function_nameBytes.Length);
byte[] timesBytes = BitConverter.GetBytes(times);
            ms.Write(timesBytes,0,timesBytes.Length);
byte[] rewardBytes = BitConverter.GetBytes(reward);
            ms.Write(rewardBytes,0,rewardBytes.Length);
byte[] function_open_idBytes = BitConverter.GetBytes(function_open_id);
            ms.Write(function_open_idBytes,0,function_open_idBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
task_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int function_name_count;function_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;function_name = System.Text.Encoding.UTF8.GetString(bytes, offset, function_name_count);offset += function_name_count;
times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward = BitConverter.ToInt32(bytes, offset);
            offset += 4;
function_open_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmars_addition
    {
		public string unikey;
		public int lv; //等级
		public int exp; //升级所需活跃度
		public float arg; //加成比例
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] argBytes = BitConverter.GetBytes(arg);
            ms.Write(argBytes,0,argBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmars_use
    {
		public string unikey;
		public int id; //次数
		public List<Sysuse> use_1; //上古神器普通培养消耗
		public List<Sysuse> use_3; //上古神器高级培养消耗
		public int mars_exp_1; //普通培养获得
		public int mars_exp_3; //高级培养获得
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(use_1==null)use_1 = new List<Sysuse>();
byte[] use_1CountBytes = BitConverter.GetBytes(use_1.Count);
            ms.Write(use_1CountBytes,0,use_1CountBytes.Length);
for (int i = 0; i < use_1.Count; i++){
if(use_1[i] == null)use_1[i] = new Sysuse();use_1[i].Serializer(ms);
}
if(use_3==null)use_3 = new List<Sysuse>();
byte[] use_3CountBytes = BitConverter.GetBytes(use_3.Count);
            ms.Write(use_3CountBytes,0,use_3CountBytes.Length);
for (int i = 0; i < use_3.Count; i++){
if(use_3[i] == null)use_3[i] = new Sysuse();use_3[i].Serializer(ms);
}
byte[] mars_exp_1Bytes = BitConverter.GetBytes(mars_exp_1);
            ms.Write(mars_exp_1Bytes,0,mars_exp_1Bytes.Length);
byte[] mars_exp_3Bytes = BitConverter.GetBytes(mars_exp_3);
            ms.Write(mars_exp_3Bytes,0,mars_exp_3Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int use_1Count;
use_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
use_1 = new List<Sysuse>(use_1Count);
for (int i = 0; i < use_1Count; i++){
use_1.Add(new Sysuse());offset = use_1[i].Deserializer(bytes,offset);
}

int use_3Count;
use_3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
use_3 = new List<Sysuse>(use_3Count);
for (int i = 0; i < use_3Count; i++){
use_3.Add(new Sysuse());offset = use_3[i].Deserializer(bytes,offset);
}
mars_exp_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mars_exp_3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmelee
    {
		public string unikey;
		public int melee_id; //关卡ID
		public int chapter_id; //章节ID
		public int pre_dungeon; //前置关卡ID
		public int pre_nomal_dungeon; //前置普通副本关卡id
		public int next_dungeon; //下一关关卡ID
		public int type; //关卡类型
		public string dungeon_name; //关卡名称
		public string map; //场景地图
		public int xml; //场景配置
		public int strength_w; //挑战胜利消耗体力
		public int strength_f; //挑战失败消耗体力
		public int strength_s; //扫荡消耗体力
		public int init_times; //初始挑战次数
		public int init_max; //初始上限
		public int max_times; //不再回复的上限
		public int buy_times; //购买次数
		public int recover_cd; //次数恢复时间
		public int clean_cost; //清除逃跑cd消耗
		public int buy_cost; //购买次数消耗
		public int lv; //等级限制
		public int advise_lv; //推荐等级
		public int time; //时间限制
		public int monster_limit; //野怪数量限制
		public List<Sysstar_rule> rule; //星数规则
		public List<Sysdesc_rule> rule_desc; //规则描述，显示用
		public int star; //最高星数
		public int can_auto; //托管战斗
		public int times; //每日可通关次数
		public int hero_limit; //英雄进入数限制
		public List<Sysdungeon_position> target_pos; //角色下一个目标点
		public List<int> icon_pos; //小关卡在UI上的位置
		public List<Syswin_rule> win_rule; //胜利条件
		public List<Sysfail_rule> fail_rule; //失败规则
		public string map_load; //关卡loading图片
		public int hero_ai1; //主英雄ai调用
		public int hero_ai2; //副英雄ai调用
		public int enemy_ai1; //敌对匹配主英雄ai调用
		public int enemy_ai2; //敌对匹配副英雄ai调用
		public Syssoul_calculate soul; //血契计算引用
		public List<Systower> towers1; //己方推塔顺序
		public List<Systower> towers2; //敌方推塔顺序
		public int robot; //机器人
		public int way; //单/双路
		public int field_of_view; //视野
		public float offset_x; //x偏移
		public float offset_y; //y偏移
		public float offset_z; //z偏移
		public List<int> blood_buff_0; //血契增强BUFF
		public List<int> blood_buff_1; //血契减免BUFF
		public List<int> blood_exps; //血契经验
		public int player_number; //单个队伍最多人数
		public List<int> combat_plus; //战力BUFF加成
		public List<int> star_plus; //星级BUFF加成
		public List<int> neutral_ids; //野怪id
		public List<int> neutral_ids_right; //野怪id(pvp红方专用)
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] melee_idBytes = BitConverter.GetBytes(melee_id);
            ms.Write(melee_idBytes,0,melee_idBytes.Length);
byte[] chapter_idBytes = BitConverter.GetBytes(chapter_id);
            ms.Write(chapter_idBytes,0,chapter_idBytes.Length);
byte[] pre_dungeonBytes = BitConverter.GetBytes(pre_dungeon);
            ms.Write(pre_dungeonBytes,0,pre_dungeonBytes.Length);
byte[] pre_nomal_dungeonBytes = BitConverter.GetBytes(pre_nomal_dungeon);
            ms.Write(pre_nomal_dungeonBytes,0,pre_nomal_dungeonBytes.Length);
byte[] next_dungeonBytes = BitConverter.GetBytes(next_dungeon);
            ms.Write(next_dungeonBytes,0,next_dungeonBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(string.IsNullOrEmpty(dungeon_name))dungeon_name = string.Empty;
            byte[] dungeon_nameBytes = System.Text.Encoding.UTF8.GetBytes(dungeon_name);
            byte[] dungeon_nameBytesLen = BitConverter.GetBytes(dungeon_nameBytes.Length);
            ms.Write(dungeon_nameBytesLen, 0, dungeon_nameBytesLen.Length);
            ms.Write(dungeon_nameBytes, 0, dungeon_nameBytes.Length);
if(string.IsNullOrEmpty(map))map = string.Empty;
            byte[] mapBytes = System.Text.Encoding.UTF8.GetBytes(map);
            byte[] mapBytesLen = BitConverter.GetBytes(mapBytes.Length);
            ms.Write(mapBytesLen, 0, mapBytesLen.Length);
            ms.Write(mapBytes, 0, mapBytes.Length);
byte[] xmlBytes = BitConverter.GetBytes(xml);
            ms.Write(xmlBytes,0,xmlBytes.Length);
byte[] strength_wBytes = BitConverter.GetBytes(strength_w);
            ms.Write(strength_wBytes,0,strength_wBytes.Length);
byte[] strength_fBytes = BitConverter.GetBytes(strength_f);
            ms.Write(strength_fBytes,0,strength_fBytes.Length);
byte[] strength_sBytes = BitConverter.GetBytes(strength_s);
            ms.Write(strength_sBytes,0,strength_sBytes.Length);
byte[] init_timesBytes = BitConverter.GetBytes(init_times);
            ms.Write(init_timesBytes,0,init_timesBytes.Length);
byte[] init_maxBytes = BitConverter.GetBytes(init_max);
            ms.Write(init_maxBytes,0,init_maxBytes.Length);
byte[] max_timesBytes = BitConverter.GetBytes(max_times);
            ms.Write(max_timesBytes,0,max_timesBytes.Length);
byte[] buy_timesBytes = BitConverter.GetBytes(buy_times);
            ms.Write(buy_timesBytes,0,buy_timesBytes.Length);
byte[] recover_cdBytes = BitConverter.GetBytes(recover_cd);
            ms.Write(recover_cdBytes,0,recover_cdBytes.Length);
byte[] clean_costBytes = BitConverter.GetBytes(clean_cost);
            ms.Write(clean_costBytes,0,clean_costBytes.Length);
byte[] buy_costBytes = BitConverter.GetBytes(buy_cost);
            ms.Write(buy_costBytes,0,buy_costBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] advise_lvBytes = BitConverter.GetBytes(advise_lv);
            ms.Write(advise_lvBytes,0,advise_lvBytes.Length);
byte[] timeBytes = BitConverter.GetBytes(time);
            ms.Write(timeBytes,0,timeBytes.Length);
byte[] monster_limitBytes = BitConverter.GetBytes(monster_limit);
            ms.Write(monster_limitBytes,0,monster_limitBytes.Length);
if(rule==null)rule = new List<Sysstar_rule>();
byte[] ruleCountBytes = BitConverter.GetBytes(rule.Count);
            ms.Write(ruleCountBytes,0,ruleCountBytes.Length);
for (int i = 0; i < rule.Count; i++){
if(rule[i] == null)rule[i] = new Sysstar_rule();rule[i].Serializer(ms);
}
if(rule_desc==null)rule_desc = new List<Sysdesc_rule>();
byte[] rule_descCountBytes = BitConverter.GetBytes(rule_desc.Count);
            ms.Write(rule_descCountBytes,0,rule_descCountBytes.Length);
for (int i = 0; i < rule_desc.Count; i++){
if(rule_desc[i] == null)rule_desc[i] = new Sysdesc_rule();rule_desc[i].Serializer(ms);
}
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] can_autoBytes = BitConverter.GetBytes(can_auto);
            ms.Write(can_autoBytes,0,can_autoBytes.Length);
byte[] timesBytes = BitConverter.GetBytes(times);
            ms.Write(timesBytes,0,timesBytes.Length);
byte[] hero_limitBytes = BitConverter.GetBytes(hero_limit);
            ms.Write(hero_limitBytes,0,hero_limitBytes.Length);
if(target_pos==null)target_pos = new List<Sysdungeon_position>();
byte[] target_posCountBytes = BitConverter.GetBytes(target_pos.Count);
            ms.Write(target_posCountBytes,0,target_posCountBytes.Length);
for (int i = 0; i < target_pos.Count; i++){
if(target_pos[i] == null)target_pos[i] = new Sysdungeon_position();target_pos[i].Serializer(ms);
}
if(icon_pos==null)icon_pos = new List<int>();
byte[] icon_posCountBytes = BitConverter.GetBytes(icon_pos.Count);
            ms.Write(icon_posCountBytes,0,icon_posCountBytes.Length);
for (int i = 0; i < icon_pos.Count; i++){
byte[] icon_posBytes = BitConverter.GetBytes(icon_pos[i]);
            ms.Write(icon_posBytes,0,icon_posBytes.Length);
}
if(win_rule==null)win_rule = new List<Syswin_rule>();
byte[] win_ruleCountBytes = BitConverter.GetBytes(win_rule.Count);
            ms.Write(win_ruleCountBytes,0,win_ruleCountBytes.Length);
for (int i = 0; i < win_rule.Count; i++){
if(win_rule[i] == null)win_rule[i] = new Syswin_rule();win_rule[i].Serializer(ms);
}
if(fail_rule==null)fail_rule = new List<Sysfail_rule>();
byte[] fail_ruleCountBytes = BitConverter.GetBytes(fail_rule.Count);
            ms.Write(fail_ruleCountBytes,0,fail_ruleCountBytes.Length);
for (int i = 0; i < fail_rule.Count; i++){
if(fail_rule[i] == null)fail_rule[i] = new Sysfail_rule();fail_rule[i].Serializer(ms);
}
if(string.IsNullOrEmpty(map_load))map_load = string.Empty;
            byte[] map_loadBytes = System.Text.Encoding.UTF8.GetBytes(map_load);
            byte[] map_loadBytesLen = BitConverter.GetBytes(map_loadBytes.Length);
            ms.Write(map_loadBytesLen, 0, map_loadBytesLen.Length);
            ms.Write(map_loadBytes, 0, map_loadBytes.Length);
byte[] hero_ai1Bytes = BitConverter.GetBytes(hero_ai1);
            ms.Write(hero_ai1Bytes,0,hero_ai1Bytes.Length);
byte[] hero_ai2Bytes = BitConverter.GetBytes(hero_ai2);
            ms.Write(hero_ai2Bytes,0,hero_ai2Bytes.Length);
byte[] enemy_ai1Bytes = BitConverter.GetBytes(enemy_ai1);
            ms.Write(enemy_ai1Bytes,0,enemy_ai1Bytes.Length);
byte[] enemy_ai2Bytes = BitConverter.GetBytes(enemy_ai2);
            ms.Write(enemy_ai2Bytes,0,enemy_ai2Bytes.Length);
if(soul == null)soul = new Syssoul_calculate();soul.Serializer(ms);
if(towers1==null)towers1 = new List<Systower>();
byte[] towers1CountBytes = BitConverter.GetBytes(towers1.Count);
            ms.Write(towers1CountBytes,0,towers1CountBytes.Length);
for (int i = 0; i < towers1.Count; i++){
if(towers1[i] == null)towers1[i] = new Systower();towers1[i].Serializer(ms);
}
if(towers2==null)towers2 = new List<Systower>();
byte[] towers2CountBytes = BitConverter.GetBytes(towers2.Count);
            ms.Write(towers2CountBytes,0,towers2CountBytes.Length);
for (int i = 0; i < towers2.Count; i++){
if(towers2[i] == null)towers2[i] = new Systower();towers2[i].Serializer(ms);
}
byte[] robotBytes = BitConverter.GetBytes(robot);
            ms.Write(robotBytes,0,robotBytes.Length);
byte[] wayBytes = BitConverter.GetBytes(way);
            ms.Write(wayBytes,0,wayBytes.Length);
byte[] field_of_viewBytes = BitConverter.GetBytes(field_of_view);
            ms.Write(field_of_viewBytes,0,field_of_viewBytes.Length);
byte[] offset_xBytes = BitConverter.GetBytes(offset_x);
            ms.Write(offset_xBytes,0,offset_xBytes.Length);
byte[] offset_yBytes = BitConverter.GetBytes(offset_y);
            ms.Write(offset_yBytes,0,offset_yBytes.Length);
byte[] offset_zBytes = BitConverter.GetBytes(offset_z);
            ms.Write(offset_zBytes,0,offset_zBytes.Length);
if(blood_buff_0==null)blood_buff_0 = new List<int>();
byte[] blood_buff_0CountBytes = BitConverter.GetBytes(blood_buff_0.Count);
            ms.Write(blood_buff_0CountBytes,0,blood_buff_0CountBytes.Length);
for (int i = 0; i < blood_buff_0.Count; i++){
byte[] blood_buff_0Bytes = BitConverter.GetBytes(blood_buff_0[i]);
            ms.Write(blood_buff_0Bytes,0,blood_buff_0Bytes.Length);
}
if(blood_buff_1==null)blood_buff_1 = new List<int>();
byte[] blood_buff_1CountBytes = BitConverter.GetBytes(blood_buff_1.Count);
            ms.Write(blood_buff_1CountBytes,0,blood_buff_1CountBytes.Length);
for (int i = 0; i < blood_buff_1.Count; i++){
byte[] blood_buff_1Bytes = BitConverter.GetBytes(blood_buff_1[i]);
            ms.Write(blood_buff_1Bytes,0,blood_buff_1Bytes.Length);
}
if(blood_exps==null)blood_exps = new List<int>();
byte[] blood_expsCountBytes = BitConverter.GetBytes(blood_exps.Count);
            ms.Write(blood_expsCountBytes,0,blood_expsCountBytes.Length);
for (int i = 0; i < blood_exps.Count; i++){
byte[] blood_expsBytes = BitConverter.GetBytes(blood_exps[i]);
            ms.Write(blood_expsBytes,0,blood_expsBytes.Length);
}
byte[] player_numberBytes = BitConverter.GetBytes(player_number);
            ms.Write(player_numberBytes,0,player_numberBytes.Length);
if(combat_plus==null)combat_plus = new List<int>();
byte[] combat_plusCountBytes = BitConverter.GetBytes(combat_plus.Count);
            ms.Write(combat_plusCountBytes,0,combat_plusCountBytes.Length);
for (int i = 0; i < combat_plus.Count; i++){
byte[] combat_plusBytes = BitConverter.GetBytes(combat_plus[i]);
            ms.Write(combat_plusBytes,0,combat_plusBytes.Length);
}
if(star_plus==null)star_plus = new List<int>();
byte[] star_plusCountBytes = BitConverter.GetBytes(star_plus.Count);
            ms.Write(star_plusCountBytes,0,star_plusCountBytes.Length);
for (int i = 0; i < star_plus.Count; i++){
byte[] star_plusBytes = BitConverter.GetBytes(star_plus[i]);
            ms.Write(star_plusBytes,0,star_plusBytes.Length);
}
if(neutral_ids==null)neutral_ids = new List<int>();
byte[] neutral_idsCountBytes = BitConverter.GetBytes(neutral_ids.Count);
            ms.Write(neutral_idsCountBytes,0,neutral_idsCountBytes.Length);
for (int i = 0; i < neutral_ids.Count; i++){
byte[] neutral_idsBytes = BitConverter.GetBytes(neutral_ids[i]);
            ms.Write(neutral_idsBytes,0,neutral_idsBytes.Length);
}
if(neutral_ids_right==null)neutral_ids_right = new List<int>();
byte[] neutral_ids_rightCountBytes = BitConverter.GetBytes(neutral_ids_right.Count);
            ms.Write(neutral_ids_rightCountBytes,0,neutral_ids_rightCountBytes.Length);
for (int i = 0; i < neutral_ids_right.Count; i++){
byte[] neutral_ids_rightBytes = BitConverter.GetBytes(neutral_ids_right[i]);
            ms.Write(neutral_ids_rightBytes,0,neutral_ids_rightBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
melee_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
chapter_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_nomal_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int dungeon_name_count;dungeon_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;dungeon_name = System.Text.Encoding.UTF8.GetString(bytes, offset, dungeon_name_count);offset += dungeon_name_count;
int map_count;map_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map = System.Text.Encoding.UTF8.GetString(bytes, offset, map_count);offset += map_count;
xml = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_w = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_f = BitConverter.ToInt32(bytes, offset);
            offset += 4;
strength_s = BitConverter.ToInt32(bytes, offset);
            offset += 4;
init_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
init_max = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
recover_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
clean_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
advise_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int ruleCount;
ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rule = new List<Sysstar_rule>(ruleCount);
for (int i = 0; i < ruleCount; i++){
rule.Add(new Sysstar_rule());offset = rule[i].Deserializer(bytes,offset);
}

int rule_descCount;
rule_descCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rule_desc = new List<Sysdesc_rule>(rule_descCount);
for (int i = 0; i < rule_descCount; i++){
rule_desc.Add(new Sysdesc_rule());offset = rule_desc[i].Deserializer(bytes,offset);
}
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
can_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int target_posCount;
target_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
target_pos = new List<Sysdungeon_position>(target_posCount);
for (int i = 0; i < target_posCount; i++){
target_pos.Add(new Sysdungeon_position());offset = target_pos[i].Deserializer(bytes,offset);
}

int icon_posCount;
icon_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
icon_pos = new List<int>(icon_posCount);
for (int i = 0; i < icon_posCount; i++){
icon_pos.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int win_ruleCount;
win_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
win_rule = new List<Syswin_rule>(win_ruleCount);
for (int i = 0; i < win_ruleCount; i++){
win_rule.Add(new Syswin_rule());offset = win_rule[i].Deserializer(bytes,offset);
}

int fail_ruleCount;
fail_ruleCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fail_rule = new List<Sysfail_rule>(fail_ruleCount);
for (int i = 0; i < fail_ruleCount; i++){
fail_rule.Add(new Sysfail_rule());offset = fail_rule[i].Deserializer(bytes,offset);
}
int map_load_count;map_load_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;map_load = System.Text.Encoding.UTF8.GetString(bytes, offset, map_load_count);offset += map_load_count;
hero_ai1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_ai2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
enemy_ai1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
enemy_ai2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
soul = new Syssoul_calculate();offset = soul.Deserializer(bytes,offset);

int towers1Count;
towers1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
towers1 = new List<Systower>(towers1Count);
for (int i = 0; i < towers1Count; i++){
towers1.Add(new Systower());offset = towers1[i].Deserializer(bytes,offset);
}

int towers2Count;
towers2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
towers2 = new List<Systower>(towers2Count);
for (int i = 0; i < towers2Count; i++){
towers2.Add(new Systower());offset = towers2[i].Deserializer(bytes,offset);
}
robot = BitConverter.ToInt32(bytes, offset);
            offset += 4;
way = BitConverter.ToInt32(bytes, offset);
            offset += 4;
field_of_view = BitConverter.ToInt32(bytes, offset);
            offset += 4;
offset_x = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_y = BitConverter.ToSingle(bytes, offset);
            offset += 4;
offset_z = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int blood_buff_0Count;
blood_buff_0Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
blood_buff_0 = new List<int>(blood_buff_0Count);
for (int i = 0; i < blood_buff_0Count; i++){
blood_buff_0.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int blood_buff_1Count;
blood_buff_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
blood_buff_1 = new List<int>(blood_buff_1Count);
for (int i = 0; i < blood_buff_1Count; i++){
blood_buff_1.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int blood_expsCount;
blood_expsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
blood_exps = new List<int>(blood_expsCount);
for (int i = 0; i < blood_expsCount; i++){
blood_exps.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
player_number = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int combat_plusCount;
combat_plusCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_plus = new List<int>(combat_plusCount);
for (int i = 0; i < combat_plusCount; i++){
combat_plus.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int star_plusCount;
star_plusCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_plus = new List<int>(star_plusCount);
for (int i = 0; i < star_plusCount; i++){
star_plus.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int neutral_idsCount;
neutral_idsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
neutral_ids = new List<int>(neutral_idsCount);
for (int i = 0; i < neutral_idsCount; i++){
neutral_ids.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int neutral_ids_rightCount;
neutral_ids_rightCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
neutral_ids_right = new List<int>(neutral_ids_rightCount);
for (int i = 0; i < neutral_ids_rightCount; i++){
neutral_ids_right.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysmelee_box
    {
		public string unikey;
		public int union_id; //宝箱品质
		public int box_cd; //宝箱cd
		public string box_name; //宝箱名称
		public string box_model; //宝箱模型
		public List<Sysmelee_box_reward> box_reward_new; //宝箱奖励(显示用[新])
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
byte[] box_cdBytes = BitConverter.GetBytes(box_cd);
            ms.Write(box_cdBytes,0,box_cdBytes.Length);
if(string.IsNullOrEmpty(box_name))box_name = string.Empty;
            byte[] box_nameBytes = System.Text.Encoding.UTF8.GetBytes(box_name);
            byte[] box_nameBytesLen = BitConverter.GetBytes(box_nameBytes.Length);
            ms.Write(box_nameBytesLen, 0, box_nameBytesLen.Length);
            ms.Write(box_nameBytes, 0, box_nameBytes.Length);
if(string.IsNullOrEmpty(box_model))box_model = string.Empty;
            byte[] box_modelBytes = System.Text.Encoding.UTF8.GetBytes(box_model);
            byte[] box_modelBytesLen = BitConverter.GetBytes(box_modelBytes.Length);
            ms.Write(box_modelBytesLen, 0, box_modelBytesLen.Length);
            ms.Write(box_modelBytes, 0, box_modelBytes.Length);
if(box_reward_new==null)box_reward_new = new List<Sysmelee_box_reward>();
byte[] box_reward_newCountBytes = BitConverter.GetBytes(box_reward_new.Count);
            ms.Write(box_reward_newCountBytes,0,box_reward_newCountBytes.Length);
for (int i = 0; i < box_reward_new.Count; i++){
if(box_reward_new[i] == null)box_reward_new[i] = new Sysmelee_box_reward();box_reward_new[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int box_name_count;box_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_name = System.Text.Encoding.UTF8.GetString(bytes, offset, box_name_count);offset += box_name_count;
int box_model_count;box_model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_model = System.Text.Encoding.UTF8.GetString(bytes, offset, box_model_count);offset += box_model_count;

int box_reward_newCount;
box_reward_newCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_reward_new = new List<Sysmelee_box_reward>(box_reward_newCount);
for (int i = 0; i < box_reward_newCount; i++){
box_reward_new.Add(new Sysmelee_box_reward());offset = box_reward_new[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysmelee_box_reward
    {
		public int goods_id; //物品id
		public int goods_number_lower; //物品数量下限
		public int goods_number_up; //物品数量上限
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_number_lowerBytes = BitConverter.GetBytes(goods_number_lower);
            ms.Write(goods_number_lowerBytes,0,goods_number_lowerBytes.Length);
byte[] goods_number_upBytes = BitConverter.GetBytes(goods_number_up);
            ms.Write(goods_number_upBytes,0,goods_number_upBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_number_lower = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_number_up = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmelee_goods
    {
		public int type; //宝箱类型
		public int goods_id; //物品Id
		public int rate; //物品概率
		public int num_min; //物品下限
		public int num_max; //物品上限
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] rateBytes = BitConverter.GetBytes(rate);
            ms.Write(rateBytes,0,rateBytes.Length);
byte[] num_minBytes = BitConverter.GetBytes(num_min);
            ms.Write(num_minBytes,0,num_minBytes.Length);
byte[] num_maxBytes = BitConverter.GetBytes(num_max);
            ms.Write(num_maxBytes,0,num_maxBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num_min = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num_max = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmelee_lv_add
    {
		public string unikey;
		public int id; //玩家id
		public string name; //玩家昵称
		public int lv; //玩家等级
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public float pdef_ignore; //忽略护甲%
		public float mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
		public List<int> star; //显示星级
		public List<int> quality; //显示品质
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
if(star==null)star = new List<int>();
byte[] starCountBytes = BitConverter.GetBytes(star.Count);
            ms.Write(starCountBytes,0,starCountBytes.Length);
for (int i = 0; i < star.Count; i++){
byte[] starBytes = BitConverter.GetBytes(star[i]);
            ms.Write(starBytes,0,starBytes.Length);
}
if(quality==null)quality = new List<int>();
byte[] qualityCountBytes = BitConverter.GetBytes(quality.Count);
            ms.Write(qualityCountBytes,0,qualityCountBytes.Length);
for (int i = 0; i < quality.Count; i++){
byte[] qualityBytes = BitConverter.GetBytes(quality[i]);
            ms.Write(qualityBytes,0,qualityBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int starCount;
starCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = new List<int>(starCount);
for (int i = 0; i < starCount; i++){
star.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int qualityCount;
qualityCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = new List<int>(qualityCount);
for (int i = 0; i < qualityCount; i++){
quality.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysmelee_reward
    {
		public string unikey;
		public int win_times; //胜利次数
		public List<Sysmelee_goods> single_goods_list; //单路道具奖励
		public List<Sysmelee_goods> double_goods_list; //双路道具奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] win_timesBytes = BitConverter.GetBytes(win_times);
            ms.Write(win_timesBytes,0,win_timesBytes.Length);
if(single_goods_list==null)single_goods_list = new List<Sysmelee_goods>();
byte[] single_goods_listCountBytes = BitConverter.GetBytes(single_goods_list.Count);
            ms.Write(single_goods_listCountBytes,0,single_goods_listCountBytes.Length);
for (int i = 0; i < single_goods_list.Count; i++){
if(single_goods_list[i] == null)single_goods_list[i] = new Sysmelee_goods();single_goods_list[i].Serializer(ms);
}
if(double_goods_list==null)double_goods_list = new List<Sysmelee_goods>();
byte[] double_goods_listCountBytes = BitConverter.GetBytes(double_goods_list.Count);
            ms.Write(double_goods_listCountBytes,0,double_goods_listCountBytes.Length);
for (int i = 0; i < double_goods_list.Count; i++){
if(double_goods_list[i] == null)double_goods_list[i] = new Sysmelee_goods();double_goods_list[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
win_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int single_goods_listCount;
single_goods_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
single_goods_list = new List<Sysmelee_goods>(single_goods_listCount);
for (int i = 0; i < single_goods_listCount; i++){
single_goods_list.Add(new Sysmelee_goods());offset = single_goods_list[i].Deserializer(bytes,offset);
}

int double_goods_listCount;
double_goods_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
double_goods_list = new List<Sysmelee_goods>(double_goods_listCount);
for (int i = 0; i < double_goods_listCount; i++){
double_goods_list.Add(new Sysmelee_goods());offset = double_goods_list[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysmine
    {
		public string unikey;
		public int union_id; //编号
		public int id; //道具id
		public int num; //道具数量
		public int star; //道具星级
		public int quality; //道具品质
		public string name; //道具名称
		public int position; //位置
		public int rate_0; //幸运值0时概率
		public int rate_50; //幸运值50时概率
		public int rate_60; //幸运值60时概率
		public int rate_70; //幸运值70时概率
		public int rate_80; //幸运值80时概率
		public int rate_90; //幸运值90时概率
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] positionBytes = BitConverter.GetBytes(position);
            ms.Write(positionBytes,0,positionBytes.Length);
byte[] rate_0Bytes = BitConverter.GetBytes(rate_0);
            ms.Write(rate_0Bytes,0,rate_0Bytes.Length);
byte[] rate_50Bytes = BitConverter.GetBytes(rate_50);
            ms.Write(rate_50Bytes,0,rate_50Bytes.Length);
byte[] rate_60Bytes = BitConverter.GetBytes(rate_60);
            ms.Write(rate_60Bytes,0,rate_60Bytes.Length);
byte[] rate_70Bytes = BitConverter.GetBytes(rate_70);
            ms.Write(rate_70Bytes,0,rate_70Bytes.Length);
byte[] rate_80Bytes = BitConverter.GetBytes(rate_80);
            ms.Write(rate_80Bytes,0,rate_80Bytes.Length);
byte[] rate_90Bytes = BitConverter.GetBytes(rate_90);
            ms.Write(rate_90Bytes,0,rate_90Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
position = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_0 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_50 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_60 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_70 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_80 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate_90 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmine_explore
    {
		public string unikey;
		public int id; //id
		public int one_lucky; //一次探索增加幸运值
		public int five_lucky; //五次探索增加幸运值
		public int max_lucky; //最大幸运值
		public int one_cost; //一次探索所需材料
		public int five_cost; //五次探索所需材料
		public string desc; //描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] one_luckyBytes = BitConverter.GetBytes(one_lucky);
            ms.Write(one_luckyBytes,0,one_luckyBytes.Length);
byte[] five_luckyBytes = BitConverter.GetBytes(five_lucky);
            ms.Write(five_luckyBytes,0,five_luckyBytes.Length);
byte[] max_luckyBytes = BitConverter.GetBytes(max_lucky);
            ms.Write(max_luckyBytes,0,max_luckyBytes.Length);
byte[] one_costBytes = BitConverter.GetBytes(one_cost);
            ms.Write(one_costBytes,0,one_costBytes.Length);
byte[] five_costBytes = BitConverter.GetBytes(five_cost);
            ms.Write(five_costBytes,0,five_costBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
one_lucky = BitConverter.ToInt32(bytes, offset);
            offset += 4;
five_lucky = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_lucky = BitConverter.ToInt32(bytes, offset);
            offset += 4;
one_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
five_cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Sysmonster
    {
		public string unikey;
		public int id; //怪物id
		public string name; //怪物名称
		public int monster_type; //归类
		public int dungeon_type; //归类2
		public string actorClass; //怪物类型
		public string actorType; //怪物类型
		public int career; //怪物职业
		public int blood_layers; //怪物血条管数
		public int mini_blood; //boss是否显示小血条
		public int ai; //怪物ai
		public string model; //怪物模型
		public float model_scale; //怪物模型大小
		public string born_effect; //出生效果
		public string dead_effect; //死亡效果
		public List<int> skills; //技能 
		public int lv; //等级
		public int search_range; //视野范围
		public List<string> effects; //英雄特效
		public int attr_id; //属性模板id
		public float view_angle; //视野范围
		public int collider; //怪物碰撞类型
		public int cg_group; //过场动画组
		public int born_state; //出生状态
		public float radius; //角色半径
		public int dead_sound; //死亡的音效
		public List<int> born_sound; //出生音效
		public int dld_layer; //大乱斗层
		public List<int> buffs; //被动技能(buff)
		public int search_wild; //是否检测野区
		public List<int> dead_events; //死亡触发事件
		public int team_soul_calculate; //团队血气计算类型
		public int disable_animation; //不在视野内时禁止动画
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] monster_typeBytes = BitConverter.GetBytes(monster_type);
            ms.Write(monster_typeBytes,0,monster_typeBytes.Length);
byte[] dungeon_typeBytes = BitConverter.GetBytes(dungeon_type);
            ms.Write(dungeon_typeBytes,0,dungeon_typeBytes.Length);
if(string.IsNullOrEmpty(actorClass))actorClass = string.Empty;
            byte[] actorClassBytes = System.Text.Encoding.UTF8.GetBytes(actorClass);
            byte[] actorClassBytesLen = BitConverter.GetBytes(actorClassBytes.Length);
            ms.Write(actorClassBytesLen, 0, actorClassBytesLen.Length);
            ms.Write(actorClassBytes, 0, actorClassBytes.Length);
if(string.IsNullOrEmpty(actorType))actorType = string.Empty;
            byte[] actorTypeBytes = System.Text.Encoding.UTF8.GetBytes(actorType);
            byte[] actorTypeBytesLen = BitConverter.GetBytes(actorTypeBytes.Length);
            ms.Write(actorTypeBytesLen, 0, actorTypeBytesLen.Length);
            ms.Write(actorTypeBytes, 0, actorTypeBytes.Length);
byte[] careerBytes = BitConverter.GetBytes(career);
            ms.Write(careerBytes,0,careerBytes.Length);
byte[] blood_layersBytes = BitConverter.GetBytes(blood_layers);
            ms.Write(blood_layersBytes,0,blood_layersBytes.Length);
byte[] mini_bloodBytes = BitConverter.GetBytes(mini_blood);
            ms.Write(mini_bloodBytes,0,mini_bloodBytes.Length);
byte[] aiBytes = BitConverter.GetBytes(ai);
            ms.Write(aiBytes,0,aiBytes.Length);
if(string.IsNullOrEmpty(model))model = string.Empty;
            byte[] modelBytes = System.Text.Encoding.UTF8.GetBytes(model);
            byte[] modelBytesLen = BitConverter.GetBytes(modelBytes.Length);
            ms.Write(modelBytesLen, 0, modelBytesLen.Length);
            ms.Write(modelBytes, 0, modelBytes.Length);
byte[] model_scaleBytes = BitConverter.GetBytes(model_scale);
            ms.Write(model_scaleBytes,0,model_scaleBytes.Length);
if(string.IsNullOrEmpty(born_effect))born_effect = string.Empty;
            byte[] born_effectBytes = System.Text.Encoding.UTF8.GetBytes(born_effect);
            byte[] born_effectBytesLen = BitConverter.GetBytes(born_effectBytes.Length);
            ms.Write(born_effectBytesLen, 0, born_effectBytesLen.Length);
            ms.Write(born_effectBytes, 0, born_effectBytes.Length);
if(string.IsNullOrEmpty(dead_effect))dead_effect = string.Empty;
            byte[] dead_effectBytes = System.Text.Encoding.UTF8.GetBytes(dead_effect);
            byte[] dead_effectBytesLen = BitConverter.GetBytes(dead_effectBytes.Length);
            ms.Write(dead_effectBytesLen, 0, dead_effectBytesLen.Length);
            ms.Write(dead_effectBytes, 0, dead_effectBytes.Length);
if(skills==null)skills = new List<int>();
byte[] skillsCountBytes = BitConverter.GetBytes(skills.Count);
            ms.Write(skillsCountBytes,0,skillsCountBytes.Length);
for (int i = 0; i < skills.Count; i++){
byte[] skillsBytes = BitConverter.GetBytes(skills[i]);
            ms.Write(skillsBytes,0,skillsBytes.Length);
}
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] search_rangeBytes = BitConverter.GetBytes(search_range);
            ms.Write(search_rangeBytes,0,search_rangeBytes.Length);
if(effects==null)effects = new List<string>();
byte[] effectsCountBytes = BitConverter.GetBytes(effects.Count);
            ms.Write(effectsCountBytes,0,effectsCountBytes.Length);
for (int i = 0; i < effects.Count; i++){
if(string.IsNullOrEmpty(effects[i]))effects[i] = string.Empty;
            byte[] effectsBytes = System.Text.Encoding.UTF8.GetBytes(effects[i]);
            byte[] effectsBytesLen = BitConverter.GetBytes(effectsBytes.Length);
            ms.Write(effectsBytesLen, 0, effectsBytesLen.Length);
            ms.Write(effectsBytes, 0, effectsBytes.Length);
}
byte[] attr_idBytes = BitConverter.GetBytes(attr_id);
            ms.Write(attr_idBytes,0,attr_idBytes.Length);
byte[] view_angleBytes = BitConverter.GetBytes(view_angle);
            ms.Write(view_angleBytes,0,view_angleBytes.Length);
byte[] colliderBytes = BitConverter.GetBytes(collider);
            ms.Write(colliderBytes,0,colliderBytes.Length);
byte[] cg_groupBytes = BitConverter.GetBytes(cg_group);
            ms.Write(cg_groupBytes,0,cg_groupBytes.Length);
byte[] born_stateBytes = BitConverter.GetBytes(born_state);
            ms.Write(born_stateBytes,0,born_stateBytes.Length);
byte[] radiusBytes = BitConverter.GetBytes(radius);
            ms.Write(radiusBytes,0,radiusBytes.Length);
byte[] dead_soundBytes = BitConverter.GetBytes(dead_sound);
            ms.Write(dead_soundBytes,0,dead_soundBytes.Length);
if(born_sound==null)born_sound = new List<int>();
byte[] born_soundCountBytes = BitConverter.GetBytes(born_sound.Count);
            ms.Write(born_soundCountBytes,0,born_soundCountBytes.Length);
for (int i = 0; i < born_sound.Count; i++){
byte[] born_soundBytes = BitConverter.GetBytes(born_sound[i]);
            ms.Write(born_soundBytes,0,born_soundBytes.Length);
}
byte[] dld_layerBytes = BitConverter.GetBytes(dld_layer);
            ms.Write(dld_layerBytes,0,dld_layerBytes.Length);
if(buffs==null)buffs = new List<int>();
byte[] buffsCountBytes = BitConverter.GetBytes(buffs.Count);
            ms.Write(buffsCountBytes,0,buffsCountBytes.Length);
for (int i = 0; i < buffs.Count; i++){
byte[] buffsBytes = BitConverter.GetBytes(buffs[i]);
            ms.Write(buffsBytes,0,buffsBytes.Length);
}
byte[] search_wildBytes = BitConverter.GetBytes(search_wild);
            ms.Write(search_wildBytes,0,search_wildBytes.Length);
if(dead_events==null)dead_events = new List<int>();
byte[] dead_eventsCountBytes = BitConverter.GetBytes(dead_events.Count);
            ms.Write(dead_eventsCountBytes,0,dead_eventsCountBytes.Length);
for (int i = 0; i < dead_events.Count; i++){
byte[] dead_eventsBytes = BitConverter.GetBytes(dead_events[i]);
            ms.Write(dead_eventsBytes,0,dead_eventsBytes.Length);
}
byte[] team_soul_calculateBytes = BitConverter.GetBytes(team_soul_calculate);
            ms.Write(team_soul_calculateBytes,0,team_soul_calculateBytes.Length);
byte[] disable_animationBytes = BitConverter.GetBytes(disable_animation);
            ms.Write(disable_animationBytes,0,disable_animationBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
monster_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int actorClass_count;actorClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;actorClass = System.Text.Encoding.UTF8.GetString(bytes, offset, actorClass_count);offset += actorClass_count;
int actorType_count;actorType_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;actorType = System.Text.Encoding.UTF8.GetString(bytes, offset, actorType_count);offset += actorType_count;
career = BitConverter.ToInt32(bytes, offset);
            offset += 4;
blood_layers = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mini_blood = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ai = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int model_count;model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;model = System.Text.Encoding.UTF8.GetString(bytes, offset, model_count);offset += model_count;
model_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int born_effect_count;born_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;born_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, born_effect_count);offset += born_effect_count;
int dead_effect_count;dead_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;dead_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, dead_effect_count);offset += dead_effect_count;

int skillsCount;
skillsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skills = new List<int>(skillsCount);
for (int i = 0; i < skillsCount; i++){
skills.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
search_range = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int effectsCount;
effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effects = new List<string>(effectsCount);
for (int i = 0; i < effectsCount; i++){
int effects_count;effects_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effects.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, effects_count));offset += effects_count;
}
attr_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
view_angle = BitConverter.ToSingle(bytes, offset);
            offset += 4;
collider = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cg_group = BitConverter.ToInt32(bytes, offset);
            offset += 4;
born_state = BitConverter.ToInt32(bytes, offset);
            offset += 4;
radius = BitConverter.ToSingle(bytes, offset);
            offset += 4;
dead_sound = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int born_soundCount;
born_soundCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
born_sound = new List<int>(born_soundCount);
for (int i = 0; i < born_soundCount; i++){
born_sound.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
dld_layer = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int buffsCount;
buffsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffs = new List<int>(buffsCount);
for (int i = 0; i < buffsCount; i++){
buffs.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
search_wild = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dead_eventsCount;
dead_eventsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dead_events = new List<int>(dead_eventsCount);
for (int i = 0; i < dead_eventsCount; i++){
dead_events.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
team_soul_calculate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
disable_animation = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmons_dialog
    {
		public List<int> trigger; //触发条件
		public List<int> dialog; //对话id
    public void Serializer(MemoryStream ms){

if(trigger==null)trigger = new List<int>();
byte[] triggerCountBytes = BitConverter.GetBytes(trigger.Count);
            ms.Write(triggerCountBytes,0,triggerCountBytes.Length);
for (int i = 0; i < trigger.Count; i++){
byte[] triggerBytes = BitConverter.GetBytes(trigger[i]);
            ms.Write(triggerBytes,0,triggerBytes.Length);
}
if(dialog==null)dialog = new List<int>();
byte[] dialogCountBytes = BitConverter.GetBytes(dialog.Count);
            ms.Write(dialogCountBytes,0,dialogCountBytes.Length);
for (int i = 0; i < dialog.Count; i++){
byte[] dialogBytes = BitConverter.GetBytes(dialog[i]);
            ms.Write(dialogBytes,0,dialogBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){


int triggerCount;
triggerCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
trigger = new List<int>(triggerCount);
for (int i = 0; i < triggerCount; i++){
trigger.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int dialogCount;
dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dialog = new List<int>(dialogCount);
for (int i = 0; i < dialogCount; i++){
dialog.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysmon_attribute
    {
		public string unikey;
		public int id; // 怪物id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
		public float hurt_limit; //对敌人的最高伤害限制
		public float min_hurt_coefficient; //不破防系数
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
byte[] hurt_limitBytes = BitConverter.GetBytes(hurt_limit);
            ms.Write(hurt_limitBytes,0,hurt_limitBytes.Length);
byte[] min_hurt_coefficientBytes = BitConverter.GetBytes(min_hurt_coefficient);
            ms.Write(min_hurt_coefficientBytes,0,min_hurt_coefficientBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
hurt_limit = BitConverter.ToSingle(bytes, offset);
            offset += 4;
min_hurt_coefficient = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysmove_path
    {
		public string unikey;
		public int id; //id
		public List<Syspoint> points; //名称
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(points==null)points = new List<Syspoint>();
byte[] pointsCountBytes = BitConverter.GetBytes(points.Count);
            ms.Write(pointsCountBytes,0,pointsCountBytes.Length);
for (int i = 0; i < points.Count; i++){
if(points[i] == null)points[i] = new Syspoint();points[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int pointsCount;
pointsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
points = new List<Syspoint>(pointsCount);
for (int i = 0; i < pointsCount; i++){
points.Add(new Syspoint());offset = points[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysnpc
    {
		public string unikey;
		public int npcid; //id
		public string name; //npc名称
		public int title; //npc称号
		public int monster_id; //对应怪物id
		public List<int> pos; //位置
		public int show; //显示方式
		public string action; //动作
		public string bust; //半身像
		public List<float> bust_pos; //半身像位置
		public float bust_scale; //半身像缩放
		public List<float> card_pos; //卡片位置
		public float card_scale; //卡片缩放
		public List<float> arena_bust_pos; //竞技场半身像位置
		public float arena_bust_scale; //竞技场半身像缩放
		public int dialog_sound; //音效
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] npcidBytes = BitConverter.GetBytes(npcid);
            ms.Write(npcidBytes,0,npcidBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] titleBytes = BitConverter.GetBytes(title);
            ms.Write(titleBytes,0,titleBytes.Length);
byte[] monster_idBytes = BitConverter.GetBytes(monster_id);
            ms.Write(monster_idBytes,0,monster_idBytes.Length);
if(pos==null)pos = new List<int>();
byte[] posCountBytes = BitConverter.GetBytes(pos.Count);
            ms.Write(posCountBytes,0,posCountBytes.Length);
for (int i = 0; i < pos.Count; i++){
byte[] posBytes = BitConverter.GetBytes(pos[i]);
            ms.Write(posBytes,0,posBytes.Length);
}
byte[] showBytes = BitConverter.GetBytes(show);
            ms.Write(showBytes,0,showBytes.Length);
if(string.IsNullOrEmpty(action))action = string.Empty;
            byte[] actionBytes = System.Text.Encoding.UTF8.GetBytes(action);
            byte[] actionBytesLen = BitConverter.GetBytes(actionBytes.Length);
            ms.Write(actionBytesLen, 0, actionBytesLen.Length);
            ms.Write(actionBytes, 0, actionBytes.Length);
if(string.IsNullOrEmpty(bust))bust = string.Empty;
            byte[] bustBytes = System.Text.Encoding.UTF8.GetBytes(bust);
            byte[] bustBytesLen = BitConverter.GetBytes(bustBytes.Length);
            ms.Write(bustBytesLen, 0, bustBytesLen.Length);
            ms.Write(bustBytes, 0, bustBytes.Length);
if(bust_pos==null)bust_pos = new List<float>();
byte[] bust_posCountBytes = BitConverter.GetBytes(bust_pos.Count);
            ms.Write(bust_posCountBytes,0,bust_posCountBytes.Length);
for (int i = 0; i < bust_pos.Count; i++){
byte[] bust_posBytes = BitConverter.GetBytes(bust_pos[i]);
            ms.Write(bust_posBytes,0,bust_posBytes.Length);
}
byte[] bust_scaleBytes = BitConverter.GetBytes(bust_scale);
            ms.Write(bust_scaleBytes,0,bust_scaleBytes.Length);
if(card_pos==null)card_pos = new List<float>();
byte[] card_posCountBytes = BitConverter.GetBytes(card_pos.Count);
            ms.Write(card_posCountBytes,0,card_posCountBytes.Length);
for (int i = 0; i < card_pos.Count; i++){
byte[] card_posBytes = BitConverter.GetBytes(card_pos[i]);
            ms.Write(card_posBytes,0,card_posBytes.Length);
}
byte[] card_scaleBytes = BitConverter.GetBytes(card_scale);
            ms.Write(card_scaleBytes,0,card_scaleBytes.Length);
if(arena_bust_pos==null)arena_bust_pos = new List<float>();
byte[] arena_bust_posCountBytes = BitConverter.GetBytes(arena_bust_pos.Count);
            ms.Write(arena_bust_posCountBytes,0,arena_bust_posCountBytes.Length);
for (int i = 0; i < arena_bust_pos.Count; i++){
byte[] arena_bust_posBytes = BitConverter.GetBytes(arena_bust_pos[i]);
            ms.Write(arena_bust_posBytes,0,arena_bust_posBytes.Length);
}
byte[] arena_bust_scaleBytes = BitConverter.GetBytes(arena_bust_scale);
            ms.Write(arena_bust_scaleBytes,0,arena_bust_scaleBytes.Length);
byte[] dialog_soundBytes = BitConverter.GetBytes(dialog_sound);
            ms.Write(dialog_soundBytes,0,dialog_soundBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
npcid = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
title = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int posCount;
posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pos = new List<int>(posCount);
for (int i = 0; i < posCount; i++){
pos.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
show = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int action_count;action_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;action = System.Text.Encoding.UTF8.GetString(bytes, offset, action_count);offset += action_count;
int bust_count;bust_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bust = System.Text.Encoding.UTF8.GetString(bytes, offset, bust_count);offset += bust_count;

int bust_posCount;
bust_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bust_pos = new List<float>(bust_posCount);
for (int i = 0; i < bust_posCount; i++){
bust_pos.Add( BitConverter.ToSingle(bytes, offset));
            offset += 4;
}
bust_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int card_posCount;
card_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
card_pos = new List<float>(card_posCount);
for (int i = 0; i < card_posCount; i++){
card_pos.Add( BitConverter.ToSingle(bytes, offset));
            offset += 4;
}
card_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int arena_bust_posCount;
arena_bust_posCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_bust_pos = new List<float>(arena_bust_posCount);
for (int i = 0; i < arena_bust_posCount; i++){
arena_bust_pos.Add( BitConverter.ToSingle(bytes, offset));
            offset += 4;
}
arena_bust_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;
dialog_sound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysopen_award
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysopen_condition
    {
		public int id; //条件类型
		public int value; //达成条件
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspeerage
    {
		public string unikey;
		public int id; //编号
		public string name; //爵位
		public int num_max; //爵位人数
		public List<Syspeerage_goods> time_reward; //爵位时薪
		public List<Syspeerage_goods> daily_reward; //爵位结算奖励
		public int robot_num; //机器人配表人数
		public List<Syspeerage_goods> reward_limit; //爵位薪资上限
		public List<int> bufflist; //爵位buff
		public int privilege; //特权与否
		public string p_desc; //特权内容
		public string icon; //界面icon
		public List<int> icon_pixel; //icon大小位置
		public int add_attr; //战斗力加成属性
		public float add_attr_value; //加成属性值
		public int num_show; //人数显示与否
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] num_maxBytes = BitConverter.GetBytes(num_max);
            ms.Write(num_maxBytes,0,num_maxBytes.Length);
if(time_reward==null)time_reward = new List<Syspeerage_goods>();
byte[] time_rewardCountBytes = BitConverter.GetBytes(time_reward.Count);
            ms.Write(time_rewardCountBytes,0,time_rewardCountBytes.Length);
for (int i = 0; i < time_reward.Count; i++){
if(time_reward[i] == null)time_reward[i] = new Syspeerage_goods();time_reward[i].Serializer(ms);
}
if(daily_reward==null)daily_reward = new List<Syspeerage_goods>();
byte[] daily_rewardCountBytes = BitConverter.GetBytes(daily_reward.Count);
            ms.Write(daily_rewardCountBytes,0,daily_rewardCountBytes.Length);
for (int i = 0; i < daily_reward.Count; i++){
if(daily_reward[i] == null)daily_reward[i] = new Syspeerage_goods();daily_reward[i].Serializer(ms);
}
byte[] robot_numBytes = BitConverter.GetBytes(robot_num);
            ms.Write(robot_numBytes,0,robot_numBytes.Length);
if(reward_limit==null)reward_limit = new List<Syspeerage_goods>();
byte[] reward_limitCountBytes = BitConverter.GetBytes(reward_limit.Count);
            ms.Write(reward_limitCountBytes,0,reward_limitCountBytes.Length);
for (int i = 0; i < reward_limit.Count; i++){
if(reward_limit[i] == null)reward_limit[i] = new Syspeerage_goods();reward_limit[i].Serializer(ms);
}
if(bufflist==null)bufflist = new List<int>();
byte[] bufflistCountBytes = BitConverter.GetBytes(bufflist.Count);
            ms.Write(bufflistCountBytes,0,bufflistCountBytes.Length);
for (int i = 0; i < bufflist.Count; i++){
byte[] bufflistBytes = BitConverter.GetBytes(bufflist[i]);
            ms.Write(bufflistBytes,0,bufflistBytes.Length);
}
byte[] privilegeBytes = BitConverter.GetBytes(privilege);
            ms.Write(privilegeBytes,0,privilegeBytes.Length);
if(string.IsNullOrEmpty(p_desc))p_desc = string.Empty;
            byte[] p_descBytes = System.Text.Encoding.UTF8.GetBytes(p_desc);
            byte[] p_descBytesLen = BitConverter.GetBytes(p_descBytes.Length);
            ms.Write(p_descBytesLen, 0, p_descBytesLen.Length);
            ms.Write(p_descBytes, 0, p_descBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(icon_pixel==null)icon_pixel = new List<int>();
byte[] icon_pixelCountBytes = BitConverter.GetBytes(icon_pixel.Count);
            ms.Write(icon_pixelCountBytes,0,icon_pixelCountBytes.Length);
for (int i = 0; i < icon_pixel.Count; i++){
byte[] icon_pixelBytes = BitConverter.GetBytes(icon_pixel[i]);
            ms.Write(icon_pixelBytes,0,icon_pixelBytes.Length);
}
byte[] add_attrBytes = BitConverter.GetBytes(add_attr);
            ms.Write(add_attrBytes,0,add_attrBytes.Length);
byte[] add_attr_valueBytes = BitConverter.GetBytes(add_attr_value);
            ms.Write(add_attr_valueBytes,0,add_attr_valueBytes.Length);
byte[] num_showBytes = BitConverter.GetBytes(num_show);
            ms.Write(num_showBytes,0,num_showBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
num_max = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int time_rewardCount;
time_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
time_reward = new List<Syspeerage_goods>(time_rewardCount);
for (int i = 0; i < time_rewardCount; i++){
time_reward.Add(new Syspeerage_goods());offset = time_reward[i].Deserializer(bytes,offset);
}

int daily_rewardCount;
daily_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
daily_reward = new List<Syspeerage_goods>(daily_rewardCount);
for (int i = 0; i < daily_rewardCount; i++){
daily_reward.Add(new Syspeerage_goods());offset = daily_reward[i].Deserializer(bytes,offset);
}
robot_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int reward_limitCount;
reward_limitCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward_limit = new List<Syspeerage_goods>(reward_limitCount);
for (int i = 0; i < reward_limitCount; i++){
reward_limit.Add(new Syspeerage_goods());offset = reward_limit[i].Deserializer(bytes,offset);
}

int bufflistCount;
bufflistCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bufflist = new List<int>(bufflistCount);
for (int i = 0; i < bufflistCount; i++){
bufflist.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
privilege = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int p_desc_count;p_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;p_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, p_desc_count);offset += p_desc_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;

int icon_pixelCount;
icon_pixelCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
icon_pixel = new List<int>(icon_pixelCount);
for (int i = 0; i < icon_pixelCount; i++){
icon_pixel.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
add_attr = BitConverter.ToInt32(bytes, offset);
            offset += 4;
add_attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
num_show = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspeerage_add
    {
		public string unikey;
		public int id; //层级
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspeerage_double
    {
		public string unikey;
		public int union_id; //唯一id
		public int day; //双倍天数
		public int cost; //消耗
		public string title; //标题
		public string icon; //图标
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
byte[] dayBytes = BitConverter.GetBytes(day);
            ms.Write(dayBytes,0,dayBytes.Length);
byte[] costBytes = BitConverter.GetBytes(cost);
            ms.Write(costBytes,0,costBytes.Length);
if(string.IsNullOrEmpty(title))title = string.Empty;
            byte[] titleBytes = System.Text.Encoding.UTF8.GetBytes(title);
            byte[] titleBytesLen = BitConverter.GetBytes(titleBytes.Length);
            ms.Write(titleBytesLen, 0, titleBytesLen.Length);
            ms.Write(titleBytes, 0, titleBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
day = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cost = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int title_count;title_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;title = System.Text.Encoding.UTF8.GetString(bytes, offset, title_count);offset += title_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
return offset;
        }
} 
 [Serializable]public class Syspeerage_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysplayer_head
    {
		public string unikey;
		public int id; //id
		public string icon; //头像图标
		public string icon_r; //头像图标(圆形)
		public int hero_id; //英雄ID
		public int star_limit; //星级限制
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(icon_r))icon_r = string.Empty;
            byte[] icon_rBytes = System.Text.Encoding.UTF8.GetBytes(icon_r);
            byte[] icon_rBytesLen = BitConverter.GetBytes(icon_rBytes.Length);
            ms.Write(icon_rBytesLen, 0, icon_rBytesLen.Length);
            ms.Write(icon_rBytes, 0, icon_rBytes.Length);
byte[] hero_idBytes = BitConverter.GetBytes(hero_id);
            ms.Write(hero_idBytes,0,hero_idBytes.Length);
byte[] star_limitBytes = BitConverter.GetBytes(star_limit);
            ms.Write(star_limitBytes,0,star_limitBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int icon_r_count;icon_r_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon_r = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_r_count);offset += icon_r_count;
hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspoint
    {
		public int id; //id
		public int x; //x坐标
		public int y; //y坐标
		public int z; //z坐标
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] xBytes = BitConverter.GetBytes(x);
            ms.Write(xBytes,0,xBytes.Length);
byte[] yBytes = BitConverter.GetBytes(y);
            ms.Write(yBytes,0,yBytes.Length);
byte[] zBytes = BitConverter.GetBytes(z);
            ms.Write(zBytes,0,zBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
x = BitConverter.ToInt32(bytes, offset);
            offset += 4;
y = BitConverter.ToInt32(bytes, offset);
            offset += 4;
z = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspower_param
    {
		public string unikey;
		public int id; //属性模板id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysproto_data
    {
		public string unikey;
		public int id; //cmd协议ID
		public string s2c; //s结构
		public string c2s; //c结构
		public string memo; //描述
		public string constStr; //常量
		public string arg; //参数描述
		public int back; //是否回包给前端
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(s2c))s2c = string.Empty;
            byte[] s2cBytes = System.Text.Encoding.UTF8.GetBytes(s2c);
            byte[] s2cBytesLen = BitConverter.GetBytes(s2cBytes.Length);
            ms.Write(s2cBytesLen, 0, s2cBytesLen.Length);
            ms.Write(s2cBytes, 0, s2cBytes.Length);
if(string.IsNullOrEmpty(c2s))c2s = string.Empty;
            byte[] c2sBytes = System.Text.Encoding.UTF8.GetBytes(c2s);
            byte[] c2sBytesLen = BitConverter.GetBytes(c2sBytes.Length);
            ms.Write(c2sBytesLen, 0, c2sBytesLen.Length);
            ms.Write(c2sBytes, 0, c2sBytes.Length);
if(string.IsNullOrEmpty(memo))memo = string.Empty;
            byte[] memoBytes = System.Text.Encoding.UTF8.GetBytes(memo);
            byte[] memoBytesLen = BitConverter.GetBytes(memoBytes.Length);
            ms.Write(memoBytesLen, 0, memoBytesLen.Length);
            ms.Write(memoBytes, 0, memoBytes.Length);
if(string.IsNullOrEmpty(constStr))constStr = string.Empty;
            byte[] constStrBytes = System.Text.Encoding.UTF8.GetBytes(constStr);
            byte[] constStrBytesLen = BitConverter.GetBytes(constStrBytes.Length);
            ms.Write(constStrBytesLen, 0, constStrBytesLen.Length);
            ms.Write(constStrBytes, 0, constStrBytes.Length);
if(string.IsNullOrEmpty(arg))arg = string.Empty;
            byte[] argBytes = System.Text.Encoding.UTF8.GetBytes(arg);
            byte[] argBytesLen = BitConverter.GetBytes(argBytes.Length);
            ms.Write(argBytesLen, 0, argBytesLen.Length);
            ms.Write(argBytes, 0, argBytes.Length);
byte[] backBytes = BitConverter.GetBytes(back);
            ms.Write(backBytes,0,backBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int s2c_count;s2c_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;s2c = System.Text.Encoding.UTF8.GetString(bytes, offset, s2c_count);offset += s2c_count;
int c2s_count;c2s_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;c2s = System.Text.Encoding.UTF8.GetString(bytes, offset, c2s_count);offset += c2s_count;
int memo_count;memo_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;memo = System.Text.Encoding.UTF8.GetString(bytes, offset, memo_count);offset += memo_count;
int constStr_count;constStr_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;constStr = System.Text.Encoding.UTF8.GetString(bytes, offset, constStr_count);offset += constStr_count;
int arg_count;arg_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;arg = System.Text.Encoding.UTF8.GetString(bytes, offset, arg_count);offset += arg_count;
back = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspvp
    {
		public string unikey;
		public int id; //实时对战
		public int level; //开启等级
		public int match_time; //匹配时间
		public int cancel_match; //取消匹配
		public int select_hero_time; //选英雄时间
		public int offline_to_ai; //英雄掉线转AI
		public List<int> surrender_cd; //投降CD
		public int win_score; //战斗胜利积分
		public int fail_score; //战斗失败积分
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
byte[] match_timeBytes = BitConverter.GetBytes(match_time);
            ms.Write(match_timeBytes,0,match_timeBytes.Length);
byte[] cancel_matchBytes = BitConverter.GetBytes(cancel_match);
            ms.Write(cancel_matchBytes,0,cancel_matchBytes.Length);
byte[] select_hero_timeBytes = BitConverter.GetBytes(select_hero_time);
            ms.Write(select_hero_timeBytes,0,select_hero_timeBytes.Length);
byte[] offline_to_aiBytes = BitConverter.GetBytes(offline_to_ai);
            ms.Write(offline_to_aiBytes,0,offline_to_aiBytes.Length);
if(surrender_cd==null)surrender_cd = new List<int>();
byte[] surrender_cdCountBytes = BitConverter.GetBytes(surrender_cd.Count);
            ms.Write(surrender_cdCountBytes,0,surrender_cdCountBytes.Length);
for (int i = 0; i < surrender_cd.Count; i++){
byte[] surrender_cdBytes = BitConverter.GetBytes(surrender_cd[i]);
            ms.Write(surrender_cdBytes,0,surrender_cdBytes.Length);
}
byte[] win_scoreBytes = BitConverter.GetBytes(win_score);
            ms.Write(win_scoreBytes,0,win_scoreBytes.Length);
byte[] fail_scoreBytes = BitConverter.GetBytes(fail_score);
            ms.Write(fail_scoreBytes,0,fail_scoreBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
match_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cancel_match = BitConverter.ToInt32(bytes, offset);
            offset += 4;
select_hero_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
offline_to_ai = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int surrender_cdCount;
surrender_cdCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
surrender_cd = new List<int>(surrender_cdCount);
for (int i = 0; i < surrender_cdCount; i++){
surrender_cd.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
win_score = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fail_score = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspvp_box
    {
		public string unikey;
		public int union_id; //宝箱品质
		public int box_cd; //宝箱cd
		public string box_name; //宝箱名称
		public string box_model; //宝箱模型
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
byte[] box_cdBytes = BitConverter.GetBytes(box_cd);
            ms.Write(box_cdBytes,0,box_cdBytes.Length);
if(string.IsNullOrEmpty(box_name))box_name = string.Empty;
            byte[] box_nameBytes = System.Text.Encoding.UTF8.GetBytes(box_name);
            byte[] box_nameBytesLen = BitConverter.GetBytes(box_nameBytes.Length);
            ms.Write(box_nameBytesLen, 0, box_nameBytesLen.Length);
            ms.Write(box_nameBytes, 0, box_nameBytes.Length);
if(string.IsNullOrEmpty(box_model))box_model = string.Empty;
            byte[] box_modelBytes = System.Text.Encoding.UTF8.GetBytes(box_model);
            byte[] box_modelBytesLen = BitConverter.GetBytes(box_modelBytes.Length);
            ms.Write(box_modelBytesLen, 0, box_modelBytesLen.Length);
            ms.Write(box_modelBytes, 0, box_modelBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int box_name_count;box_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_name = System.Text.Encoding.UTF8.GetString(bytes, offset, box_name_count);offset += box_name_count;
int box_model_count;box_model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_model = System.Text.Encoding.UTF8.GetString(bytes, offset, box_model_count);offset += box_model_count;
return offset;
        }
} 
 [Serializable]public class Syspvp_box_reward
    {
		public int goods_id; //物品id
		public int goods_number_lower; //物品数量下限
		public int goods_number_up; //物品数量上限
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_number_lowerBytes = BitConverter.GetBytes(goods_number_lower);
            ms.Write(goods_number_lowerBytes,0,goods_number_lowerBytes.Length);
byte[] goods_number_upBytes = BitConverter.GetBytes(goods_number_up);
            ms.Write(goods_number_upBytes,0,goods_number_upBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_number_lower = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_number_up = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspvp_box_reward_show
    {
		public string unikey;
		public int union_id; //宝箱品质
		public int phase_id; //段位id
		public int box_cd; //宝箱cd
		public string box_name; //宝箱名称
		public string box_model; //宝箱模型
		public List<int> box_reward; //宝箱奖励(显示用)
		public List<Syspvp_box_reward> box_reward_new; //宝箱奖励(显示用[新])
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
byte[] phase_idBytes = BitConverter.GetBytes(phase_id);
            ms.Write(phase_idBytes,0,phase_idBytes.Length);
byte[] box_cdBytes = BitConverter.GetBytes(box_cd);
            ms.Write(box_cdBytes,0,box_cdBytes.Length);
if(string.IsNullOrEmpty(box_name))box_name = string.Empty;
            byte[] box_nameBytes = System.Text.Encoding.UTF8.GetBytes(box_name);
            byte[] box_nameBytesLen = BitConverter.GetBytes(box_nameBytes.Length);
            ms.Write(box_nameBytesLen, 0, box_nameBytesLen.Length);
            ms.Write(box_nameBytes, 0, box_nameBytes.Length);
if(string.IsNullOrEmpty(box_model))box_model = string.Empty;
            byte[] box_modelBytes = System.Text.Encoding.UTF8.GetBytes(box_model);
            byte[] box_modelBytesLen = BitConverter.GetBytes(box_modelBytes.Length);
            ms.Write(box_modelBytesLen, 0, box_modelBytesLen.Length);
            ms.Write(box_modelBytes, 0, box_modelBytes.Length);
if(box_reward==null)box_reward = new List<int>();
byte[] box_rewardCountBytes = BitConverter.GetBytes(box_reward.Count);
            ms.Write(box_rewardCountBytes,0,box_rewardCountBytes.Length);
for (int i = 0; i < box_reward.Count; i++){
byte[] box_rewardBytes = BitConverter.GetBytes(box_reward[i]);
            ms.Write(box_rewardBytes,0,box_rewardBytes.Length);
}
if(box_reward_new==null)box_reward_new = new List<Syspvp_box_reward>();
byte[] box_reward_newCountBytes = BitConverter.GetBytes(box_reward_new.Count);
            ms.Write(box_reward_newCountBytes,0,box_reward_newCountBytes.Length);
for (int i = 0; i < box_reward_new.Count; i++){
if(box_reward_new[i] == null)box_reward_new[i] = new Syspvp_box_reward();box_reward_new[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int box_name_count;box_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_name = System.Text.Encoding.UTF8.GetString(bytes, offset, box_name_count);offset += box_name_count;
int box_model_count;box_model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_model = System.Text.Encoding.UTF8.GetString(bytes, offset, box_model_count);offset += box_model_count;

int box_rewardCount;
box_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_reward = new List<int>(box_rewardCount);
for (int i = 0; i < box_rewardCount; i++){
box_reward.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int box_reward_newCount;
box_reward_newCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
box_reward_new = new List<Syspvp_box_reward>(box_reward_newCount);
for (int i = 0; i < box_reward_newCount; i++){
box_reward_new.Add(new Syspvp_box_reward());offset = box_reward_new[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syspvp_chat
    {
		public string unikey;
		public int id; //id
		public string chat_content; //默认聊天内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(chat_content))chat_content = string.Empty;
            byte[] chat_contentBytes = System.Text.Encoding.UTF8.GetBytes(chat_content);
            byte[] chat_contentBytesLen = BitConverter.GetBytes(chat_contentBytes.Length);
            ms.Write(chat_contentBytesLen, 0, chat_contentBytesLen.Length);
            ms.Write(chat_contentBytes, 0, chat_contentBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int chat_content_count;chat_content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;chat_content = System.Text.Encoding.UTF8.GetString(bytes, offset, chat_content_count);offset += chat_content_count;
return offset;
        }
} 
 [Serializable]public class Syspvp_goods
    {
		public int quality; //品质
		public int goods_id; //物品Id
		public int goods_num_min; //物品下限
		public int goods_num_max; //物品上限
    public void Serializer(MemoryStream ms){

byte[] qualityBytes = BitConverter.GetBytes(quality);
            ms.Write(qualityBytes,0,qualityBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_num_minBytes = BitConverter.GetBytes(goods_num_min);
            ms.Write(goods_num_minBytes,0,goods_num_minBytes.Length);
byte[] goods_num_maxBytes = BitConverter.GetBytes(goods_num_max);
            ms.Write(goods_num_maxBytes,0,goods_num_maxBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

quality = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num_min = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num_max = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syspvp_phase
    {
		public string unikey;
		public int id; //段位id
		public string name; //段位名称
		public List<int> phase_score; //段位积分
		public List<Systask_goods> pvp_phase_goods; //道具奖励
		public string phase_icon; //段位图标(大)
		public string phase_icon_mini; //段位图标(小)
		public string box_icon; //宝箱图标
		public int need_score; //段位升级所需积分
		public string phase_effect; //特效
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(phase_score==null)phase_score = new List<int>();
byte[] phase_scoreCountBytes = BitConverter.GetBytes(phase_score.Count);
            ms.Write(phase_scoreCountBytes,0,phase_scoreCountBytes.Length);
for (int i = 0; i < phase_score.Count; i++){
byte[] phase_scoreBytes = BitConverter.GetBytes(phase_score[i]);
            ms.Write(phase_scoreBytes,0,phase_scoreBytes.Length);
}
if(pvp_phase_goods==null)pvp_phase_goods = new List<Systask_goods>();
byte[] pvp_phase_goodsCountBytes = BitConverter.GetBytes(pvp_phase_goods.Count);
            ms.Write(pvp_phase_goodsCountBytes,0,pvp_phase_goodsCountBytes.Length);
for (int i = 0; i < pvp_phase_goods.Count; i++){
if(pvp_phase_goods[i] == null)pvp_phase_goods[i] = new Systask_goods();pvp_phase_goods[i].Serializer(ms);
}
if(string.IsNullOrEmpty(phase_icon))phase_icon = string.Empty;
            byte[] phase_iconBytes = System.Text.Encoding.UTF8.GetBytes(phase_icon);
            byte[] phase_iconBytesLen = BitConverter.GetBytes(phase_iconBytes.Length);
            ms.Write(phase_iconBytesLen, 0, phase_iconBytesLen.Length);
            ms.Write(phase_iconBytes, 0, phase_iconBytes.Length);
if(string.IsNullOrEmpty(phase_icon_mini))phase_icon_mini = string.Empty;
            byte[] phase_icon_miniBytes = System.Text.Encoding.UTF8.GetBytes(phase_icon_mini);
            byte[] phase_icon_miniBytesLen = BitConverter.GetBytes(phase_icon_miniBytes.Length);
            ms.Write(phase_icon_miniBytesLen, 0, phase_icon_miniBytesLen.Length);
            ms.Write(phase_icon_miniBytes, 0, phase_icon_miniBytes.Length);
if(string.IsNullOrEmpty(box_icon))box_icon = string.Empty;
            byte[] box_iconBytes = System.Text.Encoding.UTF8.GetBytes(box_icon);
            byte[] box_iconBytesLen = BitConverter.GetBytes(box_iconBytes.Length);
            ms.Write(box_iconBytesLen, 0, box_iconBytesLen.Length);
            ms.Write(box_iconBytes, 0, box_iconBytes.Length);
byte[] need_scoreBytes = BitConverter.GetBytes(need_score);
            ms.Write(need_scoreBytes,0,need_scoreBytes.Length);
if(string.IsNullOrEmpty(phase_effect))phase_effect = string.Empty;
            byte[] phase_effectBytes = System.Text.Encoding.UTF8.GetBytes(phase_effect);
            byte[] phase_effectBytesLen = BitConverter.GetBytes(phase_effectBytes.Length);
            ms.Write(phase_effectBytesLen, 0, phase_effectBytesLen.Length);
            ms.Write(phase_effectBytes, 0, phase_effectBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int phase_scoreCount;
phase_scoreCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase_score = new List<int>(phase_scoreCount);
for (int i = 0; i < phase_scoreCount; i++){
phase_score.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int pvp_phase_goodsCount;
pvp_phase_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pvp_phase_goods = new List<Systask_goods>(pvp_phase_goodsCount);
for (int i = 0; i < pvp_phase_goodsCount; i++){
pvp_phase_goods.Add(new Systask_goods());offset = pvp_phase_goods[i].Deserializer(bytes,offset);
}
int phase_icon_count;phase_icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;phase_icon = System.Text.Encoding.UTF8.GetString(bytes, offset, phase_icon_count);offset += phase_icon_count;
int phase_icon_mini_count;phase_icon_mini_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;phase_icon_mini = System.Text.Encoding.UTF8.GetString(bytes, offset, phase_icon_mini_count);offset += phase_icon_mini_count;
int box_icon_count;box_icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;box_icon = System.Text.Encoding.UTF8.GetString(bytes, offset, box_icon_count);offset += box_icon_count;
need_score = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int phase_effect_count;phase_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;phase_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, phase_effect_count);offset += phase_effect_count;
return offset;
        }
} 
 [Serializable]public class Syspvp_reward
    {
		public string unikey;
		public int union_id; //唯一id
		public List<Syspvp_goods> phase1_goods; //青铜
		public List<Syspvp_goods> phase2_goods; //白银
		public List<Syspvp_goods> phase3_goods; //黄金
		public List<Syspvp_goods> phase4_goods; //铂金
		public List<Syspvp_goods> phase5_goods; //钻石
		public List<Syspvp_goods> phase6_goods; //王者
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] union_idBytes = BitConverter.GetBytes(union_id);
            ms.Write(union_idBytes,0,union_idBytes.Length);
if(phase1_goods==null)phase1_goods = new List<Syspvp_goods>();
byte[] phase1_goodsCountBytes = BitConverter.GetBytes(phase1_goods.Count);
            ms.Write(phase1_goodsCountBytes,0,phase1_goodsCountBytes.Length);
for (int i = 0; i < phase1_goods.Count; i++){
if(phase1_goods[i] == null)phase1_goods[i] = new Syspvp_goods();phase1_goods[i].Serializer(ms);
}
if(phase2_goods==null)phase2_goods = new List<Syspvp_goods>();
byte[] phase2_goodsCountBytes = BitConverter.GetBytes(phase2_goods.Count);
            ms.Write(phase2_goodsCountBytes,0,phase2_goodsCountBytes.Length);
for (int i = 0; i < phase2_goods.Count; i++){
if(phase2_goods[i] == null)phase2_goods[i] = new Syspvp_goods();phase2_goods[i].Serializer(ms);
}
if(phase3_goods==null)phase3_goods = new List<Syspvp_goods>();
byte[] phase3_goodsCountBytes = BitConverter.GetBytes(phase3_goods.Count);
            ms.Write(phase3_goodsCountBytes,0,phase3_goodsCountBytes.Length);
for (int i = 0; i < phase3_goods.Count; i++){
if(phase3_goods[i] == null)phase3_goods[i] = new Syspvp_goods();phase3_goods[i].Serializer(ms);
}
if(phase4_goods==null)phase4_goods = new List<Syspvp_goods>();
byte[] phase4_goodsCountBytes = BitConverter.GetBytes(phase4_goods.Count);
            ms.Write(phase4_goodsCountBytes,0,phase4_goodsCountBytes.Length);
for (int i = 0; i < phase4_goods.Count; i++){
if(phase4_goods[i] == null)phase4_goods[i] = new Syspvp_goods();phase4_goods[i].Serializer(ms);
}
if(phase5_goods==null)phase5_goods = new List<Syspvp_goods>();
byte[] phase5_goodsCountBytes = BitConverter.GetBytes(phase5_goods.Count);
            ms.Write(phase5_goodsCountBytes,0,phase5_goodsCountBytes.Length);
for (int i = 0; i < phase5_goods.Count; i++){
if(phase5_goods[i] == null)phase5_goods[i] = new Syspvp_goods();phase5_goods[i].Serializer(ms);
}
if(phase6_goods==null)phase6_goods = new List<Syspvp_goods>();
byte[] phase6_goodsCountBytes = BitConverter.GetBytes(phase6_goods.Count);
            ms.Write(phase6_goodsCountBytes,0,phase6_goodsCountBytes.Length);
for (int i = 0; i < phase6_goods.Count; i++){
if(phase6_goods[i] == null)phase6_goods[i] = new Syspvp_goods();phase6_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
union_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int phase1_goodsCount;
phase1_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase1_goods = new List<Syspvp_goods>(phase1_goodsCount);
for (int i = 0; i < phase1_goodsCount; i++){
phase1_goods.Add(new Syspvp_goods());offset = phase1_goods[i].Deserializer(bytes,offset);
}

int phase2_goodsCount;
phase2_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase2_goods = new List<Syspvp_goods>(phase2_goodsCount);
for (int i = 0; i < phase2_goodsCount; i++){
phase2_goods.Add(new Syspvp_goods());offset = phase2_goods[i].Deserializer(bytes,offset);
}

int phase3_goodsCount;
phase3_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase3_goods = new List<Syspvp_goods>(phase3_goodsCount);
for (int i = 0; i < phase3_goodsCount; i++){
phase3_goods.Add(new Syspvp_goods());offset = phase3_goods[i].Deserializer(bytes,offset);
}

int phase4_goodsCount;
phase4_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase4_goods = new List<Syspvp_goods>(phase4_goodsCount);
for (int i = 0; i < phase4_goodsCount; i++){
phase4_goods.Add(new Syspvp_goods());offset = phase4_goods[i].Deserializer(bytes,offset);
}

int phase5_goodsCount;
phase5_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase5_goods = new List<Syspvp_goods>(phase5_goodsCount);
for (int i = 0; i < phase5_goodsCount; i++){
phase5_goods.Add(new Syspvp_goods());offset = phase5_goods[i].Deserializer(bytes,offset);
}

int phase6_goodsCount;
phase6_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase6_goods = new List<Syspvp_goods>(phase6_goodsCount);
for (int i = 0; i < phase6_goodsCount; i++){
phase6_goods.Add(new Syspvp_goods());offset = phase6_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysrandom_name
    {
		public string unikey;
		public int sex; //性别
		public List<Sysrandom_name_first> surnames; //姓
		public List<Sysrandom_name_second> names; //名
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] sexBytes = BitConverter.GetBytes(sex);
            ms.Write(sexBytes,0,sexBytes.Length);
if(surnames==null)surnames = new List<Sysrandom_name_first>();
byte[] surnamesCountBytes = BitConverter.GetBytes(surnames.Count);
            ms.Write(surnamesCountBytes,0,surnamesCountBytes.Length);
for (int i = 0; i < surnames.Count; i++){
if(surnames[i] == null)surnames[i] = new Sysrandom_name_first();surnames[i].Serializer(ms);
}
if(names==null)names = new List<Sysrandom_name_second>();
byte[] namesCountBytes = BitConverter.GetBytes(names.Count);
            ms.Write(namesCountBytes,0,namesCountBytes.Length);
for (int i = 0; i < names.Count; i++){
if(names[i] == null)names[i] = new Sysrandom_name_second();names[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
sex = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int surnamesCount;
surnamesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
surnames = new List<Sysrandom_name_first>(surnamesCount);
for (int i = 0; i < surnamesCount; i++){
surnames.Add(new Sysrandom_name_first());offset = surnames[i].Deserializer(bytes,offset);
}

int namesCount;
namesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
names = new List<Sysrandom_name_second>(namesCount);
for (int i = 0; i < namesCount; i++){
names.Add(new Sysrandom_name_second());offset = names[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysrandom_name_first
    {
		public int id; //索引
		public string value; //姓
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(value))value = string.Empty;
            byte[] valueBytes = System.Text.Encoding.UTF8.GetBytes(value);
            byte[] valueBytesLen = BitConverter.GetBytes(valueBytes.Length);
            ms.Write(valueBytesLen, 0, valueBytesLen.Length);
            ms.Write(valueBytes, 0, valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int value_count;value_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;value = System.Text.Encoding.UTF8.GetString(bytes, offset, value_count);offset += value_count;
return offset;
        }
} 
 [Serializable]public class Sysrandom_name_second
    {
		public int id; //索引
		public string value; //名
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(value))value = string.Empty;
            byte[] valueBytes = System.Text.Encoding.UTF8.GetBytes(value);
            byte[] valueBytesLen = BitConverter.GetBytes(valueBytes.Length);
            ms.Write(valueBytesLen, 0, valueBytesLen.Length);
            ms.Write(valueBytes, 0, valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int value_count;value_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;value = System.Text.Encoding.UTF8.GetString(bytes, offset, value_count);offset += value_count;
return offset;
        }
} 
 [Serializable]public class Sysrandom_prompt
    {
		public string unikey;
		public int id; //索引
		public string prompt; //提示语句
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(prompt))prompt = string.Empty;
            byte[] promptBytes = System.Text.Encoding.UTF8.GetBytes(prompt);
            byte[] promptBytesLen = BitConverter.GetBytes(promptBytes.Length);
            ms.Write(promptBytesLen, 0, promptBytesLen.Length);
            ms.Write(promptBytes, 0, promptBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int prompt_count;prompt_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;prompt = System.Text.Encoding.UTF8.GetString(bytes, offset, prompt_count);offset += prompt_count;
return offset;
        }
} 
 [Serializable]public class Sysranking_addition
    {
		public string unikey;
		public int id; //排行榜类型
		public int ranking; //名次
		public int attr_type; //加成类型
		public float attr_value; //加成数值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] rankingBytes = BitConverter.GetBytes(ranking);
            ms.Write(rankingBytes,0,rankingBytes.Length);
byte[] attr_typeBytes = BitConverter.GetBytes(attr_type);
            ms.Write(attr_typeBytes,0,attr_typeBytes.Length);
byte[] attr_valueBytes = BitConverter.GetBytes(attr_value);
            ms.Write(attr_valueBytes,0,attr_valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ranking = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr_value = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrank_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrecharge
    {
		public string unikey;
		public int rmb; //充值RMB
		public int diamond; //获得钻石
		public int presentation; //赠送钻石
		public string diamond_id; //钻石ID
		public string wzjx_diamond_id; //钻石ID
		public string desc; //描述
		public string bg_icon; //钻石ID
		public string top_left_name; //左上角
		public string top_left_bg; //左上角
		public List<Sysrecharge_award> recharge_award; //首充奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] rmbBytes = BitConverter.GetBytes(rmb);
            ms.Write(rmbBytes,0,rmbBytes.Length);
byte[] diamondBytes = BitConverter.GetBytes(diamond);
            ms.Write(diamondBytes,0,diamondBytes.Length);
byte[] presentationBytes = BitConverter.GetBytes(presentation);
            ms.Write(presentationBytes,0,presentationBytes.Length);
if(string.IsNullOrEmpty(diamond_id))diamond_id = string.Empty;
            byte[] diamond_idBytes = System.Text.Encoding.UTF8.GetBytes(diamond_id);
            byte[] diamond_idBytesLen = BitConverter.GetBytes(diamond_idBytes.Length);
            ms.Write(diamond_idBytesLen, 0, diamond_idBytesLen.Length);
            ms.Write(diamond_idBytes, 0, diamond_idBytes.Length);
if(string.IsNullOrEmpty(wzjx_diamond_id))wzjx_diamond_id = string.Empty;
            byte[] wzjx_diamond_idBytes = System.Text.Encoding.UTF8.GetBytes(wzjx_diamond_id);
            byte[] wzjx_diamond_idBytesLen = BitConverter.GetBytes(wzjx_diamond_idBytes.Length);
            ms.Write(wzjx_diamond_idBytesLen, 0, wzjx_diamond_idBytesLen.Length);
            ms.Write(wzjx_diamond_idBytes, 0, wzjx_diamond_idBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(bg_icon))bg_icon = string.Empty;
            byte[] bg_iconBytes = System.Text.Encoding.UTF8.GetBytes(bg_icon);
            byte[] bg_iconBytesLen = BitConverter.GetBytes(bg_iconBytes.Length);
            ms.Write(bg_iconBytesLen, 0, bg_iconBytesLen.Length);
            ms.Write(bg_iconBytes, 0, bg_iconBytes.Length);
if(string.IsNullOrEmpty(top_left_name))top_left_name = string.Empty;
            byte[] top_left_nameBytes = System.Text.Encoding.UTF8.GetBytes(top_left_name);
            byte[] top_left_nameBytesLen = BitConverter.GetBytes(top_left_nameBytes.Length);
            ms.Write(top_left_nameBytesLen, 0, top_left_nameBytesLen.Length);
            ms.Write(top_left_nameBytes, 0, top_left_nameBytes.Length);
if(string.IsNullOrEmpty(top_left_bg))top_left_bg = string.Empty;
            byte[] top_left_bgBytes = System.Text.Encoding.UTF8.GetBytes(top_left_bg);
            byte[] top_left_bgBytesLen = BitConverter.GetBytes(top_left_bgBytes.Length);
            ms.Write(top_left_bgBytesLen, 0, top_left_bgBytesLen.Length);
            ms.Write(top_left_bgBytes, 0, top_left_bgBytes.Length);
if(recharge_award==null)recharge_award = new List<Sysrecharge_award>();
byte[] recharge_awardCountBytes = BitConverter.GetBytes(recharge_award.Count);
            ms.Write(recharge_awardCountBytes,0,recharge_awardCountBytes.Length);
for (int i = 0; i < recharge_award.Count; i++){
if(recharge_award[i] == null)recharge_award[i] = new Sysrecharge_award();recharge_award[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
rmb = BitConverter.ToInt32(bytes, offset);
            offset += 4;
diamond = BitConverter.ToInt32(bytes, offset);
            offset += 4;
presentation = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int diamond_id_count;diamond_id_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;diamond_id = System.Text.Encoding.UTF8.GetString(bytes, offset, diamond_id_count);offset += diamond_id_count;
int wzjx_diamond_id_count;wzjx_diamond_id_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;wzjx_diamond_id = System.Text.Encoding.UTF8.GetString(bytes, offset, wzjx_diamond_id_count);offset += wzjx_diamond_id_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int bg_icon_count;bg_icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bg_icon = System.Text.Encoding.UTF8.GetString(bytes, offset, bg_icon_count);offset += bg_icon_count;
int top_left_name_count;top_left_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;top_left_name = System.Text.Encoding.UTF8.GetString(bytes, offset, top_left_name_count);offset += top_left_name_count;
int top_left_bg_count;top_left_bg_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;top_left_bg = System.Text.Encoding.UTF8.GetString(bytes, offset, top_left_bg_count);offset += top_left_bg_count;

int recharge_awardCount;
recharge_awardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
recharge_award = new List<Sysrecharge_award>(recharge_awardCount);
for (int i = 0; i < recharge_awardCount; i++){
recharge_award.Add(new Sysrecharge_award());offset = recharge_award[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysrecharge_award
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrefresh_rate
    {
		public int id; //品质id
		public int rate; //品质概率
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] rateBytes = BitConverter.GetBytes(rate);
            ms.Write(rateBytes,0,rateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrelive_time
    {
		public string unikey;
		public int time; //战斗时间
		public int relive; //单路复活时间
		public int relive2; //三路复活时间
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] timeBytes = BitConverter.GetBytes(time);
            ms.Write(timeBytes,0,timeBytes.Length);
byte[] reliveBytes = BitConverter.GetBytes(relive);
            ms.Write(reliveBytes,0,reliveBytes.Length);
byte[] relive2Bytes = BitConverter.GetBytes(relive2);
            ms.Write(relive2Bytes,0,relive2Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
relive = BitConverter.ToInt32(bytes, offset);
            offset += 4;
relive2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrender
    {
		public int id; //镜头ID
		public float fog_start; //雾参数
		public float fog_end; //雾参数
		public float fog_density_start; //开始时的雾效强度
		public float fog_density_end; //结束时的雾效强度
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] fog_startBytes = BitConverter.GetBytes(fog_start);
            ms.Write(fog_startBytes,0,fog_startBytes.Length);
byte[] fog_endBytes = BitConverter.GetBytes(fog_end);
            ms.Write(fog_endBytes,0,fog_endBytes.Length);
byte[] fog_density_startBytes = BitConverter.GetBytes(fog_density_start);
            ms.Write(fog_density_startBytes,0,fog_density_startBytes.Length);
byte[] fog_density_endBytes = BitConverter.GetBytes(fog_density_end);
            ms.Write(fog_density_endBytes,0,fog_density_endBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fog_start = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fog_end = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fog_density_start = BitConverter.ToSingle(bytes, offset);
            offset += 4;
fog_density_end = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrobotic_player
    {
		public string unikey;
		public int id; //玩家id
		public string name; //玩家昵称
		public int lv; //玩家等级
		public List<int> star; //显示英雄星级
		public List<int> quality; //显示英雄品质
		public List<int> hero_list; //英雄列表
		public int icon; //玩家头像
		public int model_skin; //玩家模型
		public int combat; //战斗力
		public int skill_lv; //技能等级
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(star==null)star = new List<int>();
byte[] starCountBytes = BitConverter.GetBytes(star.Count);
            ms.Write(starCountBytes,0,starCountBytes.Length);
for (int i = 0; i < star.Count; i++){
byte[] starBytes = BitConverter.GetBytes(star[i]);
            ms.Write(starBytes,0,starBytes.Length);
}
if(quality==null)quality = new List<int>();
byte[] qualityCountBytes = BitConverter.GetBytes(quality.Count);
            ms.Write(qualityCountBytes,0,qualityCountBytes.Length);
for (int i = 0; i < quality.Count; i++){
byte[] qualityBytes = BitConverter.GetBytes(quality[i]);
            ms.Write(qualityBytes,0,qualityBytes.Length);
}
if(hero_list==null)hero_list = new List<int>();
byte[] hero_listCountBytes = BitConverter.GetBytes(hero_list.Count);
            ms.Write(hero_listCountBytes,0,hero_listCountBytes.Length);
for (int i = 0; i < hero_list.Count; i++){
byte[] hero_listBytes = BitConverter.GetBytes(hero_list[i]);
            ms.Write(hero_listBytes,0,hero_listBytes.Length);
}
byte[] iconBytes = BitConverter.GetBytes(icon);
            ms.Write(iconBytes,0,iconBytes.Length);
byte[] model_skinBytes = BitConverter.GetBytes(model_skin);
            ms.Write(model_skinBytes,0,model_skinBytes.Length);
byte[] combatBytes = BitConverter.GetBytes(combat);
            ms.Write(combatBytes,0,combatBytes.Length);
byte[] skill_lvBytes = BitConverter.GetBytes(skill_lv);
            ms.Write(skill_lvBytes,0,skill_lvBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int starCount;
starCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = new List<int>(starCount);
for (int i = 0; i < starCount; i++){
star.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int qualityCount;
qualityCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = new List<int>(qualityCount);
for (int i = 0; i < qualityCount; i++){
quality.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int hero_listCount;
hero_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero_list = new List<int>(hero_listCount);
for (int i = 0; i < hero_listCount; i++){
hero_list.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
icon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
model_skin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysscene
    {
		public string unikey;
		public int scene_id; //场景ID
		public string scene_name; //场景资源名字
		public int scene_type; //场景类型
		public List<int> sound_interval; //音效出战音效播放间隔
		public float sound_start; //首次播放出战音效时间
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] scene_idBytes = BitConverter.GetBytes(scene_id);
            ms.Write(scene_idBytes,0,scene_idBytes.Length);
if(string.IsNullOrEmpty(scene_name))scene_name = string.Empty;
            byte[] scene_nameBytes = System.Text.Encoding.UTF8.GetBytes(scene_name);
            byte[] scene_nameBytesLen = BitConverter.GetBytes(scene_nameBytes.Length);
            ms.Write(scene_nameBytesLen, 0, scene_nameBytesLen.Length);
            ms.Write(scene_nameBytes, 0, scene_nameBytes.Length);
byte[] scene_typeBytes = BitConverter.GetBytes(scene_type);
            ms.Write(scene_typeBytes,0,scene_typeBytes.Length);
if(sound_interval==null)sound_interval = new List<int>();
byte[] sound_intervalCountBytes = BitConverter.GetBytes(sound_interval.Count);
            ms.Write(sound_intervalCountBytes,0,sound_intervalCountBytes.Length);
for (int i = 0; i < sound_interval.Count; i++){
byte[] sound_intervalBytes = BitConverter.GetBytes(sound_interval[i]);
            ms.Write(sound_intervalBytes,0,sound_intervalBytes.Length);
}
byte[] sound_startBytes = BitConverter.GetBytes(sound_start);
            ms.Write(sound_startBytes,0,sound_startBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
scene_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int scene_name_count;scene_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;scene_name = System.Text.Encoding.UTF8.GetString(bytes, offset, scene_name_count);offset += scene_name_count;
scene_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int sound_intervalCount;
sound_intervalCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sound_interval = new List<int>(sound_intervalCount);
for (int i = 0; i < sound_intervalCount; i++){
sound_interval.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
sound_start = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysscene_skill
    {
		public string unikey;
		public int id; //id
		public int skill; //id
		public string icon; //图标
		public string name; //技能名字
		public string desc; //技能描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] skillBytes = BitConverter.GetBytes(skill);
            ms.Write(skillBytes,0,skillBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Syssensitive_word
    {
		public string unikey;
		public int id; //索引
		public string word; //词汇
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(word))word = string.Empty;
            byte[] wordBytes = System.Text.Encoding.UTF8.GetBytes(word);
            byte[] wordBytesLen = BitConverter.GetBytes(wordBytes.Length);
            ms.Write(wordBytesLen, 0, wordBytesLen.Length);
            ms.Write(wordBytes, 0, wordBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int word_count;word_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;word = System.Text.Encoding.UTF8.GetString(bytes, offset, word_count);offset += word_count;
return offset;
        }
} 
 [Serializable]public class Sysshake
    {
		public string unikey;
		public int id; //技能id
		public string name; //技能名
		public int mode; //震动模式
		public float delta; //震动幅度
		public float duration; //震动时间
		public float rate; //震动频率
		public string state_name; //调用动画
		public int shake_type; //震屏类型
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] modeBytes = BitConverter.GetBytes(mode);
            ms.Write(modeBytes,0,modeBytes.Length);
byte[] deltaBytes = BitConverter.GetBytes(delta);
            ms.Write(deltaBytes,0,deltaBytes.Length);
byte[] durationBytes = BitConverter.GetBytes(duration);
            ms.Write(durationBytes,0,durationBytes.Length);
byte[] rateBytes = BitConverter.GetBytes(rate);
            ms.Write(rateBytes,0,rateBytes.Length);
if(string.IsNullOrEmpty(state_name))state_name = string.Empty;
            byte[] state_nameBytes = System.Text.Encoding.UTF8.GetBytes(state_name);
            byte[] state_nameBytesLen = BitConverter.GetBytes(state_nameBytes.Length);
            ms.Write(state_nameBytesLen, 0, state_nameBytesLen.Length);
            ms.Write(state_nameBytes, 0, state_nameBytes.Length);
byte[] shake_typeBytes = BitConverter.GetBytes(shake_type);
            ms.Write(shake_typeBytes,0,shake_typeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
mode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
delta = BitConverter.ToSingle(bytes, offset);
            offset += 4;
duration = BitConverter.ToSingle(bytes, offset);
            offset += 4;
rate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int state_name_count;state_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;state_name = System.Text.Encoding.UTF8.GetString(bytes, offset, state_name_count);offset += state_name_count;
shake_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syssign
    {
		public string unikey;
		public int month; //签到月
		public List<Syssign_value> date; //所有日期的
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] monthBytes = BitConverter.GetBytes(month);
            ms.Write(monthBytes,0,monthBytes.Length);
if(date==null)date = new List<Syssign_value>();
byte[] dateCountBytes = BitConverter.GetBytes(date.Count);
            ms.Write(dateCountBytes,0,dateCountBytes.Length);
for (int i = 0; i < date.Count; i++){
if(date[i] == null)date[i] = new Syssign_value();date[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
month = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dateCount;
dateCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
date = new List<Syssign_value>(dateCount);
for (int i = 0; i < dateCount; i++){
date.Add(new Syssign_value());offset = date[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syssign_all_day_award
    {
		public string unikey;
		public int date; //总共签到天数
		public List<Syssign_all_goods> goods; //物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dateBytes = BitConverter.GetBytes(date);
            ms.Write(dateBytes,0,dateBytes.Length);
if(goods==null)goods = new List<Syssign_all_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syssign_all_goods();goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
date = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syssign_all_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syssign_all_goods());offset = goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syssign_all_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syssign_always
    {
		public string unikey;
		public int date; //连续天数
		public List<Syssign_goods> goods; //物品
		public List<Syssign_goods> goods_first; //首次7连签奖励
		public List<Syssign_goods> land_goods; //7天连续登陆奖励物品
		public string goods_name; //七日登陆奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dateBytes = BitConverter.GetBytes(date);
            ms.Write(dateBytes,0,dateBytes.Length);
if(goods==null)goods = new List<Syssign_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syssign_goods();goods[i].Serializer(ms);
}
if(goods_first==null)goods_first = new List<Syssign_goods>();
byte[] goods_firstCountBytes = BitConverter.GetBytes(goods_first.Count);
            ms.Write(goods_firstCountBytes,0,goods_firstCountBytes.Length);
for (int i = 0; i < goods_first.Count; i++){
if(goods_first[i] == null)goods_first[i] = new Syssign_goods();goods_first[i].Serializer(ms);
}
if(land_goods==null)land_goods = new List<Syssign_goods>();
byte[] land_goodsCountBytes = BitConverter.GetBytes(land_goods.Count);
            ms.Write(land_goodsCountBytes,0,land_goodsCountBytes.Length);
for (int i = 0; i < land_goods.Count; i++){
if(land_goods[i] == null)land_goods[i] = new Syssign_goods();land_goods[i].Serializer(ms);
}
if(string.IsNullOrEmpty(goods_name))goods_name = string.Empty;
            byte[] goods_nameBytes = System.Text.Encoding.UTF8.GetBytes(goods_name);
            byte[] goods_nameBytesLen = BitConverter.GetBytes(goods_nameBytes.Length);
            ms.Write(goods_nameBytesLen, 0, goods_nameBytesLen.Length);
            ms.Write(goods_nameBytes, 0, goods_nameBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
date = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syssign_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syssign_goods());offset = goods[i].Deserializer(bytes,offset);
}

int goods_firstCount;
goods_firstCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_first = new List<Syssign_goods>(goods_firstCount);
for (int i = 0; i < goods_firstCount; i++){
goods_first.Add(new Syssign_goods());offset = goods_first[i].Deserializer(bytes,offset);
}

int land_goodsCount;
land_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
land_goods = new List<Syssign_goods>(land_goodsCount);
for (int i = 0; i < land_goodsCount; i++){
land_goods.Add(new Syssign_goods());offset = land_goods[i].Deserializer(bytes,offset);
}
int goods_name_count;goods_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;goods_name = System.Text.Encoding.UTF8.GetString(bytes, offset, goods_name_count);offset += goods_name_count;
return offset;
        }
} 
 [Serializable]public class Syssign_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syssign_value
    {
		public int id; //奖励ID
		public int goods_id; //物品ID
		public int num; //数量
		public int vip; //VIP等级
		public int amount; //倍数
		public int gold; //补签消耗
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
byte[] vipBytes = BitConverter.GetBytes(vip);
            ms.Write(vipBytes,0,vipBytes.Length);
byte[] amountBytes = BitConverter.GetBytes(amount);
            ms.Write(amountBytes,0,amountBytes.Length);
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
vip = BitConverter.ToInt32(bytes, offset);
            offset += 4;
amount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill
    {
		public string unikey;
		public int id; //技能id
		public string name; //技能名
		public List<int> validTargetType; //有效单位类型
		public List<int> subValidTargetType; //有效单位子类型
		public List<int> disableWhenInStates; //当处于什么状态下无法使用
		public List<int> interruptWhenInStates; //当处于什么状态下会被打断
		public List<int> invalidInScenes; //当处于什么场景下被禁用
		public int cdMode; //技能CD类型
		public int nextSkill; //下一个技能
		public int viewType; //技能区域显示类型
		public float viewAngle; //显示角度
		public float useRadius; //施法距离
		public float aiUseRadius; //AI施法距离
		public float lockRadius; //锁怪范围
		public List<int> checks; //作用范围
		public int ai; //技能AI
		public int sound; //技能释放音效
		public float soundDelay; //技能释放音效延时
		public List<int> effects; //技能特效
		public Sysskill_affect affect; //技能效果
		public int shake; //技能震屏
		public string button; //技能的按键id
		public float cd; //技能cd
		public string actionMode; //动作类型
		public int minRepeatCount; //最小重复次数
		public int maxRepeatCount; //最大重复次数
		public float rushSpeed; //突进速度
		public float rushStopDistance; //突进停止距离
		public int lockMode; //锁定模式
		public float checkTime; //开始检测伤害的时间（动画时间）
		public float delayCheckTime; //检测延时时间（常规时间）
		public float duration; //技能持续时间
		public float intervalCheckTime; //持续伤害类型技能的检测间隔
		public string logicClass; //技能逻辑类名
		public int targetType; //目标类型
		public int break_reset_cd; //移动是否打断
		public float transition_limit; //最快可以切换到下一个动作的时间
		public int rush_mode; //突进模式
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(validTargetType==null)validTargetType = new List<int>();
byte[] validTargetTypeCountBytes = BitConverter.GetBytes(validTargetType.Count);
            ms.Write(validTargetTypeCountBytes,0,validTargetTypeCountBytes.Length);
for (int i = 0; i < validTargetType.Count; i++){
byte[] validTargetTypeBytes = BitConverter.GetBytes(validTargetType[i]);
            ms.Write(validTargetTypeBytes,0,validTargetTypeBytes.Length);
}
if(subValidTargetType==null)subValidTargetType = new List<int>();
byte[] subValidTargetTypeCountBytes = BitConverter.GetBytes(subValidTargetType.Count);
            ms.Write(subValidTargetTypeCountBytes,0,subValidTargetTypeCountBytes.Length);
for (int i = 0; i < subValidTargetType.Count; i++){
byte[] subValidTargetTypeBytes = BitConverter.GetBytes(subValidTargetType[i]);
            ms.Write(subValidTargetTypeBytes,0,subValidTargetTypeBytes.Length);
}
if(disableWhenInStates==null)disableWhenInStates = new List<int>();
byte[] disableWhenInStatesCountBytes = BitConverter.GetBytes(disableWhenInStates.Count);
            ms.Write(disableWhenInStatesCountBytes,0,disableWhenInStatesCountBytes.Length);
for (int i = 0; i < disableWhenInStates.Count; i++){
byte[] disableWhenInStatesBytes = BitConverter.GetBytes(disableWhenInStates[i]);
            ms.Write(disableWhenInStatesBytes,0,disableWhenInStatesBytes.Length);
}
if(interruptWhenInStates==null)interruptWhenInStates = new List<int>();
byte[] interruptWhenInStatesCountBytes = BitConverter.GetBytes(interruptWhenInStates.Count);
            ms.Write(interruptWhenInStatesCountBytes,0,interruptWhenInStatesCountBytes.Length);
for (int i = 0; i < interruptWhenInStates.Count; i++){
byte[] interruptWhenInStatesBytes = BitConverter.GetBytes(interruptWhenInStates[i]);
            ms.Write(interruptWhenInStatesBytes,0,interruptWhenInStatesBytes.Length);
}
if(invalidInScenes==null)invalidInScenes = new List<int>();
byte[] invalidInScenesCountBytes = BitConverter.GetBytes(invalidInScenes.Count);
            ms.Write(invalidInScenesCountBytes,0,invalidInScenesCountBytes.Length);
for (int i = 0; i < invalidInScenes.Count; i++){
byte[] invalidInScenesBytes = BitConverter.GetBytes(invalidInScenes[i]);
            ms.Write(invalidInScenesBytes,0,invalidInScenesBytes.Length);
}
byte[] cdModeBytes = BitConverter.GetBytes(cdMode);
            ms.Write(cdModeBytes,0,cdModeBytes.Length);
byte[] nextSkillBytes = BitConverter.GetBytes(nextSkill);
            ms.Write(nextSkillBytes,0,nextSkillBytes.Length);
byte[] viewTypeBytes = BitConverter.GetBytes(viewType);
            ms.Write(viewTypeBytes,0,viewTypeBytes.Length);
byte[] viewAngleBytes = BitConverter.GetBytes(viewAngle);
            ms.Write(viewAngleBytes,0,viewAngleBytes.Length);
byte[] useRadiusBytes = BitConverter.GetBytes(useRadius);
            ms.Write(useRadiusBytes,0,useRadiusBytes.Length);
byte[] aiUseRadiusBytes = BitConverter.GetBytes(aiUseRadius);
            ms.Write(aiUseRadiusBytes,0,aiUseRadiusBytes.Length);
byte[] lockRadiusBytes = BitConverter.GetBytes(lockRadius);
            ms.Write(lockRadiusBytes,0,lockRadiusBytes.Length);
if(checks==null)checks = new List<int>();
byte[] checksCountBytes = BitConverter.GetBytes(checks.Count);
            ms.Write(checksCountBytes,0,checksCountBytes.Length);
for (int i = 0; i < checks.Count; i++){
byte[] checksBytes = BitConverter.GetBytes(checks[i]);
            ms.Write(checksBytes,0,checksBytes.Length);
}
byte[] aiBytes = BitConverter.GetBytes(ai);
            ms.Write(aiBytes,0,aiBytes.Length);
byte[] soundBytes = BitConverter.GetBytes(sound);
            ms.Write(soundBytes,0,soundBytes.Length);
byte[] soundDelayBytes = BitConverter.GetBytes(soundDelay);
            ms.Write(soundDelayBytes,0,soundDelayBytes.Length);
if(effects==null)effects = new List<int>();
byte[] effectsCountBytes = BitConverter.GetBytes(effects.Count);
            ms.Write(effectsCountBytes,0,effectsCountBytes.Length);
for (int i = 0; i < effects.Count; i++){
byte[] effectsBytes = BitConverter.GetBytes(effects[i]);
            ms.Write(effectsBytes,0,effectsBytes.Length);
}
if(affect == null)affect = new Sysskill_affect();affect.Serializer(ms);
byte[] shakeBytes = BitConverter.GetBytes(shake);
            ms.Write(shakeBytes,0,shakeBytes.Length);
if(string.IsNullOrEmpty(button))button = string.Empty;
            byte[] buttonBytes = System.Text.Encoding.UTF8.GetBytes(button);
            byte[] buttonBytesLen = BitConverter.GetBytes(buttonBytes.Length);
            ms.Write(buttonBytesLen, 0, buttonBytesLen.Length);
            ms.Write(buttonBytes, 0, buttonBytes.Length);
byte[] cdBytes = BitConverter.GetBytes(cd);
            ms.Write(cdBytes,0,cdBytes.Length);
if(string.IsNullOrEmpty(actionMode))actionMode = string.Empty;
            byte[] actionModeBytes = System.Text.Encoding.UTF8.GetBytes(actionMode);
            byte[] actionModeBytesLen = BitConverter.GetBytes(actionModeBytes.Length);
            ms.Write(actionModeBytesLen, 0, actionModeBytesLen.Length);
            ms.Write(actionModeBytes, 0, actionModeBytes.Length);
byte[] minRepeatCountBytes = BitConverter.GetBytes(minRepeatCount);
            ms.Write(minRepeatCountBytes,0,minRepeatCountBytes.Length);
byte[] maxRepeatCountBytes = BitConverter.GetBytes(maxRepeatCount);
            ms.Write(maxRepeatCountBytes,0,maxRepeatCountBytes.Length);
byte[] rushSpeedBytes = BitConverter.GetBytes(rushSpeed);
            ms.Write(rushSpeedBytes,0,rushSpeedBytes.Length);
byte[] rushStopDistanceBytes = BitConverter.GetBytes(rushStopDistance);
            ms.Write(rushStopDistanceBytes,0,rushStopDistanceBytes.Length);
byte[] lockModeBytes = BitConverter.GetBytes(lockMode);
            ms.Write(lockModeBytes,0,lockModeBytes.Length);
byte[] checkTimeBytes = BitConverter.GetBytes(checkTime);
            ms.Write(checkTimeBytes,0,checkTimeBytes.Length);
byte[] delayCheckTimeBytes = BitConverter.GetBytes(delayCheckTime);
            ms.Write(delayCheckTimeBytes,0,delayCheckTimeBytes.Length);
byte[] durationBytes = BitConverter.GetBytes(duration);
            ms.Write(durationBytes,0,durationBytes.Length);
byte[] intervalCheckTimeBytes = BitConverter.GetBytes(intervalCheckTime);
            ms.Write(intervalCheckTimeBytes,0,intervalCheckTimeBytes.Length);
if(string.IsNullOrEmpty(logicClass))logicClass = string.Empty;
            byte[] logicClassBytes = System.Text.Encoding.UTF8.GetBytes(logicClass);
            byte[] logicClassBytesLen = BitConverter.GetBytes(logicClassBytes.Length);
            ms.Write(logicClassBytesLen, 0, logicClassBytesLen.Length);
            ms.Write(logicClassBytes, 0, logicClassBytes.Length);
byte[] targetTypeBytes = BitConverter.GetBytes(targetType);
            ms.Write(targetTypeBytes,0,targetTypeBytes.Length);
byte[] break_reset_cdBytes = BitConverter.GetBytes(break_reset_cd);
            ms.Write(break_reset_cdBytes,0,break_reset_cdBytes.Length);
byte[] transition_limitBytes = BitConverter.GetBytes(transition_limit);
            ms.Write(transition_limitBytes,0,transition_limitBytes.Length);
byte[] rush_modeBytes = BitConverter.GetBytes(rush_mode);
            ms.Write(rush_modeBytes,0,rush_modeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int validTargetTypeCount;
validTargetTypeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
validTargetType = new List<int>(validTargetTypeCount);
for (int i = 0; i < validTargetTypeCount; i++){
validTargetType.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int subValidTargetTypeCount;
subValidTargetTypeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
subValidTargetType = new List<int>(subValidTargetTypeCount);
for (int i = 0; i < subValidTargetTypeCount; i++){
subValidTargetType.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int disableWhenInStatesCount;
disableWhenInStatesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
disableWhenInStates = new List<int>(disableWhenInStatesCount);
for (int i = 0; i < disableWhenInStatesCount; i++){
disableWhenInStates.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int interruptWhenInStatesCount;
interruptWhenInStatesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
interruptWhenInStates = new List<int>(interruptWhenInStatesCount);
for (int i = 0; i < interruptWhenInStatesCount; i++){
interruptWhenInStates.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int invalidInScenesCount;
invalidInScenesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
invalidInScenes = new List<int>(invalidInScenesCount);
for (int i = 0; i < invalidInScenesCount; i++){
invalidInScenes.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
cdMode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
nextSkill = BitConverter.ToInt32(bytes, offset);
            offset += 4;
viewType = BitConverter.ToInt32(bytes, offset);
            offset += 4;
viewAngle = BitConverter.ToSingle(bytes, offset);
            offset += 4;
useRadius = BitConverter.ToSingle(bytes, offset);
            offset += 4;
aiUseRadius = BitConverter.ToSingle(bytes, offset);
            offset += 4;
lockRadius = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int checksCount;
checksCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
checks = new List<int>(checksCount);
for (int i = 0; i < checksCount; i++){
checks.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
ai = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
soundDelay = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int effectsCount;
effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
effects = new List<int>(effectsCount);
for (int i = 0; i < effectsCount; i++){
effects.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
affect = new Sysskill_affect();offset = affect.Deserializer(bytes,offset);
shake = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int button_count;button_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;button = System.Text.Encoding.UTF8.GetString(bytes, offset, button_count);offset += button_count;
cd = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int actionMode_count;actionMode_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;actionMode = System.Text.Encoding.UTF8.GetString(bytes, offset, actionMode_count);offset += actionMode_count;
minRepeatCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
maxRepeatCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rushSpeed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
rushStopDistance = BitConverter.ToSingle(bytes, offset);
            offset += 4;
lockMode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
checkTime = BitConverter.ToSingle(bytes, offset);
            offset += 4;
delayCheckTime = BitConverter.ToSingle(bytes, offset);
            offset += 4;
duration = BitConverter.ToSingle(bytes, offset);
            offset += 4;
intervalCheckTime = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int logicClass_count;logicClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;logicClass = System.Text.Encoding.UTF8.GetString(bytes, offset, logicClass_count);offset += logicClass_count;
targetType = BitConverter.ToInt32(bytes, offset);
            offset += 4;
break_reset_cd = BitConverter.ToInt32(bytes, offset);
            offset += 4;
transition_limit = BitConverter.ToSingle(bytes, offset);
            offset += 4;
rush_mode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_affect
    {
		public int id; //技能效果id
		public int attr; //属性ID
		public string name; //效果名称
		public List<int> types; //类型
		public List<Syshit_effect> hit_effects_1; //受击特效
		public int hit_sound_1; //受击音效
		public List<int> buffs_1; //附加buff or debuff
		public List<Sysextra_hurt> extra_hurts_1; //额外伤害
		public List<Syshit_effect> hit_effects_2; //受击特效
		public int hit_sound_2; //受击音效
		public List<int> buffs_2; //附加buff or debuff
		public List<Sysextra_hurt> extra_hurts_2; //额外伤害
		public List<Syshit_effect> hit_effects_3; //受击特效
		public int hit_sound_3; //受击音效
		public List<int> buffs_3; //附加buff or debuff
		public List<Sysextra_hurt> extra_hurts_3; //额外伤害
		public List<int> attach_affects_1; //附加效果
		public List<int> attach_affects_2; //附加效果
		public List<int> attach_affects_3; //附加效果
		public int grow_type; //成长类型
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] attrBytes = BitConverter.GetBytes(attr);
            ms.Write(attrBytes,0,attrBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(types==null)types = new List<int>();
byte[] typesCountBytes = BitConverter.GetBytes(types.Count);
            ms.Write(typesCountBytes,0,typesCountBytes.Length);
for (int i = 0; i < types.Count; i++){
byte[] typesBytes = BitConverter.GetBytes(types[i]);
            ms.Write(typesBytes,0,typesBytes.Length);
}
if(hit_effects_1==null)hit_effects_1 = new List<Syshit_effect>();
byte[] hit_effects_1CountBytes = BitConverter.GetBytes(hit_effects_1.Count);
            ms.Write(hit_effects_1CountBytes,0,hit_effects_1CountBytes.Length);
for (int i = 0; i < hit_effects_1.Count; i++){
if(hit_effects_1[i] == null)hit_effects_1[i] = new Syshit_effect();hit_effects_1[i].Serializer(ms);
}
byte[] hit_sound_1Bytes = BitConverter.GetBytes(hit_sound_1);
            ms.Write(hit_sound_1Bytes,0,hit_sound_1Bytes.Length);
if(buffs_1==null)buffs_1 = new List<int>();
byte[] buffs_1CountBytes = BitConverter.GetBytes(buffs_1.Count);
            ms.Write(buffs_1CountBytes,0,buffs_1CountBytes.Length);
for (int i = 0; i < buffs_1.Count; i++){
byte[] buffs_1Bytes = BitConverter.GetBytes(buffs_1[i]);
            ms.Write(buffs_1Bytes,0,buffs_1Bytes.Length);
}
if(extra_hurts_1==null)extra_hurts_1 = new List<Sysextra_hurt>();
byte[] extra_hurts_1CountBytes = BitConverter.GetBytes(extra_hurts_1.Count);
            ms.Write(extra_hurts_1CountBytes,0,extra_hurts_1CountBytes.Length);
for (int i = 0; i < extra_hurts_1.Count; i++){
if(extra_hurts_1[i] == null)extra_hurts_1[i] = new Sysextra_hurt();extra_hurts_1[i].Serializer(ms);
}
if(hit_effects_2==null)hit_effects_2 = new List<Syshit_effect>();
byte[] hit_effects_2CountBytes = BitConverter.GetBytes(hit_effects_2.Count);
            ms.Write(hit_effects_2CountBytes,0,hit_effects_2CountBytes.Length);
for (int i = 0; i < hit_effects_2.Count; i++){
if(hit_effects_2[i] == null)hit_effects_2[i] = new Syshit_effect();hit_effects_2[i].Serializer(ms);
}
byte[] hit_sound_2Bytes = BitConverter.GetBytes(hit_sound_2);
            ms.Write(hit_sound_2Bytes,0,hit_sound_2Bytes.Length);
if(buffs_2==null)buffs_2 = new List<int>();
byte[] buffs_2CountBytes = BitConverter.GetBytes(buffs_2.Count);
            ms.Write(buffs_2CountBytes,0,buffs_2CountBytes.Length);
for (int i = 0; i < buffs_2.Count; i++){
byte[] buffs_2Bytes = BitConverter.GetBytes(buffs_2[i]);
            ms.Write(buffs_2Bytes,0,buffs_2Bytes.Length);
}
if(extra_hurts_2==null)extra_hurts_2 = new List<Sysextra_hurt>();
byte[] extra_hurts_2CountBytes = BitConverter.GetBytes(extra_hurts_2.Count);
            ms.Write(extra_hurts_2CountBytes,0,extra_hurts_2CountBytes.Length);
for (int i = 0; i < extra_hurts_2.Count; i++){
if(extra_hurts_2[i] == null)extra_hurts_2[i] = new Sysextra_hurt();extra_hurts_2[i].Serializer(ms);
}
if(hit_effects_3==null)hit_effects_3 = new List<Syshit_effect>();
byte[] hit_effects_3CountBytes = BitConverter.GetBytes(hit_effects_3.Count);
            ms.Write(hit_effects_3CountBytes,0,hit_effects_3CountBytes.Length);
for (int i = 0; i < hit_effects_3.Count; i++){
if(hit_effects_3[i] == null)hit_effects_3[i] = new Syshit_effect();hit_effects_3[i].Serializer(ms);
}
byte[] hit_sound_3Bytes = BitConverter.GetBytes(hit_sound_3);
            ms.Write(hit_sound_3Bytes,0,hit_sound_3Bytes.Length);
if(buffs_3==null)buffs_3 = new List<int>();
byte[] buffs_3CountBytes = BitConverter.GetBytes(buffs_3.Count);
            ms.Write(buffs_3CountBytes,0,buffs_3CountBytes.Length);
for (int i = 0; i < buffs_3.Count; i++){
byte[] buffs_3Bytes = BitConverter.GetBytes(buffs_3[i]);
            ms.Write(buffs_3Bytes,0,buffs_3Bytes.Length);
}
if(extra_hurts_3==null)extra_hurts_3 = new List<Sysextra_hurt>();
byte[] extra_hurts_3CountBytes = BitConverter.GetBytes(extra_hurts_3.Count);
            ms.Write(extra_hurts_3CountBytes,0,extra_hurts_3CountBytes.Length);
for (int i = 0; i < extra_hurts_3.Count; i++){
if(extra_hurts_3[i] == null)extra_hurts_3[i] = new Sysextra_hurt();extra_hurts_3[i].Serializer(ms);
}
if(attach_affects_1==null)attach_affects_1 = new List<int>();
byte[] attach_affects_1CountBytes = BitConverter.GetBytes(attach_affects_1.Count);
            ms.Write(attach_affects_1CountBytes,0,attach_affects_1CountBytes.Length);
for (int i = 0; i < attach_affects_1.Count; i++){
byte[] attach_affects_1Bytes = BitConverter.GetBytes(attach_affects_1[i]);
            ms.Write(attach_affects_1Bytes,0,attach_affects_1Bytes.Length);
}
if(attach_affects_2==null)attach_affects_2 = new List<int>();
byte[] attach_affects_2CountBytes = BitConverter.GetBytes(attach_affects_2.Count);
            ms.Write(attach_affects_2CountBytes,0,attach_affects_2CountBytes.Length);
for (int i = 0; i < attach_affects_2.Count; i++){
byte[] attach_affects_2Bytes = BitConverter.GetBytes(attach_affects_2[i]);
            ms.Write(attach_affects_2Bytes,0,attach_affects_2Bytes.Length);
}
if(attach_affects_3==null)attach_affects_3 = new List<int>();
byte[] attach_affects_3CountBytes = BitConverter.GetBytes(attach_affects_3.Count);
            ms.Write(attach_affects_3CountBytes,0,attach_affects_3CountBytes.Length);
for (int i = 0; i < attach_affects_3.Count; i++){
byte[] attach_affects_3Bytes = BitConverter.GetBytes(attach_affects_3[i]);
            ms.Write(attach_affects_3Bytes,0,attach_affects_3Bytes.Length);
}
byte[] grow_typeBytes = BitConverter.GetBytes(grow_type);
            ms.Write(grow_typeBytes,0,grow_typeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attr = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int typesCount;
typesCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
types = new List<int>(typesCount);
for (int i = 0; i < typesCount; i++){
types.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int hit_effects_1Count;
hit_effects_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hit_effects_1 = new List<Syshit_effect>(hit_effects_1Count);
for (int i = 0; i < hit_effects_1Count; i++){
hit_effects_1.Add(new Syshit_effect());offset = hit_effects_1[i].Deserializer(bytes,offset);
}
hit_sound_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int buffs_1Count;
buffs_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffs_1 = new List<int>(buffs_1Count);
for (int i = 0; i < buffs_1Count; i++){
buffs_1.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int extra_hurts_1Count;
extra_hurts_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
extra_hurts_1 = new List<Sysextra_hurt>(extra_hurts_1Count);
for (int i = 0; i < extra_hurts_1Count; i++){
extra_hurts_1.Add(new Sysextra_hurt());offset = extra_hurts_1[i].Deserializer(bytes,offset);
}

int hit_effects_2Count;
hit_effects_2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hit_effects_2 = new List<Syshit_effect>(hit_effects_2Count);
for (int i = 0; i < hit_effects_2Count; i++){
hit_effects_2.Add(new Syshit_effect());offset = hit_effects_2[i].Deserializer(bytes,offset);
}
hit_sound_2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int buffs_2Count;
buffs_2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffs_2 = new List<int>(buffs_2Count);
for (int i = 0; i < buffs_2Count; i++){
buffs_2.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int extra_hurts_2Count;
extra_hurts_2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
extra_hurts_2 = new List<Sysextra_hurt>(extra_hurts_2Count);
for (int i = 0; i < extra_hurts_2Count; i++){
extra_hurts_2.Add(new Sysextra_hurt());offset = extra_hurts_2[i].Deserializer(bytes,offset);
}

int hit_effects_3Count;
hit_effects_3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hit_effects_3 = new List<Syshit_effect>(hit_effects_3Count);
for (int i = 0; i < hit_effects_3Count; i++){
hit_effects_3.Add(new Syshit_effect());offset = hit_effects_3[i].Deserializer(bytes,offset);
}
hit_sound_3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int buffs_3Count;
buffs_3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffs_3 = new List<int>(buffs_3Count);
for (int i = 0; i < buffs_3Count; i++){
buffs_3.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int extra_hurts_3Count;
extra_hurts_3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
extra_hurts_3 = new List<Sysextra_hurt>(extra_hurts_3Count);
for (int i = 0; i < extra_hurts_3Count; i++){
extra_hurts_3.Add(new Sysextra_hurt());offset = extra_hurts_3[i].Deserializer(bytes,offset);
}

int attach_affects_1Count;
attach_affects_1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attach_affects_1 = new List<int>(attach_affects_1Count);
for (int i = 0; i < attach_affects_1Count; i++){
attach_affects_1.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int attach_affects_2Count;
attach_affects_2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attach_affects_2 = new List<int>(attach_affects_2Count);
for (int i = 0; i < attach_affects_2Count; i++){
attach_affects_2.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int attach_affects_3Count;
attach_affects_3Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
attach_affects_3 = new List<int>(attach_affects_3Count);
for (int i = 0; i < attach_affects_3Count; i++){
attach_affects_3.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
grow_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_ai
    {
		public string unikey;
		public int id; //技能id
		public string name; //技能名
		public int priority; //优先级别
		public int aiMode; //ai类型
		public List<int> self_conditions; //自身条件
		public List<Sysskill_locktarget> autoLockTarget; //自动锁定目标
		public List<Sysskill_locktarget> autoLockTarget_pvp; //自动锁定目标
		public List<Sysskill_locktarget> aiLockTarget; //AI锁定目标
		public int moveType; //技能过程中移动类型
		public int weight; //权重
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] priorityBytes = BitConverter.GetBytes(priority);
            ms.Write(priorityBytes,0,priorityBytes.Length);
byte[] aiModeBytes = BitConverter.GetBytes(aiMode);
            ms.Write(aiModeBytes,0,aiModeBytes.Length);
if(self_conditions==null)self_conditions = new List<int>();
byte[] self_conditionsCountBytes = BitConverter.GetBytes(self_conditions.Count);
            ms.Write(self_conditionsCountBytes,0,self_conditionsCountBytes.Length);
for (int i = 0; i < self_conditions.Count; i++){
byte[] self_conditionsBytes = BitConverter.GetBytes(self_conditions[i]);
            ms.Write(self_conditionsBytes,0,self_conditionsBytes.Length);
}
if(autoLockTarget==null)autoLockTarget = new List<Sysskill_locktarget>();
byte[] autoLockTargetCountBytes = BitConverter.GetBytes(autoLockTarget.Count);
            ms.Write(autoLockTargetCountBytes,0,autoLockTargetCountBytes.Length);
for (int i = 0; i < autoLockTarget.Count; i++){
if(autoLockTarget[i] == null)autoLockTarget[i] = new Sysskill_locktarget();autoLockTarget[i].Serializer(ms);
}
if(autoLockTarget_pvp==null)autoLockTarget_pvp = new List<Sysskill_locktarget>();
byte[] autoLockTarget_pvpCountBytes = BitConverter.GetBytes(autoLockTarget_pvp.Count);
            ms.Write(autoLockTarget_pvpCountBytes,0,autoLockTarget_pvpCountBytes.Length);
for (int i = 0; i < autoLockTarget_pvp.Count; i++){
if(autoLockTarget_pvp[i] == null)autoLockTarget_pvp[i] = new Sysskill_locktarget();autoLockTarget_pvp[i].Serializer(ms);
}
if(aiLockTarget==null)aiLockTarget = new List<Sysskill_locktarget>();
byte[] aiLockTargetCountBytes = BitConverter.GetBytes(aiLockTarget.Count);
            ms.Write(aiLockTargetCountBytes,0,aiLockTargetCountBytes.Length);
for (int i = 0; i < aiLockTarget.Count; i++){
if(aiLockTarget[i] == null)aiLockTarget[i] = new Sysskill_locktarget();aiLockTarget[i].Serializer(ms);
}
byte[] moveTypeBytes = BitConverter.GetBytes(moveType);
            ms.Write(moveTypeBytes,0,moveTypeBytes.Length);
byte[] weightBytes = BitConverter.GetBytes(weight);
            ms.Write(weightBytes,0,weightBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
priority = BitConverter.ToInt32(bytes, offset);
            offset += 4;
aiMode = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int self_conditionsCount;
self_conditionsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
self_conditions = new List<int>(self_conditionsCount);
for (int i = 0; i < self_conditionsCount; i++){
self_conditions.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int autoLockTargetCount;
autoLockTargetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
autoLockTarget = new List<Sysskill_locktarget>(autoLockTargetCount);
for (int i = 0; i < autoLockTargetCount; i++){
autoLockTarget.Add(new Sysskill_locktarget());offset = autoLockTarget[i].Deserializer(bytes,offset);
}

int autoLockTarget_pvpCount;
autoLockTarget_pvpCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
autoLockTarget_pvp = new List<Sysskill_locktarget>(autoLockTarget_pvpCount);
for (int i = 0; i < autoLockTarget_pvpCount; i++){
autoLockTarget_pvp.Add(new Sysskill_locktarget());offset = autoLockTarget_pvp[i].Deserializer(bytes,offset);
}

int aiLockTargetCount;
aiLockTargetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
aiLockTarget = new List<Sysskill_locktarget>(aiLockTargetCount);
for (int i = 0; i < aiLockTargetCount; i++){
aiLockTarget.Add(new Sysskill_locktarget());offset = aiLockTarget[i].Deserializer(bytes,offset);
}
moveType = BitConverter.ToInt32(bytes, offset);
            offset += 4;
weight = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_attribute
    {
		public string unikey;
		public int id; //技能效果id
		public string name; //效果名称
		public int formula_1; //计算公式类型
		public int high_affect_1; //是否触发高阶效果
		public float grow_1; //额外伤害系数（新）
		public float perhp_1; //按生命的百分比造成伤害（加血）
		public float basehurt_1; //技能固定伤害（加血）
		public float basehurt_add_1; //基础伤害系数（新）
		public float add_1; //技能伤害系数（新）
		public float patk_1; //攻击系数
		public float matk_1; //法强系数
		public float def_1; //护甲系数or魔抗系数
		public int formula_2; //计算公式类型
		public int high_affect_2; //是否触发高阶效果
		public float grow_2; //额外伤害系数（新）
		public float perhp_2; //按生命的百分比造成伤害（加血）
		public float basehurt_2; //技能固定伤害（加血）
		public float basehurt_add_2; //基础伤害系数（新）
		public float add_2; //技能伤害系数（新）
		public float patk_2; //攻击系数
		public float matk_2; //法强系数
		public float def_2; //护甲系数or魔抗系数
		public int formula_3; //计算公式类型
		public int high_affect_3; //是否触发高阶效果
		public float grow_3; //额外伤害系数（新）
		public float perhp_3; //按生命的百分比造成伤害（加血）
		public float basehurt_3; //技能固定伤害（加血）
		public float basehurt_add_3; //基础伤害系数（新）
		public float add_3; //技能伤害系数（新）
		public float patk_3; //攻击系数
		public float matk_3; //法强系数
		public float def_3; //护甲系数or魔抗系数
		public int base_attribute; //参考属性
		public int is_atk_perhp_1; //是否依据施法者的血量
		public int is_atk_perhp_2; //是否依据施法者的血量
		public int is_atk_perhp_3; //是否依据施法者的血量
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] formula_1Bytes = BitConverter.GetBytes(formula_1);
            ms.Write(formula_1Bytes,0,formula_1Bytes.Length);
byte[] high_affect_1Bytes = BitConverter.GetBytes(high_affect_1);
            ms.Write(high_affect_1Bytes,0,high_affect_1Bytes.Length);
byte[] grow_1Bytes = BitConverter.GetBytes(grow_1);
            ms.Write(grow_1Bytes,0,grow_1Bytes.Length);
byte[] perhp_1Bytes = BitConverter.GetBytes(perhp_1);
            ms.Write(perhp_1Bytes,0,perhp_1Bytes.Length);
byte[] basehurt_1Bytes = BitConverter.GetBytes(basehurt_1);
            ms.Write(basehurt_1Bytes,0,basehurt_1Bytes.Length);
byte[] basehurt_add_1Bytes = BitConverter.GetBytes(basehurt_add_1);
            ms.Write(basehurt_add_1Bytes,0,basehurt_add_1Bytes.Length);
byte[] add_1Bytes = BitConverter.GetBytes(add_1);
            ms.Write(add_1Bytes,0,add_1Bytes.Length);
byte[] patk_1Bytes = BitConverter.GetBytes(patk_1);
            ms.Write(patk_1Bytes,0,patk_1Bytes.Length);
byte[] matk_1Bytes = BitConverter.GetBytes(matk_1);
            ms.Write(matk_1Bytes,0,matk_1Bytes.Length);
byte[] def_1Bytes = BitConverter.GetBytes(def_1);
            ms.Write(def_1Bytes,0,def_1Bytes.Length);
byte[] formula_2Bytes = BitConverter.GetBytes(formula_2);
            ms.Write(formula_2Bytes,0,formula_2Bytes.Length);
byte[] high_affect_2Bytes = BitConverter.GetBytes(high_affect_2);
            ms.Write(high_affect_2Bytes,0,high_affect_2Bytes.Length);
byte[] grow_2Bytes = BitConverter.GetBytes(grow_2);
            ms.Write(grow_2Bytes,0,grow_2Bytes.Length);
byte[] perhp_2Bytes = BitConverter.GetBytes(perhp_2);
            ms.Write(perhp_2Bytes,0,perhp_2Bytes.Length);
byte[] basehurt_2Bytes = BitConverter.GetBytes(basehurt_2);
            ms.Write(basehurt_2Bytes,0,basehurt_2Bytes.Length);
byte[] basehurt_add_2Bytes = BitConverter.GetBytes(basehurt_add_2);
            ms.Write(basehurt_add_2Bytes,0,basehurt_add_2Bytes.Length);
byte[] add_2Bytes = BitConverter.GetBytes(add_2);
            ms.Write(add_2Bytes,0,add_2Bytes.Length);
byte[] patk_2Bytes = BitConverter.GetBytes(patk_2);
            ms.Write(patk_2Bytes,0,patk_2Bytes.Length);
byte[] matk_2Bytes = BitConverter.GetBytes(matk_2);
            ms.Write(matk_2Bytes,0,matk_2Bytes.Length);
byte[] def_2Bytes = BitConverter.GetBytes(def_2);
            ms.Write(def_2Bytes,0,def_2Bytes.Length);
byte[] formula_3Bytes = BitConverter.GetBytes(formula_3);
            ms.Write(formula_3Bytes,0,formula_3Bytes.Length);
byte[] high_affect_3Bytes = BitConverter.GetBytes(high_affect_3);
            ms.Write(high_affect_3Bytes,0,high_affect_3Bytes.Length);
byte[] grow_3Bytes = BitConverter.GetBytes(grow_3);
            ms.Write(grow_3Bytes,0,grow_3Bytes.Length);
byte[] perhp_3Bytes = BitConverter.GetBytes(perhp_3);
            ms.Write(perhp_3Bytes,0,perhp_3Bytes.Length);
byte[] basehurt_3Bytes = BitConverter.GetBytes(basehurt_3);
            ms.Write(basehurt_3Bytes,0,basehurt_3Bytes.Length);
byte[] basehurt_add_3Bytes = BitConverter.GetBytes(basehurt_add_3);
            ms.Write(basehurt_add_3Bytes,0,basehurt_add_3Bytes.Length);
byte[] add_3Bytes = BitConverter.GetBytes(add_3);
            ms.Write(add_3Bytes,0,add_3Bytes.Length);
byte[] patk_3Bytes = BitConverter.GetBytes(patk_3);
            ms.Write(patk_3Bytes,0,patk_3Bytes.Length);
byte[] matk_3Bytes = BitConverter.GetBytes(matk_3);
            ms.Write(matk_3Bytes,0,matk_3Bytes.Length);
byte[] def_3Bytes = BitConverter.GetBytes(def_3);
            ms.Write(def_3Bytes,0,def_3Bytes.Length);
byte[] base_attributeBytes = BitConverter.GetBytes(base_attribute);
            ms.Write(base_attributeBytes,0,base_attributeBytes.Length);
byte[] is_atk_perhp_1Bytes = BitConverter.GetBytes(is_atk_perhp_1);
            ms.Write(is_atk_perhp_1Bytes,0,is_atk_perhp_1Bytes.Length);
byte[] is_atk_perhp_2Bytes = BitConverter.GetBytes(is_atk_perhp_2);
            ms.Write(is_atk_perhp_2Bytes,0,is_atk_perhp_2Bytes.Length);
byte[] is_atk_perhp_3Bytes = BitConverter.GetBytes(is_atk_perhp_3);
            ms.Write(is_atk_perhp_3Bytes,0,is_atk_perhp_3Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
formula_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
high_affect_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
grow_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
perhp_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_add_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
add_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
def_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
formula_2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
high_affect_2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
grow_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
perhp_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_add_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
add_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
def_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
formula_3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
high_affect_3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
grow_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
perhp_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
basehurt_add_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
add_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
def_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
base_attribute = BitConverter.ToInt32(bytes, offset);
            offset += 4;
is_atk_perhp_1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
is_atk_perhp_2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
is_atk_perhp_3 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_effect
    {
		public string unikey;
		public int id; //特效id
		public string name; //特效名称
		public string path; //路径
		public int closeWhenInterrupt; //当技能被打断时是否关闭
		public int closeWhenActorDead; //当技能被打断时是否关闭
		public string startPoint; //弹道发射节点
		public float flySpeed; //弹道技能的飞行速度
		public int flyMode; //飞行模式
		public float flyHeight; //抛物线高度比例
		public int bulletCount; //子弹的数量
		public float ejectionRadius; //弹射半径
		public int startSound; //起手音效
		public int mainSound; //主音效
		public int endSound; //收尾音效
		public string bulletClass; //弹道类型
		public string logicClass; //特效逻辑类名
		public int startShake; //起手特效震动
		public int mainShake; //主特效震动
		public int endShake; //收尾特效震动
		public int show_in_melee; //是否在对战中屏蔽
		public int yujing_effect; //预警特效
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(path))path = string.Empty;
            byte[] pathBytes = System.Text.Encoding.UTF8.GetBytes(path);
            byte[] pathBytesLen = BitConverter.GetBytes(pathBytes.Length);
            ms.Write(pathBytesLen, 0, pathBytesLen.Length);
            ms.Write(pathBytes, 0, pathBytes.Length);
byte[] closeWhenInterruptBytes = BitConverter.GetBytes(closeWhenInterrupt);
            ms.Write(closeWhenInterruptBytes,0,closeWhenInterruptBytes.Length);
byte[] closeWhenActorDeadBytes = BitConverter.GetBytes(closeWhenActorDead);
            ms.Write(closeWhenActorDeadBytes,0,closeWhenActorDeadBytes.Length);
if(string.IsNullOrEmpty(startPoint))startPoint = string.Empty;
            byte[] startPointBytes = System.Text.Encoding.UTF8.GetBytes(startPoint);
            byte[] startPointBytesLen = BitConverter.GetBytes(startPointBytes.Length);
            ms.Write(startPointBytesLen, 0, startPointBytesLen.Length);
            ms.Write(startPointBytes, 0, startPointBytes.Length);
byte[] flySpeedBytes = BitConverter.GetBytes(flySpeed);
            ms.Write(flySpeedBytes,0,flySpeedBytes.Length);
byte[] flyModeBytes = BitConverter.GetBytes(flyMode);
            ms.Write(flyModeBytes,0,flyModeBytes.Length);
byte[] flyHeightBytes = BitConverter.GetBytes(flyHeight);
            ms.Write(flyHeightBytes,0,flyHeightBytes.Length);
byte[] bulletCountBytes = BitConverter.GetBytes(bulletCount);
            ms.Write(bulletCountBytes,0,bulletCountBytes.Length);
byte[] ejectionRadiusBytes = BitConverter.GetBytes(ejectionRadius);
            ms.Write(ejectionRadiusBytes,0,ejectionRadiusBytes.Length);
byte[] startSoundBytes = BitConverter.GetBytes(startSound);
            ms.Write(startSoundBytes,0,startSoundBytes.Length);
byte[] mainSoundBytes = BitConverter.GetBytes(mainSound);
            ms.Write(mainSoundBytes,0,mainSoundBytes.Length);
byte[] endSoundBytes = BitConverter.GetBytes(endSound);
            ms.Write(endSoundBytes,0,endSoundBytes.Length);
if(string.IsNullOrEmpty(bulletClass))bulletClass = string.Empty;
            byte[] bulletClassBytes = System.Text.Encoding.UTF8.GetBytes(bulletClass);
            byte[] bulletClassBytesLen = BitConverter.GetBytes(bulletClassBytes.Length);
            ms.Write(bulletClassBytesLen, 0, bulletClassBytesLen.Length);
            ms.Write(bulletClassBytes, 0, bulletClassBytes.Length);
if(string.IsNullOrEmpty(logicClass))logicClass = string.Empty;
            byte[] logicClassBytes = System.Text.Encoding.UTF8.GetBytes(logicClass);
            byte[] logicClassBytesLen = BitConverter.GetBytes(logicClassBytes.Length);
            ms.Write(logicClassBytesLen, 0, logicClassBytesLen.Length);
            ms.Write(logicClassBytes, 0, logicClassBytes.Length);
byte[] startShakeBytes = BitConverter.GetBytes(startShake);
            ms.Write(startShakeBytes,0,startShakeBytes.Length);
byte[] mainShakeBytes = BitConverter.GetBytes(mainShake);
            ms.Write(mainShakeBytes,0,mainShakeBytes.Length);
byte[] endShakeBytes = BitConverter.GetBytes(endShake);
            ms.Write(endShakeBytes,0,endShakeBytes.Length);
byte[] show_in_meleeBytes = BitConverter.GetBytes(show_in_melee);
            ms.Write(show_in_meleeBytes,0,show_in_meleeBytes.Length);
byte[] yujing_effectBytes = BitConverter.GetBytes(yujing_effect);
            ms.Write(yujing_effectBytes,0,yujing_effectBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int path_count;path_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;path = System.Text.Encoding.UTF8.GetString(bytes, offset, path_count);offset += path_count;
closeWhenInterrupt = BitConverter.ToInt32(bytes, offset);
            offset += 4;
closeWhenActorDead = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int startPoint_count;startPoint_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;startPoint = System.Text.Encoding.UTF8.GetString(bytes, offset, startPoint_count);offset += startPoint_count;
flySpeed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
flyMode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
flyHeight = BitConverter.ToSingle(bytes, offset);
            offset += 4;
bulletCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ejectionRadius = BitConverter.ToSingle(bytes, offset);
            offset += 4;
startSound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mainSound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
endSound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int bulletClass_count;bulletClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bulletClass = System.Text.Encoding.UTF8.GetString(bytes, offset, bulletClass_count);offset += bulletClass_count;
int logicClass_count;logicClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;logicClass = System.Text.Encoding.UTF8.GetString(bytes, offset, logicClass_count);offset += logicClass_count;
startShake = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mainShake = BitConverter.ToInt32(bytes, offset);
            offset += 4;
endShake = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_in_melee = BitConverter.ToInt32(bytes, offset);
            offset += 4;
yujing_effect = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_grow
    {
		public string unikey;
		public int id; //技能id
		public int lv; //技能等级
		public float cd; //冷却
		public float hurt_1; //伤害1
		public float hurt_2; //伤害2
		public float hurt_3; //伤害3
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] cdBytes = BitConverter.GetBytes(cd);
            ms.Write(cdBytes,0,cdBytes.Length);
byte[] hurt_1Bytes = BitConverter.GetBytes(hurt_1);
            ms.Write(hurt_1Bytes,0,hurt_1Bytes.Length);
byte[] hurt_2Bytes = BitConverter.GetBytes(hurt_2);
            ms.Write(hurt_2Bytes,0,hurt_2Bytes.Length);
byte[] hurt_3Bytes = BitConverter.GetBytes(hurt_3);
            ms.Write(hurt_3Bytes,0,hurt_3Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cd = BitConverter.ToSingle(bytes, offset);
            offset += 4;
hurt_1 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
hurt_2 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
hurt_3 = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_hero_use
    {
		public string unikey;
		public int id; //英雄星级
		public int lv; //技能等级
		public int need_coin; //升级技能消耗
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] need_coinBytes = BitConverter.GetBytes(need_coin);
            ms.Write(need_coinBytes,0,need_coinBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_locktarget
    {
		public int id; //id
		public string name; //名字
		public List<int> lockConditions; //锁定目标条件
		public int selectMode; //刷选模式
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(lockConditions==null)lockConditions = new List<int>();
byte[] lockConditionsCountBytes = BitConverter.GetBytes(lockConditions.Count);
            ms.Write(lockConditionsCountBytes,0,lockConditionsCountBytes.Length);
for (int i = 0; i < lockConditions.Count; i++){
byte[] lockConditionsBytes = BitConverter.GetBytes(lockConditions[i]);
            ms.Write(lockConditionsBytes,0,lockConditionsBytes.Length);
}
byte[] selectModeBytes = BitConverter.GetBytes(selectMode);
            ms.Write(selectModeBytes,0,selectModeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;

int lockConditionsCount;
lockConditionsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lockConditions = new List<int>(lockConditionsCount);
for (int i = 0; i < lockConditionsCount; i++){
lockConditions.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
selectMode = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_player
    {
		public string unikey;
		public int id; //召唤师技能id
		public string icon; //图标
		public string name; //技能名字
		public string desc; //技能描述
		public int level; //可激活等级
		public int max_level; //最高可升级别
		public int player_skill_point_need; //激活需要的供奉点
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] levelBytes = BitConverter.GetBytes(level);
            ms.Write(levelBytes,0,levelBytes.Length);
byte[] max_levelBytes = BitConverter.GetBytes(max_level);
            ms.Write(max_levelBytes,0,max_levelBytes.Length);
byte[] player_skill_point_needBytes = BitConverter.GetBytes(player_skill_point_need);
            ms.Write(player_skill_point_needBytes,0,player_skill_point_needBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
player_skill_point_need = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_player_up
    {
		public string unikey;
		public int id; //技能id
		public int lv; //技能等级
		public int need_skill_point; //升级技能消耗技能点
		public int need_coin; //升级技能消耗金币
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] need_skill_pointBytes = BitConverter.GetBytes(need_skill_point);
            ms.Write(need_skill_pointBytes,0,need_skill_pointBytes.Length);
byte[] need_coinBytes = BitConverter.GetBytes(need_coin);
            ms.Write(need_coinBytes,0,need_coinBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_skill_point = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysskill_to_child
    {
		public string unikey;
		public int id; //技能id
		public string name; //技能名
		public string icon; //
		public List<int> child; //技能分段
		public int pos; //技能位置
		public string grow_desc; //技能升级描述
		public int star; //激活需要的星级
		public string desc; //技能描述
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(child==null)child = new List<int>();
byte[] childCountBytes = BitConverter.GetBytes(child.Count);
            ms.Write(childCountBytes,0,childCountBytes.Length);
for (int i = 0; i < child.Count; i++){
byte[] childBytes = BitConverter.GetBytes(child[i]);
            ms.Write(childBytes,0,childBytes.Length);
}
byte[] posBytes = BitConverter.GetBytes(pos);
            ms.Write(posBytes,0,posBytes.Length);
if(string.IsNullOrEmpty(grow_desc))grow_desc = string.Empty;
            byte[] grow_descBytes = System.Text.Encoding.UTF8.GetBytes(grow_desc);
            byte[] grow_descBytesLen = BitConverter.GetBytes(grow_descBytes.Length);
            ms.Write(grow_descBytesLen, 0, grow_descBytesLen.Length);
            ms.Write(grow_descBytes, 0, grow_descBytes.Length);
byte[] starBytes = BitConverter.GetBytes(star);
            ms.Write(starBytes,0,starBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;

int childCount;
childCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
child = new List<int>(childCount);
for (int i = 0; i < childCount; i++){
child.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
pos = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int grow_desc_count;grow_desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;grow_desc = System.Text.Encoding.UTF8.GetString(bytes, offset, grow_desc_count);offset += grow_desc_count;
star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
return offset;
        }
} 
 [Serializable]public class Syssoul_calculate
    {
		public int hero1; //击杀英雄
		public int soldier1; //击杀小兵
		public int tower1; //击杀防御塔
		public int elite1; //击杀精英怪
		public int monster1; //击杀野怪
		public int hero2; //被英雄杀
		public int soldier2; //被小兵杀
		public int tower2; //被防御塔杀
		public int elite2; //被精英怪杀
		public int monster2; //被野怪杀
		public int assistant1; //助攻
    public void Serializer(MemoryStream ms){

byte[] hero1Bytes = BitConverter.GetBytes(hero1);
            ms.Write(hero1Bytes,0,hero1Bytes.Length);
byte[] soldier1Bytes = BitConverter.GetBytes(soldier1);
            ms.Write(soldier1Bytes,0,soldier1Bytes.Length);
byte[] tower1Bytes = BitConverter.GetBytes(tower1);
            ms.Write(tower1Bytes,0,tower1Bytes.Length);
byte[] elite1Bytes = BitConverter.GetBytes(elite1);
            ms.Write(elite1Bytes,0,elite1Bytes.Length);
byte[] monster1Bytes = BitConverter.GetBytes(monster1);
            ms.Write(monster1Bytes,0,monster1Bytes.Length);
byte[] hero2Bytes = BitConverter.GetBytes(hero2);
            ms.Write(hero2Bytes,0,hero2Bytes.Length);
byte[] soldier2Bytes = BitConverter.GetBytes(soldier2);
            ms.Write(soldier2Bytes,0,soldier2Bytes.Length);
byte[] tower2Bytes = BitConverter.GetBytes(tower2);
            ms.Write(tower2Bytes,0,tower2Bytes.Length);
byte[] elite2Bytes = BitConverter.GetBytes(elite2);
            ms.Write(elite2Bytes,0,elite2Bytes.Length);
byte[] monster2Bytes = BitConverter.GetBytes(monster2);
            ms.Write(monster2Bytes,0,monster2Bytes.Length);
byte[] assistant1Bytes = BitConverter.GetBytes(assistant1);
            ms.Write(assistant1Bytes,0,assistant1Bytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

hero1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
soldier1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tower1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
elite1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hero2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
soldier2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tower2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
elite2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
monster2 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
assistant1 = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syssound
    {
		public string unikey;
		public int id; //音效
		public string name; //音效文件名称
		public int loop; //是否循环播放
		public int distance; //最大距离
		public int min_distance; //最小距离
		public int volume; //最高音量
		public int type; //声音类型
		public int fade_time; //淡入淡出时间(毫秒)
		public int next_sound; //下一首
		public int sub_type; //子类型
		public int priority; //优先权
		public int sound_3d; //3d音效
		public int play_time; //播放时长（毫秒*100）
		public int need_pause; //暂停播放
		public int forbid_click; //屏蔽点击
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] loopBytes = BitConverter.GetBytes(loop);
            ms.Write(loopBytes,0,loopBytes.Length);
byte[] distanceBytes = BitConverter.GetBytes(distance);
            ms.Write(distanceBytes,0,distanceBytes.Length);
byte[] min_distanceBytes = BitConverter.GetBytes(min_distance);
            ms.Write(min_distanceBytes,0,min_distanceBytes.Length);
byte[] volumeBytes = BitConverter.GetBytes(volume);
            ms.Write(volumeBytes,0,volumeBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] fade_timeBytes = BitConverter.GetBytes(fade_time);
            ms.Write(fade_timeBytes,0,fade_timeBytes.Length);
byte[] next_soundBytes = BitConverter.GetBytes(next_sound);
            ms.Write(next_soundBytes,0,next_soundBytes.Length);
byte[] sub_typeBytes = BitConverter.GetBytes(sub_type);
            ms.Write(sub_typeBytes,0,sub_typeBytes.Length);
byte[] priorityBytes = BitConverter.GetBytes(priority);
            ms.Write(priorityBytes,0,priorityBytes.Length);
byte[] sound_3dBytes = BitConverter.GetBytes(sound_3d);
            ms.Write(sound_3dBytes,0,sound_3dBytes.Length);
byte[] play_timeBytes = BitConverter.GetBytes(play_time);
            ms.Write(play_timeBytes,0,play_timeBytes.Length);
byte[] need_pauseBytes = BitConverter.GetBytes(need_pause);
            ms.Write(need_pauseBytes,0,need_pauseBytes.Length);
byte[] forbid_clickBytes = BitConverter.GetBytes(forbid_click);
            ms.Write(forbid_clickBytes,0,forbid_clickBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
loop = BitConverter.ToInt32(bytes, offset);
            offset += 4;
distance = BitConverter.ToInt32(bytes, offset);
            offset += 4;
min_distance = BitConverter.ToInt32(bytes, offset);
            offset += 4;
volume = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fade_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_sound = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sub_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
priority = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sound_3d = BitConverter.ToInt32(bytes, offset);
            offset += 4;
play_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
need_pause = BitConverter.ToInt32(bytes, offset);
            offset += 4;
forbid_click = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysspecial_word
    {
		public string unikey;
		public int id; //索引
		public string word; //词汇
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(word))word = string.Empty;
            byte[] wordBytes = System.Text.Encoding.UTF8.GetBytes(word);
            byte[] wordBytesLen = BitConverter.GetBytes(wordBytes.Length);
            ms.Write(wordBytesLen, 0, wordBytesLen.Length);
            ms.Write(wordBytes, 0, wordBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int word_count;word_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;word = System.Text.Encoding.UTF8.GetString(bytes, offset, word_count);offset += word_count;
return offset;
        }
} 
 [Serializable]public class Sysstar_reward
    {
		public int goods_id; //物品ID
		public int number; //数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] numberBytes = BitConverter.GetBytes(number);
            ms.Write(numberBytes,0,numberBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
number = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysstar_rule
    {
		public int type; //类型
		public List<int> param1; //参数
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(param1==null)param1 = new List<int>();
byte[] param1CountBytes = BitConverter.GetBytes(param1.Count);
            ms.Write(param1CountBytes,0,param1CountBytes.Length);
for (int i = 0; i < param1.Count; i++){
byte[] param1Bytes = BitConverter.GetBytes(param1[i]);
            ms.Write(param1Bytes,0,param1Bytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int param1Count;
param1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
param1 = new List<int>(param1Count);
for (int i = 0; i < param1Count; i++){
param1.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysstory
    {
		public int index; //剧情id
		public List<int> trigger; //触发条件
		public List<int> dialog; //对话id
		public int pre_story; //前置剧情
		public List<int> sound; //音效
    public void Serializer(MemoryStream ms){

byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
if(trigger==null)trigger = new List<int>();
byte[] triggerCountBytes = BitConverter.GetBytes(trigger.Count);
            ms.Write(triggerCountBytes,0,triggerCountBytes.Length);
for (int i = 0; i < trigger.Count; i++){
byte[] triggerBytes = BitConverter.GetBytes(trigger[i]);
            ms.Write(triggerBytes,0,triggerBytes.Length);
}
if(dialog==null)dialog = new List<int>();
byte[] dialogCountBytes = BitConverter.GetBytes(dialog.Count);
            ms.Write(dialogCountBytes,0,dialogCountBytes.Length);
for (int i = 0; i < dialog.Count; i++){
byte[] dialogBytes = BitConverter.GetBytes(dialog[i]);
            ms.Write(dialogBytes,0,dialogBytes.Length);
}
byte[] pre_storyBytes = BitConverter.GetBytes(pre_story);
            ms.Write(pre_storyBytes,0,pre_storyBytes.Length);
if(sound==null)sound = new List<int>();
byte[] soundCountBytes = BitConverter.GetBytes(sound.Count);
            ms.Write(soundCountBytes,0,soundCountBytes.Length);
for (int i = 0; i < sound.Count; i++){
byte[] soundBytes = BitConverter.GetBytes(sound[i]);
            ms.Write(soundBytes,0,soundBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

index = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int triggerCount;
triggerCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
trigger = new List<int>(triggerCount);
for (int i = 0; i < triggerCount; i++){
trigger.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int dialogCount;
dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dialog = new List<int>(dialogCount);
for (int i = 0; i < dialogCount; i++){
dialog.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
pre_story = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int soundCount;
soundCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sound = new List<int>(soundCount);
for (int i = 0; i < soundCount; i++){
sound.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysstory_dialog
    {
		public string unikey;
		public int id; //剧情对话id
		public List<int> dialog; //对话列表
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(dialog==null)dialog = new List<int>();
byte[] dialogCountBytes = BitConverter.GetBytes(dialog.Count);
            ms.Write(dialogCountBytes,0,dialogCountBytes.Length);
for (int i = 0; i < dialog.Count; i++){
byte[] dialogBytes = BitConverter.GetBytes(dialog[i]);
            ms.Write(dialogBytes,0,dialogBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dialogCount;
dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dialog = new List<int>(dialogCount);
for (int i = 0; i < dialogCount; i++){
dialog.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Sysstruct
    {
		public int id; //物品ID
		public int num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systask
    {
		public string unikey;
		public int id; //任务id
		public int type; //任务类型
		public int show_type; //任务显示类型
		public string name; //任务名称
		public int showGuide; //是否主页指引
		public int color; //任务品质
		public int lv; //等级下限
		public int pre_id; //前置任务
		public List<int> next_id; //后置任务
		public int dungeon_open; //通关副本开启
		public List<Systask_content> target; //任务目标
		public List<int> begin_time; //起始时间
		public List<int> end_time; //结束时间
		public int auto_accept; //自动接取
		public int accept_npc; //接任务npc
		public List<int> accept_dialog; //接取任务对话
		public int pre_finish; //任务提前完成检查
		public int reward_type; //奖励领取方式
		public int recv_npc; //领取奖励npc
		public List<int> recv_dialog; //领取奖励对话
		public int exp; //经验
		public int coin; //金币
		public int gold; //钻石
		public List<Systask_goods> goods; //物品
		public string desc; //任务描述
		public string desc2; //任务描述2
		public string desc3; //任务描述3
		public string icon; //icon
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
byte[] show_typeBytes = BitConverter.GetBytes(show_type);
            ms.Write(show_typeBytes,0,show_typeBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
byte[] showGuideBytes = BitConverter.GetBytes(showGuide);
            ms.Write(showGuideBytes,0,showGuideBytes.Length);
byte[] colorBytes = BitConverter.GetBytes(color);
            ms.Write(colorBytes,0,colorBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] pre_idBytes = BitConverter.GetBytes(pre_id);
            ms.Write(pre_idBytes,0,pre_idBytes.Length);
if(next_id==null)next_id = new List<int>();
byte[] next_idCountBytes = BitConverter.GetBytes(next_id.Count);
            ms.Write(next_idCountBytes,0,next_idCountBytes.Length);
for (int i = 0; i < next_id.Count; i++){
byte[] next_idBytes = BitConverter.GetBytes(next_id[i]);
            ms.Write(next_idBytes,0,next_idBytes.Length);
}
byte[] dungeon_openBytes = BitConverter.GetBytes(dungeon_open);
            ms.Write(dungeon_openBytes,0,dungeon_openBytes.Length);
if(target==null)target = new List<Systask_content>();
byte[] targetCountBytes = BitConverter.GetBytes(target.Count);
            ms.Write(targetCountBytes,0,targetCountBytes.Length);
for (int i = 0; i < target.Count; i++){
if(target[i] == null)target[i] = new Systask_content();target[i].Serializer(ms);
}
if(begin_time==null)begin_time = new List<int>();
byte[] begin_timeCountBytes = BitConverter.GetBytes(begin_time.Count);
            ms.Write(begin_timeCountBytes,0,begin_timeCountBytes.Length);
for (int i = 0; i < begin_time.Count; i++){
byte[] begin_timeBytes = BitConverter.GetBytes(begin_time[i]);
            ms.Write(begin_timeBytes,0,begin_timeBytes.Length);
}
if(end_time==null)end_time = new List<int>();
byte[] end_timeCountBytes = BitConverter.GetBytes(end_time.Count);
            ms.Write(end_timeCountBytes,0,end_timeCountBytes.Length);
for (int i = 0; i < end_time.Count; i++){
byte[] end_timeBytes = BitConverter.GetBytes(end_time[i]);
            ms.Write(end_timeBytes,0,end_timeBytes.Length);
}
byte[] auto_acceptBytes = BitConverter.GetBytes(auto_accept);
            ms.Write(auto_acceptBytes,0,auto_acceptBytes.Length);
byte[] accept_npcBytes = BitConverter.GetBytes(accept_npc);
            ms.Write(accept_npcBytes,0,accept_npcBytes.Length);
if(accept_dialog==null)accept_dialog = new List<int>();
byte[] accept_dialogCountBytes = BitConverter.GetBytes(accept_dialog.Count);
            ms.Write(accept_dialogCountBytes,0,accept_dialogCountBytes.Length);
for (int i = 0; i < accept_dialog.Count; i++){
byte[] accept_dialogBytes = BitConverter.GetBytes(accept_dialog[i]);
            ms.Write(accept_dialogBytes,0,accept_dialogBytes.Length);
}
byte[] pre_finishBytes = BitConverter.GetBytes(pre_finish);
            ms.Write(pre_finishBytes,0,pre_finishBytes.Length);
byte[] reward_typeBytes = BitConverter.GetBytes(reward_type);
            ms.Write(reward_typeBytes,0,reward_typeBytes.Length);
byte[] recv_npcBytes = BitConverter.GetBytes(recv_npc);
            ms.Write(recv_npcBytes,0,recv_npcBytes.Length);
if(recv_dialog==null)recv_dialog = new List<int>();
byte[] recv_dialogCountBytes = BitConverter.GetBytes(recv_dialog.Count);
            ms.Write(recv_dialogCountBytes,0,recv_dialogCountBytes.Length);
for (int i = 0; i < recv_dialog.Count; i++){
byte[] recv_dialogBytes = BitConverter.GetBytes(recv_dialog[i]);
            ms.Write(recv_dialogBytes,0,recv_dialogBytes.Length);
}
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
if(goods==null)goods = new List<Systask_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Systask_goods();goods[i].Serializer(ms);
}
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(desc2))desc2 = string.Empty;
            byte[] desc2Bytes = System.Text.Encoding.UTF8.GetBytes(desc2);
            byte[] desc2BytesLen = BitConverter.GetBytes(desc2Bytes.Length);
            ms.Write(desc2BytesLen, 0, desc2BytesLen.Length);
            ms.Write(desc2Bytes, 0, desc2Bytes.Length);
if(string.IsNullOrEmpty(desc3))desc3 = string.Empty;
            byte[] desc3Bytes = System.Text.Encoding.UTF8.GetBytes(desc3);
            byte[] desc3BytesLen = BitConverter.GetBytes(desc3Bytes.Length);
            ms.Write(desc3BytesLen, 0, desc3BytesLen.Length);
            ms.Write(desc3Bytes, 0, desc3Bytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
show_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
showGuide = BitConverter.ToInt32(bytes, offset);
            offset += 4;
color = BitConverter.ToInt32(bytes, offset);
            offset += 4;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pre_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int next_idCount;
next_idCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
next_id = new List<int>(next_idCount);
for (int i = 0; i < next_idCount; i++){
next_id.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
dungeon_open = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int targetCount;
targetCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
target = new List<Systask_content>(targetCount);
for (int i = 0; i < targetCount; i++){
target.Add(new Systask_content());offset = target[i].Deserializer(bytes,offset);
}

int begin_timeCount;
begin_timeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
begin_time = new List<int>(begin_timeCount);
for (int i = 0; i < begin_timeCount; i++){
begin_time.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int end_timeCount;
end_timeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
end_time = new List<int>(end_timeCount);
for (int i = 0; i < end_timeCount; i++){
end_time.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
auto_accept = BitConverter.ToInt32(bytes, offset);
            offset += 4;
accept_npc = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int accept_dialogCount;
accept_dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
accept_dialog = new List<int>(accept_dialogCount);
for (int i = 0; i < accept_dialogCount; i++){
accept_dialog.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
pre_finish = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
recv_npc = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int recv_dialogCount;
recv_dialogCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
recv_dialog = new List<int>(recv_dialogCount);
for (int i = 0; i < recv_dialogCount; i++){
recv_dialog.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Systask_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Systask_goods());offset = goods[i].Deserializer(bytes,offset);
}
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int desc2_count;desc2_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc2 = System.Text.Encoding.UTF8.GetString(bytes, offset, desc2_count);offset += desc2_count;
int desc3_count;desc3_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc3 = System.Text.Encoding.UTF8.GetString(bytes, offset, desc3_count);offset += desc3_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
return offset;
        }
} 
 [Serializable]public class Systask_content
    {
		public int task_type; //任务目标
		public int task_target; //任务对象
		public int task_condition; //完成条件
    public void Serializer(MemoryStream ms){

byte[] task_typeBytes = BitConverter.GetBytes(task_type);
            ms.Write(task_typeBytes,0,task_typeBytes.Length);
byte[] task_targetBytes = BitConverter.GetBytes(task_target);
            ms.Write(task_targetBytes,0,task_targetBytes.Length);
byte[] task_conditionBytes = BitConverter.GetBytes(task_condition);
            ms.Write(task_conditionBytes,0,task_conditionBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

task_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
task_target = BitConverter.ToInt32(bytes, offset);
            offset += 4;
task_condition = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systask_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systeam_soul_calculate
    {
		public string unikey;
		public int index; //索引
		public int range; //有效范围
		public int kill; //击杀魂值
		public int assistant; //助攻魂值
		public List<int> for_killer; //击杀
		public List<int> for_team_mate; //友军击杀
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
byte[] rangeBytes = BitConverter.GetBytes(range);
            ms.Write(rangeBytes,0,rangeBytes.Length);
byte[] killBytes = BitConverter.GetBytes(kill);
            ms.Write(killBytes,0,killBytes.Length);
byte[] assistantBytes = BitConverter.GetBytes(assistant);
            ms.Write(assistantBytes,0,assistantBytes.Length);
if(for_killer==null)for_killer = new List<int>();
byte[] for_killerCountBytes = BitConverter.GetBytes(for_killer.Count);
            ms.Write(for_killerCountBytes,0,for_killerCountBytes.Length);
for (int i = 0; i < for_killer.Count; i++){
byte[] for_killerBytes = BitConverter.GetBytes(for_killer[i]);
            ms.Write(for_killerBytes,0,for_killerBytes.Length);
}
if(for_team_mate==null)for_team_mate = new List<int>();
byte[] for_team_mateCountBytes = BitConverter.GetBytes(for_team_mate.Count);
            ms.Write(for_team_mateCountBytes,0,for_team_mateCountBytes.Length);
for (int i = 0; i < for_team_mate.Count; i++){
byte[] for_team_mateBytes = BitConverter.GetBytes(for_team_mate[i]);
            ms.Write(for_team_mateBytes,0,for_team_mateBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
index = BitConverter.ToInt32(bytes, offset);
            offset += 4;
range = BitConverter.ToInt32(bytes, offset);
            offset += 4;
kill = BitConverter.ToInt32(bytes, offset);
            offset += 4;
assistant = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int for_killerCount;
for_killerCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
for_killer = new List<int>(for_killerCount);
for (int i = 0; i < for_killerCount; i++){
for_killer.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int for_team_mateCount;
for_team_mateCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
for_team_mate = new List<int>(for_team_mateCount);
for (int i = 0; i < for_team_mateCount; i++){
for_team_mate.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Systitle
    {
		public string unikey;
		public int id; //称号id
		public string name; //称号名称
		public string desc; //获得条件描述
		public string icon; //称号图标
		public string icon_small; //称号图标（小）
		public int type; //称号类别
		public List<int> condition; //匹配条件
		public int color; //等级
		public int hp; //生命
		public int patk; //攻击
		public int matk; //法强
		public int pdef; //护甲
		public int mdef; //魔抗
		public float cri_hurt; //暴击伤害
		public string bottom; //颜色渐变
		public string top; //颜色渐变
		public string effect; //特效
		public List<int> bufflist; //buff列表
		public List<string> buffdesc; //buff描述
		public string addition; //排行榜中显示的属性加成
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
if(string.IsNullOrEmpty(icon_small))icon_small = string.Empty;
            byte[] icon_smallBytes = System.Text.Encoding.UTF8.GetBytes(icon_small);
            byte[] icon_smallBytesLen = BitConverter.GetBytes(icon_smallBytes.Length);
            ms.Write(icon_smallBytesLen, 0, icon_smallBytesLen.Length);
            ms.Write(icon_smallBytes, 0, icon_smallBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(condition==null)condition = new List<int>();
byte[] conditionCountBytes = BitConverter.GetBytes(condition.Count);
            ms.Write(conditionCountBytes,0,conditionCountBytes.Length);
for (int i = 0; i < condition.Count; i++){
byte[] conditionBytes = BitConverter.GetBytes(condition[i]);
            ms.Write(conditionBytes,0,conditionBytes.Length);
}
byte[] colorBytes = BitConverter.GetBytes(color);
            ms.Write(colorBytes,0,colorBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
if(string.IsNullOrEmpty(bottom))bottom = string.Empty;
            byte[] bottomBytes = System.Text.Encoding.UTF8.GetBytes(bottom);
            byte[] bottomBytesLen = BitConverter.GetBytes(bottomBytes.Length);
            ms.Write(bottomBytesLen, 0, bottomBytesLen.Length);
            ms.Write(bottomBytes, 0, bottomBytes.Length);
if(string.IsNullOrEmpty(top))top = string.Empty;
            byte[] topBytes = System.Text.Encoding.UTF8.GetBytes(top);
            byte[] topBytesLen = BitConverter.GetBytes(topBytes.Length);
            ms.Write(topBytesLen, 0, topBytesLen.Length);
            ms.Write(topBytes, 0, topBytes.Length);
if(string.IsNullOrEmpty(effect))effect = string.Empty;
            byte[] effectBytes = System.Text.Encoding.UTF8.GetBytes(effect);
            byte[] effectBytesLen = BitConverter.GetBytes(effectBytes.Length);
            ms.Write(effectBytesLen, 0, effectBytesLen.Length);
            ms.Write(effectBytes, 0, effectBytes.Length);
if(bufflist==null)bufflist = new List<int>();
byte[] bufflistCountBytes = BitConverter.GetBytes(bufflist.Count);
            ms.Write(bufflistCountBytes,0,bufflistCountBytes.Length);
for (int i = 0; i < bufflist.Count; i++){
byte[] bufflistBytes = BitConverter.GetBytes(bufflist[i]);
            ms.Write(bufflistBytes,0,bufflistBytes.Length);
}
if(buffdesc==null)buffdesc = new List<string>();
byte[] buffdescCountBytes = BitConverter.GetBytes(buffdesc.Count);
            ms.Write(buffdescCountBytes,0,buffdescCountBytes.Length);
for (int i = 0; i < buffdesc.Count; i++){
if(string.IsNullOrEmpty(buffdesc[i]))buffdesc[i] = string.Empty;
            byte[] buffdescBytes = System.Text.Encoding.UTF8.GetBytes(buffdesc[i]);
            byte[] buffdescBytesLen = BitConverter.GetBytes(buffdescBytes.Length);
            ms.Write(buffdescBytesLen, 0, buffdescBytesLen.Length);
            ms.Write(buffdescBytes, 0, buffdescBytes.Length);
}
if(string.IsNullOrEmpty(addition))addition = string.Empty;
            byte[] additionBytes = System.Text.Encoding.UTF8.GetBytes(addition);
            byte[] additionBytesLen = BitConverter.GetBytes(additionBytes.Length);
            ms.Write(additionBytesLen, 0, additionBytesLen.Length);
            ms.Write(additionBytes, 0, additionBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
int icon_small_count;icon_small_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon_small = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_small_count);offset += icon_small_count;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int conditionCount;
conditionCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
condition = new List<int>(conditionCount);
for (int i = 0; i < conditionCount; i++){
condition.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
color = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
patk = BitConverter.ToInt32(bytes, offset);
            offset += 4;
matk = BitConverter.ToInt32(bytes, offset);
            offset += 4;
pdef = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int bottom_count;bottom_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bottom = System.Text.Encoding.UTF8.GetString(bytes, offset, bottom_count);offset += bottom_count;
int top_count;top_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;top = System.Text.Encoding.UTF8.GetString(bytes, offset, top_count);offset += top_count;
int effect_count;effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;effect = System.Text.Encoding.UTF8.GetString(bytes, offset, effect_count);offset += effect_count;

int bufflistCount;
bufflistCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bufflist = new List<int>(bufflistCount);
for (int i = 0; i < bufflistCount; i++){
bufflist.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int buffdescCount;
buffdescCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buffdesc = new List<string>(buffdescCount);
for (int i = 0; i < buffdescCount; i++){
int buffdesc_count;buffdesc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buffdesc.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, buffdesc_count));offset += buffdesc_count;
}
int addition_count;addition_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;addition = System.Text.Encoding.UTF8.GetString(bytes, offset, addition_count);offset += addition_count;
return offset;
        }
} 
 [Serializable]public class Systower
    {
		public int id; //子表id
		public int tower_id; //塔id
		public int is_base; //是否基地
		public int route; //所属路线路线
		public int index; //在所属路线中的顺序
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] tower_idBytes = BitConverter.GetBytes(tower_id);
            ms.Write(tower_idBytes,0,tower_idBytes.Length);
byte[] is_baseBytes = BitConverter.GetBytes(is_base);
            ms.Write(is_baseBytes,0,is_baseBytes.Length);
byte[] routeBytes = BitConverter.GetBytes(route);
            ms.Write(routeBytes,0,routeBytes.Length);
byte[] indexBytes = BitConverter.GetBytes(index);
            ms.Write(indexBytes,0,indexBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tower_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
is_base = BitConverter.ToInt32(bytes, offset);
            offset += 4;
route = BitConverter.ToInt32(bytes, offset);
            offset += 4;
index = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systower_attribute
    {
		public string unikey;
		public int id; //英雄id
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systower_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
		public int goods_rate; //物品概率
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
byte[] goods_rateBytes = BitConverter.GetBytes(goods_rate);
            ms.Write(goods_rateBytes,0,goods_rateBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_rate = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systower_layer
    {
		public string unikey;
		public int id; //关卡id
		public int type; //关卡类型
		public List<Systask_goods> common_goods; //通关奖励
		public List<Systower_goods> gold_goods; //宝箱奖励
		public List<int> mon_list; //怪物列表
		public List<int> buff_list; //buff列表
		public List<string> buff_effects; //buff的UI显示特效
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(common_goods==null)common_goods = new List<Systask_goods>();
byte[] common_goodsCountBytes = BitConverter.GetBytes(common_goods.Count);
            ms.Write(common_goodsCountBytes,0,common_goodsCountBytes.Length);
for (int i = 0; i < common_goods.Count; i++){
if(common_goods[i] == null)common_goods[i] = new Systask_goods();common_goods[i].Serializer(ms);
}
if(gold_goods==null)gold_goods = new List<Systower_goods>();
byte[] gold_goodsCountBytes = BitConverter.GetBytes(gold_goods.Count);
            ms.Write(gold_goodsCountBytes,0,gold_goodsCountBytes.Length);
for (int i = 0; i < gold_goods.Count; i++){
if(gold_goods[i] == null)gold_goods[i] = new Systower_goods();gold_goods[i].Serializer(ms);
}
if(mon_list==null)mon_list = new List<int>();
byte[] mon_listCountBytes = BitConverter.GetBytes(mon_list.Count);
            ms.Write(mon_listCountBytes,0,mon_listCountBytes.Length);
for (int i = 0; i < mon_list.Count; i++){
byte[] mon_listBytes = BitConverter.GetBytes(mon_list[i]);
            ms.Write(mon_listBytes,0,mon_listBytes.Length);
}
if(buff_list==null)buff_list = new List<int>();
byte[] buff_listCountBytes = BitConverter.GetBytes(buff_list.Count);
            ms.Write(buff_listCountBytes,0,buff_listCountBytes.Length);
for (int i = 0; i < buff_list.Count; i++){
byte[] buff_listBytes = BitConverter.GetBytes(buff_list[i]);
            ms.Write(buff_listBytes,0,buff_listBytes.Length);
}
if(buff_effects==null)buff_effects = new List<string>();
byte[] buff_effectsCountBytes = BitConverter.GetBytes(buff_effects.Count);
            ms.Write(buff_effectsCountBytes,0,buff_effectsCountBytes.Length);
for (int i = 0; i < buff_effects.Count; i++){
if(string.IsNullOrEmpty(buff_effects[i]))buff_effects[i] = string.Empty;
            byte[] buff_effectsBytes = System.Text.Encoding.UTF8.GetBytes(buff_effects[i]);
            byte[] buff_effectsBytesLen = BitConverter.GetBytes(buff_effectsBytes.Length);
            ms.Write(buff_effectsBytesLen, 0, buff_effectsBytesLen.Length);
            ms.Write(buff_effectsBytes, 0, buff_effectsBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int common_goodsCount;
common_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
common_goods = new List<Systask_goods>(common_goodsCount);
for (int i = 0; i < common_goodsCount; i++){
common_goods.Add(new Systask_goods());offset = common_goods[i].Deserializer(bytes,offset);
}

int gold_goodsCount;
gold_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_goods = new List<Systower_goods>(gold_goodsCount);
for (int i = 0; i < gold_goodsCount; i++){
gold_goods.Add(new Systower_goods());offset = gold_goods[i].Deserializer(bytes,offset);
}

int mon_listCount;
mon_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mon_list = new List<int>(mon_listCount);
for (int i = 0; i < mon_listCount; i++){
mon_list.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int buff_listCount;
buff_listCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buff_list = new List<int>(buff_listCount);
for (int i = 0; i < buff_listCount; i++){
buff_list.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int buff_effectsCount;
buff_effectsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buff_effects = new List<string>(buff_effectsCount);
for (int i = 0; i < buff_effectsCount; i++){
int buff_effects_count;buff_effects_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;buff_effects.Add(System.Text.Encoding.UTF8.GetString(bytes, offset, buff_effects_count));offset += buff_effects_count;
}
return offset;
        }
} 
 [Serializable]public class Systower_layer_add
    {
		public string unikey;
		public int id; //层级
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public int pdef_ignore; //忽略护甲%
		public int mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systower_lv_add
    {
		public string unikey;
		public int id; //账号等级
		public float hp; //生命
		public float patk; //攻击
		public float pdef; //护甲
		public float matk; //法强
		public float mdef; //魔抗
		public float ppenetrate; //护甲穿透
		public float mpenetrate; //法术穿透
		public float recover; //生命回复
		public float cri_odds; //物理暴击值
		public float cri_offset; //物理抗暴值
		public float mcri_odds; //法术暴击值
		public float mcri_offset; //法术抗暴值
		public float pconvert_life; //物理吸血%
		public float mconvert_life; //法术吸血%
		public float preturn_damage; //物理反伤%
		public float mreturn_damage; //法术反伤%
		public float cri_hurt; //暴击伤害%
		public float cri_resist; //暴伤减免%
		public float pdef_ignore; //忽略护甲%
		public float mdef_ignore; //忽略魔抗%
		public float tenacity; //韧性%
		public float atk_range; //攻击范围
		public float atk_speed; //攻速
		public float move_speed; //移速
		public List<int> star; //显示星级
		public List<int> quality; //显示品质
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] hpBytes = BitConverter.GetBytes(hp);
            ms.Write(hpBytes,0,hpBytes.Length);
byte[] patkBytes = BitConverter.GetBytes(patk);
            ms.Write(patkBytes,0,patkBytes.Length);
byte[] pdefBytes = BitConverter.GetBytes(pdef);
            ms.Write(pdefBytes,0,pdefBytes.Length);
byte[] matkBytes = BitConverter.GetBytes(matk);
            ms.Write(matkBytes,0,matkBytes.Length);
byte[] mdefBytes = BitConverter.GetBytes(mdef);
            ms.Write(mdefBytes,0,mdefBytes.Length);
byte[] ppenetrateBytes = BitConverter.GetBytes(ppenetrate);
            ms.Write(ppenetrateBytes,0,ppenetrateBytes.Length);
byte[] mpenetrateBytes = BitConverter.GetBytes(mpenetrate);
            ms.Write(mpenetrateBytes,0,mpenetrateBytes.Length);
byte[] recoverBytes = BitConverter.GetBytes(recover);
            ms.Write(recoverBytes,0,recoverBytes.Length);
byte[] cri_oddsBytes = BitConverter.GetBytes(cri_odds);
            ms.Write(cri_oddsBytes,0,cri_oddsBytes.Length);
byte[] cri_offsetBytes = BitConverter.GetBytes(cri_offset);
            ms.Write(cri_offsetBytes,0,cri_offsetBytes.Length);
byte[] mcri_oddsBytes = BitConverter.GetBytes(mcri_odds);
            ms.Write(mcri_oddsBytes,0,mcri_oddsBytes.Length);
byte[] mcri_offsetBytes = BitConverter.GetBytes(mcri_offset);
            ms.Write(mcri_offsetBytes,0,mcri_offsetBytes.Length);
byte[] pconvert_lifeBytes = BitConverter.GetBytes(pconvert_life);
            ms.Write(pconvert_lifeBytes,0,pconvert_lifeBytes.Length);
byte[] mconvert_lifeBytes = BitConverter.GetBytes(mconvert_life);
            ms.Write(mconvert_lifeBytes,0,mconvert_lifeBytes.Length);
byte[] preturn_damageBytes = BitConverter.GetBytes(preturn_damage);
            ms.Write(preturn_damageBytes,0,preturn_damageBytes.Length);
byte[] mreturn_damageBytes = BitConverter.GetBytes(mreturn_damage);
            ms.Write(mreturn_damageBytes,0,mreturn_damageBytes.Length);
byte[] cri_hurtBytes = BitConverter.GetBytes(cri_hurt);
            ms.Write(cri_hurtBytes,0,cri_hurtBytes.Length);
byte[] cri_resistBytes = BitConverter.GetBytes(cri_resist);
            ms.Write(cri_resistBytes,0,cri_resistBytes.Length);
byte[] pdef_ignoreBytes = BitConverter.GetBytes(pdef_ignore);
            ms.Write(pdef_ignoreBytes,0,pdef_ignoreBytes.Length);
byte[] mdef_ignoreBytes = BitConverter.GetBytes(mdef_ignore);
            ms.Write(mdef_ignoreBytes,0,mdef_ignoreBytes.Length);
byte[] tenacityBytes = BitConverter.GetBytes(tenacity);
            ms.Write(tenacityBytes,0,tenacityBytes.Length);
byte[] atk_rangeBytes = BitConverter.GetBytes(atk_range);
            ms.Write(atk_rangeBytes,0,atk_rangeBytes.Length);
byte[] atk_speedBytes = BitConverter.GetBytes(atk_speed);
            ms.Write(atk_speedBytes,0,atk_speedBytes.Length);
byte[] move_speedBytes = BitConverter.GetBytes(move_speed);
            ms.Write(move_speedBytes,0,move_speedBytes.Length);
if(star==null)star = new List<int>();
byte[] starCountBytes = BitConverter.GetBytes(star.Count);
            ms.Write(starCountBytes,0,starCountBytes.Length);
for (int i = 0; i < star.Count; i++){
byte[] starBytes = BitConverter.GetBytes(star[i]);
            ms.Write(starBytes,0,starBytes.Length);
}
if(quality==null)quality = new List<int>();
byte[] qualityCountBytes = BitConverter.GetBytes(quality.Count);
            ms.Write(qualityCountBytes,0,qualityCountBytes.Length);
for (int i = 0; i < quality.Count; i++){
byte[] qualityBytes = BitConverter.GetBytes(quality[i]);
            ms.Write(qualityBytes,0,qualityBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hp = BitConverter.ToSingle(bytes, offset);
            offset += 4;
patk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
matk = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef = BitConverter.ToSingle(bytes, offset);
            offset += 4;
ppenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mpenetrate = BitConverter.ToSingle(bytes, offset);
            offset += 4;
recover = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_odds = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mcri_offset = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mconvert_life = BitConverter.ToSingle(bytes, offset);
            offset += 4;
preturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mreturn_damage = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_hurt = BitConverter.ToSingle(bytes, offset);
            offset += 4;
cri_resist = BitConverter.ToSingle(bytes, offset);
            offset += 4;
pdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
mdef_ignore = BitConverter.ToSingle(bytes, offset);
            offset += 4;
tenacity = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
atk_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;
move_speed = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int starCount;
starCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
star = new List<int>(starCount);
for (int i = 0; i < starCount; i++){
star.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int qualityCount;
qualityCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
quality = new List<int>(qualityCount);
for (int i = 0; i < qualityCount; i++){
quality.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Systrap
    {
		public string unikey;
		public int id; //陷阱id
		public int ai; //ai
		public string model; //模型
		public float model_scale; //模型大小
		public string born_effect; //出生效果
		public List<int> skills; //技能 
		public float search_range; //视野范围
		public int attr_id; //属性模板id
		public int cg_group; //过场动画组
		public int loop; //周期
		public Systrap_switch my_switch; //开关
		public string actorClass; //逻辑类型
		public string actorType; //角色类型
		public List<Systrap_event> destroy_events; //摧毁事件
		public int career; //职业
		public int collider; //碰撞
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] aiBytes = BitConverter.GetBytes(ai);
            ms.Write(aiBytes,0,aiBytes.Length);
if(string.IsNullOrEmpty(model))model = string.Empty;
            byte[] modelBytes = System.Text.Encoding.UTF8.GetBytes(model);
            byte[] modelBytesLen = BitConverter.GetBytes(modelBytes.Length);
            ms.Write(modelBytesLen, 0, modelBytesLen.Length);
            ms.Write(modelBytes, 0, modelBytes.Length);
byte[] model_scaleBytes = BitConverter.GetBytes(model_scale);
            ms.Write(model_scaleBytes,0,model_scaleBytes.Length);
if(string.IsNullOrEmpty(born_effect))born_effect = string.Empty;
            byte[] born_effectBytes = System.Text.Encoding.UTF8.GetBytes(born_effect);
            byte[] born_effectBytesLen = BitConverter.GetBytes(born_effectBytes.Length);
            ms.Write(born_effectBytesLen, 0, born_effectBytesLen.Length);
            ms.Write(born_effectBytes, 0, born_effectBytes.Length);
if(skills==null)skills = new List<int>();
byte[] skillsCountBytes = BitConverter.GetBytes(skills.Count);
            ms.Write(skillsCountBytes,0,skillsCountBytes.Length);
for (int i = 0; i < skills.Count; i++){
byte[] skillsBytes = BitConverter.GetBytes(skills[i]);
            ms.Write(skillsBytes,0,skillsBytes.Length);
}
byte[] search_rangeBytes = BitConverter.GetBytes(search_range);
            ms.Write(search_rangeBytes,0,search_rangeBytes.Length);
byte[] attr_idBytes = BitConverter.GetBytes(attr_id);
            ms.Write(attr_idBytes,0,attr_idBytes.Length);
byte[] cg_groupBytes = BitConverter.GetBytes(cg_group);
            ms.Write(cg_groupBytes,0,cg_groupBytes.Length);
byte[] loopBytes = BitConverter.GetBytes(loop);
            ms.Write(loopBytes,0,loopBytes.Length);
if(my_switch == null)my_switch = new Systrap_switch();my_switch.Serializer(ms);
if(string.IsNullOrEmpty(actorClass))actorClass = string.Empty;
            byte[] actorClassBytes = System.Text.Encoding.UTF8.GetBytes(actorClass);
            byte[] actorClassBytesLen = BitConverter.GetBytes(actorClassBytes.Length);
            ms.Write(actorClassBytesLen, 0, actorClassBytesLen.Length);
            ms.Write(actorClassBytes, 0, actorClassBytes.Length);
if(string.IsNullOrEmpty(actorType))actorType = string.Empty;
            byte[] actorTypeBytes = System.Text.Encoding.UTF8.GetBytes(actorType);
            byte[] actorTypeBytesLen = BitConverter.GetBytes(actorTypeBytes.Length);
            ms.Write(actorTypeBytesLen, 0, actorTypeBytesLen.Length);
            ms.Write(actorTypeBytes, 0, actorTypeBytes.Length);
if(destroy_events==null)destroy_events = new List<Systrap_event>();
byte[] destroy_eventsCountBytes = BitConverter.GetBytes(destroy_events.Count);
            ms.Write(destroy_eventsCountBytes,0,destroy_eventsCountBytes.Length);
for (int i = 0; i < destroy_events.Count; i++){
if(destroy_events[i] == null)destroy_events[i] = new Systrap_event();destroy_events[i].Serializer(ms);
}
byte[] careerBytes = BitConverter.GetBytes(career);
            ms.Write(careerBytes,0,careerBytes.Length);
byte[] colliderBytes = BitConverter.GetBytes(collider);
            ms.Write(colliderBytes,0,colliderBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
ai = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int model_count;model_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;model = System.Text.Encoding.UTF8.GetString(bytes, offset, model_count);offset += model_count;
model_scale = BitConverter.ToSingle(bytes, offset);
            offset += 4;
int born_effect_count;born_effect_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;born_effect = System.Text.Encoding.UTF8.GetString(bytes, offset, born_effect_count);offset += born_effect_count;

int skillsCount;
skillsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skills = new List<int>(skillsCount);
for (int i = 0; i < skillsCount; i++){
skills.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
search_range = BitConverter.ToSingle(bytes, offset);
            offset += 4;
attr_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
cg_group = BitConverter.ToInt32(bytes, offset);
            offset += 4;
loop = BitConverter.ToInt32(bytes, offset);
            offset += 4;
my_switch = new Systrap_switch();offset = my_switch.Deserializer(bytes,offset);
int actorClass_count;actorClass_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;actorClass = System.Text.Encoding.UTF8.GetString(bytes, offset, actorClass_count);offset += actorClass_count;
int actorType_count;actorType_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;actorType = System.Text.Encoding.UTF8.GetString(bytes, offset, actorType_count);offset += actorType_count;

int destroy_eventsCount;
destroy_eventsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
destroy_events = new List<Systrap_event>(destroy_eventsCount);
for (int i = 0; i < destroy_eventsCount; i++){
destroy_events.Add(new Systrap_event());offset = destroy_events[i].Deserializer(bytes,offset);
}
career = BitConverter.ToInt32(bytes, offset);
            offset += 4;
collider = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Systrap_event
    {
		public int id; //陷阱开关触发事件
		public int event_type; //事件类型
		public int intParameter; //参数1
		public string stringParameter; //参数2
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] event_typeBytes = BitConverter.GetBytes(event_type);
            ms.Write(event_typeBytes,0,event_typeBytes.Length);
byte[] intParameterBytes = BitConverter.GetBytes(intParameter);
            ms.Write(intParameterBytes,0,intParameterBytes.Length);
if(string.IsNullOrEmpty(stringParameter))stringParameter = string.Empty;
            byte[] stringParameterBytes = System.Text.Encoding.UTF8.GetBytes(stringParameter);
            byte[] stringParameterBytesLen = BitConverter.GetBytes(stringParameterBytes.Length);
            ms.Write(stringParameterBytesLen, 0, stringParameterBytesLen.Length);
            ms.Write(stringParameterBytes, 0, stringParameterBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
event_type = BitConverter.ToInt32(bytes, offset);
            offset += 4;
intParameter = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int stringParameter_count;stringParameter_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;stringParameter = System.Text.Encoding.UTF8.GetString(bytes, offset, stringParameter_count);offset += stringParameter_count;
return offset;
        }
} 
 [Serializable]public class Systrap_switch
    {
		public int id; //陷阱开关
		public float open_time; //打开时间
		public float close_time; //关闭时间
		public float range; //触发区域的半径
		public List<Systrap_event> open_events; //打开事件
		public List<Systrap_event> close_events; //关闭事件
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] open_timeBytes = BitConverter.GetBytes(open_time);
            ms.Write(open_timeBytes,0,open_timeBytes.Length);
byte[] close_timeBytes = BitConverter.GetBytes(close_time);
            ms.Write(close_timeBytes,0,close_timeBytes.Length);
byte[] rangeBytes = BitConverter.GetBytes(range);
            ms.Write(rangeBytes,0,rangeBytes.Length);
if(open_events==null)open_events = new List<Systrap_event>();
byte[] open_eventsCountBytes = BitConverter.GetBytes(open_events.Count);
            ms.Write(open_eventsCountBytes,0,open_eventsCountBytes.Length);
for (int i = 0; i < open_events.Count; i++){
if(open_events[i] == null)open_events[i] = new Systrap_event();open_events[i].Serializer(ms);
}
if(close_events==null)close_events = new List<Systrap_event>();
byte[] close_eventsCountBytes = BitConverter.GetBytes(close_events.Count);
            ms.Write(close_eventsCountBytes,0,close_eventsCountBytes.Length);
for (int i = 0; i < close_events.Count; i++){
if(close_events[i] == null)close_events[i] = new Systrap_event();close_events[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
open_time = BitConverter.ToSingle(bytes, offset);
            offset += 4;
close_time = BitConverter.ToSingle(bytes, offset);
            offset += 4;
range = BitConverter.ToSingle(bytes, offset);
            offset += 4;

int open_eventsCount;
open_eventsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
open_events = new List<Systrap_event>(open_eventsCount);
for (int i = 0; i < open_eventsCount; i++){
open_events.Add(new Systrap_event());offset = open_events[i].Deserializer(bytes,offset);
}

int close_eventsCount;
close_eventsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
close_events = new List<Systrap_event>(close_eventsCount);
for (int i = 0; i < close_eventsCount; i++){
close_events.Add(new Systrap_event());offset = close_events[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysunion_boss_award
    {
		public string unikey;
		public int boss_id; //副本BOSS战
		public int open_level; //开放联盟等级
		public int damage; //伤害总值
		public int dungeon; //副本id
		public int npc_id; //boss半身像
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] boss_idBytes = BitConverter.GetBytes(boss_id);
            ms.Write(boss_idBytes,0,boss_idBytes.Length);
byte[] open_levelBytes = BitConverter.GetBytes(open_level);
            ms.Write(open_levelBytes,0,open_levelBytes.Length);
byte[] damageBytes = BitConverter.GetBytes(damage);
            ms.Write(damageBytes,0,damageBytes.Length);
byte[] dungeonBytes = BitConverter.GetBytes(dungeon);
            ms.Write(dungeonBytes,0,dungeonBytes.Length);
byte[] npc_idBytes = BitConverter.GetBytes(npc_id);
            ms.Write(npc_idBytes,0,npc_idBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
boss_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
open_level = BitConverter.ToInt32(bytes, offset);
            offset += 4;
damage = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
npc_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysunion_boss_award_arg
    {
		public int kill_value; //伤害值
    public void Serializer(MemoryStream ms){

byte[] kill_valueBytes = BitConverter.GetBytes(kill_value);
            ms.Write(kill_valueBytes,0,kill_valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

kill_value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysunion_lev_info
    {
		public string unikey;
		public int lv; //联盟等级
		public int exp; //联盟建设度
		public int member_limit; //成员上限
		public int second_num; //副盟主人数
		public int third_num; //元老人数
		public int fourth_num; //精英人数
		public List<int> family_boss; //副本BOSS战
		public int coin; //供奉消耗金币
		public int exp_coin; //金币增加经验
		public int dev_coin; //金币增加联盟币
		public int gold; //供奉消耗钻石
		public int exp_gold; //钻石增加经验
		public int dev_gold; //钻石增加联盟币
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] member_limitBytes = BitConverter.GetBytes(member_limit);
            ms.Write(member_limitBytes,0,member_limitBytes.Length);
byte[] second_numBytes = BitConverter.GetBytes(second_num);
            ms.Write(second_numBytes,0,second_numBytes.Length);
byte[] third_numBytes = BitConverter.GetBytes(third_num);
            ms.Write(third_numBytes,0,third_numBytes.Length);
byte[] fourth_numBytes = BitConverter.GetBytes(fourth_num);
            ms.Write(fourth_numBytes,0,fourth_numBytes.Length);
if(family_boss==null)family_boss = new List<int>();
byte[] family_bossCountBytes = BitConverter.GetBytes(family_boss.Count);
            ms.Write(family_bossCountBytes,0,family_bossCountBytes.Length);
for (int i = 0; i < family_boss.Count; i++){
byte[] family_bossBytes = BitConverter.GetBytes(family_boss[i]);
            ms.Write(family_bossBytes,0,family_bossBytes.Length);
}
byte[] coinBytes = BitConverter.GetBytes(coin);
            ms.Write(coinBytes,0,coinBytes.Length);
byte[] exp_coinBytes = BitConverter.GetBytes(exp_coin);
            ms.Write(exp_coinBytes,0,exp_coinBytes.Length);
byte[] dev_coinBytes = BitConverter.GetBytes(dev_coin);
            ms.Write(dev_coinBytes,0,dev_coinBytes.Length);
byte[] goldBytes = BitConverter.GetBytes(gold);
            ms.Write(goldBytes,0,goldBytes.Length);
byte[] exp_goldBytes = BitConverter.GetBytes(exp_gold);
            ms.Write(exp_goldBytes,0,exp_goldBytes.Length);
byte[] dev_goldBytes = BitConverter.GetBytes(dev_gold);
            ms.Write(dev_goldBytes,0,dev_goldBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
member_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;
second_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
third_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
fourth_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int family_bossCount;
family_bossCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
family_boss = new List<int>(family_bossCount);
for (int i = 0; i < family_bossCount; i++){
family_boss.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dev_coin = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
exp_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dev_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysunion_privilege
    {
		public string unikey;
		public int office; //职位
		public List<int> privilege; //权限
		public string name; //名字
		public string icon; //图片名字
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] officeBytes = BitConverter.GetBytes(office);
            ms.Write(officeBytes,0,officeBytes.Length);
if(privilege==null)privilege = new List<int>();
byte[] privilegeCountBytes = BitConverter.GetBytes(privilege.Count);
            ms.Write(privilegeCountBytes,0,privilegeCountBytes.Length);
for (int i = 0; i < privilege.Count; i++){
byte[] privilegeBytes = BitConverter.GetBytes(privilege[i]);
            ms.Write(privilegeBytes,0,privilegeBytes.Length);
}
if(string.IsNullOrEmpty(name))name = string.Empty;
            byte[] nameBytes = System.Text.Encoding.UTF8.GetBytes(name);
            byte[] nameBytesLen = BitConverter.GetBytes(nameBytes.Length);
            ms.Write(nameBytesLen, 0, nameBytesLen.Length);
            ms.Write(nameBytes, 0, nameBytes.Length);
if(string.IsNullOrEmpty(icon))icon = string.Empty;
            byte[] iconBytes = System.Text.Encoding.UTF8.GetBytes(icon);
            byte[] iconBytesLen = BitConverter.GetBytes(iconBytes.Length);
            ms.Write(iconBytesLen, 0, iconBytesLen.Length);
            ms.Write(iconBytes, 0, iconBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
office = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int privilegeCount;
privilegeCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
privilege = new List<int>(privilegeCount);
for (int i = 0; i < privilegeCount; i++){
privilege.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
int name_count;name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;name = System.Text.Encoding.UTF8.GetString(bytes, offset, name_count);offset += name_count;
int icon_count;icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;icon = System.Text.Encoding.UTF8.GetString(bytes, offset, icon_count);offset += icon_count;
return offset;
        }
} 
 [Serializable]public class Sysuse
    {
		public int id; //类型
		public int num; //数量
    public void Serializer(MemoryStream ms){

byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysvip
    {
		public string unikey;
		public int lv; //vip等级
		public string desc; //描述
		public int exp; //总共需要的经验
		public int dungeon_no_star; //非三星开启扫荡功能
		public int dungeon_sweep; //扫荡十次功能
		public int bag_num; //背包格子容量
		public int coin_num; //购买金币的次数
		public int tittle; //获得称号
		public int player_skill_point_num; //上古神器钻石购买次数
		public int energy_num; //购买体力次数
		public int skill_point_num; //购买英雄技能点次数
		public int max_energy_auto; //体力上限
		public int max_skill_point_auto; //自动增长英雄技能点上限
		public int max_energy; //最大体力上限
		public int max_skill_point; //英雄技能点上限
		public int super_dungeon; //精英副本购买次数
		public int arena_num; //购买竞技场次数
		public int marking_gold; //印记VIP消耗
		public int marking_exp; //印记经验翻倍
		public List<Sysvip_award> award; //奖励
		public int value; //价值
		public int union_build_time; //联盟朝拜钻石次数
		public int hell_times; //血色地狱次数
		public int peerage_num; //购买爵位挑战次数
		public int escort_num; //征服之海护送次数
		public int escort_rob_num; //征服之海掠夺次数
		public int buy_trial_times; //购买试炼币次数
		public int buy_grow_fund; //购买成长基金
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] dungeon_no_starBytes = BitConverter.GetBytes(dungeon_no_star);
            ms.Write(dungeon_no_starBytes,0,dungeon_no_starBytes.Length);
byte[] dungeon_sweepBytes = BitConverter.GetBytes(dungeon_sweep);
            ms.Write(dungeon_sweepBytes,0,dungeon_sweepBytes.Length);
byte[] bag_numBytes = BitConverter.GetBytes(bag_num);
            ms.Write(bag_numBytes,0,bag_numBytes.Length);
byte[] coin_numBytes = BitConverter.GetBytes(coin_num);
            ms.Write(coin_numBytes,0,coin_numBytes.Length);
byte[] tittleBytes = BitConverter.GetBytes(tittle);
            ms.Write(tittleBytes,0,tittleBytes.Length);
byte[] player_skill_point_numBytes = BitConverter.GetBytes(player_skill_point_num);
            ms.Write(player_skill_point_numBytes,0,player_skill_point_numBytes.Length);
byte[] energy_numBytes = BitConverter.GetBytes(energy_num);
            ms.Write(energy_numBytes,0,energy_numBytes.Length);
byte[] skill_point_numBytes = BitConverter.GetBytes(skill_point_num);
            ms.Write(skill_point_numBytes,0,skill_point_numBytes.Length);
byte[] max_energy_autoBytes = BitConverter.GetBytes(max_energy_auto);
            ms.Write(max_energy_autoBytes,0,max_energy_autoBytes.Length);
byte[] max_skill_point_autoBytes = BitConverter.GetBytes(max_skill_point_auto);
            ms.Write(max_skill_point_autoBytes,0,max_skill_point_autoBytes.Length);
byte[] max_energyBytes = BitConverter.GetBytes(max_energy);
            ms.Write(max_energyBytes,0,max_energyBytes.Length);
byte[] max_skill_pointBytes = BitConverter.GetBytes(max_skill_point);
            ms.Write(max_skill_pointBytes,0,max_skill_pointBytes.Length);
byte[] super_dungeonBytes = BitConverter.GetBytes(super_dungeon);
            ms.Write(super_dungeonBytes,0,super_dungeonBytes.Length);
byte[] arena_numBytes = BitConverter.GetBytes(arena_num);
            ms.Write(arena_numBytes,0,arena_numBytes.Length);
byte[] marking_goldBytes = BitConverter.GetBytes(marking_gold);
            ms.Write(marking_goldBytes,0,marking_goldBytes.Length);
byte[] marking_expBytes = BitConverter.GetBytes(marking_exp);
            ms.Write(marking_expBytes,0,marking_expBytes.Length);
if(award==null)award = new List<Sysvip_award>();
byte[] awardCountBytes = BitConverter.GetBytes(award.Count);
            ms.Write(awardCountBytes,0,awardCountBytes.Length);
for (int i = 0; i < award.Count; i++){
if(award[i] == null)award[i] = new Sysvip_award();award[i].Serializer(ms);
}
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
byte[] union_build_timeBytes = BitConverter.GetBytes(union_build_time);
            ms.Write(union_build_timeBytes,0,union_build_timeBytes.Length);
byte[] hell_timesBytes = BitConverter.GetBytes(hell_times);
            ms.Write(hell_timesBytes,0,hell_timesBytes.Length);
byte[] peerage_numBytes = BitConverter.GetBytes(peerage_num);
            ms.Write(peerage_numBytes,0,peerage_numBytes.Length);
byte[] escort_numBytes = BitConverter.GetBytes(escort_num);
            ms.Write(escort_numBytes,0,escort_numBytes.Length);
byte[] escort_rob_numBytes = BitConverter.GetBytes(escort_rob_num);
            ms.Write(escort_rob_numBytes,0,escort_rob_numBytes.Length);
byte[] buy_trial_timesBytes = BitConverter.GetBytes(buy_trial_times);
            ms.Write(buy_trial_timesBytes,0,buy_trial_timesBytes.Length);
byte[] buy_grow_fundBytes = BitConverter.GetBytes(buy_grow_fund);
            ms.Write(buy_grow_fundBytes,0,buy_grow_fundBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_no_star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_sweep = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bag_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tittle = BitConverter.ToInt32(bytes, offset);
            offset += 4;
player_skill_point_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
energy_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill_point_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_energy_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_skill_point_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_energy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_skill_point = BitConverter.ToInt32(bytes, offset);
            offset += 4;
super_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
marking_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
marking_exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int awardCount;
awardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
award = new List<Sysvip_award>(awardCount);
for (int i = 0; i < awardCount; i++){
award.Add(new Sysvip_award());offset = award[i].Deserializer(bytes,offset);
}
value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
union_build_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hell_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
peerage_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_rob_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_trial_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_grow_fund = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysvip_award
    {
		public int goods_id; //物品ID
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syswin_rule
    {
		public int type; //类型
		public List<int> param; //参数1
    public void Serializer(MemoryStream ms){

byte[] typeBytes = BitConverter.GetBytes(type);
            ms.Write(typeBytes,0,typeBytes.Length);
if(param==null)param = new List<int>();
byte[] paramCountBytes = BitConverter.GetBytes(param.Count);
            ms.Write(paramCountBytes,0,paramCountBytes.Length);
for (int i = 0; i < param.Count; i++){
byte[] paramBytes = BitConverter.GetBytes(param[i]);
            ms.Write(paramBytes,0,paramBytes.Length);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

type = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int paramCount;
paramCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
param = new List<int>(paramCount);
for (int i = 0; i < paramCount; i++){
param.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}
return offset;
        }
} 
 [Serializable]public class Syswords
    {
		public string unikey;
		public int wordid; //文本id
		public string content; //文本内容
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] wordidBytes = BitConverter.GetBytes(wordid);
            ms.Write(wordidBytes,0,wordidBytes.Length);
if(string.IsNullOrEmpty(content))content = string.Empty;
            byte[] contentBytes = System.Text.Encoding.UTF8.GetBytes(content);
            byte[] contentBytesLen = BitConverter.GetBytes(contentBytes.Length);
            ms.Write(contentBytesLen, 0, contentBytesLen.Length);
            ms.Write(contentBytes, 0, contentBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
wordid = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int content_count;content_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;content = System.Text.Encoding.UTF8.GetString(bytes, offset, content_count);offset += content_count;
return offset;
        }
} 
 [Serializable]public class Sysworship_award_per
    {
		public string unikey;
		public int lv; //玩家等级
		public int rank; //膜拜第N名
		public List<Systask_goods> arg; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] rankBytes = BitConverter.GetBytes(rank);
            ms.Write(rankBytes,0,rankBytes.Length);
if(arg==null)arg = new List<Systask_goods>();
byte[] argCountBytes = BitConverter.GetBytes(arg.Count);
            ms.Write(argCountBytes,0,argCountBytes.Length);
for (int i = 0; i < arg.Count; i++){
if(arg[i] == null)arg[i] = new Systask_goods();arg[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
rank = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int argCount;
argCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = new List<Systask_goods>(argCount);
for (int i = 0; i < argCount; i++){
arg.Add(new Systask_goods());offset = arg[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysworship_award_top3
    {
		public string unikey;
		public int num; //次数
		public List<Systask_goods> arg; //属性
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] numBytes = BitConverter.GetBytes(num);
            ms.Write(numBytes,0,numBytes.Length);
if(arg==null)arg = new List<Systask_goods>();
byte[] argCountBytes = BitConverter.GetBytes(arg.Count);
            ms.Write(argCountBytes,0,argCountBytes.Length);
for (int i = 0; i < arg.Count; i++){
if(arg[i] == null)arg[i] = new Systask_goods();arg[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
num = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int argCount;
argCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arg = new List<Systask_goods>(argCount);
for (int i = 0; i < argCount; i++){
arg.Add(new Systask_goods());offset = arg[i].Deserializer(bytes,offset);
}
return offset;
        }
}}