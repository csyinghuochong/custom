using System.Collections;
using System.Collections.Generic;
using System.Collections;
using UnityEngine;

public class CombineModel : MonoBehaviour 
{
    class MeshInfo
    {
        public SkinnedMeshRenderer[] smrs;
    }
    public GameObject[] components;
    public bool mergeSubMeshes = false;
    public bool useMatrices = false;
    public bool combine = true;
	void Start () 
    {
	}
	
	void Update () 
    {
        if (this.combine)
        {
            this.Combine();
            this.combine = false;
        }
	}

    void Combine()
    {
        SkinnedMeshRenderer smr = this.GetComponentInChildren<SkinnedMeshRenderer>(true);
        Transform[] transforms = this.GetComponentsInChildren<Transform>(true);
        Dictionary<string, Transform> bonesMap = new Dictionary<string, Transform>();
        List<CombineInstance> combineInstances = new List<CombineInstance>();
        List<Transform> bones = new List<Transform>();
        List<Material> materials = new List<Material>();

        foreach (var trans in transforms)
        {
            bonesMap[trans.name] = trans;
        }

        foreach (var comp in this.components)
        {

            this.AddCombineInstances(comp.GetComponentsInChildren<SkinnedMeshRenderer>(true), combineInstances, bones, materials, bonesMap);
        }
        smr.sharedMesh = new Mesh();
        smr.sharedMesh.CombineMeshes(combineInstances.ToArray(), this.mergeSubMeshes, this.useMatrices);
        smr.materials = materials.ToArray();
        smr.bones = bones.ToArray();
    }
    void AddCombineInstances(SkinnedMeshRenderer[] smrs, List<CombineInstance> combineInstances, List<Transform> bones, List<Material> materials, Dictionary<string, Transform> bonesMap)
    {
        foreach (var smr in smrs)
        {
            var mesh = smr.sharedMesh;
            for (int i = 0; i < mesh.subMeshCount; i++)
            {
                CombineInstance instance = new CombineInstance();
                instance.mesh = mesh;
                instance.subMeshIndex = i;
                combineInstances.Add(instance);
            }

            foreach(var bone in smr.bones)
            {
                if (bonesMap.ContainsKey(bone.name))
                {
                    bones.Add(bonesMap[bone.name]);
                }
                else
                {
                    Debug.LogError(string.Format("{0}不存在骨骼名字为{1}的骨骼",smr.gameObject.name,bone.name));
                }
                
            }

            foreach (var mtl in smr.sharedMaterials)
            {
                materials.Add(mtl);
            }
        }
    }
}
