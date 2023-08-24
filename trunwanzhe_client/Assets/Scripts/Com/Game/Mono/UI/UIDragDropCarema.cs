using UnityEngine;
using Assets.Scripts.Com.Game.Manager;

namespace Assets.Scripts.Com.Game.Mono.UI
{

    public delegate Vector3 GetWordPos(Vector3 x);
    public delegate Vector3 CheckUIPosition(Vector3 x);
    class UIDragDropCarema : UIDragDropItem
    {

        public GameObject mMapCollider;
        public GetWordPos mGetWordPos;
        public CheckUIPosition mCheckUIPosition;

        protected override void OnDragStart()
        {
            base.OnDragStart();

            ShowCarema(true);
        }

        protected override void OnDragEnd()
        {
            base.OnDragEnd();

            ShowCarema(false);
        }

        private void ShowCarema(bool show)
        {
            if (mTrans == null)
                mTrans = transform;
            mTrans.gameObject.SetActive(show);
         
        }

        public void AddEventListener()
        {
            GameUIEventListener.Get(mMapCollider).onPress = delegate(GameObject obj, bool press)
            {
                if (press)
                {
                    ShowCarema(true);
                    SetUIPosition(Input.mousePosition);
                }
                else
                {
                    ShowCarema(false);
                }
            };

            GameUIEventListener.Get(mMapCollider).onDrag = delegate(GameObject go, Vector2 delta)
            {
                OnDragDropMove(delta);
            };
        }

        protected override void OnDragDropMove(Vector2 delta)
        {
            SetUIPosition(Input.mousePosition);
        }

        private void SetUIPosition(Vector3 pos)
        {
            Vector3 ui_pos = Input.mousePosition;
            ui_pos.x = Mathf.Clamp01(pos.x / Screen.width);
            ui_pos.y = Mathf.Clamp01(pos.y / Screen.height);
          
            Vector3 local_pos = new Vector3(mTrans.localPosition.x, mTrans.localPosition.y, 0f);
            local_pos = mCheckUIPosition(local_pos);
            mTrans.localPosition = local_pos;

        }

    }

}
