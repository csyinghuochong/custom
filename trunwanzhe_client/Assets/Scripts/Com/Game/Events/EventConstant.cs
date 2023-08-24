using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils;

namespace Assets.Scripts.Com.Game.Events
{
    public enum EventConstant : int
    {
        VOICE_LOGIN,

        VOICE_LOGOUT,

        VOICE_CHAT_START,

        VOICE_CHAT_STOP,

        SEND_MOBILE_INFO,

        SHOW_IME,

        SHOW_FULLSCREEN,

        IME_KEY,

        IME_CHANGE,

        VOICE_MSG_NOTIFY,

        VOICE_MSG_PLAY,

        VOICE_PLAY_COMPLETION,

        VOICE_LOGIN_SUCCESS,

        //音效
        PLAY_GAME_2D_SOUND,        //播放2D音效
        STOP_GAME_SOUND,           //暂停音效
        SETTING_GAME_SOUND,

        //socket建立链接成功
        NET_CONNECT_SUCCESS,
        NET_DISCONNECT,

        LOGIN_SUCCESS,        //登录成功，重登录下会存在多次登录成功的情况
        LOGIN_OUT_SUCCESS,    //登出成功

        FIRST_LOGIN_SUCCESS,

        FIRST_GET_SERVER_DATA,

        //退出游戏提示
        QUIT_TIP,
        APPLICATION_PAUSE,

        PING_TIME,

        //清除数据
        CLEAR_BASE_MODEL,

        GET_HERO_LIST,

        SHOW_UI_LOADING,
        SHOW_SCENE_LOADING,
        SHOW_REQUEST_LOADING,
        SHOW_NET_ERROR_TIP,

        //普通场景转战斗场景的释放
        NORMAL_TO_BATTLE_DISPOSE,

        LOAD_CONFIG_COMPLETE,

        //角色信息相关
        UPDATE_EQUIP_STAR_NUM,
        UPDATE_MALL_DRAW_NUMBER,
        UPDATE_PLAYER_BASE_GOLD,
        UPDATE_PLAYER_BASE_COIN,
        UPDATE_PLAYER_BASE_ENERGY,
        UPDATE_PLAYER_BASE_FIGHT_COIN,
        UPDATE_PLAYER_BASE_LEVEL,
        UPDATE_PLAYER_BASE_VIP,
        UPDATE_PLAYER_BASE_NAME,
        UPDATE_PLAYER_BASE_HEAD,
        UPDATE_PLAYER_BASE_INFO,
        UPDATE_PLAYER_BASE_POWER,
        UPDATE_PLAYER_MARS_EXP,
        UPDATE_PLAYER_MARS_LEVEL,
        UPDATE_PLAYER_MARS_TASK,
        UPDATE_PLAYER_SKILL_POINT,
        UPDATE_PLAYER_SKILL_BUY_COUNT,
        UPDATE_PLAYER_COIN_BUY_COUNT,
        UPDATE_PLAYER_ENERGY_BUY_COUNT,
        UPDATE_PLAYER_WORSHIP_NUM,
        UPDATE_PLAYER_PEERAGE,
        UPDATE_PLAYER_ARENA_COIN,
        UPDATE_PLAYER_LEAGUE_COIN,
        UPDATE_PLAYER_HELL_NUM,
        UPDATE_PLAYER_FIRST_RECHARGE,

        //请求进入场景
        ASK_FOR_ENTER_SCENE,
        ENTER_SCENE_STATE,
        SCENE_XML_LOADED,   //场景加载完毕&初始化英雄后

        //自动寻路
        SHOW_AUTO_PATH_FINDING_TIP,

        //预加载UI
        PRELOAD_UI,

        //切换显示隐藏UI
        TOGGLE_UI,

        //切换显示隐藏UI
        TOGGLE_UI_WITH_PARAM,

        //打开界面
        OPEN_UI,

        //打开界面,可以携带参数
        OPEN_UI_WITH_PARAM,

        //切换界面显示隐藏
        SWITCH_UI_VISIBLE,

        //切换界面显示隐藏,可以携带参数
        SWITCH_UI_VISIBLE_WITH_PARAM,

        //返回上一个进入的UI
        RETURN_UI,

        NO_FULL_SCREEN_WINDOW,

        ON_LAYER_SHOW_WINDOW,

        //设置主场景角色的位置
        SET_MAIN_PLAYER_POSITION,

        //主角停止移动
        MAIN_PLAYER_STOP_MOVE,

        //隐藏主角
        SET_MAIN_PLAYER_VISIBLE,

