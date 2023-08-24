using UnityEngine;

namespace Assets.Scripts.Com.Game.Core.CommonList
{
    class CommonListItem<D>:BaseView
    {
        public delegate void VoidDelegate(CommonListItem<D> item);

        public VoidDelegate onClick;
        public float sWidth;
        public float sHeight;
       
        public D data;
        protected GameUIEventListener listener;
        public CommonListItem()
        {
        }

        protected override void Init()
        {
            base.Init();

            BoxCollider collider = gameObject.GetComponent<BoxCollider>();
            if (collider != null)
            {
                this.sWidth = collider.size.x;
                this.sHeight = collider.size.y;
            }

            listener = GameUIEventListener.Get(gameObject);
            listener.onClick = ClickItem;
        }


        public void SetParent(GameObject go)
        {
            this.transform.parent = go.transform;
            this.transform.localScale = go.transform.localScale;
            this.transform.localPosition = Vector3.zero;
            this.gameObject.layer = go.layer;
        }

        public void ClickItem(GameObject go)
        {
            if (onClick != null) onClick(this);
        }

        private UICenterOnChild centerScript;
        public void CenterOnScroll()
        {
            if (centerScript == null)
            {
                centerScript = this.gameObject.AddComponent<UICenterOnChild>();
            }
            centerScript.onCenter = OnCenter;
            centerScript.Recenter();
            centerScript.enabled = false;
        }

        private void OnCenter(GameObject centeredObject)
        {
            UIScrollView mScrollView = NGUITools.FindInParents<UIScrollView>(gameObject);
            if (mScrollView)
            {
            }
        }

        /// <summary>
        /// 赋值 子类复写
        /// </summary>
        /// <param name="obj"></param>
        public virtual void SetData(D d)
        {
            this.data = d;
        }

        /// <summary>
        /// 赋值 子类复写
        /// </summary>
        /// <param name="obj"></param>
        public virtual void ClearData()
        {
            
        }

        protected bool isChoose;
        /// <summary>
        /// 选中效果 子类复写
        /// </summary>
        /// <param name="choose"></param>
        public virtual void SetChoose(bool choose)
        {
            isChoose = choose;
        }

        public virtual void Hide()
        {
            this.gameObject.SetActive(false);
//             UIToggle toggle = this.gameObject.GetComponent<UIToggle>();
//             if (toggle != null)
//             {
//                 this.gameObject.GetComponent<UIToggle>().value = false;
//             }
            
        }

    }
}
