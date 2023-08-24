using UnityEngine;

public class ChangerEquipt : MonoBehaviour
{
      public Transform idplayer;//就是玩家
      public Transform idpartplayer;//所换的装备。


      public void ChangeEquip(Transform boneObj, Transform rootObj)
      {
            SkinnedMeshRenderer[] skinnedMeshRenderers = boneObj.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (var tmpRender in skinnedMeshRenderers)
            {
                  ProcessMeshRender(tmpRender, rootObj);
            }

      }

      private void ProcessMeshRender(SkinnedMeshRenderer thisRender,Transform rootObj)
      {
           GameObject newObj = new GameObject(thisRender.gameObject.name);
           newObj.transform.parent = rootObj.transform;
           SkinnedMeshRenderer newRenderer = newObj.AddComponent<SkinnedMeshRenderer>();
           Transform[] myBones = new Transform[thisRender.bones.Length];
           for (int i = 0; i < thisRender.bones.Length; i++)
           {
                 myBones[i] = FindChildByName(thisRender.bones[i].name, rootObj);
           }
           newRenderer.rootBone = rootObj;
           newRenderer.bones = myBones;
           newRenderer.sharedMesh = thisRender.sharedMesh;
           newRenderer.materials = thisRender.materials;

      }

      private Transform FindChildByName(string thisName,Transform thisObj)
      {
            Transform resultObj = null;
            if (thisObj.name == thisName)
            {
                  return thisObj.transform;
            }

            for (int i = 0; i < thisObj.childCount; i++)
            {
                  resultObj = FindChildByName(thisName, thisObj.GetChild(i));
                  if (resultObj != null)
                  {
                        return resultObj;
                  }
            }
            return resultObj;
      }

      private void Start()
      {
            ChangeEquip(idpartplayer,this.idplayer);
      }
}
