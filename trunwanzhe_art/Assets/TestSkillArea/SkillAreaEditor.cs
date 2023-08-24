using UnityEngine;
using System.Collections;

public enum AreaType
{
    直线,
    圆形,
    扇形,
    方向
}
[ExecuteInEditMode]
public class SkillAreaEditor : MonoBehaviour {

	// Use this for initialization
    public float areaRange = 5;
    public float areaAngle = 90;
    public AreaType areaType = AreaType.方向;

    public GameObject yuan;
    public GameObject shan;
    public GameObject zhi;
    
    private AreaType lastType = AreaType.扇形;

	void Start () 
    {

	}
	
	// Update is called once per frame
	void Update () 
    {
        if (this.lastType != this.areaType)
        {
            switch (lastType)
            {
                case AreaType.方向:
                    if (this.zhi) this.zhi.SetActive(false);
                    break;
                case AreaType.扇形:
                    if (this.shan) this.shan.SetActive(false);
                    break;
                case AreaType.圆形:
                    if (this.yuan) this.yuan.SetActive(false);
                    break;
                case AreaType.直线:
                    if (this.zhi) this.zhi.SetActive(false);
                    break;
            }
            


            this.lastType = this.areaType;
        }

        switch (this.areaType)
        {
            case AreaType.方向:
                if(this.zhi)this.InitDirection();
                break;
            case AreaType.扇形:
                if(this.shan)this.InitShan();
                break;
            case AreaType.圆形:
                if(this.yuan)this.InitYuan();
                break;
            case AreaType.直线:
                if(this.zhi)this.InitZhixian();
                break;
        }

	}

    private void InitYuan()
    {
        this.yuan.SetActive(true);
        this.yuan.transform.localScale = Vector3.one * this.areaRange;
    }
    private void InitDirection()
    {
        this.zhi.SetActive(true);
        Transform main = this.zhi.transform.Find("MainEffect");
        if (main)
        {
            main.localPosition = Vector3.forward;// * Mathf.Max(1, this.areaRange - 4);
        }
    }
    private void InitZhixian()
    {
        this.zhi.SetActive(true);
        Transform main = this.zhi.transform.Find("MainEffect");
        if (main)
        {
            main.localPosition = Vector3.forward * Mathf.Max(1, this.areaRange - 4);
        }
    }
    private void InitShan()
    {
        this.shan.SetActive(true);
        Transform main = this.shan.transform.Find("MainEffect");
        if (main)
        {
            main.localScale = (Vector3.right + Vector3.forward) * this.areaRange;
            Transform left = main.Find("Left");
            Transform right = main.Find("Right");
            Transform yuanhu = main.Find("yuanhu");
            if (yuanhu)
            {
                float a = Mathf.PI * this.areaAngle * 0.5f / 180.0f;
                left.localEulerAngles = Vector3.up * this.areaAngle * 0.5f;
                right.localEulerAngles = -Vector3.up * this.areaAngle * 0.5f;
                //Shader shader = Shader.Find("Custom/SkillArea");
                //yuanhu.renderer.material.shader = shader;
                yuanhu.GetComponent<Renderer>().material.SetFloat("_Angle", a);
            }

        }
    }
}
