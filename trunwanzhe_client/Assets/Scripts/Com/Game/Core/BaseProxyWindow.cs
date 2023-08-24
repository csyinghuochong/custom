using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using LuaInterface;

namespace Assets.Scripts.Com.Game.Core
{
    public class BaseProxyWindow : BaseWindow
    {
        BaseViewParam mExternalBaseViewParam;
      

        public void SetViewParam(BaseViewParam viewParam)
        {
            mDisposeRemoveViewID = false;
            mExternalBaseViewParam = viewParam;
            mViewParam = InitViewParam();
        }

        protected override BaseViewParam InitViewParam()
        {
            return mExternalBaseViewParam;
        }

        protected override void Init()
        {
            base.Init();

       
        }

        protected override void OnViewShow()
        {
            base.OnViewShow();

         
        }

        protected override void OnViewHide()
        {
            base.OnViewHide();

        }

        protected override void Dispose()
        {
            base.Dispose();

        
        }
    }
}
