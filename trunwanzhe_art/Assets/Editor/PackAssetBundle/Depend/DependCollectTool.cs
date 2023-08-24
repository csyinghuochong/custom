using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEditor;
using System.IO;

namespace Assets.Editor.PackAssetBundle.Depend
{
    public class DependCollectTool
    {
        public const string cMeshFilterPrefabPath = "Assets/RawResources/MeshFilter/{0}.prefab";
        public static readonly HashSet<string> sMeshFilterPrefabSet = new HashSet<string>();

        const string _MainTex = "_MainTex";
        const string _MainTexLM = "_MainTexLM";
        public static readonly List<string> mTexturesList = new List<string>() { _MainTex, "_Splat0", "_Splat1", "_Splat2", "_Splat3", "_Control", "_Illum", "_DetailTex", _MainTexLM, "_AlphaTexLM" };
        static public bool mSplit = true;
        static public bool mCollect = false;

        static Dictionary<string, int> mAssetCountDic = new Dictionary<string, int>();
        static void AddAssetCount(string path)
        {
            mAssetCountDic[path] = GetAssetCount(path) + 1;
        }

        static int GetAssetCount(string path)
        {
            int count = 0;
            mAssetCountDic.TryGetValue(path, out count);
            return count;
        }

        static HashSet<string> mAssetsHashSet;
        static public void CollectAssetsStart()
        {
            mAssetsHashSet = new HashSet<string>();
        }

        static public void CollectAssetsEnd()
        {
            foreach (var str in mAssetsHashSet)
            {
                AddAssetCount(str);
            }

            mAssetsHashSet.Clear();
        }

        static void CollectAssets(HashSet<string> hashSet)
        {
            mAssetsHashSet.UnionWith(hashSet);
        }

        static public List<string> AnalyseMeshFilter(MeshFilter meshFilter)
        {
            if (meshFilter == null)
                return null;

            List<string> result = new List<string>();
            GameObject prefabRoot = PrefabUtility.FindPrefabRoot(meshFilter.gameObject);

            if (mCollect)
            {
                if (prefabRoot != null && meshFilter.sharedMesh != null)
                {
                    HashSet<string> hashSet = new HashSet<string>();

                    string meshName = string.Format("Mesh_{0}_{1}", prefabRoot.name, meshFilter.sharedMesh.name);
                    string path = string.Format(cMeshFilterPrefabPath, meshName);

                    hashSet.Add(path);
                    CollectAssets(hashSet);
                }
            }
            else
            {
                if (prefabRoot == null || meshFilter.sharedMesh == null)
                {
                    result.Add("");
                }
                else
                {
                    string meshName = string.Format("Mesh_{0}_{1}", prefabRoot.name, meshFilter.sharedMesh.name);
                    string path = string.Format(cMeshFilterPrefabPath, meshName);

                    if (mSplit || GetAssetCount(path) > 1)
                    {
                        result.Add(meshName);

                        if (!sMeshFilterPrefabSet.Contains(path))
                        {
                            sMeshFilterPrefabSet.Add(path);

                            if (File.Exists(path))
                            {
                                GameObject go = AssetDatabase.LoadAssetAtPath(path, typeof(UnityEngine.Object)) as GameObject;
                                Mesh oldMesh = go.GetComponent<MeshFilter>().sharedMesh;
                                if (oldMesh != meshFilter.sharedMesh)
                                {
                                    GameObject g = new GameObject(meshName);
                                    g.AddComponent<MeshFilter>().sharedMesh = meshFilter.sharedMesh;
                                    PrefabUtility.CreatePrefab(path, g);
                                    GameObject.DestroyImmediate(g);
                                }
                            }
                            else
                            {
                                GameObject g = new GameObject(meshName);
                                g.AddComponent<MeshFilter>().sharedMesh = meshFilter.sharedMesh;
                                PrefabUtility.CreatePrefab(path, g);
                                GameObject.DestroyImmediate(g);
                            }
                        }

                        meshFilter.sharedMesh = null;
                        meshFilter.mesh = null;
                    }
                    else
                    {
                        result.Add("");
                    }
                }
            }

            return result;
        }

