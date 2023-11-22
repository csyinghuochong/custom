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
    public class TikTok_OnTikTokPayRequest : AEventClass<EventType.TikTokPayRequest>
    {
        protected override void Run(object a)
        {
            EventType.TikTokPayRequest args = a as EventType.TikTokPayRequest;

            string[] parminfolist = args.PayMessage.Split('&');
            string dinghaoid = parminfolist[0];

            Log.Debug($"TikTokPayMessage: {args.PayMessage}");
            TikTokPay tikTokPay = JsonHelper.FromJson<TikTokPay>(parminfolist[0]);
            if (tikTokPay.code == 0 && tikTokPay.message.Equals("success"))
            {
                //TikTokPay(String cpOrderId, int amountInCent, String productId, String productName, String sdkParam)
                GameObject.Find("Global").GetComponent<Init>().TikTokPay(dinghaoid, 1, "6", "钻石", tikTokPay.sdk_param);
            }
            else
            {
                Log.ILog.Debug($"TikTokPayError: {tikTokPay.message}");
            }
        }
    }


}
