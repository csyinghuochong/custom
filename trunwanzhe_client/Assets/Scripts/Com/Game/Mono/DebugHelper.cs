using UnityEngine;
using System.Collections;
using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Config;
using Assets.Scripts.Com.Game.Manager;
namespace Assets.Scripts.Com.Game.Mono
{
    enum TestSoundType
    {
        DELAY,
        VOLUME
    }
    //发布手机版本就不要给Main加DebugHelper这个组件了
    class DebugHelperCommand
    {
        public const string TEST_PVP_ON = "pvp on";
        public const string TEST_PVP_OFF = "pvp off";
        public const string SKILL_CD = "skill cd ";
        public const string MAIN_HERO_HURT = "main hero hurt ";
        public const string SKILL_HURT = "skill hurt ";
        public const string AI_ON = "ai on";
        public const string AI_OFF = "ai off";
        public const string NAT_ON = "nat on";
        public const string NAT_OFF = "nat off";
    }
    class DebugHelperControl
    {
        public static readonly DebugHelperControl instance = new DebugHelperControl();
        public TestSound testSound { get { return DebugHelper.instance ? DebugHelper.instance.testSound : this.mTestSound; } }

        public int dungeonTime { get { return DebugHelper.instance ? DebugHelper.instance.dungeonTime : 0; } }
        public int logAISystem { get { return DebugHelper.instance ? DebugHelper.instance.logAISystem : -1; } }
        public int logFsmSystem { get { return DebugHelper.instance ? DebugHelper.instance.logFsmSystem : -1; } }
        public bool DaluandouAutoSelect { get { return DebugHelper.instance ? DebugHelper.instance.daluandouAutoSelect : false; } }
        public bool debugLog { get { return DebugHelper.instance ? DebugHelper.instance.debugLog : true; } }
        public bool logPvpMessage { get { return DebugHelper.instance ? DebugHelper.instance.logPvpMessage : false; } }
        public int testMonsterId { get { return DebugHelper.instance ? DebugHelper.instance.testMonsterId : -1; } }
        public float skillHurt { get { return DebugHelper.instance ? DebugHelper.instance.skillHurt : this.mSkillHurt; } }
        public float skillCD { get { return DebugHelper.instance ? DebugHelper.instance.skillCD : this.mSkillCD; } }
        public float mainHeroHurt { get { return DebugHelper.instance ? DebugHelper.instance.mainHeroHurt : this.mMainHeroHurt; } }
        public bool mainHeroNoHurt { get { return DebugHelper.instance ? DebugHelper.instance.mainHeroNoHurt : false; } }
        public bool NoGuide { get { return DebugHelper.instance ? DebugHelper.instance.NoGuide : false; } }
        public bool NoPipei { get { return DebugHelper.instance ? DebugHelper.instance.NoPipei : false; } }
        public bool stopAI { get { return DebugHelper.instance ? DebugHelper.instance.stopAI : this.mStopAI; } }
        public bool useNat { get { return this.mUseNat; } }
        public int testPing { get{ return DebugHelper.instance ? DebugHelper.instance.testPing : 100; }}
        public bool allowRotateAndZoom { get { return DebugHelper.instance ? DebugHelper.instance.allowRotateAndZoom : false; } }
        private TestSound mTestSound = new TestSound();
        private bool mTestPVP = false;
        private bool mStopAI = false;
        private float mMainHeroHurt = 0;
        private float mSkillCD = float.MaxValue;
        private float mSkillHurt = float.MaxValue;
        private bool mUseNat = false;

        public int ResetGuideID { get { return DebugHelper.instance ? DebugHelper.instance.ResetGuideID : 0; } }

        public bool IsDebugCommand(string text)
        {
            bool isCommand = false;
          //  if (Launch.LAN)
            {
                if (text == DebugHelperCommand.TEST_PVP_OFF)
                {
                    this.mTestPVP = false;
                 
                    isCommand = true;
                }
                else if (text == DebugHelperCommand.TEST_PVP_ON)
                {
                    this.mTestPVP = true;
                    isCommand = true;
                }
                else if (text == DebugHelperCommand.NAT_ON)
                {
                    this.mUseNat = true;
                    isCommand = true;
                }
                else if (text == DebugHelperCommand.NAT_OFF)
                {
                    this.mUseNat = false;
                    isCommand = true;
                }
                else if (text == DebugHelperCommand.AI_OFF)
                {
                    isCommand = true;
                    this.mStopAI = true;
                }
                else if (text == DebugHelperCommand.AI_ON)
                {
                    isCommand = true;
                    this.mStopAI = false;
                }
                else if (text.Contains(DebugHelperCommand.SKILL_CD))
                {
                    string x = text.Replace(DebugHelperCommand.SKILL_CD, "");
                    try
                    {
                        this.mSkillCD = float.Parse(x);
                    }
                    catch (System.Exception e){}
                    isCommand = true;
                }
                else if (text.Contains(DebugHelperCommand.SKILL_HURT))
                {
                    string x = text.Replace(DebugHelperCommand.SKILL_CD, "");
                    try
                    {
                        this.mSkillHurt = float.Parse(x);
                    }
                    catch (System.Exception e) { }
                    isCommand = true;
                }
                else if (text.Contains(DebugHelperCommand.MAIN_HERO_HURT))
                {
                    string x = text.Replace(DebugHelperCommand.SKILL_CD, "");
                    try
                    {
                        this.mMainHeroHurt = float.Parse(x);
                    }
                    catch (System.Exception e) { }
                    isCommand = true;
                }
            }
            return isCommand;
        }
    }

    [System.Serializable]
    class TestSound
    {
        public int id = -1;
        public int volume = 1000;
        public float delay = 0;
    }

    class DebugHelper : MonoBehaviour
    {
        public int logAISystem = -1;
        public int logFsmSystem = -1;
        public bool daluandouAutoSelect = false;
        public bool debugLog = true;
        public bool logPvpMessage = false;
        public int testMonsterId = -1;

        public int dungeonTime = 0;
        public float skillHurt = 100000;
        public float skillCD = 100000;
        public float mainHeroHurt = 0;
        public TestSound testSound = new TestSound();
        public bool NoGuide = false;
        public bool NoPipei = false;
        public bool stopAI = false;
        public bool mainHeroNoHurt = false;
        public bool allowRotateAndZoom = false;
        public static DebugHelper instance;
        private bool debugOnFrequent;
        private bool debugOnEditor;

        public int targetFrameCount = 40;
        public int testPing = 100;

        public int ResetGuideID = 0;

        public int SynchroStrategy = 0;
        void Awake()
        {
            instance = this;
            debugOnFrequent = DebugControl.debugOnFrequent;
            debugOnEditor = DebugControl.debugOnEditor;
     
        }

        void Update()
        {
            if (Application.isEditor)
            {
                DebugControl.debugOnFrequent = this.debugOnFrequent && this.debugLog;
                DebugControl.debugOnEditor = this.debugOnEditor && this.debugLog;
                if (Application.targetFrameRate != this.targetFrameCount)
                {
                    Application.targetFrameRate = this.targetFrameCount;
                }
            }
        }
    }
}