        static public List<string> AnalyseRenderer(Renderer render)
        {
            if (render == null)
                return null;

            List<string> result = new List<string>();
            Material[] materials = render.sharedMaterials;

            if (mCollect)
            {
                AnalyseMetarials(materials);
            }
            else
            {
                for (int i = 0, count = materials.Length; i < count; i++)
                {
                    Material material = materials[i];

                    if (material)
                    {
                        DeleteSomeTextures(material);

                        if (mSplit || IsMaterialShared(material))
                        {
                            CollectTextures(material);
                        }

                        result.Add(material.name);
                    }
                    else
                    {
                        result.Add("");
                    }
                }

                render.sharedMaterial = null;
                render.sharedMaterials = materials;
                render.material = null;
                render.materials = materials;
            }

            return result;
        }

        static public Dictionary<string, string> mDependDesDic = new Dictionary<string, string>();
        static public HashSet<string> mTexturesHasSet = new HashSet<string>();

        static private void DeleteSomeTextures(Material mat)
        {
            if (mat.HasProperty(_MainTexLM))
            {
                mat.SetTexture(_MainTex, null);
            }
        }

        static private void CollectTextures(Material mat)
        {
            string dependKey = mat.name + ".mat";
            string dependDesc = "";

            for (int i = 0, count = DependCollectTool.mTexturesList.Count; i < count; i++)
            {
                string texName = DependCollectTool.mTexturesList[i];
                if (mat.HasProperty(texName))
                {
                    Texture tex = mat.GetTexture(texName);
                    if (tex != null)
                    {
                        mat.SetTexture(texName, null);

                        string texPath = AssetDatabase.GetAssetOrScenePath(tex);
                        mTexturesHasSet.Add(texPath);
                    }

                    if (string.IsNullOrEmpty(dependDesc))
                    {
                        dependDesc = "Texture:" + (tex == null ? "nil" : tex.name);
                    }
                    else
                    {
                        dependDesc += "," + (tex == null ? "nil" : tex.name);
                    }
                }
            }

            if (string.IsNullOrEmpty(dependDesc) == false && mDependDesDic.ContainsKey(dependKey) == false)
                mDependDesDic[dependKey] = dependDesc;
        }

        static private HashSet<string> AnalyseMetarialPath(Material mat)
        {
            HashSet<string> hashSet = new HashSet<string>();

            if (mat != null)
            {
                string materialPath = AssetDatabase.GetAssetOrScenePath(mat);
                hashSet.Add(materialPath);

                for (int i = 0, count = mTexturesList.Count; i < count; i++)
                {
                    string texName = mTexturesList[i];
                    if (mat.HasProperty(texName))
                    {
                        Texture tex = mat.GetTexture(texName);
                        if (tex != null)
                        {
                            string texPath = AssetDatabase.GetAssetOrScenePath(tex);
                            hashSet.Add(texPath);
                        }
                    }
                }
            }

            return hashSet;
        }

        static private void AnalyseMetarials(Material[] mats)
        {
            if (mats == null)
                return;

            HashSet<string> hashSet = new HashSet<string>();

            for (int k = 0, len = mats.Length; k < len; k++)
            {
                Material mat = mats[k];

                if (mat != null)
                {
                    DeleteSomeTextures(mat);
                    hashSet.UnionWith(AnalyseMetarialPath(mat));
                }
            }

            CollectAssets(hashSet);
        }

        static bool IsMaterialShared(Material mat)
        {
            if (mat == null)
                return false;

            if (mAssetCountDic.Count == 0)
                return true;

            HashSet<string> hashSet = AnalyseMetarialPath(mat);
            foreach (var str in hashSet)
            {
                if (GetAssetCount(str) > 1)
                {
                    return true;
                }
            }

            return false;
        }
    }
}
