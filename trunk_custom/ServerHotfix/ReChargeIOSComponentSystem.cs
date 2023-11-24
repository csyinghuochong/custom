﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ObjectSystem]
    public class ReChargeIOSComponentAwake : AwakeSystem<ReChargeIOSComponent>
    {
        public override void Awake(ReChargeIOSComponent self)
        {
            self.PayLoadList.Clear();   
        }
    }

    public static class ReChargeIOSComponentSystem
    {

        public static async ETTask<int> OnIOSPayVerify(this ReChargeIOSComponent self, M2R_RechargeRequest request)
        {
            Log.Warning($"IOS充值回调执行00 " + "id:" + request.UnitId);
            string verifyURL = string.Empty;
            if (request.UnitId == 1603809198615887872 || request.UnitId == 1636544958309662720)
            {
                verifyURL = "https://sandbox.itunes.apple.com/verifyReceipt";
            }
            else
            {
                verifyURL = "https://buy.itunes.apple.com/verifyReceipt";
            }

            string payLoad = request.payMessage;
            if (self.PayLoadList.Contains(payLoad))
            {
                return ErrorCode.ERR_IOSVerify;
            }

            string sendStr = "{\"receipt-data\":\"" + payLoad + "\"}";
            string postReturnStr = await HttpHelper.GetIosPayParameter(verifyURL, sendStr);
            Root rt = null;
            Log.Warning($"IOS充值回调11 {postReturnStr}");
            try
            {
                rt = JsonHelper.FromJson<Root>(postReturnStr);
            }
            catch (Exception ex)
            {
                Log.Warning($"IOS充值回调11_1 {ex.ToString()}");
                return ErrorCode.ERR_IOSVerify;
            }
            Log.Warning($"IOS充值回调22 {rt.status}");
            //交易失败，直接返回
            if (rt.status != 0)
            {
                Log.Warning($"IOS充值回调ERROR1 {rt.status}");
                return ErrorCode.ERR_IOSVerify;
            }

            if (rt.receipt.in_app == null || rt.receipt.in_app.Count == 0)
            {
                Log.Warning($"IOS充值回调ERROR2 ");
                return ErrorCode.ERR_IOSVerify;
            }

            //封号处理 使用IAPFree工具
            if (rt.receipt.in_app[0].product_id == "com.zeptolab.ctrbonus.superpower1")
            {
                Log.Warning($"IOS充值回调ERROR3 ");
                return ErrorCode.ERR_IOSVerify;
            }

            if (!string.IsNullOrEmpty(rt.receipt.bundle_id) && rt.receipt.bundle_id != "com.guangying.weijing2")
            {
                Log.Warning($"IOS充值回调ERROR4");
                return ErrorCode.ERR_IOSVerify;
            }

            string dingDanTime = rt.receipt.purchase_date_ms;
            //判断时间
            List<InApp> in_app_list = rt.receipt.in_app;
            Log.Warning($"IOS充值回调[inapp]: {in_app_list.Count}");
            for (int i = 0; i < in_app_list.Count; i++)
            {
                InApp inApp = in_app_list[i];   
                string product_id = inApp.product_id;

                if (product_id.Contains("SG"))
                {
                    Log.Warning($"IOS充值回调ERROR5 : SG");
                    continue;
                }
                if (!product_id.Contains("WJ"))
                {
                    Log.Warning($"IOS充值回调ERROR6 : !WJ");
                    continue;
                }

                product_id = product_id.Substring(0, product_id.Length - 2);
                int rechargeNumber = 0;
                try
                {
                    rechargeNumber = int.Parse(product_id);
                }
                catch (Exception ex)
                {
                    Log.Warning(ex.ToString());
                    continue;
                }
                self.PayLoadList.Add(payLoad);
                if (self.PayLoadList.Count >= 100)
                {
                    self.PayLoadList.RemoveAt(0);
                }
                string serverName = ServerHelper.GetGetServerItem(false, request.Zone).ServerName;
                Log.Warning($"支付成功[IOS]: 区：{serverName}     玩家名字：{request.UnitName}     充值额度：{rechargeNumber}");
                Log.Console($"支付成功[IOS]: 区：{serverName}     玩家名字：{request.UnitName}     充值额度：{rechargeNumber}  时间:{TimeHelper.DateTimeNow().ToString()}");
                await RechargeHelp.OnPaySucessToGate(request.Zone, request.UnitId, rechargeNumber, postReturnStr);
            }

            return ErrorCode.ERR_Success;
        }
    }
}
