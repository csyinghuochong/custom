using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 添加指引目标点
/// </summary>
public class GuideNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private int addType = 1;
    private int addFlag;
    private int addClose;
    private string addName;
    private Vector3 addPos;
    private float addRotation;
    private Vector2 addSize;

    private Vector3 targetPos;
    private float targetRotation;

    private int targetType = 1;     //目标点类型: (0传送点，1指引点）

    void OnGUI()
    {
        EditorGUILayout.BeginVertical();

        if (RootTrans != null)
            EditorGUILayout.LabelField("添加的指引目标点id: " + RootTrans.name.Substring(6));

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

        targetPos = EditorGUILayout.Vector3Field("目标位置: ", targetPos);
        if (GUILayout.Button("复制选中位置和方向"))
        {
            if (Selection.activeTransform == null)
            {
                Debug.LogWarning("请先选中场景中的物件！！！");
            }
            else
            {
                targetPos = Selection.activeTransform.position;
            }
        }

        EditorGUILayout.Space();
        EditorGUILayout.Space(); 
        EditorGUILayout.Space();

        if (GUILayout.Button("确认添加指引目标点"))
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
        var vo = childGo.AddComponent<PortalVo>();
        vo.id = int.Parse(RootTrans.name.Substring(6));
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

        vo.target_x = targetPos.x;
        vo.target_y = targetPos.y;
        vo.target_z = targetPos.z;
        vo.target_r = targetRotation;

        vo.target_type = targetType;

        var childTrans = childGo.transform;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        var box = childTrans.GetComponent<BoxCollider>();
        box.size = vo.size;

        childGo.name = string.Format("Guide_{0}_{1}_{2}", vo.id, vo.type, vo.flag);

        var target = new GameObject("target");
        target.transform.parent = RootTrans;
        target.transform.localPosition = vo.target_position;
        target.transform.localEulerAngles = vo.target_rotation;

        Debug.Log("添加指引目标点成功：" + string.Format("Guide_{0}_{1}_{2}", vo.id, vo.type, vo.flag));
        this.Close();
    }
}

