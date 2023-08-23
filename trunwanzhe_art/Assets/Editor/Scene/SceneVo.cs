using UnityEngine;
using Assets.Scripts.Com.Game.Module.Scene;


    /// <summary>
    /// 刷怪促发条件
    /// </summary>
    [SerializeField]
    public class FlagVo : MonoBehaviour
    {
        public int id;
        public EFlag flag;
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
            return string.Format("Flag_{0}_{1}", id, flag);
        }

        public DungeonFlagVo Clone()
        {
            DungeonFlagVo vo = new DungeonFlagVo();
            vo.id = id;
            vo.flag = (int)flag;
            vo.x = transform.localPosition.x;
            vo.y = transform.localPosition.y;
            vo.z = transform.localPosition.z;
            vo.r = transform.localEulerAngles.y;
            vo.width = width;
            vo.height = height;         
            vo.second = second;
            vo.monster = monster;
            vo.hp = hp;
            vo.wave = wave;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;

                var box = gameObject.GetComponent<BoxCollider>();
                if (box != null)
                {
                    vo.width = box.size.x;
                    vo.height = box.size.z;
                }
            }
            return vo;
        }
    }

    /// <summary>
    /// 怪物
    /// </summary>
    [SerializeField]
    public class MonsterlVo : MonoBehaviour
    {
        public int id;          //场景配置的唯一id
        public int actId;       //配置的Actor id           比如怪物，就是怪物表的id
        public ECamp camp;        //阵营
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
            return string.Format("Monster_{0}_{1}_{2}_{3}", id, actId, actNum, camp);
        }

        public DungeonMonsterlVo Clone()
        {
            DungeonMonsterlVo vo = new DungeonMonsterlVo();
            vo.id = id;
            vo.actId = actId;
            vo.camp = (int)camp;
            vo.actFlag = actFlag;
            vo.x = x;
            vo.y = y;
            vo.z = z;
            vo.r = r;
            vo.actNum = actNum;
            vo.randRadius = randRadius;
            vo.trigger = trigger;
            vo.modelName = modelName;
            vo.delay = delay;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;
            }
            return vo;
        }
    }

    /// <summary>
    /// 英雄
    ///     出生点
    ///     buff;skill;...
    /// </summary>
    [SerializeField]
    public class HeroVo : MonoBehaviour
    {
        public int id;          //场景配置的唯一id
        public int heroId;      //英雄表id
        public ECamp camp;        //阵营
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
            return string.Format("Hero_{0}_{1}_{2}", id, heroId, camp);
        }


        public DungeonHeroVo Clone()
        {
            DungeonHeroVo vo = new DungeonHeroVo();
            vo.id = id;
            vo.heroId = heroId;
            vo.camp = (int)camp;
            vo.x = x;
            vo.y = y;
            vo.z = z;
            vo.r = r;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;
            }
            return vo;
        }
    }

    /// <summary>
    /// 门
    /// </summary>
    [SerializeField]
    public class DoorVo : MonoBehaviour
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
            return string.Format("Door_{0}_{1}_{2}_{3}", id, type, flag, close);
        }

        public DungeonDoorVo Clone()
        {
            DungeonDoorVo vo = new DungeonDoorVo();
            vo.id = id;
            vo.type = type;
            vo.flag = flag;
            vo.close = close;
            vo.name = name;
            vo.x = x;
            vo.y = y;
            vo.z = z;
            vo.r = r;
            vo.width = width;
            vo.height = height;

            vo.doorType = doorType;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;

                var box = gameObject.GetComponent<BoxCollider>();
                if (box != null)
                {
                    vo.width = box.size.x;
                    vo.height = box.size.z;
                }
            }
            return vo;
        }
    }

    /// <summary>
    /// 陷阱
    /// </summary>
    [SerializeField]
    public class TrapVo : MonoBehaviour
    {
        public int id;          //场景配置的唯一id
        public int trapId;      //陷阱表的id
        public ECamp camp;        //阵营
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
            get { return new Vector3(width, 5f, height); }
        }
        public int GetTrapId()
        {
            var list = trapIdStr.Split(',');
            var rand = Random.Range(0, list.Length - 1);
            return int.Parse(list[rand]);
        }
        public override string ToString()
        {
            return string.Format("Trap_{0}_{1}_{2}", id, trapId, camp);
        }


        public DungeonTrapVo Clone()
        {
            DungeonTrapVo vo = new DungeonTrapVo();
            vo.id = id;
            vo.trapId = trapId;
            vo.camp = (int)camp;
            vo.x = x;
            vo.y = y;
            vo.z = z;
            vo.r = r;
            vo.width = width;
            vo.height = height;
            vo.trapIdStr = trapIdStr;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;

                var box = gameObject.GetComponent<BoxCollider>();
                if (box != null)
                {
                    vo.width = box.size.x;
                    vo.height = box.size.z;
                }
            }
            return vo;
        }
    }

    /// <summary>
    /// 传送门
    /// </summary>
    [SerializeField]
    public class PortalVo : MonoBehaviour
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
            return string.Format("Portal_{0}_{1}_{2}_{3}", id, type, flag, close);
        }

        public DungeonPortalVo Clone()
        {
            DungeonPortalVo vo = new DungeonPortalVo();
            vo.id = id;
            vo.type = type;
            vo.flag = flag;
            vo.close = close;
            vo.name = name;
            vo.x = x;
            vo.y = y;
            vo.z = z;
            vo.r = r;
            vo.width = width;
            vo.height = height;

            vo.target_x = target_x;
            vo.target_y = target_y;
            vo.target_z = target_z;
            vo.target_r = target_r;

            vo.target_type = target_type;

            if (gameObject != null)
            {
                vo.x = transform.localPosition.x;
                vo.y = transform.localPosition.y;
                vo.z = transform.localPosition.z;
                vo.r = transform.localEulerAngles.y;

                var box = gameObject.GetComponent<BoxCollider>();
                if (box != null)
                {
                    vo.width = box.size.x;
                    vo.height = box.size.z;
                }

                var target = gameObject.transform.parent.Find("target");
                if (target != null)
                {
                    vo.target_x = target.localPosition.x;
                    vo.target_y = target.localPosition.y;
                    vo.target_z = target.localPosition.z;
                    vo.target_r = target.localEulerAngles.y;
                }
            }
            return vo;
        }
    }
