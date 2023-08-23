using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Xml.Serialization;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;

public class SceneEditor : EditorWindow
{
    private static Serializer mSerializer = new Serializer();
    private static GameObject RootGo;
    private static Transform RootTrans;
    public static string RootName = "SceneEditor Root";

    private int flagId;
    private int heroId;
    private int monsterFlag;
    private int doorId;
    private int portalId;
    private int guideId;
    private int trapId;

    /// <summary>
    /// 布怪工具：导入/导出
    /// </summary>
    [MenuItem("Editor/SceneEditor")]
    static void Init()
    {
        var window = GetWindow<SceneEditor>();
        window.Show();      
    }

    void OnGUI()
    {
        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("打开场景"))
        {
            OpenScene();
        }
        if (GUILayout.Button("导入配置"))
        {
            ImportConfig();
        }
        if (GUILayout.Button("导出配置"))
        {
            ExportConfig();
        }       
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.Space();
        EditorGUILayout.Space();

        #region //添加英雄
        heroId = EditorGUILayout.IntField("添加英雄出生点,请先输入id:", heroId);
        if (GUILayout.Button("添加英雄出生点"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Hero_" + heroId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Hero_" + heroId);
                trans = go.transform;
                trans.parent = RootTrans;
                HeroNode.RootTrans = trans;
                var window = GetWindow<HeroNode>();
                window.Show();           
            }
        }
        #endregion

        EditorGUILayout.Space();
        EditorGUILayout.Space();
        EditorGUILayout.BeginHorizontal();

        #region //添加条件
        flagId = EditorGUILayout.IntField("添加触发怪条件,请先输入id:", flagId);
        if (GUILayout.Button("添加触发怪条件"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Flag_" + flagId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Flag_" + flagId);
                trans = go.transform;
                trans.parent = RootTrans;
                FlagNode.RootTrans = trans;
                var window = GetWindow<FlagNode>();
                window.Show();
            }
        }
        #endregion

        #region //添加怪
        monsterFlag = EditorGUILayout.IntField("添加怪请先输入条件id:", monsterFlag);
        if (GUILayout.Button("添加怪"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;
            Transform trans = RootTrans.Find("Flag_" + monsterFlag);
            if (trans != null)
            {
                MonsterNode.RootTrans = trans;
                var window = GetWindow<MonsterNode>();
                window.Show();
            }
            else
            {
                Debug.LogWarning("找不到条件节点");
            }
        }
        #endregion

        EditorGUILayout.EndHorizontal();
        EditorGUILayout.Space();
        EditorGUILayout.Space();

        #region //添加门
        doorId = EditorGUILayout.IntField("添加门,请先输入id:", doorId);
        if (GUILayout.Button("添加门"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Door_" + doorId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Door_" + doorId);
                trans = go.transform;
                trans.parent = RootTrans;
                DoorNode.RootTrans = trans;
                var window = GetWindow<DoorNode>();
                window.Show();
            }
        }
        #endregion

        EditorGUILayout.Space();
        EditorGUILayout.Space();

        #region //添加传送门
        portalId = EditorGUILayout.IntField("添加传送门,请先输入id:", portalId);
        if (GUILayout.Button("添加传送门"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Portal_" + portalId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Portal_" + portalId);
                trans = go.transform;
                trans.parent = RootTrans;
                PortalNode.RootTrans = trans;
                var window = GetWindow<PortalNode>();
                window.Show();
            }
        }
        #endregion

        EditorGUILayout.Space();
        EditorGUILayout.Space();

        #region //添加指引目标点
        guideId = EditorGUILayout.IntField("添加指引目标点,请先输入id:", guideId);
        if (GUILayout.Button("添加指引目标点"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Guide_" + guideId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Guide_" + guideId);
                trans = go.transform;
                trans.parent = RootTrans;
                GuideNode.RootTrans = trans;
                var window = GetWindow<GuideNode>();
                window.Show();
            }
        }
        #endregion

        EditorGUILayout.Space();
        EditorGUILayout.Space();
        #region //添加陷阱
        trapId = EditorGUILayout.IntField("添加陷阱,请先输入id:", trapId);
        if (GUILayout.Button("添加陷阱"))
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            Transform trans = RootTrans.Find("Trap_" + trapId);
            if (trans != null)
            {
                Debug.LogWarning("该id已存在");
            }
            else
            {
                GameObject go = new GameObject("Trap_" + trapId);
                trans = go.transform;
                trans.parent = RootTrans;
                TrapNode.RootTrans = trans;
                var window = GetWindow<TrapNode>();
                window.Show();
            }
        }
        #endregion

    }

    /// <summary>
    /// 载入场景
    /// </summary>
    private static void OpenScene()
    {
        AssetDatabase.Refresh();

        string str = EditorUtility.OpenFilePanel("请选择要导入的配置", "Assets/RawResourcesExport/GameScenes", "unity");
        Debug.Log("场景路径：" + str);

        if (str.Length > 0)
        {
            if (EditorApplication.OpenScene(str))
            {
                RootGo = GameObject.Find(RootName);
                if (RootGo == null)
                    RootGo = new GameObject(RootName);
                RootTrans = RootGo.transform;
            }
        }
    }
    

    /// <summary>
    /// 布怪工具：导入
    /// </summary>
    public static void ImportConfig()
    {
        AssetDatabase.Refresh();

        string str = EditorUtility.OpenFilePanel("请选择要导入的配置", "Assets/RawResourcesExport/ScenesXml", "xml");
        Debug.Log("导入路径：" + str);

        if (str.Length > 0)
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
                RootGo = new GameObject(RootName);
            RootTrans = RootGo.transform;

            for (int i = RootTrans.childCount-1; i >= 0; i--)
            {
                GameObject.DestroyImmediate(RootTrans.GetChild(i).gameObject);
             }

            List<DungeonVo> list = null;
            try
            {
                XmlReader reader = XmlReader.Create(str);
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(List<DungeonVo>));
                list = xmlSerializer.Deserialize(reader) as List<DungeonVo>;
            }
            catch (Exception e)
            {
                Debug.LogWarning("xml序列化报错：" + e);
            }
            if (list == null)
                return;

            foreach (var dungeonVo in list)
            {
                if (dungeonVo.FlagVo != null)
                {
                    DungeonFlagVo vo = dungeonVo.FlagVo;
                    var waveGo = new GameObject("Flag_" + vo.id);
                    waveGo.transform.parent = RootTrans;

                    var flagGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    var flagvo = flagGo.AddComponent<FlagVo>();
                    flagvo.id = vo.id;
                    flagvo.flag = (EFlag)vo.flag;
                    flagvo.x = vo.x;
                    flagvo.y = vo.y;
                    flagvo.z = vo.z;
                    flagvo.r = vo.r;
                    flagvo.width = vo.width;
                    flagvo.height = vo.height;
                    flagvo.second = vo.second;
                    flagvo.monster = vo.monster;
                    flagvo.hp = vo.hp;
                    flagvo.wave = vo.wave;

                    flagGo.name = flagvo.ToString();
                    var flagTrans = flagGo.transform;

                    flagTrans.parent = waveGo.transform;
                    flagTrans.localPosition = vo.position;
                    flagTrans.localEulerAngles = vo.rotation;
                    var box = flagTrans.GetComponent<BoxCollider>();
                    box.size = vo.size;

                    foreach (DungeonMonsterlVo mvo in vo.monsterList)
                    {
                        var childGo = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
                        var childVo = childGo.AddComponent<MonsterlVo>();
                        childVo.id = mvo.id;
                        childVo.actId = mvo.actId;
                        childVo.camp = (ECamp)mvo.camp;
                        childVo.actFlag = mvo.actFlag;
                        childVo.x = mvo.x;
                        childVo.y = mvo.y;
                        childVo.z = mvo.z;
                        childVo.r = mvo.r;
                        childVo.actNum = mvo.actNum;
                        childVo.randRadius = mvo.randRadius;
                        childVo.trigger = mvo.trigger;
                        childVo.modelName = mvo.modelName;
                        childVo.delay = mvo.delay;

                        childGo.name = childVo.ToString();
                        var childTrans = childGo.transform;

                        childTrans.parent = waveGo.transform;
                        childTrans.localPosition = childVo.position;
                        childTrans.localEulerAngles = childVo.rotation;

                        Debug.Log("添加怪物成功：" + mvo);
                    }

                    Debug.Log("添加条件成功：" + vo);
                }
                else if (dungeonVo.HeroVo != null)
                {
                    DungeonHeroVo vo = dungeonVo.HeroVo;
                    var waveGo = new GameObject("Hero_" + vo.id);
                    waveGo.transform.parent = RootTrans;

                    var heroGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    var hvo = heroGo.AddComponent<HeroVo>();
                    hvo.id = vo.id;
                    hvo.camp = (ECamp)vo.camp;
                    hvo.x = vo.x;
                    hvo.y = vo.y;
                    hvo.z = vo.z;
                    hvo.r = vo.r;
                    hvo.heroId = vo.heroId;

                    var childTrans = heroGo.transform;
                    childTrans.parent = waveGo.transform;
                    childTrans.localPosition = vo.position;
                    childTrans.localEulerAngles = vo.rotation;

                    heroGo.name = hvo.ToString();
                    Debug.Log("添加英雄成功：" + vo);
                }
                else if (dungeonVo.DoorVo != null)
                {
                    DungeonDoorVo vo = dungeonVo.DoorVo;
                    var waveGo = new GameObject("Door_" + vo.id);
                    waveGo.transform.parent = RootTrans;

                    var doorGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    var dvo = doorGo.AddComponent<DoorVo>();
                    dvo.id = vo.id;
                    dvo.type = vo.type;
                    dvo.flag = vo.flag;
                    dvo.close = vo.close;
                    dvo.name = vo.name;
                    dvo.x = vo.x;
                    dvo.y = vo.y;
                    dvo.z = vo.z;
                    dvo.r = vo.r;
                    dvo.width = vo.width;
                    dvo.height = vo.height;

                    dvo.doorType = vo.doorType;

                    var childTrans = doorGo.transform;
                    childTrans.parent = waveGo.transform;
                    childTrans.localPosition = vo.position;
                    childTrans.localEulerAngles = vo.rotation;

                    var box = childTrans.GetComponent<BoxCollider>();
                    box.size = vo.size;

                    doorGo.name = dvo.ToString();
                    Debug.Log("添加门成功：" + vo);
                }
                else if (dungeonVo.TrapVo != null)
                {
                    DungeonTrapVo vo = dungeonVo.TrapVo;
                    var waveGo = new GameObject("Trap_" + vo.id);
                    waveGo.transform.parent = RootTrans;

                    var trapGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    var tvo = trapGo.AddComponent<TrapVo>();
                    tvo.id = vo.id;
                    tvo.trapId = vo.trapId;
                    tvo.camp = (ECamp)vo.camp;
                    tvo.x = vo.x;
                    tvo.y = vo.y;
                    tvo.z = vo.z;
                    tvo.r = vo.r;
                    tvo.width = vo.width;
                    tvo.height = vo.height;
                    tvo.trapIdStr = vo.trapIdStr;

                    var childTrans = trapGo.transform;
                    childTrans.parent = waveGo.transform;
                    childTrans.localPosition = vo.position;
                    childTrans.localEulerAngles = vo.rotation;

                    var box = childTrans.GetComponent<BoxCollider>();
                    box.size = vo.size;

                    trapGo.name = tvo.ToString();
                    Debug.Log("添加陷阱成功：" + vo);
                }
                else if (dungeonVo.PortalVo != null)
                {
                    DungeonPortalVo vo = dungeonVo.PortalVo;
                    var waveGo = new GameObject("Portal_" + vo.id);
                    if(vo.target_type == 1)
                        waveGo.name = "Guide_" + vo.id;
                    waveGo.transform.parent = RootTrans;

                    var doorGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    var pvo = doorGo.AddComponent<PortalVo>();
                    pvo.id = vo.id;
                    pvo.type = vo.type;
                    pvo.flag = vo.flag;
                    pvo.close = vo.close;
                    pvo.name = vo.name;
                    pvo.x = vo.x;
                    pvo.y = vo.y;
                    pvo.z = vo.z;
                    pvo.r = vo.r;
                    pvo.width = vo.width;
                    pvo.height = vo.height;

                    pvo.target_x = vo.target_x;
                    pvo.target_y = vo.target_y;
                    pvo.target_z = vo.target_z;
                    pvo.target_r = vo.target_r;

                    var childTrans = doorGo.transform;
                    childTrans.parent = waveGo.transform;
                    childTrans.localPosition = vo.position;
                    childTrans.localEulerAngles = vo.rotation;

                    var box = childTrans.GetComponent<BoxCollider>();
                    box.size = vo.size;

                    doorGo.name = pvo.ToString();

                    var target = new GameObject("target");
                    target.transform.parent = waveGo.transform;
                    target.transform.localPosition = vo.target_position;
                    target.transform.localEulerAngles = vo.target_rotation;

                    pvo.target_type = vo.target_type;

                    Debug.Log("添加传送门成功：" + vo);
                }
            }

            
        }
    }


    /// <summary>
    /// 布怪工具：导出
    /// </summary>
    //[MenuItem("MonsterPositioner/Export")]
    public static void ExportConfig()
    {
        string str = EditorUtility.SaveFilePanel("导出配置", "Assets/RawResourcesExport/ScenesXml", "", "xml");
        Debug.Log("导出路径：" + str);

        if (str.Length > 0)
        {
            RootGo = GameObject.Find(RootName);
            if (RootGo == null)
            {
                Debug.LogWarning("根节点为空");
                return;
            }
            else
            {
                RootTrans = RootGo.transform;
            }

            List<DungeonVo> dungeonVoList = new List<DungeonVo>();

            for (int i = 0; i < RootTrans.childCount; i++)
            {
                var transform = RootTrans.GetChild(i);
                if (transform.name.StartsWith("Flag"))
                {
                    FlagVo flagVo = transform.GetComponentInChildren<FlagVo>();
                    if (flagVo != null)
                    {
                        var dungeonVo = new DungeonVo();
                        dungeonVo.FlagVo = flagVo.Clone();

                        var xmlvos = transform.GetComponentsInChildren<MonsterlVo>();
                        foreach (var monsterVo in xmlvos)
                        {
                            DungeonMonsterlVo mvo = monsterVo.Clone();
                            dungeonVo.FlagVo.monsterList.Add(mvo);
                        }
                        dungeonVoList.Add(dungeonVo);
                    }
                }//end Flag
                else if (transform.name.StartsWith("Hero"))
                {
                    HeroVo heroVo = transform.GetComponentInChildren<HeroVo>();
                    if (heroVo != null)
                    {
                        var dungeonVo = new DungeonVo();
                        dungeonVo.HeroVo = heroVo.Clone();
                        dungeonVoList.Add(dungeonVo);
                    }
                }//end Hero
                else if (transform.name.StartsWith("Door"))
                {
                    DoorVo doorVo = transform.GetComponentInChildren<DoorVo>();
                    if (doorVo != null)
                    {
                        var dungeonVo = new DungeonVo();
                        dungeonVo.DoorVo = doorVo.Clone();
                        dungeonVoList.Add(dungeonVo);
                    }
                }//end Door
                else if (transform.name.StartsWith("Trap"))
                {
                    TrapVo trapVo = transform.GetComponentInChildren<TrapVo>();
                    if (trapVo != null)
                    {
                        var dungeonVo = new DungeonVo();
                        dungeonVo.TrapVo = trapVo.Clone();
                        dungeonVoList.Add(dungeonVo);
                    }
                }//end Trap
                else if (transform.name.StartsWith("Portal") || transform.name.StartsWith("Guide"))
                {
                    PortalVo pVo = transform.GetComponentInChildren<PortalVo>();
                    if (pVo != null)
                    {
                        var dungeonVo = new DungeonVo();
                        dungeonVo.PortalVo = pVo.Clone();
                        dungeonVoList.Add(dungeonVo);
                    }
                }//end Portal
            }
            mSerializer.SerializeToXml(dungeonVoList, str);
            
            AssetDatabase.Refresh();
        }
    }

   
}
