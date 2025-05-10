﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace ET
{

    public static class PetComponentSystem
    {

        public static List<PropertyValue> GetPetShouHuPro(this PetComponent self)
        {
            List<PropertyValue> proList = new List<PropertyValue>();
            if (self.PetShouHuActive == 0)
            {
                return proList;
            }

            int fightNum = 0;       //评分
            int nowNum = 0;
            for (int i = 0; i < 4; i++)
            {
                RolePetInfo rolePetInfoNow = self.GetPetInfo(self.PetShouHuList[i]);
                if (rolePetInfoNow == null)
                {
                    continue;
                }
                fightNum = fightNum + rolePetInfoNow.PetPingFen;
                if (i == (self.PetShouHuActive - 1))
                {
                    //获取当前守护
                    nowNum = rolePetInfoNow.PetPingFen;
                }
            }

            //增加属性
            float addFloat = ComHelp.GetPetShouHuPro(nowNum, fightNum);
            PropertyValue hide = new PropertyValue();
            hide.HideID = int.Parse(ConfigHelper.PetShouHuAttri[self.PetShouHuActive - 1].Value2);
            hide.HideValue = (long)(addFloat * 10000);
            proList.Add(hide);

            return proList;
        }


        public static void CheckPetList(this PetComponent self, List<long> petList)
        {
            List<long> ids = new List<long>();

            for (int i = petList.Count - 1; i >= 0; i--)
            {
                if (petList[i] != 0 && (self.GetPetInfo(petList[i]) == null) || ids.Contains(petList[i]))
                {
                    petList[i] = 0;
                }

                if (petList[i] != 0 && ids.Contains(petList[i]))
                {
                    ids.Add(petList[i]);
                }
            }
        }

        public static void InitPetInfo(this PetComponent self)
        {
            if (!self.PetCangKuOpen.Contains(0))
            {
                self.PetCangKuOpen.Add(0);
            }
            if (self.RolePetEggs.Count == 0)
            {
                for (int i = 0; i < 3; i++)
                {
                    self.RolePetEggs.Add(new RolePetEgg());
                }
            }
            if (self.PetFormations.Count != 9)
            {
                self.PetFormations.Clear();
                for (int i = 0; i < 9; i++)
                {
                    self.PetFormations.Add(0);
                }
            }
            if (self.TeamPetList.Count != 9)
            {
                self.TeamPetList.Clear();
                for (int i = 0; i < 9; i++)
                {
                    self.TeamPetList.Add(0);
                }
            }
            if (self.PetShouHuList.Count != 4)
            {
                self.PetShouHuList.Clear();
                for (int i = 0; i < 4; i++)
                {
                    self.PetShouHuList.Add(0);
                }
            }
            if (self.PetMingList.Count != 15)
            {
                self.PetMingList.Clear();
                for (int i = 0; i < 15; i++)
                {
                    self.PetMingList.Add(0);
                }
            }
            if (self.PetMingPosition.Count != 27)
            {
                self.PetMingPosition.Clear();

                for (int i = 0; i < 27; i++)
                {
                    int index = i % 9;
                    int teamid = i / 9;
                    if (index < 5)
                    {
                        long petId = self.PetMingList[teamid * 5 + index];
                        self.PetMingPosition.Add(petId);
                    }
                    else
                    {
                        self.PetMingPosition.Add(0);
                    }
                }
            }
            self.CheckPetList(self.PetFormations);
            self.CheckPetList(self.TeamPetList);
            self.CheckPetList(self.PetShouHuList);
            self.CheckPetList(self.PetMingList);
            self.CheckPetList(self.PetMingPosition);

            if (self.PetShouHuActive == 0)
            {
                self.PetShouHuActive = 1;
            }
            List<PetConfig> petConfigs = PetConfigCategory.Instance.GetAll().Values.ToList();
            for (int i = 0; i < petConfigs.Count; i++)
            {
                bool havepet = false;
                for (int p = 0; p < self.PetSkinList.Count; p++)
                {
                    if (self.PetSkinList[p].KeyId == petConfigs[i].Id)
                    {
                        havepet = true;
                        break;
                    }
                }
                if (!havepet)
                {
                    self.PetSkinList.Add(new KeyValuePair() { KeyId = petConfigs[i].Id, Value = String.Empty });
                }
            }

            Unit unit = self.GetParent<Unit>();
            UserInfo userInfo = unit.GetComponent<UserInfoComponent>().UserInfo;
            int maxLv = GlobalValueConfigCategory.Instance.Get(41).Value2;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                RolePetInfo rolePetInfo = self.RolePetInfos[i];
                rolePetInfo.PlayerName = userInfo.Name;
                if (rolePetInfo.PetHeXinList.Count == 0)
                {
                    rolePetInfo.PetHeXinList = new List<long>() { 0, 0, 0 };
                }
                if (rolePetInfo.ShouHuPos == 0)
                {
                    rolePetInfo.ShouHuPos = RandomHelper.RandomNumber(1, 5);
                }
                if (PetHelper.IsShenShou(rolePetInfo.ConfigId))
                {
                    for (int skill = rolePetInfo.PetSkill.Count - 1; skill >= 0; skill--)
                    {
                        int skillid = rolePetInfo.PetSkill[skill];
                        if (skillid >= 80001001 && skillid <= 80001028)
                        {
                            rolePetInfo.PetSkill.RemoveAt(skill);
                        }
                    }
                    rolePetInfo.ShouHuPos = 5;
                }

                if (rolePetInfo.PetLv > maxLv && !ExpConfigCategory.Instance.Contain(rolePetInfo.PetLv))
                {
                    rolePetInfo.PetLv = maxLv;
                }

                PetHelper.CheckPropretyPoint(rolePetInfo);
            }

            if (self.UpdateNumber == 0)
            {
                self.UpdateNumber = 1;

                int skill8Number = 0;
                for (int i = 0; i < self.RolePetInfos.Count; i++)
                {
                    RolePetInfo rolePetInfo = self.RolePetInfos[i];
                    rolePetInfo.SkinId = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId).Skin[0];
                    skill8Number += (rolePetInfo.PetSkill.Count >= 8 ? 1 : 0);

                    if (PetHelper.IsShenShou(rolePetInfo.ConfigId))
                    {
                        self.PetXiLian(rolePetInfo, 2, 0, 0);
                    }
                    self.UpdatePetAttribute(rolePetInfo, false);
                }

                skill8Number = Math.Min(5, skill8Number);
                if (skill8Number > 0)
                {
                    unit.GetComponent<BagComponent>().OnAddItemData($"10010097;{skill8Number}", $"{ItemGetWay.PetFenjie}_{TimeHelper.ServerNow()}");
                }
            }
        }

        //获取新宠物
        public static RolePetInfo GenerateNewPet(this PetComponent self, int petId, int skinId)
        {
            Unit unit = self.GetParent<Unit>();
            PetConfig petConfig = PetConfigCategory.Instance.Get(petId);
            RolePetInfo newpet = new RolePetInfo();
            newpet.Id = IdGenerater.Instance.GenerateId();
            newpet.PetStatus = 0;
            newpet.ConfigId = petConfig.Id;
            newpet.PetLv = petConfig.PetLv;
            newpet.PetExp = 0;
            newpet.PetName = petConfig.PetName;
            newpet.IfBaby = true;
            newpet.SkinId = skinId != 0 ? skinId : petConfig.Skin[0];
            newpet.PetHeXinList = new List<long>() { 0, 0, 0 };
            newpet.AddPropretyNum = 0;
            newpet.AddPropretyValue = ItemHelper.DefaultGem;
            newpet.ShouHuPos = RandomHelper.RandomNumber(1, 5);
            newpet.PetName = PetSkinConfigCategory.Instance.Get(newpet.SkinId).Name;
            newpet.PlayerName = unit.GetComponent<UserInfoComponent>().UserInfo.Name;
            return newpet;
        }

        //取随机值 保留两位
        public static float RandomNumberFloatKeep2(this PetComponent self, float lower, float upper)
        {

            float value = lower + ((upper - lower) * RandomHelper.RandFloat());
            return (float)Math.Round(value, 2);
        }

        public static void CheckSkin(this PetComponent self)
        {
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                RolePetInfo rolePetInfo = self.RolePetInfos[i];
                if (!PetSkinConfigCategory.Instance.Contain(rolePetInfo.SkinId))
                {
                    PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);
                    rolePetInfo.SkinId = petConfig.Skin.Length >= 2 ? petConfig.Skin[1] : petConfig.Skin[0];
                }
            }
            for (int i = 0; i < self.RolePetBag.Count; i++)
            {
                RolePetInfo rolePetInfo = self.RolePetBag[i];
                if (!PetSkinConfigCategory.Instance.Contain(rolePetInfo.SkinId))
                {
                    PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);
                    rolePetInfo.SkinId = petConfig.Skin.Length >= 2 ? petConfig.Skin[1] : petConfig.Skin[0];
                }
            }

        }

        public static void OnLogin(this PetComponent self)
        {
            self.CheckSkin();
            self.CheckPetPingFen();
            self.CheckPetZiZhi();
        }

        public static void CheckPetPingFen(this PetComponent self)
        {
            Unit unit = self.GetParent<Unit>();
            int maxping = self.GetPetMaxPingFen();

            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.PegScoreToValue_307, 0, maxping);

            int arrayping = self.GetPetArrayPingFen();
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.PetArrayScoreToValue_308, 0, arrayping);
        }

        public static void CheckPetZiZhi(this PetComponent self)
        {
            Unit unit = self.GetParent<Unit>();
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.ZiZhiToValue_311, 1, self.GetPetMaxZiZhi(1));
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.ZiZhiToValue_311, 2, self.GetPetMaxZiZhi(2));
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.ZiZhiToValue_311, 3, self.GetPetMaxZiZhi(3));
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.ZiZhiToValue_311, 4, self.GetPetMaxZiZhi(4));
            unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.ZiZhiToValue_311, 5, self.GetPetMaxZiZhi(5));
        }

        public static int GetPetMaxZiZhi(this PetComponent self, int zizhiType)
        {
            int maxPing = 0;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                int zishi = 0;
                switch (zizhiType)
                {

                    case 1: //="获得宠物生命资质超过"&K386&"点"
                        zishi = self.RolePetInfos[i].ZiZhi_Hp;
                        break;
                    case 2: //="获得宠物攻击资质超过"&K387&"点"
                        zishi = self.RolePetInfos[i].ZiZhi_Act;
                        break;
                    case 3: //="获得宠物物防资质超过"&K388&"点"
                        zishi = self.RolePetInfos[i].ZiZhi_Def;
                        break;
                    case 4: //="获得宠物魔防资质超过"&K389&"点"
                        zishi = self.RolePetInfos[i].ZiZhi_Adf;
                        break;
                    case 5: //="获得宠物魔法资质超过"&K390&"点"
                        zishi = self.RolePetInfos[i].ZiZhi_MageAct;
                        break;
                }

                if (zishi >= maxPing)
                {
                    maxPing = zishi;
                }
            }
            return maxPing;
        }

        public static string GetPingfenList(this PetComponent self)
        {
            string pingFen = string.Empty;

            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                RolePetInfo rolePetInfo = self.RolePetInfos[i];
                int intFen = rolePetInfo.PetPingFen;
                if (intFen == 0)
                {
                    intFen = PetHelper.PetPingJia(rolePetInfo);
                }
                string strFen = $"{rolePetInfo.ConfigId},{intFen};";
                pingFen += strFen;
            }

            return pingFen;
        }


        public static int GetPetMaxPingFen(this PetComponent self)
        {
            int maxPing = 0;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (self.RolePetInfos[i].PetPingFen >= maxPing)
                {
                    maxPing = self.RolePetInfos[i].PetPingFen;
                }
            }
            return maxPing;
        }

        public static int GetPetArrayPingFen(this PetComponent self)
        {
            int pingfen_1 = 0;
            int pingfen_2 = 0;
            for (int i = 0; i < self.TeamPetList.Count; i++)
            {
                RolePetInfo rolePetInfo = self.GetPetInfo(self.TeamPetList[i]);
                if (rolePetInfo != null)
                {
                    pingfen_1 += rolePetInfo.PetPingFen;
                }
            }
            for (int i = 0; i < self.PetFormations.Count; i++)
            {
                RolePetInfo rolePetInfo = self.GetPetInfo(self.PetFormations[i]);
                if (rolePetInfo != null)
                {
                    pingfen_2 += rolePetInfo.PetPingFen;
                }
            }
            return Math.Max(pingfen_1, pingfen_2);
        }

        /// <summary>
        /// 宠物洗炼
        /// </summary>
        /// <param name="self"></param>
        /// <param name="rolePetInfo"></param>
        /// <param name="XiLianType"> 1 表示出生  2 表示洗炼 </param>
        /// <param name="XiLianType"> itemId 可能为0 </param>
        /// <returns></returns>
        public static RolePetInfo PetXiLian(this PetComponent self, RolePetInfo rolePetInfo, int XiLianType, int itemId, int fuling)
        {
            Unit unit = self.GetParent<Unit>();
            PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);

            int addValue = 0;

            //超级宠之晶
            if (itemId == 10010096)
            {
                addValue = 50;
            }

            bool fulingStatus = false;
            if (XiLianType == 1 && fuling == 1)
            {
                //Log.Console("已附灵！！！！！");
                addValue = 75;
                fulingStatus = true;
            }

            rolePetInfo.PetPingFen = int.Parse(petConfig.Base_PingFen);
            rolePetInfo.ZiZhi_Hp = RandomHelper.RandomNumber(petConfig.ZiZhi_Hp_Min, petConfig.ZiZhi_Hp_Max + addValue);
            rolePetInfo.ZiZhi_Act = RandomHelper.RandomNumber(petConfig.ZiZhi_Act_Min, petConfig.ZiZhi_Act_Max + addValue);
            rolePetInfo.ZiZhi_MageAct = RandomHelper.RandomNumber(petConfig.ZiZhi_MageAct_Min, petConfig.ZiZhi_MageAct_Max + addValue);
            rolePetInfo.ZiZhi_Def = RandomHelper.RandomNumber(petConfig.ZiZhi_Def_Min, petConfig.ZiZhi_Def_Max + addValue);
            rolePetInfo.ZiZhi_Adf = RandomHelper.RandomNumber(petConfig.ZiZhi_Adf_Min, petConfig.ZiZhi_Adf_Max + addValue);
            rolePetInfo.ZiZhi_ActSpeed = RandomHelper.RandomNumber(petConfig.ZiZhi_ActSpeed_Min, petConfig.ZiZhi_ActSpeed_Max + addValue);
            rolePetInfo.ZiZhi_ChengZhang = self.RandomNumberFloatKeep2((float)petConfig.ZiZhi_ChengZhang_Min, (float)petConfig.ZiZhi_ChengZhang_Max);

            //表示出生创建
            if (XiLianType == 1)
            {
                int minStart = petConfig.InitStartNum[0];
                int maxStart = petConfig.InitStartNum[1];
                rolePetInfo.Star = RandomHelper.RandomNumber(minStart, maxStart);
            }

            int petluckly = unit.GetComponent<NumericComponent>().GetAsInt(NumericType.PetExploreLuckly);

            //运气值100 百分变异
            if (XiLianType == 1 && petluckly >= 100 && petConfig.Skin.Length >= 2)
            {
                //Log.Console("幸运值100！！！！！");
                int skinId = petConfig.Skin[RandomHelper.RandomNumber(1, petConfig.Skin.Length)];
                rolePetInfo.SkinId = skinId;
                rolePetInfo.PetName = PetSkinConfigCategory.Instance.Get(rolePetInfo.SkinId).Name;
                unit.GetComponent<NumericComponent>().ApplyValue(NumericType.PetExploreLuckly, 0);
            }

            rolePetInfo.Luckly = 0;   //1为运气加倍 

            string[] skilll = petConfig.BaseSkillID.Split(';');
            rolePetInfo.PetSkill = new List<int>();
            for (int i = 0; i < skilll.Length; i++)
            {
                if (skilll[i] == "0")
                {
                    continue;
                }
                rolePetInfo.PetSkill.Add(int.Parse(skilll[i]));
            }

            //增加宠物专注技能
            skilll = petConfig.ZhuanZhuSkillID.Split(';');
            for (int i = 0; i < skilll.Length; i++)
            {
                if (skilll[i] == "0")
                {
                    continue;
                }
                rolePetInfo.PetSkill.Add(int.Parse(skilll[i]));
            }

            //增加宠物随机技能
            string randomSkillID = petConfig.RandomSkillID;
            float randomAddPro = 1;
            if (fulingStatus)
            {
                randomAddPro = 2.5f;
            }
            //80001010,01;80001014,0.1;80001015.1

            if (!ComHelp.IfNull(randomSkillID))
            {
                string[] randomSkillList = randomSkillID.Split(';');
                for (int i = 0; i < randomSkillList.Length; i++)
                {
                    string[] skillInfo = randomSkillList[i].Split(",");

                    int skillID = int.Parse(skillInfo[0]);

                    if (RandomHelper.RandFloat() <= float.Parse(skillInfo[1]) * randomAddPro)
                    {
                        rolePetInfo.PetSkill.Add(skillID);
                    }
                }
            }

            return rolePetInfo;
        }

        //第一次获得宠物的时候调用
        /// <summary>
        /// 
        /// </summary>
        /// <param name="self"></param>
        /// <param name="getWay">-1</param>
        /// <param name="petId"></param>
        /// <param name="skinId"></param>
        /// <param name="fuling"></param>
        /// <returns></returns>
        public static RolePetInfo OnAddPet(this PetComponent self, int getWay, int petId, int skinId = 0, int fuling = 0)
        {
            Unit unit = self.GetParent<Unit>();
            PetConfig petConfig = PetConfigCategory.Instance.Get(petId);
            List<int> weight = new List<int>(petConfig.SkinPro);

            if (skinId == 0)
            {
                int index = RandomHelper.RandomByWeight(weight);
                skinId = petConfig.Skin[index];
            }

            self.OnUnlockSkin(petConfig.Id + ";" + skinId.ToString());

            RolePetInfo newpet = self.GenerateNewPet(petId, skinId);

            newpet = self.PetXiLian(newpet, 1, 0, fuling);
            self.UpdatePetAttribute(newpet, false);
            self.CheckPetPingFen();
            self.CheckPetZiZhi();

            unit.GetComponent<ChengJiuComponent>().OnGetPet(newpet);
            unit.GetComponent<TaskComponent>().OnGetPet(newpet);

            if (PetHelper.IsShenShou(petId) && unit.GetComponent<NumericComponent>().GetAsInt(NumericType.RechargeNumber) < 5000)
            {
                //充值低于5千的就记录 记录信息 等级 名称 充值额度 当前钻石额
                LogHelper.GongZuoShi($"神兽作弊: {unit.DomainZone()}   \t名称:{unit.GetComponent<UserInfoComponent>().UserInfo.Name}  " +
                    $"\t等级:{unit.GetComponent<UserInfoComponent>().UserInfo.Lv}" + $"\t钻石:{unit.GetComponent<UserInfoComponent>().UserInfo.Diamond}" +
                    $"\t充值:{unit.GetComponent<NumericComponent>().GetAsInt(NumericType.RechargeNumber)}");
            }

            if (ItemGetWay.PetExplore == getWay)
            {
                self.RolePetBag.Add(newpet);
                M2C_RolePetBagUpdate m2C_RolePetBag = new M2C_RolePetBagUpdate();
                m2C_RolePetBag.RolePetBag = self.RolePetBag;
                m2C_RolePetBag.UpdateMode = 1;
                MessageHelper.SendToClient(self.GetParent<Unit>(), m2C_RolePetBag);
            }
            else
            {
                self.RolePetInfos.Add(newpet);
                M2C_RolePetUpdate m2C_RolePetUpdate = new M2C_RolePetUpdate();
                m2C_RolePetUpdate.PetInfoAdd = new List<RolePetInfo>();
                m2C_RolePetUpdate.PetInfoAdd.Add(newpet);
                MessageHelper.SendToClient(self.GetParent<Unit>(), m2C_RolePetUpdate);
            }

            //如果有皮肤的话更新一次角色属性
            Function_Fight.GetInstance().UnitUpdateProperty_Base(self.GetParent<Unit>(), true, true);
            return newpet;
        }

        //击杀怪物,增加经验等
        public static void OnKillUnit(this PetComponent self, Unit beKill)
        {
            RolePetInfo rolePetInfo = self.GetFightPet();
            if (rolePetInfo == null)
            {
                return;
            }
            if (beKill.Type != UnitType.Monster)
            {
                return;
            }
            MonsterConfig mCof = MonsterConfigCategory.Instance.Get(beKill.ConfigId);
            int playerLv = self.GetParent<Unit>().GetComponent<UserInfoComponent>().UserInfo.Lv;

            //超过5级不能获得经验
            if (rolePetInfo.PetLv >= playerLv + 5)
            {
                return;
            }

            self.PetAddExp(rolePetInfo, mCof.Exp);
        }

        public static void UpdatePetZiZhi(this PetComponent self, RolePetInfo rolePetInfo, int itemId)
        {
            //10,30;10,30;10,30;10,30;10,30
            PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);
            ItemConfig itemConfig = ItemConfigCategory.Instance.Get(itemId);
            string[] zishiList = itemConfig.ItemUsePar.Split(';');

            string[] ZiZhi_Hp = zishiList[0].Split(',');
            string[] ZiZhi_Act = zishiList[1].Split(',');
            string[] ZiZhi_Def = zishiList[2].Split(',');
            string[] ZiZhi_Adf = zishiList[3].Split(',');
            string[] ZiZhi_MageAct = zishiList[4].Split(',');

            if (rolePetInfo.ZiZhi_Hp < petConfig.ZiZhi_Hp_Max)
            {
                rolePetInfo.ZiZhi_Hp += RandomHelper.RandomNumber(int.Parse(ZiZhi_Hp[0]), int.Parse(ZiZhi_Hp[1]));
                rolePetInfo.ZiZhi_Hp = Math.Min(rolePetInfo.ZiZhi_Hp, petConfig.ZiZhi_Hp_Max);
            }

            if (rolePetInfo.ZiZhi_Act < petConfig.ZiZhi_Act_Max)
            {
                rolePetInfo.ZiZhi_Act += RandomHelper.RandomNumber(int.Parse(ZiZhi_Act[0]), int.Parse(ZiZhi_Act[1]));
                rolePetInfo.ZiZhi_Act = Math.Min(rolePetInfo.ZiZhi_Act, petConfig.ZiZhi_Act_Max);
            }

            if (rolePetInfo.ZiZhi_Def < petConfig.ZiZhi_Def_Max)
            {
                rolePetInfo.ZiZhi_Def += RandomHelper.RandomNumber(int.Parse(ZiZhi_Def[0]), int.Parse(ZiZhi_Def[1]));
                rolePetInfo.ZiZhi_Def = Math.Min(rolePetInfo.ZiZhi_Def, petConfig.ZiZhi_Def_Max);
            }

            if (rolePetInfo.ZiZhi_Adf < petConfig.ZiZhi_Adf_Max)
            {
                rolePetInfo.ZiZhi_Adf += RandomHelper.RandomNumber(int.Parse(ZiZhi_Adf[0]), int.Parse(ZiZhi_Adf[1]));
                rolePetInfo.ZiZhi_Adf = Math.Min(rolePetInfo.ZiZhi_Adf, petConfig.ZiZhi_Adf_Max);
            }

            if (rolePetInfo.ZiZhi_MageAct < petConfig.ZiZhi_MageAct_Max)
            {
                rolePetInfo.ZiZhi_MageAct += RandomHelper.RandomNumber(int.Parse(ZiZhi_MageAct[0]), int.Parse(ZiZhi_MageAct[1]));
                rolePetInfo.ZiZhi_MageAct = Math.Min(rolePetInfo.ZiZhi_MageAct, petConfig.ZiZhi_MageAct_Max);
            }
        }

        //宠物进化
        public static void UpdatePetStage(this PetComponent self, RolePetInfo rolePetInfo, int pingfen)
        {
            PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);

            int maxZiZhi = 20;
            int minZiZhi = 10;

            float floatPro = (float)(pingfen / 7500);
            minZiZhi = (int)((float)minZiZhi * floatPro);
            maxZiZhi = (int)((float)maxZiZhi * floatPro);

            if (minZiZhi < 5)
            {
                minZiZhi = 5;
            }

            if (minZiZhi > 10)
            {
                minZiZhi = 10;
            }

            if (maxZiZhi < 20)
            {
                maxZiZhi = 20;
            }

            if (maxZiZhi > 30)
            {
                maxZiZhi = 30;
            }

            string[] ZiZhi_Hp = new string[] { (minZiZhi * 2).ToString(), (maxZiZhi * 2f).ToString() };
            string[] ZiZhi_Act = new string[] { minZiZhi.ToString(), maxZiZhi.ToString() };
            string[] ZiZhi_Def = new string[] { minZiZhi.ToString(), maxZiZhi.ToString() };
            string[] ZiZhi_Adf = new string[] { minZiZhi.ToString(), maxZiZhi.ToString() };
            string[] ZiZhi_MageAct = new string[] { minZiZhi.ToString(), maxZiZhi.ToString() };

            int oldZiZhiHp = rolePetInfo.ZiZhi_Hp;
            int oldZiZhiAct = rolePetInfo.ZiZhi_Act;
            int oldZiZhiDef = rolePetInfo.ZiZhi_Def;
            int oldZiZhiAdf = rolePetInfo.ZiZhi_Adf;
            int oldZiZhiMageAct = rolePetInfo.ZiZhi_MageAct;

            rolePetInfo.ZiZhi_Hp += RandomHelper.RandomNumber(int.Parse(ZiZhi_Hp[0]), int.Parse(ZiZhi_Hp[1]) + 1);
            rolePetInfo.ZiZhi_Act += RandomHelper.RandomNumber(int.Parse(ZiZhi_Act[0]), int.Parse(ZiZhi_Act[1]) + 1);
            rolePetInfo.ZiZhi_Def += RandomHelper.RandomNumber(int.Parse(ZiZhi_Def[0]), int.Parse(ZiZhi_Def[1]) + 1);
            rolePetInfo.ZiZhi_Adf += RandomHelper.RandomNumber(int.Parse(ZiZhi_Adf[0]), int.Parse(ZiZhi_Adf[1]) + 1);
            rolePetInfo.ZiZhi_MageAct += RandomHelper.RandomNumber(int.Parse(ZiZhi_MageAct[0]), int.Parse(ZiZhi_MageAct[1]) + 1);

            rolePetInfo.ZiZhi_Hp = Math.Min(rolePetInfo.ZiZhi_Hp, petConfig.ZiZhi_Hp_Max);
            rolePetInfo.ZiZhi_Act = Math.Min(rolePetInfo.ZiZhi_Act, petConfig.ZiZhi_Act_Max);
            rolePetInfo.ZiZhi_Def = Math.Min(rolePetInfo.ZiZhi_Def, petConfig.ZiZhi_Def_Max);
            rolePetInfo.ZiZhi_Adf = Math.Min(rolePetInfo.ZiZhi_Adf, petConfig.ZiZhi_Adf_Max);
            rolePetInfo.ZiZhi_MageAct = Math.Min(rolePetInfo.ZiZhi_MageAct, petConfig.ZiZhi_MageAct_Max);

            //有些宠物突破上线需要在这里做处理
            rolePetInfo.ZiZhi_Hp = Math.Max(rolePetInfo.ZiZhi_Hp, oldZiZhiHp);
            rolePetInfo.ZiZhi_Act = Math.Max(rolePetInfo.ZiZhi_Act, oldZiZhiAct);
            rolePetInfo.ZiZhi_Def = Math.Max(rolePetInfo.ZiZhi_Def, oldZiZhiDef);
            rolePetInfo.ZiZhi_Adf = Math.Max(rolePetInfo.ZiZhi_Adf, oldZiZhiAdf);
            rolePetInfo.ZiZhi_MageAct = Math.Max(rolePetInfo.ZiZhi_MageAct, oldZiZhiMageAct);

            //概率增加1个技能    1-2  100%   3 50%   4 20%    5 10%  
            int addSkillID = 0;

            //获取原始宠物技能数量
            float addSkillPro = 0;
            if (rolePetInfo.PetSkill.Count <= 2)
            {
                addSkillPro = 1;
            }

            if (rolePetInfo.PetSkill.Count == 3)
            {
                addSkillPro = 0.5f;
            }

            if (rolePetInfo.PetSkill.Count == 4)
            {
                addSkillPro = 0.2f;
            }

            if (rolePetInfo.PetSkill.Count == 5)
            {
                addSkillPro = 0.1f;
            }

            if (RandomHelper.RandFloat01() < addSkillPro)
            {
                if (RandomHelper.RandFloat01() <= 0.7f)
                {
                    //低级技能概率70%
                    int add = RandomHelper.RandomNumber(1, 28);
                    addSkillID = 80001000 + add;
                }
                else
                {
                    //高级技能30%
                    int add = RandomHelper.RandomNumber(1, 28);
                    addSkillID = 80002000 + add;
                }
            }

            //如果当前技能有了那么就忽略掉此次技能附加。
            if (rolePetInfo.PetSkill.Contains(addSkillID))
            {
                addSkillID = 0;
            }

            //检查互斥ID
            if (addSkillID != 0)
            {

                int jianchaSkillID = 0;
                if (addSkillID >= 80002000)
                {
                    jianchaSkillID = addSkillID - 1000;
                }
                else
                {
                    jianchaSkillID = addSkillID - 1000;
                }

                if (rolePetInfo.PetSkill.Contains(jianchaSkillID))
                {
                    addSkillID = 0;
                }
            }

            if (addSkillID != 0)
            {
                rolePetInfo.PetSkill.Add(addSkillID);
            }

            //设置成已进化
            rolePetInfo.UpStageStatus = 2;

            //刷新一下宠物属性
            self.UpdatePetAttribute(rolePetInfo, true);
        }

        public static void UpdatePetChengZhang(this PetComponent self, RolePetInfo rolePetInfo, int itemId)
        {
            PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);
            ItemConfig itemConfig = ItemConfigCategory.Instance.Get(itemId);
            string[] addinfo = itemConfig.ItemUsePar.Split(',');
            float addChengZhang = RandomHelper.RandomNumberFloat(float.Parse(addinfo[0]), float.Parse(addinfo[1]));
            rolePetInfo.ZiZhi_ChengZhang += addChengZhang;
            rolePetInfo.ZiZhi_ChengZhang = Math.Min(rolePetInfo.ZiZhi_ChengZhang, (float)petConfig.ZiZhi_ChengZhang_Max);
        }

        //重置属性点
        public static void OnResetPoint(this PetComponent self, RolePetInfo rolePetInfo)
        {
            rolePetInfo.AddPropretyNum = (rolePetInfo.PetLv - 1) * 5;
            rolePetInfo.AddPropretyValue = ItemHelper.DefaultGem;
            self.UpdatePetAttribute(rolePetInfo, false);
        }

        //增加经验
        public static void PetAddLv(this PetComponent self, RolePetInfo rolePetInfo, int lv)
        {
            if (rolePetInfo == null)
            {
                return;
            }
            Unit unit = self.GetParent<Unit>();
            int playerLv = unit.GetComponent<UserInfoComponent>().UserInfo.Lv;
            int newLevel = rolePetInfo.PetLv + lv;
            newLevel = Math.Min(Math.Max(0, newLevel), playerLv + 5);
            rolePetInfo.AddPropretyNum += (newLevel - rolePetInfo.PetLv) * 5;
            rolePetInfo.PetLv = newLevel;

            // 非神宠每次升级有概率进化状态
            PetConfig petConfig = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);
            if (petConfig.PetType != 2)
            {
                if (RandomHelper.RandFloat01() <= 0.02f && rolePetInfo.UpStageStatus == 0)
                {
                    rolePetInfo.UpStageStatus = 1;
                    unit.GetComponent<UserInfoComponent>().UpdateRoleData(UserDataType.Message, "恭喜你,你的宠物在升级时金光一闪,领悟进化！");
                }
                else
                {
                    //70级必定进化
                    if (rolePetInfo.PetLv >= 70 && rolePetInfo.UpStageStatus == 0)
                    {
                        rolePetInfo.UpStageStatus = 1;
                        unit.GetComponent<UserInfoComponent>().UpdateRoleData(UserDataType.Message, "恭喜你,你的宠物在升级时金光一闪,领悟进化！");
                    }
                }
            }

            //刷新属性
            self.UpdatePetAttribute(rolePetInfo, true);

            //通知客户端
            MessageHelper.SendToClient(self.GetParent<Unit>(), new M2C_PetDataUpdate() { UpdateType = (int)UserDataType.Lv, PetId = rolePetInfo.Id, UpdateTypeValue = rolePetInfo.PetLv.ToString() });
            MessageHelper.Broadcast(self.GetParent<Unit>(), new M2C_PetDataBroadcast() { UnitId = self.GetParent<Unit>().Id, UpdateType = (int)UserDataType.Lv, PetId = rolePetInfo.Id, UpdateTypeValue = rolePetInfo.PetLv.ToString() });

        }

        public static void OnPetDead(this PetComponent self, long petId)
        {
            RolePetInfo petinfo = self.GetPetInfo(petId);
            if (petinfo == null)
            {
                Log.Warning($"petinfo == null:  {self.Id} {petId}");
                return;
            }
            petinfo.PetStatus = 0;
            MessageHelper.SendToClient(self.GetParent<Unit>(), new M2C_PetDataUpdate() { UpdateType = (int)UserDataType.PetStatus, PetId = petId, UpdateTypeValue = "0" });
        }

        public static void OnPetWalk(this PetComponent self, long petId, int petstatu)
        {
            RolePetInfo petinfo = self.GetPetInfo(petId);
            petinfo.PetStatus = petstatu;
            MessageHelper.SendToClient(self.GetParent<Unit>(), new M2C_PetDataUpdate() { UpdateType = (int)UserDataType.PetStatus, PetId = petId, UpdateTypeValue = petstatu.ToString() });
        }

        //增加等级
        public static void PetAddExp(this PetComponent self, RolePetInfo rolePetInfo, int exp)
        {
            if (rolePetInfo == null)
            {
                return;
            }

            int maxLv = GlobalValueConfigCategory.Instance.Get(41).Value2;
            int newExp = rolePetInfo.PetExp + exp;
            ExpConfig xiulianconf1 = ExpConfigCategory.Instance.Get(rolePetInfo.PetLv);
            if (newExp >= xiulianconf1.PetUpExp && rolePetInfo.PetLv < maxLv)
            {
                self.PetAddLv(rolePetInfo, 1);
                newExp -= xiulianconf1.PetUpExp;
            }

            rolePetInfo.PetExp = newExp;

            //通知客户端
            MessageHelper.SendToClient(self.GetParent<Unit>(), new M2C_PetDataUpdate() { UpdateType = (int)UserDataType.Exp, PetId = rolePetInfo.Id, UpdateTypeValue = rolePetInfo.PetExp.ToString() });
        }

       
        public static void UpdatePetAttributeWithData(this PetComponent self, BagComponent bagComponent, NumericComponent numericComponent, RolePetInfo rolePetInfo, bool updateUnit = false)
        {
            //存储数据
            rolePetInfo.Ks.Clear();
            rolePetInfo.Vs.Clear();


            //获取宠物资质
            float actPro = self.GetZiZhiAddPro(1, rolePetInfo.ZiZhi_Act);
            float magePro = self.GetZiZhiAddPro(1, rolePetInfo.ZiZhi_MageAct);
            float defPro = self.GetZiZhiAddPro(1, rolePetInfo.ZiZhi_Def);
            float adfPro = self.GetZiZhiAddPro(1, rolePetInfo.ZiZhi_Adf);
            float hpPro = self.GetZiZhiAddPro(2, rolePetInfo.ZiZhi_Hp);

            //属性加点对应属性 力量-攻击 智力-魔法 体质-血量 耐力就是物防和魔防
            PetConfig petCof = PetConfigCategory.Instance.Get(rolePetInfo.ConfigId);

            PetHelper.CheckPropretyPoint(rolePetInfo);

            //获取加点属性
            string[] attributeinfos = rolePetInfo.AddPropretyValue.Split('_');
            int PointLiLiang = int.Parse(attributeinfos[0]);          //力量
            int PointZhiLi = int.Parse(attributeinfos[1]);            //智力
            int PointTiZhi = int.Parse(attributeinfos[2]);            //体制
            int PointNaiLi = int.Parse(attributeinfos[3]);            //耐力
            int PointMinJie = 0;

            int act_Now = (int)((petCof.Base_Act + rolePetInfo.PetLv * petCof.Lv_Act + PointLiLiang * 10) * actPro * rolePetInfo.ZiZhi_ChengZhang);
            int mage_Now = (int)((petCof.Base_MageAct + rolePetInfo.PetLv * petCof.Lv_MageAct + PointZhiLi * 10) * magePro * rolePetInfo.ZiZhi_ChengZhang);
            int hp_Now = (int)((petCof.Base_Hp + rolePetInfo.PetLv * petCof.Lv_Hp + PointTiZhi * 100 + PointNaiLi * 30) * hpPro * rolePetInfo.ZiZhi_ChengZhang);      //给额外血宠的属性
            int def_Now = (int)((petCof.Base_Def + rolePetInfo.PetLv * petCof.Lv_Def + PointNaiLi * 8) * defPro * rolePetInfo.ZiZhi_ChengZhang);
            int adf_Now = (int)((petCof.Base_Adf + rolePetInfo.PetLv * petCof.Lv_Adf + PointNaiLi * 8) * adfPro * rolePetInfo.ZiZhi_ChengZhang);

            float speed = petCof.Base_MoveSpeed;
            //float speed = self.GetParent<Unit>().GetComponent<NumericComponent>().GetAsFloat(NumericType.Now_Speed);


            ///传承鉴定：你的召唤物属性提升10%
            ///宠物如有需要 ，在此处加上
            ///rolePetInfo.Ks.Add((int)NumericType.Now_Hp);
            ///rolePetInfo.Vs.Add(hp_Now * (1 + now_SummonAddPro));
            float now_SummonAddPro = numericComponent.GetAsFloat(NumericType.Now_SummonAddPro);

            //宠物之核
            List<int> petheXinLv = new List<int>();

            Dictionary<int, long> attriDic = new Dictionary<int, long>();

            
            Function_Fight.AddUpdateProDicList(NumericType.Now_Hp, hp_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.PetSkin, rolePetInfo.SkinId, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Speed_Base, (long)speed * 10000, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_MaxHp_Base, hp_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_MaxAct_Base, act_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Mage_Base, mage_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_MaxDef_Base, def_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_MaxAdf_Base, adf_Now, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Cri_Base, 0, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Res_Base, 0, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Hit_Base, 0, attriDic);
            Function_Fight.AddUpdateProDicList(NumericType.Base_Dodge_Base, 0, attriDic);


            for (int i = 0; i < rolePetInfo.PetHeXinList.Count; i++)
            {
                long baginfoId = rolePetInfo.PetHeXinList[i];
                if (baginfoId == 0)
                {
                    continue;
                }

                BagInfo bagInfo = bagComponent.GetItemByLoc(ItemLocType.ItemPetHeXinEquip, baginfoId);
                if (bagInfo == null || !ItemConfigCategory.Instance.Contain(bagInfo.ItemID))
                {
                    continue;
                }

                //100203;790
                ItemConfig itemConfig = ItemConfigCategory.Instance.Get(bagInfo.ItemID);
                petheXinLv.Add(itemConfig.UseLv);

                string attriStr = itemConfig.ItemUsePar;
                string[] attriList = attriStr.Split('@');
                for (int a = 0; a < attriList.Length; a++)
                {
                    try
                    {
                        string[] attriItem = attriList[a].Split(';');
                        int typeId = int.Parse(attriItem[0]);
                        Function_Fight.AddUpdateProDicList(typeId, NumericHelp.GetNumericValueType(typeId) == 2 ? (long)(10000 * float.Parse(attriItem[1])) : long.Parse(attriItem[1]), attriDic);
                    }
                    catch (Exception ex)
                    {
                        Log.Info($"attriStrexc Eption： {attriStr} {ex.ToString()}");
                    }
                }
            }

            //宠物装备(三个一个的属性激活新技能  添加到rolePetInfo.PetSkill, 防止技能重复添加，脱装备的时候直接C2M_PetEquipRequest去掉装备技能 )
            Dictionary<int, int> hideSkillId = new Dictionary<int, int>();
            for (int i = 0; i < rolePetInfo.PetEquipList.Count; i++)
            {
                long baginfoId = rolePetInfo.PetEquipList[i];
                if (baginfoId == 0)
                {
                    continue;
                }

                BagInfo userBagInfo = bagComponent.GetItemByLoc(ItemLocType.PetLocEquip, baginfoId);
                if (userBagInfo == null || !ItemConfigCategory.Instance.Contain(userBagInfo.ItemID))
                {
                    continue;
                }

                for (int skill = 0; skill < userBagInfo.HideSkillLists.Count; skill++)
                {
                    int skillId = userBagInfo.HideSkillLists[skill];
                    if (!hideSkillId.ContainsKey(skillId))
                    {
                        hideSkillId.Add(skillId, 0);
                    }
                    hideSkillId[skillId]++;
                }


                //存储装备ID
                ItemConfig itemCof = ItemConfigCategory.Instance.Get(userBagInfo.ItemID);

                //存储洗炼数值
                if (userBagInfo.XiLianHideProLists != null)
                {
                    for (int y = 0; y < userBagInfo.XiLianHideProLists.Count; y++)
                    {
                        HideProList hidePro = userBagInfo.XiLianHideProLists[y];
                        Function_Fight.AddUpdateProDicList(hidePro.HideID, hidePro.HideValue, attriDic);
                    }
                }

                //存储洗炼数值
                if (userBagInfo.XiLianHideTeShuProLists != null)
                {
                    for (int y = 0; y < userBagInfo.XiLianHideTeShuProLists.Count; y++)
                    {
                        HideProList hidePro = userBagInfo.XiLianHideTeShuProLists[y];
                        HideProListConfig hideproCof = HideProListConfigCategory.Instance.Get(hidePro.HideID);
                        Function_Fight.AddUpdateProDicList(hideproCof.PropertyType, hidePro.HideValue, attriDic);
                    }
                }

                //存储附魔属性
                if (userBagInfo.FumoProLists != null)
                {
                    for (int y = 0; y < userBagInfo.FumoProLists.Count; y++)
                    {
                        HideProList hidePro = userBagInfo.FumoProLists[y];
                        Function_Fight.AddUpdateProDicList(hidePro.HideID, hidePro.HideValue, attriDic);
                    }
                }

                // 存储增幅属性
                if (userBagInfo.IncreaseProLists != null && userBagInfo.IncreaseProLists.Count > 0)
                {
                    for (int j = 0; j < userBagInfo.IncreaseProLists.Count; j++)
                    {
                        HideProList hideProList = userBagInfo.IncreaseProLists[j];
                        HideProListConfig hideProListConfig = HideProListConfigCategory.Instance.Get(hideProList.HideID);
                        Function_Fight.AddUpdateProDicList(hideProListConfig.PropertyType, hideProList.HideValue, attriDic);
                    }
                }
                //.InheritSkills //传承技能
                // 存储增幅技能属性
                if (userBagInfo.IncreaseSkillLists != null && userBagInfo.IncreaseSkillLists.Count > 0)
                {
                    for (int s = 0; s < userBagInfo.IncreaseSkillLists.Count; s++)
                    {
                        HideProListConfig hideProListConfig = HideProListConfigCategory.Instance.Get(userBagInfo.IncreaseSkillLists[s]);
                        SkillConfig skillConfig = SkillConfigCategory.Instance.Get(hideProListConfig.PropertyType);

                        if (skillConfig.SkillType != (int)SkillTypeEnum.PassiveAddProSkill)
                        {
                            continue;
                        }

                        string GameObjectParameter = skillConfig.GameObjectParameter;
                        if (ComHelp.IfNull(GameObjectParameter))
                        {
                            continue;
                        }

                        string[] addProList = GameObjectParameter.Split(";");
                        for (int p = 0; p < addProList.Length; p++)
                        {
                            string[] addPro = addProList[p].Split(",");
                            if (addPro.Length < 2)
                            {
                                break;
                            }
                            int key = int.Parse(addPro[0]);
                            try
                            {
                                if (NumericHelp.GetNumericValueType(key) == 1)
                                {
                                    Function_Fight.AddUpdateProDicList(key, long.Parse(addPro[1]), attriDic);
                                }
                                else
                                {
                                    Function_Fight.AddUpdateProDicList(key, (int)(float.Parse(addPro[1]) * 10000), attriDic);
                                }
                            }
                            catch (Exception ex)
                            {
                                Log.Error($"{ex.ToString()} {GameObjectParameter}");
                            }
                        }
                    }
                }


                EquipConfig mEquipCon = EquipConfigCategory.Instance.Get(itemCof.ItemEquipID);

                for (int y = 0; y < mEquipCon.AddPropreListType.Length; y++)
                {
                    if (mEquipCon.AddPropreListType[y] != 0 && mEquipCon.AddPropreListValue.Length > y)
                    {
                        //记录属性
                        Function_Fight.AddUpdateProDicList(mEquipCon.AddPropreListType[y], (long)mEquipCon.AddPropreListValue[y], attriDic);
                    }
                }
            }

            foreach ((int skillId, int skillNum) in hideSkillId)
            {
                int hideId = HideProListConfigCategory.Instance.PetSkillToHideProId[skillId];
                HideProListConfig hideProListConfig = HideProListConfigCategory.Instance.Get(hideId);
                if (skillNum >= hideProListConfig.NeedNumber)
                {
                    rolePetInfo.PetSkill.Add(hideProListConfig.PropertyType);
                }
            }

            //宠物之核套装属性
            string petheXinPro = ConfigHelper.GetPetSuitProperty(petheXinLv);
            if (!ComHelp.IfNull(petheXinPro))
            {
                string[] attriList = petheXinPro.Split(';');
                for (int a = 0; a < attriList.Length; a++)
                {
                    try
                    {
                        string[] attriItem = attriList[a].Split(',');
                        int typeId = int.Parse(attriItem[0]);
                        Function_Fight.AddUpdateProDicList(typeId, NumericHelp.GetNumericValueType(typeId) == 2 ? (long)(10000 * float.Parse(attriItem[1])) : long.Parse(attriItem[1]), attriDic);
                    }
                    catch (Exception ex)
                    {
                        Log.Info($"petheXinPro Exption： {petheXinPro} {ex.ToString()}");
                    }
                }
            }

            //宠物修炼属性。 宠物数值
            if (numericComponent != null)
            {
                int xiuLian_0 = numericComponent.GetAsInt(NumericType.UnionPetXiuLian_0);
                int xiuLian_1 = numericComponent.GetAsInt(NumericType.UnionPetXiuLian_1);
                int xiuLian_2 = numericComponent.GetAsInt(NumericType.UnionPetXiuLian_2);
                int xiuLian_3 = numericComponent.GetAsInt(NumericType.UnionPetXiuLian_3);
                List<int> unionXiuLianids = new List<int>() { xiuLian_0, xiuLian_1, xiuLian_2, xiuLian_3 };
                for (int i = 0; i < unionXiuLianids.Count; i++)
                {
                    if (unionXiuLianids[i] == 0)
                    {
                        continue;
                    }
                    UnionQiangHuaConfig unionQiangHuaCof = UnionQiangHuaConfigCategory.Instance.Get(unionXiuLianids[i]);
                    List<PropertyValue> jiazuProList = new List<PropertyValue>();
                    NumericHelp.GetProList(unionQiangHuaCof.EquipPropreAdd, jiazuProList);
                    for (int pro = 0; pro < jiazuProList.Count; pro++)
                    {
                        Function_Fight.AddUpdateProDicList(jiazuProList[pro].HideID, jiazuProList[pro].HideValue, attriDic);
                    }
                }
            }

            if (!PetSkinConfigCategory.Instance.Contain(rolePetInfo.SkinId))
            {
                rolePetInfo.SkinId = petCof.Skin.Length >= 2 ? petCof.Skin[1] : petCof.Skin[0];
                Log.Warning($"rolePetInfo.SkinId:  {rolePetInfo.SkinId}");
            }
            PetSkinConfig petSkinConfig = PetSkinConfigCategory.Instance.Get(rolePetInfo.SkinId);
            if (!ComHelp.IfNull(petSkinConfig.PripertySet))
            {
                string[] attriList = petSkinConfig.PripertySet.Split(';');
                for (int a = 0; a < attriList.Length; a++)
                {
                    try
                    {
                        string[] attriItem = attriList[a].Split(',');
                        int typeId = int.Parse(attriItem[0]);
                        Function_Fight.AddUpdateProDicList(typeId, NumericHelp.GetNumericValueType(typeId) == 2 ? (long)(10000 * float.Parse(attriItem[1])) : long.Parse(attriItem[1]), attriDic);
                    }
                    catch (Exception ex)
                    {
                        Log.Warning($"attriStrexc Eption： {petSkinConfig.PripertySet} {ex.ToString()}");
                    }
                }
            }


            //互斥技能处理
            List<int> huchiList = new List<int>();
            for (int i = 0; i < rolePetInfo.PetSkill.Count; i++)
            {
                SkillConfig skillCof = SkillConfigCategory.Instance.Get(rolePetInfo.PetSkill[i]);
                if (rolePetInfo.PetSkill.Contains(skillCof.HuChiID))
                {
                    huchiList.Add(rolePetInfo.PetSkill[i]);
                }
            }

            //宠物技能
            for (int i = 0; i < rolePetInfo.PetSkill.Count; i++)
            {
                SkillConfig skillCof = SkillConfigCategory.Instance.Get(rolePetInfo.PetSkill[i]);
                if (ComHelp.IfNull(skillCof.GameObjectParameter))
                {
                    continue;
                }

                //判定是否为附加属性
                if (skillCof.SkillType != 5)
                {
                    continue;
                }

                //判断是否为互斥技能
                if (huchiList.Contains(rolePetInfo.PetSkill[i]))
                {
                    continue;
                }

                string[] skillStrList = skillCof.GameObjectParameter.Split(';');
                if (skillStrList.Length == 0)
                {
                    continue;
                }

                for (int y = 0; y < skillStrList.Length; y++)
                {
                    try
                    {
                        string[] attriItem = skillStrList[y].Split(',');
                        if (attriItem.Length == 0)
                        {
                            continue;
                        }
                        int typeId = int.Parse(attriItem[0]);
                        long typevalue = NumericHelp.GetNumericValueType(typeId) == 2 ? (long)(10000 * float.Parse(attriItem[1])) : long.Parse(attriItem[1]);
                        Function_Fight.AddUpdateProDicList(typeId, typevalue, attriDic);
                    }
                    catch (Exception ex)
                    {
                        Log.Info($"attri Eption：{rolePetInfo.PetSkill[i]} {ex.ToString()}");
                    }
                }
            }

            self.UpdatePetNumeric(attriDic);

            //属性交互  所有的属性都在  attriDic
            /////以下代码为测试代码##################
            #region  

            bool use_addpro = true;
            if (use_addpro)
            {
                //缓存一级属性
                long Power_value = Function_Fight.GetOnePro(NumericType.Now_Power, attriDic);
                long Agility_value = Function_Fight.GetOnePro(NumericType.Now_Agility, attriDic);
                long Intellect_value = Function_Fight.GetOnePro(NumericType.Now_Intellect, attriDic);
                long Stamina_value = Function_Fight.GetOnePro(NumericType.Now_Stamina, attriDic);
                long Constitution_value = Function_Fight.GetOnePro(NumericType.Now_Constitution, attriDic);

                //属性点加成
                //二次计算暴击等属性
                long criLv = self.GetAsLong(NumericType.Now_CriLv, attriDic);
                long hitLv = self.GetAsLong(NumericType.Now_HitLv, attriDic);
                long dodgeLv = self.GetAsLong(NumericType.Now_DodgeLv, attriDic);
                long resLv = self.GetAsLong(NumericType.Now_ResLv, attriDic);
                long zhongjiLv = self.GetAsLong(NumericType.Now_ZhongJiLv, attriDic); ;

                Function_Fight.AddUpdateProDicList((int)NumericType.Base_CriLv_Add, criLv, attriDic);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HitLv_Add, hitLv, attriDic);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_DodgeLv_Add, dodgeLv, attriDic);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_ResLv_Add, resLv, attriDic);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_ZhongJiPro_Add, zhongjiLv, attriDic);

                long Power_value_add = 0;
                long Intellect_value_add = 0;
                long Agility_value_add = 0;
                long Stamina_value_add = 0;
                long Constitution_value_add = 0;

                int roleLv = rolePetInfo.PetLv;

                //力量加物理穿透
                int wuliChuanTouLv = (PointLiLiang + (int)Power_value + (int)Power_value_add) * 5;
                float adddWuLiChuanTou = Function_Fight.LvProChange(wuliChuanTouLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuShiActPro_Add, (int)(adddWuLiChuanTou * 10000), attriDic);

                //智力加魔法穿透
                int mageChuanTouLv = (PointZhiLi + (int)Intellect_value + (int)Intellect_value_add) * 5;
                float adddMageChuanTou = Function_Fight.LvProChange(mageChuanTouLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuShiMagePro_Add, (int)(adddMageChuanTou * 10000), attriDic);

                //敏捷冷却时间
                int cdTimeLv = (PointMinJie + (int)Agility_value + (int)Agility_value_add) * 2;
                float addMinJie = Function_Fight.LvProChange(cdTimeLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_SkillCDTimeCostPro_Add, (int)(addMinJie * 10000), attriDic);

                //耐力
                int huixueLv = (PointNaiLi + (int)Stamina_value + (int)Stamina_value_add);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuiXue_Add, huixueLv, attriDic);

                //体力
                int damgeProCostLv = (PointTiZhi + (int)Constitution_value + (int)Constitution_value_add) * 2;
                float damgeProCost = Function_Fight.LvProChange(damgeProCostLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_DamgeSubPro_Add, (int)(damgeProCost * 10000), attriDic);


                //缓存一级属性
                Power_value_add += Function_Fight.GetOnePro(NumericType.Now_Power, attriDic);
                Agility_value_add += Function_Fight.GetOnePro(NumericType.Now_Agility, attriDic);
                Intellect_value_add += Function_Fight.GetOnePro(NumericType.Now_Intellect, attriDic);
                Stamina_value_add += Function_Fight.GetOnePro(NumericType.Now_Stamina, attriDic);
                Constitution_value_add += Function_Fight.GetOnePro(NumericType.Now_Constitution, attriDic);


                //---加点属性---  加点和1级属性战力做平均
                //力量换算
                if (Power_value > 0 || PointLiLiang > 0)
                {
                    long value = Power_value + PointLiLiang + Power_value_add;
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxAct_Base, value * 5, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinAct_Base, value * 1, attriDic);

                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxDef_Base, value * 2, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinDef_Base, value * 1, attriDic);
                    //AddUpdateProDicList((int)NumericType.Base_HitLv_Base, Power_value * 3, UpdateProDicList);
                }

                //敏捷换算
                if (Agility_value > 0 || PointMinJie > 0)
                {
                    long value = Agility_value + PointMinJie + Agility_value_add;
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxAct_Base, value * 5, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinAct_Base, value * 2, attriDic);

                    //额外战力附加(因为冷却CD附加的战力少)
                }

                //智力换算
                if (Intellect_value > 0 || PointZhiLi > 0)
                {
                    long value = Intellect_value + PointZhiLi + Intellect_value_add;
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_Mage_Base, value * 10, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxAdf_Base, value * 2, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinAdf_Base, value * 1, attriDic);
                }

                //耐力换算
                if (Stamina_value > 0 || PointNaiLi > 0)
                {
                    long value = Stamina_value + PointNaiLi + Stamina_value_add;
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxDef_Base, value * 4, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxAdf_Base, value * 4, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinDef_Base, value * 2, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MinAdf_Base, value * 2, attriDic);
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_GeDang_Base, value * 3, attriDic);
                }

                //体质换算
                if (Constitution_value > 0 || PointTiZhi > 0)
                {
                    long value = Constitution_value + PointTiZhi + Constitution_value_add;
                    Function_Fight.AddUpdateProDicList((int)NumericType.Base_MaxHp_Base, value * 72, attriDic);
                }

                //更新属性的额外加点属性
                //力量加攻速
                int actSpeedTouLv = (PointLiLiang + (int)Power_value + (int)Power_value_add) * 2;
                float actSpeedChuanTou = Function_Fight.LvProChange(actSpeedTouLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_ActSpeedPro_Add, (int)(actSpeedChuanTou * 10000), attriDic);

                //敏捷加攻速
                int actSpeedTouLv2 = (PointLiLiang + (int)Agility_value + (int)Agility_value_add) * 2;
                float actSpeedChuanTou2 = Function_Fight.LvProChange(actSpeedTouLv2, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_ActSpeedPro_Add, (int)(actSpeedChuanTou2 * 10000), attriDic);

                //耐力加抗暴
                int kangbaoLv = (PointNaiLi + (int)Stamina_value + (int)Stamina_value_add) * 4;
                float kangbaoPro = Function_Fight.LvProChange(kangbaoLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_Res_Add, (int)(kangbaoPro * 10000), attriDic);

                //体力加闪避
                int dodgeLv2 = (PointTiZhi + (int)Constitution_value + (int)Constitution_value_add) * 2;
                float dodgePro = Function_Fight.LvProChange(dodgeLv2, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_Dodge_Add, (int)(dodgePro * 10000), attriDic);

                //更新基础强化属性
                //攻击加物理穿透
                wuliChuanTouLv = (int)Power_value_add * 5;
                adddWuLiChuanTou = Function_Fight.LvProChange(wuliChuanTouLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuShiActPro_Add, (int)(adddWuLiChuanTou * 10000), attriDic);

                //智力加魔法穿透
                mageChuanTouLv = (int)Intellect_value_add * 5;
                adddMageChuanTou = Function_Fight.LvProChange(mageChuanTouLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuShiMagePro_Add, (int)(adddMageChuanTou * 10000), attriDic);

                //敏捷冷却时间
                cdTimeLv = (int)Agility_value_add * 2;
                addMinJie = Function_Fight.LvProChange(cdTimeLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_SkillCDTimeCostPro_Add, (int)(addMinJie * 10000), attriDic);

                //耐力
                huixueLv = (int)Stamina_value_add;
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_HuiXue_Add, huixueLv, attriDic);

                //体力
                damgeProCostLv = (int)Constitution_value_add * 2;
                damgeProCost = Function_Fight.LvProChange(damgeProCostLv, roleLv);
                Function_Fight.AddUpdateProDicList((int)NumericType.Base_DamgeSubPro_Add, (int)(damgeProCost * 10000), attriDic);
            }

            
            #endregion    
            /////以上代码为测试代码##################

            //刷新一下属性attriDic  赋值给rolePetInfo.Ks rolePetInfo.Vs
            self.UpdatePetNumeric(attriDic);
            foreach (var item in attriDic)
            {
                int numericType = item.Key;
                rolePetInfo.Ks.Add(numericType);
                rolePetInfo.Vs.Add(item.Value);
            }

            int pingfen = PetHelper.PetPingJia(rolePetInfo);
            rolePetInfo.Ks.Add((int)NumericType.PetPinFen);
            rolePetInfo.Vs.Add(pingfen);
            rolePetInfo.PetPingFen = pingfen;
        }

        public static void UpdatePetNumeric(this PetComponent self, Dictionary<int, long> attriDic)
        {
            List<int> keylist = attriDic.Keys.ToList();
            for (int i = 0; i < keylist.Count; i++)
            {
                self.Update(keylist[i], attriDic);
            }
        }

        public static void Update(this PetComponent self,  int numericType, Dictionary<int, long> attriDic)
        {
            if (numericType < (int)NumericType.Max)
            {
                return;
            }

            int nowValue = (int)numericType / 100;

            int add = nowValue * 100 + 1;
            int mul = nowValue * 100 + 2;
            int finalAdd = nowValue * 100 + 3;
            int buffAdd = nowValue * 100 + 11;
            int buffMul = nowValue * 100 + 12;
            long old = self.GetByKey( nowValue, attriDic);
            long nowPropertyValue = (long)
            (
                (self.GetByKey( add, attriDic) * (1 + self.GetAsFloat( mul, attriDic)) + self.GetByKey( finalAdd, attriDic)) *
                (1 + self.GetAsFloat( buffMul, attriDic))
                + self.GetByKey( buffAdd, attriDic)
            );

            attriDic[nowValue] = nowPropertyValue;
        }

        public static long GetAsLong(this PetComponent self, int numericType, Dictionary<int, long> attriDic)
        {
            return self.GetByKey(numericType, attriDic);
        }

        public static int GetAsInt(this PetComponent self, int numericType, Dictionary<int, long> attriDic)
        {
            return (int)self.GetByKey(numericType, attriDic);
        }

        public static float GetAsFloat(this PetComponent self, int numericType, Dictionary<int, long> attriDic)
        {
            return (float)self.GetByKey(numericType, attriDic) / 10000;
        }

        public static long GetByKey(this PetComponent self,  int numericType, Dictionary<int, long> attriDic)
        {
            long value = 0;
            attriDic.TryGetValue(numericType, out value);
            return value;
        }

        public static void RemoveEquipSkill(this PetComponent self, RolePetInfo rolePetInfom, BagInfo bagInfo)
        {
            if (bagInfo == null)
            {
                return;
            }
            for (int i = rolePetInfom.PetSkill.Count - 1; i >= 0; i--)
            {
                if (bagInfo.HideSkillLists.Contains(rolePetInfom.PetSkill[i]))
                {
                    rolePetInfom.PetSkill.RemoveAt(i);
                }
            }
        }

        public static void UpdatePetAttribute(this PetComponent self, RolePetInfo rolePetInfo, bool updateUnit)
        {
            BagComponent bagComponent = self.GetParent<Unit>().GetComponent<BagComponent>();
            NumericComponent numericComponent = self.GetParent<Unit>().GetComponent<NumericComponent>();
            self.UpdatePetAttributeWithData(bagComponent, numericComponent, rolePetInfo, updateUnit);

            //如果是出战的宠物。再广播一下属性
            if (updateUnit == false)
            {
                return;
            }
            Unit petUnit = self.GetParent<Unit>().GetParent<UnitComponent>().Get(rolePetInfo.Id);
            if (petUnit == null)
            {
                return;
            }
            petUnit.GetComponent<HeroDataComponent>().InitPet(rolePetInfo, true);
            //NumericComponent numericComponent = petUnit.GetComponent<NumericComponent>();
            //numericComponent.ApplyValue(NumericType.Now_Hp, self.GetByKey(rolePetInfo, NumericType.Now_Hp), true);
            //numericComponent.ApplyValue(NumericType.Now_MaxHp, self.GetByKey(rolePetInfo, NumericType.Now_MaxHp), true);
            //numericComponent.ApplyValue(NumericType.Now_MaxAct, self.GetByKey(rolePetInfo, NumericType.Now_MaxAct), true);
            //numericComponent.ApplyValue(NumericType.Now_Mage, self.GetByKey(rolePetInfo, NumericType.Now_Mage), true);
            //numericComponent.ApplyValue(NumericType.Now_MaxDef, self.GetByKey(rolePetInfo, NumericType.Now_MaxDef), true);
            //numericComponent.ApplyValue(NumericType.Now_MaxAdf, self.GetByKey(rolePetInfo, NumericType.Now_MaxAdf), true);
        }

        //根据资质换算出当前系数
        private static float GetZiZhiAddPro(this PetComponent self, int type, int value)
        {

            float pro = 0.8f;

            if (type == 1)
            {
                if (value >= 1200)
                {
                    //超出算法
                    pro = 0.8f + ((value - 1200) / 600.0f);
                }
                else
                {
                    //低出算法
                    pro = (float)value / 1500.0f;
                }
            }

            if (type == 2)
            {
                if (value >= 2400)
                {
                    //超出算法
                    pro = 0.8f + ((value - 2400) / 1200.0f);
                }
                else
                {
                    //低出算法
                    pro = (float)value / 3000.0f;
                }
            }

            return pro;
        }

        public static void RemovePet(this PetComponent self, long petId)
        {
            Unit unit = self.GetParent<Unit>();
            BagComponent bagComponent = unit.GetComponent<BagComponent>();
            for (int i = self.RolePetInfos.Count - 1; i >= 0; i--)
            {
                if (self.RolePetInfos[i].Id == petId)
                {
                    //移除宠物之核
                    bagComponent.OnCostItemData(self.RolePetInfos[i].PetHeXinList, ItemLocType.ItemPetHeXinEquip);
                    bagComponent.OnCostItemData(self.RolePetInfos[i].PetEquipList, ItemLocType.PetLocEquip);

                    self.RolePetInfos.RemoveAt(i);
                    break;
                }
            }

            self.ResetFormation(self.PetFormations, petId);
            self.ResetFormation(self.TeamPetList, petId);
            self.ResetFormation(self.PetMingList, petId);
            self.ResetFormation(self.PetMingPosition, petId);
        }

        /// <summary>
        /// Get可以取缓存数据，不用读缓存数据库
        /// </summary>
        /// <param name="self"></param>
        /// <returns></returns>
        public static RolePetInfo GetPetInfo(this PetComponent self, long PetId)
        {
            RolePetInfo petInfo = null;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (self.RolePetInfos[i].Id == PetId)
                {
                    return self.RolePetInfos[i];
                }
            }
            return petInfo;
        }

        /// <summary>
        /// Get可以取缓存数据，不用读缓存数据库
        /// </summary>
        /// <param name="self"></param>
        /// <returns></returns>
        public static RolePetInfo GetPetInfoByBag(this PetComponent self, long PetId)
        {
            RolePetInfo petInfo = null;
            for (int i = 0; i < self.RolePetBag.Count; i++)
            {
                if (self.RolePetBag[i].Id == PetId)
                {
                    return self.RolePetBag[i];
                }
            }
            return petInfo;
        }

        public static long GetFightPetId(this PetComponent self)
        {
            RolePetInfo rolePetInfo = self.GetFightPet();
            return rolePetInfo != null ? rolePetInfo.Id : 0;
        }

        public static RolePetInfo GetFightPet(this PetComponent self)
        {
            RolePetInfo petId = null;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (self.RolePetInfos[i].PetStatus == 1)
                {
                    petId = self.RolePetInfos[i];
                }
            }
            return petId;
        }

        public static void TakeOutBag(this PetComponent self, long petId)
        {
            RolePetInfo rolePetInfo = self.GetPetInfoByBag(petId);
            if (rolePetInfo == null)
            {
                return;
            }

            self.RemovePetBag(petId);

            self.RolePetInfos.Add(rolePetInfo);
            M2C_RolePetUpdate m2C_RolePetUpdate = new M2C_RolePetUpdate();
            m2C_RolePetUpdate.PetInfoAdd = new List<RolePetInfo>();
            m2C_RolePetUpdate.PetInfoAdd.Add(rolePetInfo);
            m2C_RolePetUpdate.GetWay = 2;
            MessageHelper.SendToClient(self.GetParent<Unit>(), m2C_RolePetUpdate);
        }

        public static void RemovePetBag(this PetComponent self, long petId)
        {
            for (int i = self.RolePetBag.Count - 1; i >= 0; i--)
            {
                if (self.RolePetBag[i].Id == petId)
                {
                    self.RolePetBag.RemoveAt(i);
                    break;
                }
            }

            M2C_RolePetBagUpdate m2C_RolePetBag = new M2C_RolePetBagUpdate();
            m2C_RolePetBag.RolePetBag = self.RolePetBag;
            m2C_RolePetBag.UpdateMode = 2;
            MessageHelper.SendToClient(self.GetParent<Unit>(), m2C_RolePetBag);
        }



        public static void OnRolePetFenjie(this PetComponent self, long petId)
        {
            self.RemovePet(petId);

            for (int i = self.RolePetInfos.Count - 1; i >= 0; i--)
            {
                self.UpdatePetAttribute(self.RolePetInfos[i], false);
            }

            M2C_PetListMessage m2C_PetListMessage = new M2C_PetListMessage();
            m2C_PetListMessage.PetList = self.RolePetInfos;
            m2C_PetListMessage.RemovePetId = petId;
            MessageHelper.SendToClient(self.GetParent<Unit>(), m2C_PetListMessage);
        }

        public static int GetMaxSkillNumber(this PetComponent self)
        {
            int skillNumber = 0;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (self.RolePetInfos[i].PetSkill.Count > skillNumber)
                {
                    skillNumber = self.RolePetInfos[i].PetSkill.Count;
                }
            }
            return skillNumber;
        }

        public static List<RolePetInfo> GetAllPets(this PetComponent self)
        {
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                RolePetInfo rolePetInfo = self.RolePetInfos[i];
                if (string.IsNullOrEmpty(rolePetInfo.AddPropretyValue))
                {
                    rolePetInfo.AddPropretyNum = (rolePetInfo.PetLv - 1) * 5;
                    rolePetInfo.AddPropretyValue = ItemHelper.DefaultGem;
                }
            }
            return self.RolePetInfos;
        }

        public static int GetShenShouNumber(this PetComponent self)
        {
            int shenshouNumber = 0;
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (PetHelper.IsShenShou(self.RolePetInfos[i].ConfigId))
                {
                    shenshouNumber++;
                }
            }
            return shenshouNumber;
        }

        public static int GetTotalStar(this PetComponent self)
        {
            int star = 0;
            for (int i = 0; i < self.PetFubenInfos.Count; i++)
            {
                star += self.PetFubenInfos[i].Star;
            }

            return star;
        }

        /// <summary>
        /// 获取可以领取的最小星级奖励
        /// </summary>
        /// <param name="self"></param>
        /// <returns></returns>
        public static int GetCanRewardId(this PetComponent self)
        {
            int rewardId = 0;
            int totalStar = self.GetTotalStar();
            List<PetFubenRewardConfig> rewardConfigs = PetFubenRewardConfigCategory.Instance.GetAll().Values.ToList();
            for (int i = 0; i < rewardConfigs.Count; i++)
            {
                if (rewardConfigs[i].NeedStar <= totalStar
                    && rewardConfigs[i].Id > self.PetFubeRewardId)
                {
                    rewardId = rewardConfigs[i].Id;
                    break;
                }
            }

            return rewardId;
        }

        public static void OnUnlockSkin(this PetComponent self, string skininfo)
        {
            string[] petskininfo = skininfo.Split(';');
            int petId = int.Parse(petskininfo[0]);
            int skinId = int.Parse(petskininfo[1]);

            for (int p = 0; p < self.PetSkinList.Count; p++)
            {
                if (self.PetSkinList[p].KeyId != petId)
                {
                    //重复激活
                    continue;
                }
                if (!self.PetSkinList[p].Value.Contains(skinId.ToString()))
                {
                    self.PetSkinList[p].Value += ("_" + skinId.ToString());
                }
            }
        }

        public static void ResetFormation(this PetComponent self, List<long> formation, long petId)
        {
            for (int i = 0; i < formation.Count; i++)
            {
                if (formation[i] == petId)
                {
                    formation[i] = 0;
                }
            }
        }

        /// <summary>
        /// 通关副本ID
        /// </summary>
        /// <param name="self"></param>
        /// <returns></returns>
        public static int GetPassMaxFubenId(this PetComponent self)
        {
            int maxid = 0;
            for (int i = 0; i < self.PetFubenInfos.Count; i++)
            {
                if (self.PetFubenInfos[i].PetFubenId > maxid)
                {
                    maxid = self.PetFubenInfos[i].PetFubenId;
                }
            }

            return maxid;
        }

        public static void OnPassPetFuben(this PetComponent self, int petfubenId, int star)
        {
            for (int i = 0; i < self.PetFubenInfos.Count; i++)
            {
                if (self.PetFubenInfos[i].PetFubenId == petfubenId)
                {
                    self.PetFubenInfos[i].Star = star > self.PetFubenInfos[i].Star ? star : self.PetFubenInfos[i].Star;
                    return;
                }
            }
            self.PetFubenInfos.Add(new PetFubenInfo() { PetFubenId = petfubenId, Star = star, Reward = 0 });
        }

        public static void OnPetMingRecord(this PetComponent self, PetMingRecord record)
        {
            if (self.PetMingRecordList.Count >= 10)
            {
                self.PetMingRecordList.RemoveAt(0);
            }
            self.PetMingRecordList.Add(record);
        }

        public static void OnGmGaoJi(this PetComponent self)
        {

            //每个宠物附带满级的宠物之核,并进化
            List<int> itemids = new List<int>()
            {
            10031001,10031005,10031011,10031013,10031014,10031015,10031016,10031017
            };

            for (int i = 0; i < itemids.Count; i++)
            {
                string itempar = ItemConfigCategory.Instance.Get(itemids[i]).ItemUsePar;
                int petid = int.Parse(itempar);
                if (self.HavePetConfigId(petid))
                {
                    continue;
                }
                self.OnGmAddPet(petid);
            }
        }

        public static bool HavePetConfigId(this PetComponent self, int configId)
        {
            for (int i = 0; i < self.RolePetInfos.Count; i++)
            {
                if (self.RolePetInfos[i].ConfigId == configId)
                {
                    return true;
                }
            }
            return false;
        }

        public static void OnGmAddPet(this PetComponent self, int petId)
        {
            //10060230(攻击之核-1)   10060430(物防之核-2) 10060130(生命之核-3)  

            Unit unit = self.GetParent<Unit>();
            PetConfig petConfig = PetConfigCategory.Instance.Get(petId);
            List<int> weight = new List<int>(petConfig.SkinPro);

            int index = RandomHelper.RandomByWeight(weight);
            int skinId = petConfig.Skin[index];

            self.OnUnlockSkin(petConfig.Id + ";" + skinId.ToString());

            RolePetInfo newpet = self.GenerateNewPet(petId, skinId);

            newpet = self.PetXiLian(newpet, 1, 0, 0);
            newpet.PetLv = unit.GetComponent<UserInfoComponent>().UserInfo.Lv;
            newpet.AddPropretyValue = $"{newpet.PetLv}_{newpet.PetLv}_{newpet.PetLv}_{newpet.PetLv}";
            newpet.UpStageStatus = 2;
            self.UpdatePetAttribute(newpet, false);
            self.CheckPetPingFen();
            self.CheckPetZiZhi();

            unit.GetComponent<ChengJiuComponent>().OnGetPet(newpet);
            unit.GetComponent<TaskComponent>().OnGetPet(newpet);

            self.OnGmPetEquip(10060230, newpet);
            self.OnGmPetEquip(10060430, newpet);
            self.OnGmPetEquip(10060130, newpet);

            self.RolePetInfos.Add(newpet);
        }

        public static void OnGmPetEquip(this PetComponent self, int itemid, RolePetInfo rolePetInfo)
        {
            BagComponent bagComponent = self.GetParent<Unit>().GetComponent<BagComponent>();
            bagComponent.OnAddItemData($"{itemid};1", $"{ItemGetWay.GM}_{TimeHelper.ServerNow()}");
            List<BagInfo> bagitemList = bagComponent.GetIdItemListByLoc(itemid, ItemLocType.ItemPetHeXinBag);
            if (bagitemList.Count == 0)
            {
                return;
            }
            ItemConfig itemConfig = ItemConfigCategory.Instance.Get(itemid);
            int postion = itemConfig.ItemSubType - 1;
            bagComponent.OnChangeItemLoc(bagitemList[0], ItemLocType.ItemPetHeXinEquip, ItemLocType.ItemPetHeXinBag);
            rolePetInfo.PetHeXinList[postion] = bagitemList[0].BagInfoID;
        }

        //判断当前宠物是否已满
        public static bool PetIsFull(this PetComponent self)
        {

            Unit unit = self.GetParent<Unit>();
            int userLv = unit.GetComponent<UserInfoComponent>().UserInfo.Lv;
            if (PetHelper.GetBagPetNum(self.RolePetInfos) >= PetHelper.GetPetMaxNumber(unit, userLv))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