        // 播放主角出生特效
        SHOW_MAIN_PLAYER_BORN_EFFECT,

        //打开主场景UI
        SHOW_TOWN_PANEL,
        SHOW_TOWN_PANEL_EFFECT,     //主界面动画

        //金币增加
        ADD_GOLD_EFFECT,

        MONSTER_FLAG_TRRIGER_ON,    //第X波条件触发
        MONSTER_AWAKE_OR_DEATH,     //怪物创建或死亡
        HERO_ON_DEAD,               //英雄死亡

        CLEAR_CHAT_SEARCH_LIST,    //清除聊天搜索列表

        //好友
        //根据名字添加好友
        REQ_ADD_FRIEND_BY_NAME,
        //根据ID添加好友
        REQ_ADD_FRIEND_BY_ID,
        //根据名字添加黑名单
        REQ_ADD_SHIELD_BY_NAME,
        //根据ID添加黑名单
        REQ_ADD_SHIELD_BY_ID,
        /// <summary>
        /// 选中当前通知ID，只能在好友模块内部发送
        /// </summary>
        FRIEND_SELECT_NOTICE,

        //打开排行榜
        OPEN_RANK_VIEW,

        //通知
        SHOW_NOTIFY,

        GAME_SETTING_BACK,

        REFRESH_GAME_DATA,//n点刷新数据
        REFRESH_GAME_DATA_SIGN,//n点刷新签到数据
        REFRESH_GAME_DATA_CELEBRITY_HALL,//n点刷新名人堂数据
        REFRESH_GAME_DATA_LUCKY_DRAW,//n点刷新抽奖数据
        REFRESH_GAME_DATA_TASK,//n点刷新任务数据

        //聊天界面打开
        CHAT_WINDOW_OPEN,

        // 英雄
        HERO_CHANGE_HERO,           // 切换英雄
        HERO_SET_ATTR_VISIBLE,      // 英雄界面设置属性界面显示
        HERO_CHANGE_FIGHT_HERO,     // 更换出战英雄
        HERO_SET_FIGHT_SUCC,        // 设置出战成功
        HERO_COMBINING_SUCC,        // 合成成功
        HERO_SHOW_BATTLE_ARRY,      // 显示出战设置Button
        HERO_UPDATE_ATTR,           // 更新英雄属性
        HERO_CHOOSE_TYPE,           // 选择类型
        HERO_CHANGE_SHOW_LEVEL,     // 更改面板上的显示等级
        HERO_UPDATE_EQUIP,          // 装备更新
        HERO_LEVELUP_EFFECT,        // 播放升级特效
        HERO_ATTR_CHANGE_NOTIFY,    // 英雄属性改变检测红点
        HERO_ACTIVE_HERO,           // 激活英雄
        HERO_DATA_CHANGE,           // 英雄数据改变
        HERO_DETAILINFO_HIDE,       // 关闭英雄属性详细界面
        HERO_SOUL_TRANSFORM_SUCC,   // 魂石转化成功
        HERO_SOUL_CHANGE,           // 英雄灵魂石数量改变
        HERO_ACTIVE,                // 英雄激活
        HERO_INTRO_HIDE,            // 关闭英雄简介

        // 称号
        TITLE_REMOVE_USED,          // 取消使用
        TITLE_UPDATE_USED,          // 更新使用
        TITLE_UPDATE_SHOW,          // 更新显示
        TITLE_SELECT,               // 选中
        TITLE_NEW,

        // 印记
        STAMP_REMOVE,               // 从背包删除印记
        STAMP_ADD,                  // 添加印记到背包
        STAMP_SWALLOW_SUCC,         // 吞噬成功
        STAMP_SELECT_MASTER,        // 当前的符文制作
        STAMP_SHOW_GET,             // 显示获得的印记
        STAMP_UPDATE_HERO,          // 刷新英雄的印记列表
        STAMP_SET_MATERIAL,         // 设置吞噬材料
        STAMP_UPDATE_FREE_TIME,     // 更新免费时间
        STAMP_HEROLIST_REMOVE,      // 卸下印记
        STAMP_MOVE_PLATFORM,        // 移动平台
        STAMP_SIFT,                 // 筛选印记
        STAMP_REPLACE,              // 印记替换
        STAMP_SIFT_SETTING_SUCC,    // 吞噬设置完成
        STAMP_USE,                  // 使用印记

