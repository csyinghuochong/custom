using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 添加门节点
/// </summary>
public class DoorNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private int addDoorType = 0;
    private int addType = 1;
    private int addFlag;
    private int addClose;
    private string addName;
    private Vector3 addPos;
    private float addRotation;
    private Vector2 addSize;

    void OnGUI()
    {
        EditorGUILayout.BeginVertical();

        if (RootTrans != null)
            EditorGUILayout.LabelField("添加的门id: " + RootTrans.name.Substring(5));

        EditorGUILayout.LabelField("门的类型：0光门、1木栏、2路标");
        addDoorType = EditorGUILayout.IntField("门的类型：", addDoorType);

        EditorGUILayout.Space();

        EditorGUILayout.LabelField("条件类型：1第X个条件触发 2第X个条件的怪物全部被杀");
        addType = EditorGUILayout.IntField("条件类型：", addType);

        //addFlag = EditorGUILayout.IntField("对应的条件id:", addFlag);

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
        addFlag = EditorGUILayout.IntPopup("条件id:", addFlag, flagNames, flagIds);

        addClose = EditorGUILayout.IntField("0打开/1关闭:", addClose);
        addName = EditorGUILayout.TextField("门的路径", addName);
        if (GUILayout.Button("复制选中名字"))
        {
            if (Selection.activeTransform == null)
            {
                Debug.LogWarning("请先选中场景中的物件！！！");
            }
            else
            {
                addName = Selection.activeTransform.name;
            }
        }
        addPos = EditorGUILayout.Vector3Field("位置: ", addPos);
        addRotation = EditorGUILayout.FloatField("方向: ", addRotation);
        if (GUILayout.Button("复制选中位置和方向"))
        {
            if (Selection.activeTransform == null)
            {
                Debug.LogWarning("请先选中场景中的物件！！！");
            }
            else
            {
                addPos = Selection.activeTransform.position;
                addRotation = Selection.activeTransform.eulerAngles.y;
            }
        }       
        addSize = EditorGUILayout.Vector2Field("区域大小", addSize);

        EditorGUILayout.Space();

        if (GUILayout.Button("确认添加门"))
        {
            AddNode();
        }

        EditorGUILayout.EndVertical();
    }

    /// <summary>
    /// 添加节点
    /// 创建圆柱体
    /// </summary>
    private void AddNode()
    {
        var childGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
        var vo = childGo.AddComponent<DoorVo>();
        vo.id = int.Parse(RootTrans.name.Substring(5));
        vo.type = addType;
        vo.flag = addFlag;
        vo.close = addClose;
        vo.name = addName;
        vo.x = addPos.x;
        vo.y = addPos.y;
        vo.z = addPos.z;
        vo.r = addRotation;
        vo.width = addSize.x;
        vo.height = addSize.y;

        vo.doorType = addDoorType;

        var childTrans = childGo.transform;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        var box = childTrans.GetComponent<BoxCollider>();
        box.size = vo.size;

        //var count = Mathf.FloorToInt(vo.width) + 1;
        //for (int i = 0; i < count; i++)
        //{
        //    var obstacleGo = new GameObject("ob" + i);
        //    obstacleGo.transform.parent = childGo.transform;
        //    obstacleGo.transform.localPosition = new Vector3(vo.width * i/count - vo.width/2, 0f, 0f);
        //    var obstacle = obstacleGo.AddComponent<NavMeshObstacle>();
        //    obstacle.radius = vo.height * 0.5f;
        //    obstacle.height = 5f;
        //}

            childGo.name = vo.ToString();
        Debug.Log("添加门成功：" + vo);
        this.Close();
    }
}

