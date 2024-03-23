using UnityEngine;
using System.Collections;
using System;
using CodeStage.AntiCheat.ObscuredTypes;
using Weijing;

//施法状态脚本，用于玩家选择施法区域时调用此脚本
public class RoseSkill_Sing_1 : MonoBehaviour
{

    //public float SkillRange;                  //技能范围
    private GameObject SkillEffect;             //技能特效
    private GameObject SkillObj;                //触发技能的OBJ
    public string SelectSkillRangeType;         //技能选中范围
    public GameObject SkillRangeShow;           //释法范围展示
    private GameObject SkillRangeEffect;
    public GameObject SkillParObj;              //父级技能Obj（陷阱类技能用）
    public ObscuredBool SkillCDStatus_Sing;             //技能CD
    public bool IfSkillSelect;                  //技能是否需要技能释放区域  true：表示需要  false：不需要
    //public bool SkillCD_Status;               //技能CD开关,技能开关开启后,主界面技能图标刷新CD显示


    private ObscuredString skillID;                     //技能ID
    private ObscuredInt SkillDamge;                     //技能伤害
    private Vector3 SkillTargetPoint;           //技能释放点
    private Transform AI_MousterSet;            //附近怪物的集合
    private bool SkillSelectStatus;             //技能选中施法区域是否开启
    private ObscuredBool ifSkillOpen;                   //技能是否开始释放
    private float skillDelay;                   //技能延迟时间,配合动作
    private float skillDelaySum;                //技能延迟计数器
    private GameObject skilleffect;             //内部实例化用到的技能特效
    private GameObject SkillSelectRangeEffect;   //技能选中范围特效
    private bool SelectRangeEffectStatus;       //技能选中特效状态
    private GameObject effect;                  //实例化的技能特效
    private Vector3 effectPosition;
    private GameObject SkillObject_p;           //实例化的技能GameObject控制体
    public bool UpdateUseOnce;                  //此开关控制在Update中使用一次脚本控制的方法
    private bool ifPublicSkillStatus;           //是否触发公共CD
    private bool playAnimationOnce;             //只播放一次动作
    public string SkillUseType;                 //释放技能的人的类型, 1：玩家释放技能  2：怪物释放技能
    public int ChuMoFingerId;                   //多点触摸的唯一ID
    private Rose_Status roseStatus;
    private bool RoseSkillZhiShiOneStatus;      //技能指示器未拖动前 表示 false
    private Vector3 RoseSkillZhiShiOneVec3;
    public bool RoseSkillZhiShiStatus;         //技能指示器拖动后 表示 true
    public float RoseSkillZhiShiDisAdd;            //技能指示器距离系数

    //施法前吟唱
    public bool IfSkillFrontSingStatus;              //技能施法中吟唱状态
    private float skillFrontSingTime;                //技能施法中的吟唱时间
    public bool IfWaitSkillFrontSing;                //等待技能施法前吟唱状态完成
    public bool IfSkillFrontFail;                    //技能是否吟唱失败

    //绑点专用
    private GameObject gameStartVar;
    private Game_PositionVar game_PositionVar;

    private MainUI_SkillGrid mainUISkillGrid;

    private GameObject Obj_RoseModel;

    private bool firtshow;

    // Use this for initialization
    void Start()
    {

        //表示只更新一次
        UpdateUseOnce = false;
        game_PositionVar = Game_PublicClassVar.Get_game_PositionVar;

        SkillUseType = "1";     //默认为玩家技能 以后需要修改，考虑怪物放技能因素
        roseStatus = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>();

        mainUISkillGrid = this.gameObject.GetComponent<MainUI_SkillGrid>();

        Obj_RoseModel = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel;

        //RoseSkillZhiShiDisAdd = 0.25f;
        firtshow = false;
    }

