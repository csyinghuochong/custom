using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.Loader
{
    class AssetRequestBase
    {

    }

    class AssetRequestGeneral : AssetRequestBase
    {
        public AssetType assetType;
        public string directory;
        public string assetName;

        public virtual void Execute(UnityEngine.Object obj)
        {

        }

        public virtual bool HasCallBack()
        {
            return false;
        }
    }

    class AssetRequest<T> : AssetRequestGeneral where T : UnityEngine.Object
    {
        public Action<T> callBack;

        public override void Execute(UnityEngine.Object obj)
        {
            callBack(obj as T);
        }

        public override bool HasCallBack()
        {
            return callBack != null;
        }
    }

    class AssetUnitRequest : AssetRequestBase
    {
        public AssetType assetType;
        public string directory;
        public string assetName;
        public Dictionary<string, string> assetDependDic;
        public Dictionary<string, AssetUnit> assetUnitDic;
        public Action<AssetUnit> callBack;

        public void Execute(AssetUnit obj)
        {
            callBack(obj);
        }

        public bool HasCallBack()
        {
            return callBack != null;
        }
    }

    class ActionRequest : AssetRequestBase
    {
        public Action callBack;

        public bool HasCallBack()
        {
            return callBack != null;
        }
    }
}
