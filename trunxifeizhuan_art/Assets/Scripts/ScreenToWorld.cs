using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ScreenToWorld : MonoBehaviour {

    public Camera twoDCamera;
    public Camera threeDCamera;
    public Transform[] twoDObjects;
    public Transform[] threeDObjects;
    private Plane mPlane = new Plane(Vector3.up, Vector3.zero);
	void Update () 
    {
        if (this.threeDCamera&&this.twoDCamera)
        {
           
            for (int i = 0; i < this.twoDObjects.Length; i++)
            {
                if (this.threeDObjects.Length > i)
                {
                    if (this.threeDObjects[i] && this.threeDObjects[i])
                    {
                        Vector3 screenPosition = this.twoDCamera.WorldToScreenPoint(this.twoDObjects[i].position);
                        Ray ray = this.threeDCamera.ScreenPointToRay(screenPosition);
                        float enter = 0;
                        mPlane.Raycast(ray,out enter);
                        this.threeDObjects[i].position = ray.GetPoint(enter); ;
                    }

                }

            }

        }
	}
}
