
using System.Security.AccessControl;
using UnityEngine;
using UnityEngine.UI;

namespace ET
{

    public static class UILoginComponentSystem3
    {

        //ʵ����֤�ص�
        // code == 500;   // ���δ�ܵ����ƣ�����������Ϸ
        // code == 1000;  // �˳���������֤����飬�������ߵ��� Exit �ӿ�ʱ���û���֤��Ϣ��Чʱ��������ϷӦ���ص���¼ҳ
        // code == 1001;  // �û�����л��˺ţ���ϷӦ���ص���¼ҳ
        // code == 1030;  // �û���ǰʱ���޷�������Ϸ����ʱ�û�ֻ���˳���Ϸ���л��˺�
        // code == 1050;  // �û��޿���ʱ������ʱ�û�ֻ���˳���Ϸ���л��˺�
        // code == 1100;  // ��ǰ�û��򴥷�Ӧ�����õ����������޷�������Ϸ
        // code == 1200;  // ��������ʧ�ܣ���Ϸ���鵱ǰ���õ�Ӧ����Ϣ�Ƿ���ȷ���жϵ�ǰ���������Ƿ�����
        // code == 9002;  // ʵ�������е���˹ر�ʵ��������Ϸ�����¿�ʼ��������֤
        public static  async ETTask OnAntiAddictionHandler(this UILoginComponent self, int code, string errormsg)
        {
            if (code == 1050)
            {
                FloatTipManager.Instance.ShowFloatTip("�û��޿���ʱ������ʱ�û�ֻ���˳���Ϸ���л��˺�");
                return;
            }

            if (code != 500)
            {
                FloatTipManager.Instance.ShowFloatTip("ʵ����֤ʧ��");
                return;
            }

            //��ȡ����
            int age =  TapSDKV20Helper.Instance.GetAgeRange();
            //��ȡʣ����Ϸʱ��
            int remaintime =  TapSDKV20Helper.Instance.GetRemainingTime();

            Log.ILog.Debug($"tap��֤���أ� age:{age}  remingtime:{remaintime}");

            AccountInfoComponent accountInfoComponent = self.ZoneScene().GetComponent<AccountInfoComponent>();
            accountInfoComponent.Age_Type = age;

            string account = accountInfoComponent.Account;
            string password = accountInfoComponent.Password;
            string loginType = accountInfoComponent.LoginType;

            if (loginType == "3" || loginType == "4")
            {
                password = "3";
                loginType = "3";
            }

            long instanceid = self.InstanceId;

            C2A_TapTapAuther c2A_TapTapAuther = new C2A_TapTapAuther() { 
                Account = account,
                Password = password,   
                LoginType = int.Parse(loginType),
                age_type = age
            };
            Session accountSession = self.ZoneScene().GetComponent<NetKcpComponent>().Create(NetworkHelper.ToIPEndPoint(self.ServerInfo.ServerIp));
            A2C_TapTapAuther a2C_TikTokVerifyUser = (A2C_TapTapAuther)await accountSession.Call(c2A_TapTapAuther);
            accountSession.Dispose();

            if (instanceid != self.InstanceId)
            {
                FloatTipManager.Instance.ShowFloatTip("ʵ����֤ʧ��");
                return;
            }

            self.RequestLoginV20(account, password, loginType).Coroutine();
        }
    }




    public class TapTap_OnTapTapAuther : AEventClass<EventType.TapTapAuther>
    {
        protected override void Run(object numerice)
        {
            EventType.TapTapAuther args = numerice as EventType.TapTapAuther;

            UI ui = UIHelper.GetUI( args.ZoneScene, UIType.UILogin );
            TapSDKV20Helper.Instance.AntiAddictionHandler =  (int errror, string msg)=>
            {
                ui.GetComponent<UILoginComponent>().OnAntiAddictionHandler(errror, msg).Coroutine();
            };

            TapSDKV20Helper.Instance.RealNameAuther( args.Account );
        }
    }
}
