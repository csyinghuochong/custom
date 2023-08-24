using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.UI;

public class SortTransform : Editor
{
    [MenuItem("GameObject/SortTransform", false, 12)]
    private static void DoSortTransform()
    {
        GameObject obj = Selection.activeObject as GameObject;
        if (!obj)
        {
            Debug.LogError("沒有选择transform");
            return;
        }

        Sort(obj.transform);
        Debug.Log("SortTransform Complete");
    }

    [MenuItem("GameObject/SortTransformRecursive", false, 12)]
    private static void DoSortTransformRecursive()
    {
        GameObject obj = Selection.activeObject as GameObject;
        if (!obj)
        {
            Debug.LogError("沒有选择transform");
            return;
        }

        Sort(obj.transform, true);
        Debug.Log("SortTransformRecursive Complete");
    }

    static void AddTag(string tag, List<string> tagList, Dictionary<string, List<Transform>> tagTransformList, Transform childTransform)
    {
        if (tagList.Contains(tag) == false)
        {
            tagList.Add(tag);
        }

        List<Transform> tagTransforms;
        if (tagTransformList.TryGetValue(tag, out tagTransforms) == false)
        {
            tagTransforms = new List<Transform>();
            tagTransformList[tag] = tagTransforms;
        }

        if (childTransform != null)
            tagTransforms.Add(childTransform);
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
    static void Sort(Transform transform, bool recursive = false, int depth = 0)
    {
        if (depth == 0)
        {
            sFirstTransform = transform;
        }

        List<string> tagList = new List<string> { };
        Dictionary<string, List<Transform>> tagTransformList = new Dictionary<string, List<Transform>>();
        List<Transform> textTransformList = new List<Transform>();
        AddTag("common", tagList, tagTransformList, null);

        for (int i = 0, count = transform.childCount; i < count; i++)
        {
            var childTransform = transform.GetChild(i);

            var childImageComponent = childTransform.GetComponent<Image>();
            if (childImageComponent != null)
            {
                var mainTexture = childImageComponent.mainTexture;
                if (mainTexture != null && childImageComponent.sprite != null)
                {
                    var spriteName = mainTexture.name;
                    var assets = AssetDatabase.FindAssets(spriteName + " t:texture2D");
                    if (assets.Length != 1)
                    {
                        Debug.LogError(string.Format("找到{0}个{1},childPath:{2}", assets.Length, spriteName, GetTransformPath(childTransform)));
                    }
                    var spritePath = AssetDatabase.GUIDToAssetPath(assets[0]);
                    var assetImporter = AssetImporter.GetAtPath(spritePath) as TextureImporter;
                    var tag = assetImporter.spritePackingTag;
                    AddTag(tag, tagList, tagTransformList, childTransform);
                    continue;
                }
            }

            var childTextComponent = childTransform.GetComponent<Text>();
            if (childTextComponent != null)
            {
                textTransformList.Add(childTransform);
                continue;
            }

            AddTag("empty", tagList, tagTransformList, childTransform);
        }

        var childIndex = 0;
        for (int i = 0, count = tagList.Count; i < count; i++)
        {
            var tag = tagList[i];
            var transformList = tagTransformList[tag];
            for (int k = 0; k < transformList.Count; k++)
            {
                var childTransform = transformList[k];
                childTransform.SetSiblingIndex(childIndex++);

                if (recursive)
                {
                    Sort(childTransform, true, depth + 1);
                }
            }
        }

        for (int i = 0, count = textTransformList.Count; i < count; i++)
        {
            var childTransform = textTransformList[i];
            childTransform.SetSiblingIndex(childIndex++);
            if (recursive)
            {
                Sort(childTransform, true, depth + 1);
            }
        }
    }

}