    // Update is called once per frame
    void Update()
    {

        //获取技能ID
        skillID = mainUISkillGrid.UseSkillID;
        //Debug.Log("skillsingID = " + skillID);
        //开启技能选中施法范围
        if (IfSkillSelect)
        {
            //实例化,只执行一次
            if (!UpdateUseOnce)
            {

                //将角色设定为施法状态
                Rose_Status rose_Status = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>();
                //Debug.Log("333333333333333333333rose_Status.SkillStatu = " + rose_Status.SkillStatus);
                rose_Status.SkillStatus = true;

                float rangeSize = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillRangeSize", "ID", skillID, "Skill_Template"));
                if (SelectSkillRangeType == "1")
                {

                    //读取指示器显示
                    RoseSkillZhiShiDisAdd = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillRangeZhiShiSize", "ID", skillID, "Skill_Template"));

                    //Debug.Log("技能选择范围中000");
                    //实例化选中特效
                    SkillSelectRangeEffect = (GameObject)Resources.Load("Effect/Rose/Rose_SelectRange", typeof(GameObject));        //实例化范围特效
                    effect = (GameObject)Instantiate(SkillSelectRangeEffect);
                    effect.transform.parent = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.Find("SclectEffectSet");
                    effect.GetComponent<Rose_SelectRange>().RangeSize = rangeSize;

                    //实例化玩家释法范围
                    GameObject skillRangeEffect = (GameObject)Resources.Load("Effect/Rose/Rose_SkillRange", typeof(GameObject));        //实例化范围特效
                    SkillRangeEffect = (GameObject)Instantiate(skillRangeEffect);
                    //SkillRangeEffect.transform.parent = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.Find("SclectEffectSet");
                    //float rangeSize = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillRangeSize", "ID", skillID, "Skill_Template"));
                    //SkillRangeEffect.GetComponent<Rose_SelectRange>().RangeSize = 4;
                    Vector3 playerVec3 = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                    SkillRangeEffect.transform.SetParent(Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform);
                    SkillRangeEffect.transform.localPosition = Vector3.zero;
                    //SkillRangeEffect.transform.position = new Vector3(playerVec3.x, playerVec3.y, playerVec3.z + 1f);
                    //SkillRangeEffect.transform.position = new Vector3(playerVec3.x, playerVec3.y, playerVec3.z);
                    float sizeFloat = 1 + RoseSkillZhiShiDisAdd;
                    SkillRangeEffect.transform.localScale = new Vector3(sizeFloat, sizeFloat, 1);

                    roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().InitSkillTarget(Obj_RoseModel.transform.position);
                    effectPosition = Obj_RoseModel.transform.position;
                    effect.transform.position = effectPosition;
                }

                //技能范围选择状态开启,后面执行循环
                SkillSelectStatus = true;

                //技能范围选择特效开启
                SelectRangeEffectStatus = false;

                //显示释法范围区域
                SkillRangeShow.SetActive(true);

                //显示取消释法
                Game_PublicClassVar.Get_game_PositionVar.Obj_UI_FunctionOpen.GetComponent<UI_FunctionOpen>().Obj_MainSkillCancleBtn.SetActive(true);

                UpdateUseOnce = true;

                //初始化技能指示器
                RoseSkillZhiShiOneStatus = false;
                RoseSkillZhiShiStatus = false;
            }

            if (SkillSelectStatus)
            {
                //Debug.Log("技能选择范围中111");
                //技能选择范围，当触发鼠标点击,下面的特效变量会注销掉
                if (!SelectRangeEffectStatus)
                {

                    //Debug.Log("技能选择范围中222");
                    //不断修正选中范围的位置
                    //Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                    //设置技能释法范围
                    if (Input.touchCount <= 1)
                    {
                        ChuMoFingerId = 0;
                    }

                    Ray ray;
                    //Debug.Log("Application.platform = " + Application.platform);
                    if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.OSXEditor)
                    {
                        //王者操作
                        Vector2 selfVec_2 = new Vector3(this.GetComponent<RectTransform>().transform.position.x, this.GetComponent<RectTransform>().transform.position.y);
                        //Debug.Log ("selfVec_2 = " + selfVec_2 + ";Input.mousePosition = " + Input.mousePosition);
                        Vector2 effectVec2 = ReteunSkillRangShowPosi(selfVec_2, Input.mousePosition);
                        Vector3 effectVec3 = new Vector3(effectVec2.x, effectVec2.y, Input.mousePosition.z);
                        ray = Camera.main.ScreenPointToRay(effectVec3);

                        //指向制定区域
                        //ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                    }
                    else
                    {

                        //王者操作

                        Vector2 selfVec_2 = new Vector3(this.GetComponent<RectTransform>().transform.position.x, this.GetComponent<RectTransform>().transform.position.y);
                        //Debug.Log ("selfVec_2 = " + selfVec_2 + ";Input.mousePosition = " + Input.mousePosition);
                        try
                        {
                            Vector2 effectVec2 = ReteunSkillRangShowPosi(selfVec_2, Input.GetTouch(ChuMoFingerId).position);
                            Vector3 effectVec3 = new Vector3(effectVec2.x, effectVec2.y, 0);
                            ray = Camera.main.ScreenPointToRay(effectVec3);
                        }
                        catch (Exception ex)
                        {
                            Debug.Log("GetTouch111 ex = " + ex);
                            ray = Camera.main.ScreenPointToRay(Vector3.zero);       //随便赋值一个 防止报错
                        }
                        //指向制定区域
                        //ray = Camera.main.ScreenPointToRay(Input.GetTouch(ChuMoFingerId).position);
                    }

                    //Debug.Log("ChuMoFingerId = " + ChuMoFingerId);
                    //一直循环检测当前手指在技能指示器的位置
                    RaycastHit ray_hit;
                    LayerMask mask = (1 << 10);

                    if (Physics.Raycast(ray, out ray_hit, 1000f, mask))
                    {
                        Vector3 SelectRangeEffect = ray_hit.point;

                        //获取按下去的初始位置判定当前是否拖动
                        if (!RoseSkillZhiShiOneStatus)
                        {
                            RoseSkillZhiShiOneVec3 = SelectRangeEffect;
                            RoseSkillZhiShiOneStatus = true;
                        }
                        //判定根据前面获得的第一次位置判定是否拖动
                        if (!RoseSkillZhiShiStatus)
                        {
                            if (SelectRangeEffect != RoseSkillZhiShiOneVec3)
                            {
                                RoseSkillZhiShiStatus = true;
                            }

                            //技能指示器在未移动的时候一直表示玩家的正前方
                            if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget != null)
                            {
                                SelectRangeEffect = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget.transform.TransformPoint(0, 0, 1);
                                SkillTargetPoint = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget.transform.position;
                                //Debug.Log("SkillTargetPoint11111 = " + SkillTargetPoint);
                            }
                            else
                            {
                                SelectRangeEffect = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.TransformPoint(0, 0, 1);  //此代码表示技能指示为最前方
                                //Debug.Log("SelectRangeEffect22222 = " + SkillTargetPoint);
                            }
                            //SelectRangeEffect = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.TransformPoint(0, 0, 1);  //此代码表示技能指示为最前方

                            firtshow = true;
                        }
                        else
                        {
                            firtshow = false;
                        }

                        //Debug.DrawRay(ray.origin, ray.direction, Color.red);
                        Vector2 indicator = mainUISkillGrid.GetSkillIndicator();
                        if (effect != null && indicator != Vector2.zero)
                        {
                            // Vector3 posWorld = Skill_Dir.transform.position;
                            //SkillTarget = new Vector3(posWorld.x + dir.x, posWorld.y, posWorld.z + dir.y);

                            float dir = effect.transform.localScale.x * 13.5f * 0.5f;
                            float rate = (indicator.magnitude / (235f * 0.5f));

                            rate = (rate > 1) ? 1 : rate;
                            float dst = dir * rate;
                            Vector3 dirVc = new Vector3(indicator.x, 0f, indicator.y);

                            effectPosition = new Vector3();
                            effectPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.position + dirVc.normalized * dst;
                            effect.transform.position = effectPosition; /// new Vector3(SelectRangeEffect.x, SelectRangeEffect.y, SelectRangeEffect.z);

                            //Debug.Log ("Rose = " + Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position + "effect.transform.position = " + effect.transform.position);
                        }

                        //判断角色技能指示器是否开启
                        if (roseStatus.Obj_RoseSkillZhiShi.activeSelf && indicator != Vector2.zero)
                        {
                            Vector2 dir = indicator.normalized * 5;
                            Vector3 posWorld = Obj_RoseModel.transform.position;
                            Vector3 SkillTarget = new Vector3(posWorld.x + dir.x, posWorld.y, posWorld.z + dir.y);
                            roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().InitSkillTarget(SkillTarget);
                            //roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().InitSkillTarget(new Vector3(SelectRangeEffect.x, SelectRangeEffect.y, SelectRangeEffect.z));
                        }

                    }
                }

                //鼠标点击，确认释放技能
                //if (Input.GetMouseButtonUp(0))
                bool ifTriggerSkill = false;
                if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.OSXEditor)
                {
                    if (Input.GetMouseButtonUp(0))
                    {
                        ifTriggerSkill = true;
                        //Debug.Log("我检测到了抬起按键!");
                    }
                    /*
                    else {
                        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().SkillStatus = false;
                    }
                    */
                }
                else
                {
                    try
                    {
                        if (Input.GetTouch(ChuMoFingerId).phase == TouchPhase.Ended)
                        {
                            ifTriggerSkill = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.Log("GetTouch222 ex = " + ex);
                        ifTriggerSkill = true;       //随便赋值一个 防止报错
                    }
                }

                if (ifTriggerSkill)
                {
                    //取消释法范围显示
                    SkillRangeShow.SetActive(false);
                    if (SkillRangeEffect != null)
                    {
                        Destroy(SkillRangeEffect);
                    }
                    //Debug.Log("释法移动");
                    //鼠标点击取消角色施法状态
                    Rose_Status rose_Status = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>();
                    rose_Status.SkillStatus = false;

                    //鼠标点击后注销特效光圈
                    SelectRangeEffectStatus = true;

                    //开启刷新技能冷却CD
                    if (SkillCDStatus_Sing)
                    {
                        this.gameObject.GetComponent<MainUI_SkillGrid>().skillCDSelfStatus = true;
                    }

                    //从摄像机处向点击的目标处发送一条射线
                    Ray Move_Target_Ray;
                    if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.OSXEditor)
                    {

                        //王者操作
                        Vector2 selfVec_2 = new Vector3(this.GetComponent<RectTransform>().transform.position.x, this.GetComponent<RectTransform>().transform.position.y);
                        //Debug.Log ("selfVec_2 = " + selfVec_2 + ";Input.mousePosition = " + Input.mousePosition);
                        Vector2 effectVec2 = ReteunSkillRangShowPosi(selfVec_2, Input.mousePosition);
                        Vector3 effectVec3 = new Vector3(effectVec2.x, effectVec2.y, Input.mousePosition.z);
                        //Vector3 effectVec3 = new Vector3(effectVec2.x, effectVec2.y, 0);
                        //Debug.Log("effectVec3111 = " + effectVec3);
                        Move_Target_Ray = Camera.main.ScreenPointToRay(effectVec3);
                        //Debug.Log("AAAAAAAAAAAAA");
                        //Move_Target_Ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                    }
                    else
                    {

                        try
                        {
                            //王者操作
                            Vector2 selfVec_2 = new Vector3(this.GetComponent<RectTransform>().transform.position.x, this.GetComponent<RectTransform>().transform.position.y);
                            //Debug.Log ("selfVec_2 = " + selfVec_2 + ";Input.mousePosition = " + Input.mousePosition);
                            Vector2 effectVec2 = ReteunSkillRangShowPosi(selfVec_2, Input.GetTouch(ChuMoFingerId).position);
                            Vector3 effectVec3 = new Vector3(effectVec2.x, effectVec2.y, 0);
                            //Debug.Log("effectVec3222 = " + effectVec3);
                            Move_Target_Ray = Camera.main.ScreenPointToRay(effectVec3);
                        }
                        catch (Exception ex)
                        {
                            Debug.Log("GetTouch333 ex = " + ex);
                            Move_Target_Ray = Camera.main.ScreenPointToRay(Vector3.zero);       //随便赋值一个 防止报错
                        }

                        //Debug.Log("BBBBBBBBBBBBB");
                        //Move_Target_Ray = Camera.main.ScreenPointToRay(Input.GetTouch(ChuMoFingerId).position);
                    }

                    //获取当前鼠标状态,判定是否要对目标直接释放

                    if (this.GetComponent<MainUI_SkillGrid>().MouseEnterStatus)
                    {
                        //获取当前攻击目标
                        GameObject actObj = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget;
                        if (actObj != null)
                        {
                            //判定与目标的距离
                            float dis = Vector3.Distance(actObj.transform.position, Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position);
                            if (dis <= 20)
                            {
                                Vector3 viewPosition = Camera.main.WorldToScreenPoint(actObj.transform.position);
                                Move_Target_Ray = Camera.main.ScreenPointToRay(viewPosition);
                            }
                        }
                    }

                    //声明一个光线触碰器
                    RaycastHit Move_Target_Hit;

                    //检测射线是否碰触到对象
                    //标记OUT变量在传入参数进去后可能发生改变，和ref类似，但是ref需要给他一个初始值
                    //第一个参数射线变量  第二个参数光线触碰器的反馈变量

                    //设定射线只碰撞Terrain层级
                    LayerMask mask = 1 << 10;
                    ///////
                    if (Physics.Raycast(Move_Target_Ray, out Move_Target_Hit, 1000, mask))
                    {
                        //取得鼠标点击的位置为释放技能的范围中心点

                        if (effect != null)
                            SkillTargetPoint = effect.transform.position;
                        else
                        {
                            //SkillTargetPoint = roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().SkillTarget;

                            Vector2 dir = mainUISkillGrid.GetSkillIndicator().normalized * 5;
                            Vector3 posWorld = Obj_RoseModel.transform.position;
                            Vector3 SkillTarget = new Vector3(posWorld.x + dir.x, posWorld.y, posWorld.z + dir.y);
                            SkillTargetPoint = roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().SkillTarget;

                        }
                        //SkillTargetPoint = effect != null ? effectPosition : Move_Target_Hit.point;

                        //技能释放距离角色要小于50距离
                        if (Vector3.Distance(SkillTargetPoint, Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position) < 50.0f)
                        {
                            ifSkillOpen = true;
                            UpdateUseOnce = false;

                            //技能指示器，如果按下在没有移动过,技能指示器表示在正前方
                            if (!RoseSkillZhiShiStatus)
                            {
                                Move_Target_Hit.point = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.TransformPoint(0, 0, 1);
                                //SkillTargetPoint = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.TransformPoint(0, 0, 1);
                                //Debug.Log("Rose123=" + Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position + ";TransformVector = " + Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_RoseModel.transform.TransformPoint(0,0,1));
                            }

                            //Debug.Log("SkillTargetPoint = " + SkillTargetPoint);
                            //将释放技能是,使其朝向面对选中的区域
                            Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt(SkillTargetPoint);
                            GameTimer timer = GameTimer.ExecuteTotalFrames(10, delegate ()
                            {
                                Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt(SkillTargetPoint);
                            });
                            timer.Start();
                        }
                        else
                        {
                            //Debug.Log("释放法术的距离过长,应在角色50米内");
                        }
                        //Debug.Log("SkillTargetPoint = " + SkillTargetPoint);
                    }

                    //判断技能是否在取消状态
                    // Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("判断技能取消状态aaaaaaaaaaaaaaa = " + Game_PublicClassVar.Get_game_PositionVar.Obj_UI_FunctionOpen.GetComponent<UI_FunctionOpen>().MainSkillCancleStatus);
                    if (Game_PublicClassVar.Get_game_PositionVar.Obj_UI_FunctionOpen.GetComponent<UI_FunctionOpen>().MainSkillCancleStatus)
                    {
                        //取消释法
                        ifSkillOpen = false;
                        //Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("aaaaaaaa取消释法成功");
                        //清理数据
                        cleanSkillData();
                        Game_PublicClassVar.Get_game_PositionVar.Obj_UI_FunctionOpen.GetComponent<UI_FunctionOpen>().MainSkillCancleStatus = false;
                    }

                    Destroy(effect);
                    effect = null;
                }
            }
        }
        //表示技能不需要选中区域的操作，可以直接施放
        else
        {
            //默认释放
            ifSkillOpen = true;
            /*
        	//立即释放技能判定是否需要足够距离
			string damgeRangeType = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("DamgeRangeType", "ID", skillID, "Skill_Template");
			string damgeRange = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("DamgeRange", "ID", skillID, "Skill_Template");

			Debug.Log("skillID = " + skillID + "damgeRangeType = " + damgeRangeType);
			Rose_Status rose_Status = game_PositionVar.Obj_Rose.GetComponent<Rose_Status>();
			if (damgeRangeType == "3") {
				//Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("123123123你需要选择攻击目标");
				if (rose_Status.Obj_ActTarget == null)
				{
					Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("你需要选择攻击目标");
					cleanSkillData();
					//强行不朝向
					ifLookAtTarget = "0";
				}
			}
			//目标立即释放
			if (damgeRangeType == "4") {

				if (rose_Status.Obj_ActTarget != null)
				{
					float dis = Vector3.Distance(game_PositionVar.Obj_Rose.transform.position, rose_Status.Obj_ActTarget.transform.position);
					Debug.Log("dis = " + dis);
					if (dis > float.Parse(damgeRange))
					{
						ifSkillOpen = false;
						Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("你需要离的更近一点");
						cleanSkillData();
						//强行不朝向
						ifLookAtTarget = "0";
					}
				}
				else {
					Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("你需要选择攻击目标");
					cleanSkillData();
					//强行不朝向
					ifLookAtTarget = "0";
				}
			}
			*/

            //设置释放技能是自身朝向目标释放,并做动作
            string ifLookAtTarget = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfLookAtTarget", "ID", skillID, "Skill_Template");
            if (ifLookAtTarget == "1")
            {
                if (game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget != null)
                {
                    Transform objActTarget = game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget.GetComponent<AI_1>().BoneSet.transform.Find("Center").transform;
                    Vector3 lookVec3 = new Vector3(objActTarget.position.x, Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position.y, objActTarget.position.z);
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt(lookVec3);
                }
            }
        }



