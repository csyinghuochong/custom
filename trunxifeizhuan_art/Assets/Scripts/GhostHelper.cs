using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GhostHelper : MonoBehaviour {

	// Use this for initialization
    public MotionGhost ghost;
    public SkinnedMeshRenderer targetRenderer;
	void Start () 
    {
        this.ghost.SetRealTimeRenderer(this.targetRenderer);
	}

    void LateUpdate()
    {
        if (ghost)
        {
            ghost.transform.position = this.transform.position;
            ghost.transform.rotation = this.transform.rotation;
        }
    }
}
