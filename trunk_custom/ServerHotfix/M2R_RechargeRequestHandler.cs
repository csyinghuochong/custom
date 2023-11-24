﻿using MongoDB.Driver.Linq;
using System;

namespace ET
{
    [ActorMessageHandler]
    public class M2R_RechargeRequestHandler : AMActorRpcHandler<Scene, M2R_RechargeRequest, R2M_RechargeResponse>
    {
        protected override async ETTask Run(Scene scene, M2R_RechargeRequest request, R2M_RechargeResponse response, Action reply)
        {
            switch (request.PayType)
            {
                case PayTypeEnum.WeiXinPay:
                    response.Message = await scene.GetComponent<ReChargeWXComponent>().WeChatPay(request);
                    break;
                case PayTypeEnum.AliPay:
                    if (!ConfigHelper.RechargeGive.ContainsKey(request.RechargeNumber))
                    {
                        response.Error = ErrorCode.ERR_ModifyData;
                        reply();
                        return;
                    }
                    response.Message =  scene.GetComponent<ReChargeAliComponent>().AliPay(request);
                    break;
                case PayTypeEnum.QuDaoPay:
                    response.Message = scene.GetComponent<ReChargeQDComponent>().QudaoPay(request);
                    break;
                case PayTypeEnum.IOSPay:
                    response.Error = await scene.GetComponent<ReChargeIOSComponent>().OnIOSPayVerify(request);
                    break;
                case PayTypeEnum.TikTok:
                    response.Message = scene.GetComponent<ReChargeTikTokComponent>().TikTokPay(request);
                    break;
            }

            reply();
            await ETTask.CompletedTask;
        }
    }
}
