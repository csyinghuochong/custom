using System.Collections.Generic;
using System.Net;

namespace ET
{
    public partial class StartProcessConfig
    {
        private IPEndPoint innerIPPort;

        public long SceneId;

        public IPEndPoint InnerIPPort
        {
            get
            {
                if (this.innerIPPort == null)
                {
                    this.innerIPPort = NetworkHelper.ToIPEndPoint($"{this.InnerIP}:{this.InnerPort}");
                }

                return this.innerIPPort;
            }
        }

        public string InnerIP => this.StartMachineConfig.InnerIP;

        public string OuterIP => this.StartMachineConfig.OuterIP;

        public StartMachineConfig StartMachineConfig => StartMachineConfigCategory.Instance.Get(this.MachineId);

        public static List<int> ProcessList = new List<int>() { 1, 2 };

        public override void AfterEndInit()
        {
            InstanceIdStruct instanceIdStruct = new InstanceIdStruct((int)this.Id, 0);
            this.SceneId = instanceIdStruct.ToLong();
            Log.Info($"StartProcess info: {this.MachineId} {this.Id} {this.SceneId}");
        }
    }
}