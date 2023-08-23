using UnityEngine;
using System.Collections.Generic;

namespace Assets.Scripts.Com.Game.Module.Scene
{
    /// <summary>
    /// 序列号节点
    /// </summary>
    [SerializeField]
    public class DungeonVo
    {
        public DungeonFlagVo FlagVo;
        public DungeonHeroVo HeroVo;
        public DungeonDoorVo DoorVo;
        public DungeonTrapVo TrapVo;
        public DungeonPortalVo PortalVo;
    }

    /// <summary>
    /// 阵营类型：
    /// 中立=0, 己方=1，敌方
    /// </summary>
    public enum ECamp
    {
        Neutral = 0,    //中立
        Friend,         //己方
        Enemy,          //敌方

    }

    /// <summary>
    /// 怪物类型：
    /// 野怪=0，士兵，中立怪
    /// </summary>
    //public enum EType
    //{
    //    Monster = 0,    //野怪，副本
    //    Soldier,        //士兵，大乱斗
    //    Neutral         //中立怪，大乱斗
    //}

    /// <summary>
    /// 条件类型：
    /// 有一个英雄进入 = 0,
    /// 所有英雄进入
    /// 副本开启后X秒
    /// 某怪物血量达X%
    /// 第X波怪结束
    /// 周期刷（大乱斗士兵）
    /// 死后循环刷（大乱斗中立怪）
    /// </summary>
    public enum EFlag
    {
        OneHeroIn = 0,
        AllHeroIn,
        SecondsLater,
        MonsterHp,
        WaveFinish,
        MeleeSoldier,
        MeleeNeutral
    }

    /// <summary>
    /// 刷怪促发条件
    /// </summary>
    public class DungeonFlagVo
    {
        public int id;
        public int flag;
        public float x;
        public float y;
        public float z;
        public float r;
        public float width;
        public float height;
        public int second;
        public int monster;
        public int hp;
        public int wave;
        public List<DungeonMonsterlVo> monsterList = new List<DungeonMonsterlVo>();

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0, r, 0); }
        }
        public Vector3 size
        {
            get { return new Vector3(width, 1, height); }
        }
        public override string ToString()
        {
            return string.Format("DungeonFlagVo : id = {0}, flag = {1}", id, (EFlag)flag);
        }
    }

    /// <summary>
    /// 怪物
    /// </summary>
    public class DungeonMonsterlVo
    {
        public int id;          //场景配置的唯一id
        public int actId;       //配置的Actor id           比如怪物，就是怪物表的id
        public int camp;        //阵营
        public int actFlag;     //促发条件
        public float x;         //transform信息
        public float y;
        public float z;
        public float r;
        public int actNum;      //数量
        public float randRadius;    //随机范围
        public int trigger;     //促发开关：比如大乱斗的塔被推了促发这个超级兵
        public string modelName;    //模型名字（防御塔专用）
        public float delay;     //延迟刷出

        public string key
        {
            get { return actFlag + "_" + id; }
        }

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0f, r, 0f); }
        }
        public override string ToString()
        {
            return string.Format("DungeonMonsterlVo : id = {0}, monsterId = {1}, number ={2}, camp = {3}", id, actId, actNum, (ECamp)camp);
        }

        /// <summary>
        /// 统一生成唯一id
        /// </summary>
        /// <param name="vo"></param>
        /// <param name="num"></param>
        /// <returns></returns>
        public static int SetMonsterId(DungeonMonsterlVo vo, int num)
        {
            int monster_id = vo.actFlag * 10000000 + vo.id * 1000 + num;
            return monster_id;
        }
        public static void GetFlagAndId(int monsterId, out int flag, out int id)
        {
            flag = monsterId / 10000000;
            id = (monsterId % 10000000) / 1000;
        }
    }

    /// <summary>
    /// 英雄
    ///     出生点
    ///     buff;skill;...
    /// </summary>
    public class DungeonHeroVo
    {
        public int id;          //场景配置的唯一id
        public int heroId;      //英雄表id
        public int camp;        //阵营
        public float x;         //transform信息
        public float y;
        public float z;
        public float r;

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0f, r, 0f); }
        }
        public override string ToString()
        {
            return string.Format("DungeonHeroVo : id = {0}, heroId = {1}, camp = {2}", id, heroId, (ECamp)camp);
        }

    }

    /// <summary>
    /// 门
    /// </summary>
    public class DungeonDoorVo
    {
        public int id;          //场景配置的唯一id
        public int type;        //类型 1第X个条件触发的怪物触发 2第X个条件触发的怪物全部被杀光
        public int flag;        //类型对应的条件
        public int close;        //开关 0打开/1关闭
        public string name;     //对应场景中的名字（路径）
        public float x;         //transform信息
        public float y;
        public float z;
        public float r;
        public float width;
        public float height;

        public int doorType;    //门的类型：0光门、1木栏

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0f, r, 0f); }
        }
        public Vector3 size
        {
            get { return new Vector3(width, 5f, height); }
        }
        public override string ToString()
        {
            return string.Format("DungeonDoorVo : id = {0}, type = {1}, flag = {2}, close = {3}, name = {4}, doorType = {5}", id, type, flag, close, name, doorType);
        }

    }

    /// <summary>
    /// 陷阱
    /// </summary>
    public class DungeonTrapVo
    {
        public int id;          //场景配置的唯一id
        public int trapId;      //陷阱表的id
        public int camp;        //阵营
        public float x;         //transform信息
        public float y;
        public float z;
        public float r;
        public float width;
        public float height;
        public string trapIdStr;//多个id随机

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0f, r, 0f); }
        }
        public Vector3 size
        {
            get { return new Vector3(width, 1f, height); }
        }
        public int GetTrapId()
        {
            var list = trapIdStr.Split(',');
            var rand = Random.Range(0, list.Length - 1);
            return int.Parse(list[rand]);
        }
        public override string ToString()
        {
            return string.Format("DungeonTrapVo : id = {0}, trapId ={1}, camp = {2}", id, trapId, (ECamp)camp);
        }
    }

    /// <summary>
    /// 传送门
    /// </summary>
    public class DungeonPortalVo
    {
        public int id;          //场景配置的唯一id
        public int type;        //类型 1第X个条件触发的怪物触发 2第X个条件触发的怪物全部被杀光
        public int flag;        //类型对应的条件
        public int close;        //开关 0打开/1关闭
        public string name;     //对应场景中的名字（路径）
        public float x;         //transform信息
        public float y;
        public float z;
        public float r;
        public float width;
        public float height;

        public float target_x;         //传送门transform信息
        public float target_y;
        public float target_z;
        public float target_r;

        public int target_type;         //目标点类型: (0传送点，1指引点）

        public Vector3 target_position
        {
            get { return new Vector3(target_x, target_y, target_z); }
        }
        public Vector3 target_rotation
        {
            get { return new Vector3(0f, target_r, 0f); }
        }

        public Vector3 position
        {
            get { return new Vector3(x, y, z); }
        }
        public Vector3 rotation
        {
            get { return new Vector3(0f, r, 0f); }
        }
        public Vector3 size
        {
            get { return new Vector3(width, 5f, height); }
        }
        public override string ToString()
        {
            return string.Format("DungeonPortalVo : id = {0}, type = {1}, flag = {2}, close = {3}, name = {4}", id, type, flag, close, name);
        }

    }

}