﻿using System;
using System.Collections.Generic;

namespace ET
{
    [ActorMessageHandler]
    internal class M2E_GMEMailSendHandler : AMActorRpcHandler<Scene, M2E_GMEMailSendRequest, E2M_GMEMailSendResponse>
    {
        protected override async ETTask Run(Scene scene, M2E_GMEMailSendRequest request, E2M_GMEMailSendResponse response, Action reply)
        {
            Log.Warning($"M2E_GMEMailSendRequest:{request.UserName}");
            if (request.UserName == "0")
            {
                //dBMailInfos = await Game.Scene.GetComponent<DBComponent>().Query<DBMailInfo>(scene.DomainZone(), d => d.Id > 0);
                EventType.ServerMail serverMail = new EventType.ServerMail()
                {
                    Message = request,
                    MailScene = scene,
                };
                Game.EventSystem.Publish(serverMail);
                reply();
                return;
            }

            List<DBMailInfo> dBMailInfos = null;
            List<UserInfoComponent> accountInfoList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(scene.DomainZone(), d => d.UserInfo.Name == request.UserName);
            if (accountInfoList.Count > 0)
            {
                dBMailInfos = await Game.Scene.GetComponent<DBComponent>().Query<DBMailInfo>(scene.DomainZone(), d => d.Id == accountInfoList[0].Id);
            }
            if (dBMailInfos != null)
            {
                long serverTime = TimeHelper.ServerNow();
                for (int i = 0; i < dBMailInfos.Count; i++)
                {
                    List<NumericComponent> numericInfoList = await Game.Scene.GetComponent<DBComponent>().Query<NumericComponent>(scene.DomainZone(), d => d.Id == dBMailInfos[i].Id);
                    if (numericInfoList.Count == 0)
                    {
                        continue;
                    }
                    List<UserInfoComponent> userinfoComponents = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(scene.DomainZone(), d => d.Id == dBMailInfos[i].Id);
                    if (userinfoComponents.Count == 0)
                    {
                        continue;
                    }
                    if (userinfoComponents[0].UserInfo.RobotId > 0)
                    {
                        continue;
                    }

                    List<BagComponent> bagInfoList = await Game.Scene.GetComponent<DBComponent>().Query<BagComponent>(scene.DomainZone(), d => d.Id == dBMailInfos[i].Id);
                    if (bagInfoList.Count == 0)
                    {
                        continue;
                    }

                    bool cansendMail = MailHelp.CheckSendMail(request.MailType, request.Title, numericInfoList[0], userinfoComponents[0], bagInfoList[0]);
                    if (cansendMail == false)
                    {
                        continue;
                    }

                    MailInfo mailInfo = new MailInfo();
                    mailInfo.Status = 0;
                    mailInfo.Context = "福利发放";
                    mailInfo.Title = "福利发放";
                    mailInfo.MailId = IdGenerater.Instance.GenerateId();
                    string[] needList = request.Itemlist.Split('@');
                    for (int k = 0; k < needList.Length; k++)
                    {
                        string[] itemInfo = needList[k].Split(';');
                        if (itemInfo.Length < 2)
                        {
                            continue;
                        }
                        int itemId = int.Parse(itemInfo[0]);
                        int itemNum = int.Parse(itemInfo[1]);
                        mailInfo.ItemList.Add(new BagInfo() { ItemID = itemId, ItemNum = itemNum, GetWay = $"{ItemGetWay.ReceieMail}_{serverTime}" });
                    }

                    await MailHelp.SendUserMail((int)request.ActorId, dBMailInfos[i].Id, mailInfo);
                }
            }
            else 
            {
                response.Message = $"找不到:{request.UserName}";
                response.Error = ErrorCode.ERR_NotFindAccount;
            }

            reply();
            await ETTask.CompletedTask;
        }
    }
}