using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
public class CheckUtils : Editor
{
    [MenuItem("GameObject/CheckEmptyImage", false, 12)]
    private static void DoCheckEmptyImage()
    {
        GameObject obj = Selection.activeObject as GameObject;
        if (!obj)
        {
            Debug.LogError("沒有选择transform");
            return;
        }

        CheckImage(obj.transform, true);
        Debug.Log("CheckImage Complete");
    }

    static string GetTransformPath(Transform transform)
    {
        string path = transform.name;

        while (transform.parent != null && transform.parent != sFirstTransform.parent)
        {
            path = transform.parent.name + "/" + path;
            transform = transform.parent;
        }

        return path;
    }

    static Transform sFirstTransform;
    static void CheckImage(Transform transform, bool recursive = false, int depth = 0)
    {
        if (depth == 0)
        {
            sFirstTransform = transform;
        }

        for (int i = 0, count = transform.childCount; i < count; i++)
        {
            var childTransform = transform.GetChild(i);

            var childImageComponent = childTransform.GetComponent<Image>();
            if (childImageComponent != null)
            {
                if (childImageComponent.sprite == null && childTransform.GetComponent<Mask>() == null)
                {
                    Debug.LogError(string.Format("childPath:{0} image is empty", GetTransformPath(childTransform)));
                }
            }

            CheckImage(childTransform, recursive, depth + 1);
        }
    }

    [MenuItem("Tools/清空PlayerPrefs")]
    private static void EmptyPlayerPrefs()
    {
        PlayerPrefs.DeleteAll();
    }
}