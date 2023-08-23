using UnityEngine;
using System.Collections;
[RequireComponent(typeof(Animator))]
public class SkillShakeHelper : MonoBehaviour {

	// Use this for initialization
    public string skillName;
    public float shakeTime;
    public string shakeName;
    public Animator shakeCamera;
    private Animator animator;
    private bool shaked = false;
	void Start () 
    {
        this.animator = this.GetComponent<Animator>();
	}
	
	// Update is called once per frame
	void Update () 
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            this.animator.CrossFade(skillName, 0.0f);
            this.shaked = false;
        }
        if(!shaked)
        {
            AnimatorStateInfo info = this.animator.GetCurrentAnimatorStateInfo(0);
            if (info.IsName(this.skillName))
            {
                if (info.normalizedTime >= this.shakeTime)
                {
                    this.shaked = true;
                    if (shakeCamera)
                    {
                        shakeCamera.CrossFade(shakeName,0);
                    }
                }
            }
        }

	}

    void OnShake()
    {

    }
}
