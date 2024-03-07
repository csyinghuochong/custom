using System;


namespace ET
{
    public class GM_OnGMCommon : AEvent<EventType.GMCommonRequest>
    {
        protected override async void Run(EventType.GMCommonRequest request)
        {
            await ETTask.CompletedTask;
            string[] infoList = request.Context.Split(" ");

            if (infoList[0] == ConsoleMode.ChaXun)
            {
                await ConsoleHelper.ChaXunConsoleHandler(request.Context);
            }
            if (infoList[0] == ConsoleMode.Combat)
            {
                await ConsoleHelper.CombatConsoleHandler(request.Context);
            }
            if (infoList[0] == ConsoleMode.KickOut)
            {
                ConsoleHelper.KickOutConsoleHandler(request.Context);
            }
            if (infoList[0] == ConsoleMode.Level)
            {
                ConsoleHelper.LevelConsoleHandler(request.Context).Coroutine();
            }
            if (infoList[0] == ConsoleMode.Mail)
            {
                ConsoleHelper.MailConsoleHandler(request.Context).Coroutine();
            }
            if (infoList[0] == ConsoleMode.Rechage)
            {
#if SERVER
                string[] mailInfo = request.Context.Split(" ");
                if (mailInfo[0] != "rechage" && mailInfo.Length < 4)
                {
                    return;
                }
                RechargeHelp.OnPaySucessToGate(int.Parse(mailInfo[1]), long.Parse(mailInfo[2]), int.Parse(mailInfo[3]), "补偿").Coroutine();
#endif
            }
            if (infoList[0] == ConsoleMode.ReloadDll)
            {
                ConsoleHelper.ReloadDllConsoleHandler(request.Context).Coroutine();
            }
            if (infoList[0] == ConsoleMode.ServerRank)
            {
                ConsoleHelper.ServerRankConsoleHandler(request.Context).Coroutine();
            }
            if (infoList[0] == ConsoleMode.StopServer)
            {
                ConsoleHelper.StopServerConsoleHandler(request.Context).Coroutine();
            }
            if (infoList[0] == "gold" || infoList[0] == "diamond")
            {
                ConsoleHelper.GoldConsoleHandler(request.Context, infoList[0]).Coroutine();
            }
            if (infoList[0] == "black")
            {
                ConsoleHelper.BlackConsoleHandler(request.Context).Coroutine();
            }
        }
    }
}
