using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 触发条件节点
/// </summary>
public class FlagNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private EFlag addFlag = EFlag.OneHeroIn;
    private Vector3 addFlagPos;
    private float addRotation;
    private Vector2 addFlagSize;
    private int addSecond;
    private int addMonster;
    private int addHp;
    private int addWave;

//    private FlagVo[] exitFlags;
    private MonsterlVo[] waveMonsters;

    void OnGUI()
    {      
        if(RootTrans != null)
            EditorGUILayout.LabelField("添加的条件id: " + RootTrans.name.Substring(5));

        addFlag = (EFlag)EditorGUILayout.EnumPopup("刷出条件:", addFlag);
        if (addFlag == EFlag.OneHeroIn || addFlag == EFlag.AllHeroIn)
        {
            addFlagPos = EditorGUILayout.Vector3Field("英雄进入区域原点: ", addFlagPos);
            addRotation = EditorGUILayout.FloatField("方向: ", addRotation);
            EditorGUILayout.BeginHorizontal();
            addFlagSize = EditorGUILayout.Vector2Field("区域大小", addFlagSize);
            if (GUILayout.Button("复制选中位置"))
            {
                if (Selection.activeTransform == null)
                {
                    Debug.LogWarning("请先选中场景中的物件！！！");
                }
                else
                {
                    addFlagPos = Selection.activeTransform.position;
                    addRotation = Selection.activeTransform.eulerAngles.y;
                }
            }
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.Space();
            EditorGUILayout.LabelField("(击杀完某波怪 且 在设定的区域内)");
            addWave = EditorGUILayout.IntField("条件id:", addWave);
            EditorGUILayout.Space();

        }
        else if (addFlag == EFlag.SecondsLater)
        {
            addSecond = EditorGUILayout.IntField("副本开启后X秒:", addSecond);
        }
        else if (addFlag == EFlag.MonsterHp)
        {
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("注意：某怪物血量达X%，需要定义哪个条件下的哪个怪");
            
            //addWave = EditorGUILayout.IntField("条件id:", addWave);
            //addMonster = EditorGUILayout.IntField("怪物id:", addMonster);
            try
            {
                FlagVo[] exitFlags = GameObject.Find(SceneEditor.RootName).GetComponentsInChildren<FlagVo>();
                int[] flagIds = new int[exitFlags.Length];
                string[] flagNames = new string[exitFlags.Length];
                int i = 0;
                foreach (var flag in exitFlags)
                {
                    flagIds[i] = flag.id;
                    flagNames[i] = flag.ToString();
                    i++;
                }
                //addWave = flagIds[0];
                addWave = EditorGUILayout.IntPopup("条件:", addWave, flagNames, flagIds);

                waveMonsters = GameObject.Find("Flag_" + addWave).GetComponentsInChildren<MonsterlVo>();
                int[] monIds = new int[waveMonsters.Length];
                string[] monNames = new string[waveMonsters.Length];
                i = 0;
                foreach (var mon in waveMonsters)
                {
                    monIds[i] = mon.id;
                    monNames[i] = mon.ToString();
                    i++;
                }
                //addMonster = monIds[0];
                addMonster = EditorGUILayout.IntPopup("怪物:", addMonster, monNames, monIds);
            }
            catch (System.Exception ex)
            {
                Debug.Log("条件存在？！..." + ex);
            }
            
            addHp = EditorGUILayout.IntField("血量X%:", addHp);
        }
        else if (addFlag == EFlag.WaveFinish)
        {
            try
            {
                FlagVo[] exitFlags = GameObject.Find(SceneEditor.RootName).GetComponentsInChildren<FlagVo>();
                int[] flagIds = new int[exitFlags.Length];
                string[] flagNames = new string[exitFlags.Length];
                int i = 0;
                foreach (var flag in exitFlags)
                {
                    flagIds[i] = flag.id;
                    flagNames[i] = flag.ToString();
                    i++;
                }
                //addWave = flagIds[0];
                addWave = EditorGUILayout.IntPopup("条件id:", addWave, flagNames, flagIds);
                addSecond = EditorGUILayout.IntField("杀光后X秒后再刷:", addSecond);
            }
            catch (System.Exception ex)
            {
                Debug.Log("条件存在？！..." + ex);
            }
        }
        else if (addFlag == EFlag.MeleeSoldier)
        {
            addHp = EditorGUILayout.IntField("比赛开始X秒后开刷:", addHp);
            addSecond = EditorGUILayout.IntField("每隔X秒再刷一波:", addSecond);
        }
        else if (addFlag == EFlag.MeleeNeutral)
        {
            addSecond = EditorGUILayout.IntField("杀光后X秒后再刷一波:", addSecond);
        }

        if (GUILayout.Button("按条件添加一波"))
        {
            AddNode();
        }
    }

    /// <summary>
    /// 添加条件节点
    ///     条件里面可包含怪节点
    /// 创建圆柱体
    /// </summary>
    private void AddNode()
    {
        var childGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
        var vo = childGo.AddComponent<FlagVo>();
        vo.id = int.Parse(RootTrans.name.Substring(5));
        vo.flag = addFlag;
        vo.x = addFlagPos.x;
        vo.y = addFlagPos.y;
        vo.z = addFlagPos.z;
        vo.r = addRotation;
        vo.width = addFlagSize.x;
        vo.height = addFlagSize.y;
        vo.second = addSecond;
        vo.monster = addMonster;
        vo.hp = addHp;
        vo.wave = addWave;
       
        var childTrans = childGo.transform;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        var box = childTrans.GetComponent<BoxCollider>();
        box.size = vo.size;

        childGo.name = vo.ToString();
        Debug.Log("添加触发条件成功：" + vo);
        ResetData();
        this.Close();
    }

    private void ResetData()
    {
        addFlagPos = Vector3.zero;
        addRotation = 0f;
        addFlagSize = Vector2.zero;
        addSecond = 0;
        addHp = 0;
        addWave = 0;
        waveMonsters = null;
        addMonster = 0;
        //exitFlags = null;
    }
}
