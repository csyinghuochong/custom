using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using UnityEngine.UI;

public class CheckAssets : MonoBehaviour
{
    //UIPrefab文件夹目录
    private static string UIPrefabPath = Application.dataPath + "/RawResources/ui";

    static Dictionary<int, Transform> selectObj = new Dictionary<int, Transform>();

    static Dictionary<int, HashSet<string>> AllObj = new Dictionary<int, HashSet<string>>();

    private static UnityEngine.Object[] selectGO;
    
    public static void CheckSpriteCite()
    {
         selectGO = Selection.objects;

        selectObj.Clear();
        AllObj.Clear();

        if (selectGO == null)
            return;
        for (int i = 0; i < selectGO.Length; i++)
        {
            System.Type type = selectGO[i].GetType();
            if (type.Name != "Texture2D")
            {
                Debug.LogError("请选择图片");
            }
            else
            {
                Texture2D t2D = (Texture2D)selectGO[i];
                GameObject prefabParent = new GameObject();
                prefabParent.name = t2D.name;
                selectObj.Add(t2D.GetInstanceID(),prefabParent.transform);
            }
         }
         CheckOn();
    }

    public static void CheckScripts()
    {        
        if (Selection.objects == null)
            return;

        string target = "";
        UnityEngine.Object[] selectGO = Selection.objects;

        string[] files = Directory.GetFiles(UIPrefabPath, "*.prefab", SearchOption.AllDirectories);

        Dictionary<string, HashSet<UnityEngine.Object>> filelst = new Dictionary<string, HashSet<UnityEngine.Object>>();

        for (int i = 0; i < files.Length; i++)
        {
            string p = files[i].Replace(UIPrefabPath, "Assets/RawResources/ui");
            string[] source = AssetDatabase.GetDependencies(new string[] { p });
            for (int j = 0; j < source.Length; j++)
            {
                for (int k = 0; k < selectGO.Length; k++)
                {
                    target = AssetDatabase.GetAssetPath(selectGO[k]);
                    if (string.IsNullOrEmpty(target))
                        break;
                    if (source[j] == target)
                    {
                        if (filelst.ContainsKey(target))
                        {
                            filelst[target].Add(AssetDatabase.LoadMainAssetAtPath(files[i].Replace(UIPrefabPath, "Assets/RawResources/ui")));
                        }
                        else
                        {
                            HashSet<UnityEngine.Object> obj = new HashSet<Object>();
                            obj.Add(AssetDatabase.LoadMainAssetAtPath(files[i].Replace(UIPrefabPath, "Assets/RawResources/ui")));
                            filelst.Add(target,obj);
                        }                        
                    }                        
                }
            }
        }

        if (filelst.Count > 0)
        {
            foreach(KeyValuePair<string, HashSet<UnityEngine.Object>> kvp in filelst)
            {
                GameObject go = new GameObject();
                go.name = kvp.Key;
                HashSet<UnityEngine.Object> hashObj = kvp.Value;
                foreach(var p in hashObj)
                {
                    GameObject parfabObj = GameObject.Instantiate((GameObject)p);
                    parfabObj.transform.SetParent(go.transform);
                }   
            }
        }
    }

    public static void ChangeImage()
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
            ChangeImage(obj.transform);
        }
    }

    static void CheckOn()
    {
        string staticWriteText = "";
        DirectoryInfo Dinfo = new DirectoryInfo(UIPrefabPath);
        if (!Dinfo.Exists) return;
        FileInfo[] fileInfos = Dinfo.GetFiles("*.prefab", SearchOption.AllDirectories);
        List<int> IsCite = new List<int>(); 

        foreach (FileInfo files in fileInfos)
        {
            string path = files.FullName;
            string assetPath = path.Substring(path.IndexOf("Assets\\"));
            staticWriteText += assetPath + "\n";
            GameObject prefab = AssetDatabase.LoadAssetAtPath(assetPath, typeof(GameObject)) as GameObject;
            Image[] Images = prefab.GetComponentsInChildren<Image>(true);
            RawImage[] RawImages = prefab.GetComponentsInChildren<RawImage>(true);

            for (int i = 0; i < Images.Length; i++)
            {
                Image im = Images[i];
                if (im.mainTexture != null)
                 { 
                    int insID = im.mainTexture.GetInstanceID();
                    if(selectObj.ContainsKey(insID))
                    {
                        AddObj(im.mainTexture.GetInstanceID(), prefab);
                        if (!IsCite.Contains(insID))                        
                            IsCite.Add(insID);                        
                    }
                }
            }
            for (int i = 0; i < RawImages.Length; i++)
            {
                RawImage rIm = RawImages[i];
                if (rIm.mainTexture != null)
                {
                    int insID = rIm.mainTexture.GetInstanceID();
                    if (selectObj.ContainsKey(rIm.mainTexture.GetInstanceID()))
                    {
                        AddObj(rIm.mainTexture.GetInstanceID(), prefab);
                        if(!IsCite.Contains(insID))
                            IsCite.Add(insID);
                    }
                }    
            }
        }
        DelectPicture(IsCite);
    }

    static void DelectPicture(List<int> IsCite)
    {
        List<int> NoCite = new List<int>();
        List<UnityEngine.Object> delectObj = new List<Object>();
        foreach(KeyValuePair<int,Transform> go in selectObj)
        {
            if (!IsCite.Contains(go.Key))
            {
                NoCite.Add(go.Key);                
            }
        }
        int len = selectGO.Length;
        for (int i = 0; i < len ; i++)
        {
            int selectNum = selectGO[i].GetInstanceID();
            if (NoCite.Contains(selectNum))
            {
                string AssetPath = AssetDatabase.GetAssetPath(selectGO[i]);
                AssetDatabase.DeleteAsset(AssetPath);
            }
        }
        selectObj.Clear();
        AllObj.Clear();
        selectGO = null;
    }

    static void AddObj(int ImageID,GameObject PrefabAsset)
    {
        string prefabName = PrefabAsset.name;
        if (AllObj.ContainsKey(ImageID))
        {
            if (!AllObj[ImageID].Contains(prefabName))
            {
                GameObject p = GameObject.Instantiate(PrefabAsset);
                p.transform.SetParent(selectObj[ImageID]);
                AllObj[ImageID].Add(prefabName);
            }
        }
        else
        {
            GameObject p = GameObject.Instantiate(PrefabAsset);
            p.transform.SetParent(selectObj[ImageID]);
            HashSet<string> hash = new HashSet<string>();
            hash.Add(prefabName);
            AllObj.Add(ImageID, hash);
        } 
    }

    static string[] words = new string[4] { "common_button_1", "common_button_2", "common_icon_close2", "common_icon_return" };
    static Transform sFirstTransform;
    static void ChangeImage(Transform transform, int depth = 0)
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
                if (childImageComponent.sprite != null)
                {
                    if (CheckIsChangeImg(childImageComponent.sprite.name))
                    {
                        Debug.Log(GetTransformPath(childTransform) + "        " + childImageComponent.sprite.name);
                        childImageComponent.SetNativeSize();
                    }
                }
            }

            ChangeImage(childTransform, depth + 1);
        }
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

    static bool CheckIsChangeImg(string name)
    {
        for (int i = 0; i < words.Length; i++)
        {
            if (name == words[i])
            {
                return true;
            }
        }
        return false;
    }
}