        //检测技能是否可以战斗中释放
        if (skillifOpen() == false)
        {
            ifSkillOpen = false;
            //清理数据
            cleanSkillData();
        }

        //检测当前技能是否在CD中
        if (this.GetComponent<MainUI_SkillGrid>().SkillSpace != "0")
        {
            if (this.GetComponent<MainUI_SkillGrid>().skillCDStatus)
            {
                Debug.Log("检测到技能数据异常");
                ifSkillOpen = false;
                //清理数据
                cleanSkillData();
            }
        }


        //技能打开释放技能，处理技能延迟播放
        if (ifSkillOpen)
        {

            //Debug.Log("ifSkillOpen! ifSkillOpen! ifSkillOpen!" + skillID);
            //关闭施法前吟唱状态
            //IfSkillFrontSingStatus = false;

            //关闭选择施法区域的状态
            IfSkillSelect = false;

            //判断角色技能指示器是否开启
            if (roseStatus.Obj_RoseSkillZhiShi.activeSelf)
            {
                //清理技能指示器
                roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().ClearnsShow();
            }

            //更新技能延迟时间
            skillDelay = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillDelayTime", "ID", skillID, "Skill_Template"));
            //执行指向技能需要停止转向
            string ifSkillRange = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfSelectSkillRange", "ID", skillID, "Skill_Template");

            //指向性机能需要一个施放延迟,要不施放的时候总是会向前
            if (ifSkillRange == "2" || ifSkillRange == "3")
            {

                game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().YaoGanStopMoveTime = skillDelay + 0.1f;

            }


            if (IfSkillFrontSingStatus)
            {

                if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingStatus == false)
                {
                    IfSkillFrontSingStatus = false;
                }

            }

