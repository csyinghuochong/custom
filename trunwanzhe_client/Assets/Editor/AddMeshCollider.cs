using UnityEngine;
using System.Collections;
using UnityEditor;

public class AddMeshCollider : Editor 
{
    [MenuItem("Editor/AddMeshCollider")]
    static void AddMeshColliderToObject()
    {
        GameObject activeObject = Selection.activeGameObject;
        MeshCollider[] childMeshCollider = activeObject.GetComponentsInChildren<MeshCollider>();
        foreach (var item in childMeshCollider)
        {
            DestroyImmediate(item);
        }

        MeshRenderer[] childMeshRender = activeObject.GetComponentsInChildren<MeshRenderer>();
        foreach (var item in childMeshRender)
        {
            item.gameObject.AddComponent<MeshCollider>();
        }
    }
}
