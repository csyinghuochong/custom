using UnityEngine;

namespace ET
{

    public static class UILoginComponentSystem2
    {


        
    }

    [Event]
    public class TikTok_TikTokGetAccesstoken : AEventClass<EventType.TikTokGetAccesstoken>
    {
        protected override void Run(object a)
        {
            EventType.TikTokGetAccesstoken args = a as EventType.TikTokGetAccesstoken;

            Log.ILog.Debug("GetTiktokAccesstoken: ");

            GameObject.Find("Global").GetComponent<Init>().OnTikTokAccesstokenHandler = args.AccesstokenHandler;

            Init init = GameObject.Find("Global").GetComponent<Init>();
            init.TikTokLogin();
        }
    }

    [Event]
    public class TikTok_OnRiskControlInfo : AEventClass<EventType.TikTokRiskControlInfo>
    {
        protected override void Run(object a)
        {
            EventType.TikTokRiskControlInfo args = a as EventType.TikTokRiskControlInfo;

            Log.ILog.Debug("TikTokRiskControlInfo");
            GameObject.Find("Global").GetComponent<Init>().OnRiskControlInfoHandler = args.RiskControlInfoHandler;

            GameObject.Find("Global").GetComponent<Init>().TikTokRiskControlInfo();
        }
    }

    [Event]
    public class TikTok_OnTikTokShare : AEventClass<EventType.TikTokShare>
    {
        protected override void Run(object a)
        {
            EventType.TikTokShare args = a as EventType.TikTokShare;

            GameObject.Find("Global").GetComponent<Init>().OnShareHandler = args.ShareHandler;

            string string_1 = string.Empty;
            for (int i = 0; i < args.ShareMessage.Count; i++)
            {
                if (i == args.ShareMessage.Count - 1)
                {
                    string_1 = string_1 + $"{args.ShareMessage[i]}";
                }
                else
                {
                    string_1 = string_1 + $"{args.ShareMessage[i]}&";
                }
            }
            string string_2 = string.Empty;
            Log.ILog.Debug($"TikTokShare: {string_1} \n {string_2}");
            GameObject.Find("Global").GetComponent<Init>().TikTokShareImage(string_1, string_2);
        }
    }

    [Event]
    public class Login_LoginCheckRoot : AEventClass<EventType.LoginCheckRoot>
    {
        protected override void Run(object a)
        {
            EventType.LoginCheckRoot args = a as EventType.LoginCheckRoot;
            
            Init init = GameObject.Find("Global").GetComponent<Init>();
            AccountInfoComponent accountInfoComponent = args.ZoneScene.GetComponent<AccountInfoComponent>();
            accountInfoComponent.Simulator = init.IsEmulator;
            accountInfoComponent.Root = init.IsRoot;
            Log.ILog.Debug($"LoginCheckRoot: {init.IsRoot} {init.IsEmulator}");
        }
    }

    [Event]
    public class TikTok_OnTikTokPayRequest : AEventClass<EventType.TikTokPayRequest>
    {
        protected override void Run(object a)
        {
            EventType.TikTokPayRequest args = a as EventType.TikTokPayRequest;

            string[] parminfolist = args.PayMessage.Split('&');
            string dinghaoid = parminfolist[0];

            Log.ILog.Debug($"TikTokPayMessage:  {args.RechargeNumber}   {args.PayMessage}");
            TikTokPay tikTokPay = JsonHelper.FromJson<TikTokPay>(parminfolist[0]);
            if (tikTokPay.code == 0 && tikTokPay.message.Equals("success"))
            {
                //TikTokPay(String cpOrderId, int amountInCent, String productId, String productName, String sdkParam)
                GameObject.Find("Global").GetComponent<Init>().TikTokPay(dinghaoid, (args.RechargeNumber * 100), args.RechargeNumber.ToString(), "钻石", tikTokPay.sdk_param);
            }
            else
            {
                Log.ILog.Debug($"TikTokPayError: {tikTokPay.message}");
            }
        }
    }


}