        // 签到
        SIGN_UPDATE,                // 刷新签到信息
        SIGN_MONTH_SIGN_SUCC,       // 月签到成功
        SIGN_CONTINUE_SIGN_SUCC,    // 连续签到成功
        SIGN_SUCC,                  // 签到成功
        SIGN_TOTAL_SUCC,            // 累计天数签到成功

        //商城
        MALL_SWITCH_LEAGUE,         // 切换联盟商店
        MALL_DRAW_TIMES,            // 铸魂商城抽奖次数

        //副本(选关卡界面)
        COPY_VIEW_FRESH,            //选关卡界面刷新
        COPY_DATA_UPDATE,           //副本数据更新
        COPY_PAGE_CHANGE,           //副本显示关卡

        //副本(战斗界面)
        COMBAT_SHOW_ADD_ITEM,           //物品掉落
        COMBAT_SHOW_ADD_COIN,           //金币掉落
        COMBAT_SHOW_TEXT_TIP,           //文字提示
        COMBAT_MAIN_HERO_DEAD,          //主英雄死亡后自动切换英雄，有些玩法不需要切换
        COMBAT_SWITCH_MAIN_HERO,        //切换主英雄
        COMBAT_CLICK_HERO_HEAD,         //点击英雄头像
        COMBAT_SKILL_DESC_VIEW,         //技能描述框
        COMBAT_SKILL_DISK,              //显示技能轮盘
        COMBAT_CANCEL_SKILL,            //取消施法
        COMBAT_SKILL_DRAG,              //开始拖动技能轮盘
        COMBAT_SKILL_DRAG_START,        //拖动技能轮盘
        COMBAT_BOSS_WARN,               //BOSS预警
        COMBAT_SCENE_BUTTON,            //场景按钮
        COMBAT_RECOVER_HP_TIP,          //等待回血提示
        COMBAT_UPDATE_BUFF,             //buff更新
        COMBAT_BACK_TO_BORN,            //回城[开始/结束]

        //战斗控制
        COMBAT_ON_BEFORE_START,         //战斗触发前
        COMBAT_ON_START,                //战斗一触即发
        COMBAT_ON_GAME_OVER,            //战斗结束 胜利/失败（投降）
        COMBAT_UPDATE_TIME,             //战斗倒计时
        COMBAT_SET_AUTO,                //托管 设置自动战斗
        COMBAT_UPDATE_BLOOD,            //血量更新：检测剧情
        COMBAT_NEWBIE_STORY,            //开始剧情
        COMBAT_SHOW_BUBBLE,             //冒泡对话
        COMBAT_UPDATE_DETAIL,           //得星详情更新
        COMBAT_REFRESH_HERO_HP,         //英雄血量更新
        COMBAT_HERO_RELIVE,             //英雄复活

        COMBAT_INIT_HERO_DATA,          //大乱斗数据
        COMBAT_KILL,                    //击败
        COMBAT_HERO_ROTATE,             //慢镜头英雄转身
        COMBAT_DEAD_FINISH,             //死亡动作播放完
        COMBAT_TP_SKILL,                //回城技能释放/打断

        //任务
        TASK_SHOW_EXCUTE,               //显示当前正在执行的任务
        TASK_HIDE_VIEW,                 //隐藏任务窗口，打开其它界面时，点击返回按钮可返回任务界面
        TASK_RETURN_HIDE_VIEW,                 //隐藏任务窗口，相当于点击左上角的返回按钮

        // 抽奖
        LUCKY_DRAW_FREE_GOLD,           // 金币免费次数
        LUCKY_DRAW_FREE_DIAMOND,        // 钻石免费次数
        LUCKY_DRAW_SUCC,                // 抽奖成功
        LUCKY_DRAW_TIMES,               // 抽奖次数

        // 背包
        BACKPACK_GOODS_UPDATE,          // 背包数据更新
        BACKPACK_SHOW_GOODS_DETAIL,     // 显示详情
        BACKPACK_PRELOAD_INIT,          // 背包预加载初始化

        //竞技场
        ARENA_VIEW_TOGGLE,               //打开竞技场界面
        ARENA_OPEN_TEAM_VIEW,            //竞技场阵型界面
        ARENA_HERO_ARRIVE_TARGET,        //英雄到达目标点
        ARENA_INFO_INIT,                 //获得竞技场数据

        // 设置出战
        SET_BATTLE_ARRY_SELECT_HERO,    // 选择英雄
        SET_BATTLE_ARRY_DRAG_HEAD,      // 拖拽头像

        //VIP
        VIP_GET_INFO,
        VIP_GET_AWARD,

