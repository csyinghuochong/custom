using UnityEngine;
using System.Collections;

class UiEffect : MonoBehaviour
{
    void Start()
    {
        //设置队列
        Renderer[] rendererList = gameObject.GetComponentsInChildren<Renderer>();
        for (int i = 0, count = rendererList.Length; i < count; i++)
        {
            Renderer render = rendererList[i];
            render.material.renderQueue = 3200;
        }
    }
}