            //延迟施法处理(执行一次)
            if (!IfSkillFrontSingStatus)
            {
                //技能施法前是否需要吟唱
                if (ifSkillOpen)
                {
                    //skillFrontSingTime = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillFrontSingTime", "ID", skillID, "Skill_Template"));
                    skillFrontSingTime = Game_PublicClassVar.Get_function_Skill.GetSkillSingTime(skillID);

                    if (skillFrontSingTime > 0)
                    {
                        IfSkillFrontSingStatus = true;
                        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingStatus = true;
                        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingTime = skillFrontSingTime;
                        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingSkillObj = this.gameObject;
                        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingType = "1";
                    }
                    else
                    {
                        IfWaitSkillFrontSing = true;
                    }
                }
            }

            //等待施法失败
            if (IfSkillFrontFail)
            {
                //Debug.Log("技能施法失败");
                IfSkillFrontFail = false;
                IfSkillFrontSingStatus = false;
                cleanSkillData();
            }

            //等待判定施法状态是否完成
            if (IfWaitSkillFrontSing)
            {
                if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingType == "1")
                {
                    //设置角色吟唱结束(此处会触发暴风雪BUG,因为暴风雪的CD实在SkillObjBase中调用的)
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseSingStatus = false;
                    //Debug.Log("置为RoseSingStatus2222222 = false");
                }