        // 玩家技能
        PLAYER_SKILL_UPDATE,            // 玩家技能更新
        SKILL_LEVEL_UP,                 // 技能升级

        // 好友
        FRIEND_SHIELD_NUM_CHANGE,       // 黑名单数量改变 
        FRIEND_DELETE,                  // 删除好友黑名单或通知
        FRIEND_MOVE_FRIEND_TO_SHIELD,   // 将好友移动到黑名单
        FRIEND_STATE_CHANGE,            // 好友状态改变
        FRIEND_ADD_FRIEND,              // 添加黑名单
        FRIEND_VISIT_REWARD,            // 拜访好友获得奖励

        //新手指引
        GUIDE_TASK_DONE,                //任务完成
        GUIDE_TASK_ACCEPT,              //任务接取成功
        GUIDE_DUNGEON_QUIT,             //副本结束

        // 个人设置
        PERSONAL_SETTING,               // 个人设置修改
        INIT_RES_CD,

        // 装备合成跳转
        COMBINING_SUCC_SKIP,

        // 活动
        ACTIVITY_MSG_BACK,              // 获取各个活动信息的返回消息
        ACTIVITY_OPERATE,               // 活动相关领取消息发送
        ACTIVITY_OPERATE_BACK,          // 操作的返回消息
        ACTIVITY_OPEN,                  // 检测活动是否开启
        ACTIVITY_DIAMOND_BACK,          // 获取钻石活动返回消息
        ACTIVITY_PHASE_BACK,            // 获取战力活动返回消息
        ACTIVITY_CHECK_FUNCTION_OPEN,      // 七天登陆是否开启

        // 功能开启
        FUNCTION_OPEN_GO_ON,            // 功能开启继续
        FUNCTION_OPEN_NEW,              // 开启新功能

        // 战神谷
        MARS_SELECT_SKILL,              // 选中技能图标
        MARS_VIEW_TOGGLE,               // 打开战神谷界面
        MARS_TASK_COMPLETE,             // 任务完成

        // 物品获取途径
        GOOD_GET_WAY_TURN,              // 获取途径跳转

        // 护送商船

        // 宝藏探索
        TREASURE_VIEW_TOGGLE,           // 宝藏界面开关
        TREASURE_REWARD_CLOSE,          // 关闭奖励界面

        // 血色炼狱
        HELL_MONSTER_WAVE,              // 怪物波数刷新

        //实时对战
        PVP_BOX_END_CD,                 // pvp宝箱cd结束
        PVP_BOX_NOTICE,                 // 对战宝箱红点          
        PVP_PHASE_UPDATE,               // 段位改变
        PVP_SELECT_PLAER_SKILL,         // 选择召唤师技能
        PVP_TOGGLE_HERO_VIEW,           // 开关英雄界面
        PVP_COMBAT_SHOW_SIGNAL,         // 战斗信号
        PVP_COMBAT_REMOVE_SIGNAL,       // 移除信号
        PVP_COMBAR_SURRENFER,           // 投降
        PVP_COMBAT_HERO_RELIVE,         // 英雄复活
        PVP_COMBAT_SEND_RESULT,         // 战斗结束
        PVP_GAME_READY,                 // 所有客户端都加载完成
        PVP_UPDATE_BLOOD_BUFF,          // 血契改变

        // 播放第一次进入游戏的特效
        SHOW_FIRST_ENTER_GAME_EFFECT,

        // loading界面关闭
        SCENELOADING_HIDE,

        // 主城箭头特效显示开关
        MAIN_INTERFACE_RIGHT_ARROW,

        // 根据操作摇杆来显示屏蔽主城聊天UI
        JOYSTICK_FOR_SHOW_CHAT,

        // 获取绑定邮箱
        LOGIN_GET_BINDING_MAIL,

        // 关卡开启
        DUNGEON_OPEN,

        // 赠送鲜花
        SEND_FLOWER_CALLBACK,

        // 新的私聊消息
        CHAT_NEW_PRIVATE,

        // 刷新玩法次数
        BATTLE_SELECT_UPDATE_TIMES,

        //刷新爵位薪资红点
        PEERAGE_SALARY_RED,
        PEERAGE_NOTICE_HIDE,  //皇榜界面关闭

        // 获取功能开启奖励
        FUNCTION_OPEN_REWARD_GET,
        FUNCTION_OPEN,

        // 接受后端同步过来的膜拜信息
        RECEIVE_WORSHIP_INFO,
        
        UPDATE_SOUL,
        //放在最后
        MAX_COUNT
    }
}
