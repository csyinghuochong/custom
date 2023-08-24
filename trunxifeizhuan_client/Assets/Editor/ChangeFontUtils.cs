using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
public class ChangeFontUtils : Editor
{
    [MenuItem("GameObject/ChangeFont22", false, 12)]
    private static void DoChangeFont22()
    {
        UnityEngine.Object[] objs = Selection.objects;
        int length = objs.Length;
        if (length <= 0)
        {
            Debug.LogError("沒有选择transform");
            return;
        }
        for (int i = 0; i < length; i++)
        {
            GameObject obj = objs[i] as GameObject;
            Text text = obj.transform.GetComponent<Text>();
            if (text != null)
            {
                Font toFont = UnityEditor.AssetDatabase.LoadAssetAtPath("Assets/AssetsLibrary/font/hkyt5.TTF", typeof(Font)) as Font;
                text.font = toFont;
                text.fontSize = 22;
                text.color = new Color(0.533f, 0.145f, 0.145f, 1.0f);
            }
            Debug.Log("ChangeFont Complete");
        }
    }

    [MenuItem("GameObject/ChangeFont18", false, 12)]
    private static void DoChangeFont18()
    {
        UnityEngine.Object[] objs = Selection.objects;
        int length = objs.Length;
        if (length <= 0)
        {
            Debug.LogError("沒有选择transform");
            return;
        }
        for (int i = 0; i < length; i++)
        {
            GameObject obj = objs[i] as GameObject;
            Text text = obj.transform.GetComponent<Text>();
            if (text != null)
            {
                Font toFont = UnityEditor.AssetDatabase.LoadAssetAtPath("Assets/AssetsLibrary/font/hkyt5.TTF", typeof(Font)) as Font;
                text.font = toFont;
                text.fontSize = 18;
                text.color = new Color(0.533f, 0.145f, 0.145f, 1.0f);
            }
            Debug.Log("ChangeFont Complete");
        }
    }

    [MenuItem("GameObject/ChangeFontDesc", false, 12)]
    private static void DoChangeFontDesc()
    {
        UnityEngine.Object[] objs = Selection.objects;
        int length = objs.Length;
        if (length <= 0)
        {
            Debug.LogError("沒有选择transform");
            return;
        }
        for (int i = 0; i < length; i++)
        {
            GameObject obj = objs[i] as GameObject;
            Text text = obj.transform.GetComponent<Text>();
            if (text != null)
            {
                Font toFont = UnityEditor.AssetDatabase.LoadAssetAtPath("Assets/AssetsLibrary/font/hkyt5.TTF", typeof(Font)) as Font;
                text.font = toFont;
                text.fontSize = 18;
                text.color = new Color(0.117f, 0.055f, 0.027f, 1.0f);
            }
            Debug.Log("ChangeFont Complete");
        }
    }

    [MenuItem("GameObject/ChangeFontBtn", false, 12)]
    private static void DoChangeFontBtn()
    {
        UnityEngine.Object[] objs = Selection.objects;
        int length = objs.Length;
        if (length <= 0)
        {
            Debug.LogError("沒有选择transform");
            return;
        }
        for (int i = 0; i < length; i++)
        {
            GameObject obj = objs[i] as GameObject;
            Text text = obj.transform.GetComponent<Text>();
            if (text != null)
            {
                Font toFont = UnityEditor.AssetDatabase.LoadAssetAtPath("Assets/AssetsLibrary/font/hkyt5.TTF", typeof(Font)) as Font;
                text.font = toFont;
                text.fontSize = 22;
                text.color = Color.white;
            }
            Shadow shadow = obj.transform.GetComponent<Shadow>();
            if (shadow != null)
            {
                shadow.effectColor = new Color(0.58f, 0.321f, 0.11f, 1.0f);
                shadow.effectDistance = new Vector2(0, -2);
            }
            Debug.Log("ChangeFont Complete");
        }
    }
}