                IfSkillFrontSingStatus = false;

                //累计延迟时间
                skillDelaySum = skillDelaySum + Time.deltaTime;

                //是否播放技能动作
                if (!playAnimationOnce)
                {

                    //设置动作僵直时间,播放技能动画
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().SkillAnimationStatus = true;
                    float skillRigidity = float.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillRigidity", "ID", skillID, "Skill_Template"));
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().SkillAnimationTime = skillRigidity;
                    //设置技能ID
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseNowUseSkillID = skillID;
                    //获取技能对应的自身动作名称
                    string animationName = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillAnimation", "ID", skillID, "Skill_Template");
                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseNowUseSkillAnimationName = animationName;
                    playAnimationOnce = true;

                    //设置释放技能是自身朝向目标释放,并做动作
                    string ifLookAtTarget = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfLookAtTarget", "ID", skillID, "Skill_Template");
                    if (ifLookAtTarget == "1")
                    {

                        switch (SkillUseType)
                        {
                            //玩家施放的技能
                            case "1":

                                //设置玩家朝向目标
                                if (game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget != null)
                                {
                                    Transform objActTarget = game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget.GetComponent<AI_1>().BoneSet.transform.Find("Center").transform;
                                    Vector3 lookVec3 = new Vector3(objActTarget.position.x, Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position.y, objActTarget.position.z);
                                    Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt(lookVec3);
                                }

                                break;

                            //怪物释放的技能(以后怪物技能补充)
                            case "2":

                                break;
                        }
                    }
                }

                //技能延迟,消耗道具
                if (skillDelaySum >= skillDelay)
                {
                    skillOpen();        //执行技能
                    /*
                    string skillSingTime = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillSingTime", "ID", skillID, "Skill_Template");
                    if (skillSingTime == "0") {
                        cleanSkillData();       //清理技能数据
                    }
                    */
                    cleanSkillData();       //清理技能数据

                    //如果自己为隐身,释放主动技能会退出隐身状态
                    string skillType = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillType", "ID", skillID, "Skill_Template");
                    if (skillType == "1")
                    {
                        Game_PublicClassVar.Get_function_Rose.ExitRoseInvisible();
                    }
                    //技能CD
                    this.GetComponent<MainUI_SkillGrid>().skillCDSelfStatus = true;
                    //开启消耗道具
                    this.GetComponent<MainUI_SkillGrid>().ItemCostStatus = true;

                    //触发技能后触发技能公共冷却CD
                    bool ifPublicSkillStatus = false;
                    string ifPublicSkill = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfPublicSkillCD", "ID", skillID, "Skill_Template");
                    if (ifPublicSkill == "0")
                    {
                        ifPublicSkillStatus = true;
                    }
                    else
                    {
                        ifPublicSkillStatus = false;
                    }
                    if (ifPublicSkillStatus)
                    {
                        Game_PublicClassVar.Get_game_PositionVar.Rose_PublicSkillCDStatus = true;
                    }
                }
            }
        }
    }

    //将技能信息实例化出来
    private void skillOpen()
    {


        //魔法师需要消耗MP
        int nowSkillUseMP = int.Parse(Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillUseMP", "ID", skillID, "Skill_Template"));
        //nowSkillUseMP = 15;
        if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Proprety>().Rose_LanValue < nowSkillUseMP)
        {
            if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Proprety>().Rose_Occupation == "2")
            {

                //提示魔法值不足
                string langStrHint = Game_PublicClassVar.Get_gameSettingLanguge.LoadLocalizationHint("hint_458");
                Game_PublicClassVar.Get_function_UI.GameGirdHint_Front(langStrHint);

            }

            if (Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Proprety>().Rose_Occupation == "3")
            {

                //提示能量值不足
                //string langStrHint = Game_PublicClassVar.Get_gameSettingLanguge.LoadLocalizationHint("hint_458");
                Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("能量值不足");

            }

            return;
        }
        else
        {
            //Debug.Log("扣除魔法：" + nowSkillUseMP);
            Game_PublicClassVar.Get_function_Rose.RoseLanCost(nowSkillUseMP);
            //Debug.Log("Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Proprety>().Rose_LanValue = " + Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Proprety>().Rose_LanValue);
        }


        //设置实例化技能
        string skillObjName = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("GameObjectName", "ID", skillID, "Skill_Template");
        SkillObj = (GameObject)Resources.Load("Effect/Skill_Obj/" + skillObjName, typeof(GameObject));
        SkillObject_p = (GameObject)Instantiate(SkillObj);
        //传递技能对应的值
        SkillObjBase skillStatus = SkillObject_p.transform.GetComponent<SkillObjBase>();
        skillStatus.SkillTargetPoint = SkillTargetPoint;        //技能目标点

        skillStatus.SkillID = skillID;
        //skillStatus.DamgeValue_Fixed = SkillDamge;              //技能伤害
        //设置技能是否为技能指示器
        if (RoseSkillZhiShiStatus)
        {
            if (skillStatus != null)
            {
                skillStatus.RoseSkillZhiShiStatus = RoseSkillZhiShiStatus;
            }
        }


        //设定父节点
        string skillParent = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillParent", "ID", this.GetComponent<MainUI_SkillGrid>().UseSkillID, "Skill_Template");
        switch (skillParent)
        {
            case "0":

                //获取存放的点
                string positionName = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillParentPosition", "ID", this.GetComponent<MainUI_SkillGrid>().UseSkillID, "Skill_Template");
                SkillObject_p.transform.parent = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Bone>().BoneSet.transform.Find(positionName).transform;
                SkillObject_p.transform.localPosition = Vector3.zero;
                skillStatus.SkillTargetPoint = Vector3.zero;                        //技能目标点
                skillStatus.MonsterSkillObj = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose;
                //Debug.Log("SkillObject_p = " + SkillObject_p.transform.localPosition);
                //Debug.Log("实例化特效位置");

                break;

            //从目标自身出发
            case "1":
                //SkillObject_p.transform.parent = this.transform;
                SkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                //SkillObject_p.transform.position = SkillTargetPoint;
                break;

            //指定目标区域
            case "6":
                //SkillObject_p.transform.parent = this.transform;
                //SkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                SkillObject_p.transform.position = SkillTargetPoint;
                //Debug.Log("SkillTargetPoint33333333 = " + SkillTargetPoint);
                break;

            //从目标自身散射
            case "7":
                //SkillObject_p.transform.parent = this.transform;
                SkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;

                //SkillObject_p.transform.position = SkillTargetPoint;

                //Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt()

                //是否有波次
                int bociNum = 1;
                int addbociNum = 0;
                //查询技能附加值
                //添加数据
                string AddSkillValueStr = Game_PublicClassVar.Get_function_Skill.GetSkillAddValue(this.GetComponent<MainUI_SkillGrid>().UseSkillID, "12");
                string[] addSkillValueFenGeStrList = AddSkillValueStr.Split(',');
                for (int i = 0; i < addSkillValueFenGeStrList.Length; i++)
                {
                    string[] AddSkillValueList = addSkillValueFenGeStrList[i].Split('@');

                    //获取触发概率
                    if (AddSkillValueList.Length >= 2)
                    {

                        float chuFaPro = float.Parse(AddSkillValueList[0]);
                        //chuFaPro = 1;
                        if (UnityEngine.Random.value <= chuFaPro)
                        {
                            //触发技能
                            addbociNum = int.Parse(AddSkillValueList[1]);
                        }
                    }
                }

                bociNum = bociNum + addbociNum;

                for (int z = 1; z <= bociNum; z++)
                {

                    //生成5个
                    for (int i = 1; i <= 5; i++)
                    {

                        //if (i != 3)
                        //{
                        //设置实例化技能
                        skillObjName = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("GameObjectName", "ID", skillID, "Skill_Template");
                        SkillObj = (GameObject)Resources.Load("Effect/Skill_Obj/" + skillObjName, typeof(GameObject));
                        GameObject nowSkillObject_p = (GameObject)Instantiate(SkillObj);
                        //传递技能对应的值
                        SkillObjBase nowskillStatus = nowSkillObject_p.transform.GetComponent<SkillObjBase>();

                        nowskillStatus.SkillTargetPoint = SkillTargetPoint;        //技能目标点
                        nowskillStatus.SkillID = skillID;

                        nowskillStatus.SkillTargetPoint = Vector3.zero;                        //技能目标点
                        nowskillStatus.MonsterSkillObj = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose;
                        nowskillStatus.SkillTargetObj = null;
                        nowSkillObject_p.transform.localScale = new Vector3(1, 1, 1);
                        nowSkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                        nowSkillObject_p.transform.rotation = Quaternion.Euler(0, Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.rotation.eulerAngles.y + 30 - 10 * i, 0);
                        //Debug.Log("nowSkillObject_p.transform = " + nowSkillObject_p.transform.localRotation);
                        nowskillStatus.SkillOpen = true;

                        nowskillStatus.AddDelaySkillTime = -0.5f + z * 0.5f;
                        //开启技能，需要在设置完值后开启技能
                        /*
                        }
                        else {
                            SkillObjBase nowskillStatus = SkillObject_p.transform.GetComponent<SkillObjBase>();
                            nowskillStatus.SkillTargetPoint = Vector3.zero;
                        }
                        */
                    }
                }

                break;


            //连发
            case "8":
                //SkillObject_p.transform.parent = this.transform;
                SkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                //SkillObject_p.transform.position = SkillTargetPoint;

                //Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.LookAt()

                //生成4个
                for (int i = 1; i <= 5; i++)
                {


                    //设置实例化技能
                    skillObjName = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("GameObjectName", "ID", skillID, "Skill_Template");
                    SkillObj = (GameObject)Resources.Load("Effect/Skill_Obj/" + skillObjName, typeof(GameObject));
                    GameObject nowSkillObject_p = (GameObject)Instantiate(SkillObj);
                    //传递技能对应的值
                    SkillObjBase nowskillStatus = nowSkillObject_p.transform.GetComponent<SkillObjBase>();

                    nowskillStatus.SkillTargetPoint = SkillTargetPoint;        //技能目标点
                    nowskillStatus.SkillID = skillID;
                    nowskillStatus.SkillTargetPoint = Vector3.zero;                        //技能目标点

                    nowskillStatus.MonsterSkillObj = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose;
                    nowskillStatus.SkillTargetObj = game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget;
                    nowSkillObject_p.transform.localScale = new Vector3(1, 1, 1);
                    nowSkillObject_p.transform.localPosition = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
                    nowSkillObject_p.transform.rotation = Quaternion.Euler(0, 0, 0);
                    //Debug.Log("nowSkillObject_p.transform = " + nowSkillObject_p.transform.localRotation);
                    nowskillStatus.SkillOpen = true;   //开启技能，需要在设置完值后开启技能

                    nowskillStatus.AddDelaySkillTime = i * 0.2f;
                }

                break;


            //陷阱类技能二次触发直接点放在父级技能上
            case "9":

                if (SkillParObj != null)
                {
                    SkillObject_p.transform.position = SkillParObj.transform.position;
                }

                break;

        }

        if (skillParent != "7")
        {

            //设置技能位置
            SkillObject_p.transform.localRotation = this.transform.rotation;
            //SkillObject_p.transform.rotation = Quaternion.Euler(Vector3.zero);
            SkillObject_p.transform.localScale = new Vector3(1, 1, 1);


            skillStatus.SkillOpen = true;   //开启技能，需要在设置完值后开启技能
            //Debug.Log("SkillObject_p2222 = " + SkillObject_p.transform.localPosition);
            switch (SkillUseType)
            {
                //玩家施放的技能
                case "1":
                    //设置释放技能的目标
                    skillStatus.SkillTargetObj = game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().Obj_ActTarget;
                    break;
                //怪物释放的技能(以后怪物技能补充)
                case "2":

                    break;
            }
        }
        else
        {
            Destroy(SkillObject_p);
        }

        //增加魔法/能量
        string addMpStr = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("SkillAddMP", "ID", skillID, "Skill_Template");
        if (addMpStr != "" && addMpStr != "0" && addMpStr != null)
        {
            Game_PublicClassVar.Get_function_Rose.RoseLanAdd(int.Parse(addMpStr));
        }



    }

    //检测当前技能是否可以释放
    private bool skillifOpen()
    {

        //释放的技能是否为隐身技能
        string ifFightOpen = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfFightOpen", "ID", skillID, "Skill_Template");
        if (ifFightOpen == "1")
        {
            //获取自身是否战斗
            if (game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().RoseFightStatus)
            {
                string langStrHint = Game_PublicClassVar.Get_gameSettingLanguge.LoadLocalizationHint("hint_190");
                Game_PublicClassVar.Get_function_UI.GameGirdHint_Front(langStrHint);
                //Game_PublicClassVar.Get_function_UI.GameGirdHint_Front("战斗中不能释放此技能！");
                return false;
            }
        }

        return true;
    }


    //清理技能数据
    void cleanSkillData()
    {

        //Debug.Log("清理技能施法数据");
        ifSkillOpen = false;
        skillDelaySum = 0.0f;
        this.enabled = false;
        playAnimationOnce = false;
        IfWaitSkillFrontSing = false;
        IfSkillSelect = false;

        if (effect != null)
        {
            //Debug.Log ("选中区域没有消失");
        }

        Game_PublicClassVar.Get_game_PositionVar.Obj_UI_FunctionOpen.GetComponent<UI_FunctionOpen>().Obj_MainSkillCancleBtn.SetActive(false);

        //清理技能指示器
        //判断角色技能指示器是否开启
        if (roseStatus.Obj_RoseSkillZhiShi.activeSelf)
        {
            roseStatus.Obj_RoseSkillZhiShi.GetComponent<RoseSkillZhiShi>().ClearnsShow();
        }
        //隐藏技能范围轮盘底图
        SkillRangeShow.SetActive(false);
        //获取当前技能是否需要选中释放区域
        /*
        string ifSkillRange = Game_PublicClassVar.Get_function_DataSet.DataSet_ReadData("IfSelectSkillRange", "ID", skillID, "Skill_Template");
        if (ifSkillRange == "0")
        {
            this.GetComponent<RoseSkill_Sing_1>().IfSkillSelect = false;
        }
        if (ifSkillRange == "1")
        {
            Debug.Log("需要施法范围zxzzzzzzzzzzzzzzzzzzzzzzzzzzz");
            this.GetComponent<RoseSkill_Sing_1>().IfSkillSelect = true;
            //this.GetComponent<RoseSkill_Sing_1>().ChuMoFingerId = 0;
        }
        */

        Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.GetComponent<Rose_Status>().SkillStatus = false;


    }

    //传入目标
    public Vector2 ReteunSkillRangShowPosi(Vector2 vec2_Center, Vector2 vec2_Move)
    {

        //因为实际ui有偏移,所以此处值为特殊处理
        vec2_Center.x = vec2_Center.x + 30;
        vec2_Center.y = vec2_Center.y + 32;



        //Debug.Log ("vec2_Center = " + vec2_Center + ";vec2_Move = " + vec2_Move);

        //获取到原点的距离
        float dis = Vector2.Distance(vec2_Move, vec2_Center);
        //监测是否超出移动距离
        if (dis >= 100)
        {
            //获取两个坐标的角度
            //float jiaodu = Vector2.Angle(starVec2, moveVec2);
            Vector2 aaa = Vector2.Lerp(vec2_Center, vec2_Move, 100 / dis);
            vec2_Move = new Vector2(aaa.x, aaa.y);
            //MoveObj.transform.position = new Vector3(aaa.x, aaa.y, MoveObj.transform.position.z);
        }


        float cha_x = vec2_Move.x - vec2_Center.x;
        float cha_y = vec2_Move.y - vec2_Center.y;
        if (RoseSkillZhiShiDisAdd > 1)
        {
            RoseSkillZhiShiDisAdd = 1;
        }

        float cha_x_pro = cha_x / (100 * (1 - RoseSkillZhiShiDisAdd));
        float cha_y_pro = cha_y / (100 * (1 - RoseSkillZhiShiDisAdd));

        //超过移动范围处理
        if (Mathf.Abs(cha_x) >= 100 || Mathf.Abs(cha_y) >= 100)
        {
            if (Mathf.Abs(cha_x) >= Mathf.Abs(cha_y))
            {
                float chuValue = Mathf.Abs(cha_x_pro) / 1;
                cha_x_pro = cha_x_pro / Mathf.Abs(cha_x_pro);
                cha_y_pro = cha_y_pro / chuValue;
            }
            else
            {
                float chuValue = Mathf.Abs(cha_y_pro) / 1;
                cha_y_pro = cha_y_pro / Mathf.Abs(cha_y_pro);
                cha_x_pro = cha_x_pro / chuValue;
            }
        }

        //设置玩家屏幕坐标点
        float player_X = 1366 / 2;
        float player_y = 768 / 2;

        //获取玩家屏幕中心点坐标
        Vector3 playerPosi = Game_PublicClassVar.Get_game_PositionVar.Obj_Rose.transform.position;
        Vector3 playerVec3 = Camera.main.WorldToScreenPoint(playerPosi);
        //Debug.Log ("playerVec3 = " + playerVec3);
        player_X = playerVec3.x;
        player_y = playerVec3.y;
        //Vector3 playerVec3 = new Vector3(player_X,player_y,0);

        player_X = player_X + 300 * cha_x_pro;
        player_y = player_y + 300 * cha_y_pro;

        Vector2 vec2 = new Vector2(player_X, player_y);
        //Debug.Log ("returnvec2 = " + vec2);
        return vec2;
        //Vector3 playerPosiVec3 = Screen.

    }

}
