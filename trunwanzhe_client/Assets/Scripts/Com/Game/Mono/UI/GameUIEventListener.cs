using System;
using UnityEngine;
using Assets.Scripts.Com.Net;

public class GameUIEventListener : MonoBehaviour
{
    public object parameter;

    public UIEventListener.VoidDelegate onSubmit;
    public UIEventListener.VoidDelegate onClick;
    public UIEventListener.VoidDelegate onDoubleClick;
    public UIEventListener.BoolDelegate onHover;
    public UIEventListener.BoolDelegate onPress;
    public UIEventListener.BoolDelegate onSelect;
    public UIEventListener.FloatDelegate onScroll;
    public UIEventListener.VoidDelegate onDragStart;
    public UIEventListener.VectorDelegate onDrag;
    public UIEventListener.VoidDelegate onDragOver;
    public UIEventListener.VoidDelegate onDragOut;
    public UIEventListener.VoidDelegate onDragEnd;
    public UIEventListener.ObjectDelegate onDrop;
    public UIEventListener.KeyCodeDelegate onKey;
    public UIEventListener.BoolDelegate onTooltip;

    //主要给新手指引使用
    public event Action onClick2;

    void OnSubmit() { if (onSubmit != null) onSubmit(gameObject); }

    private float mContinueClickInterval = 0f;
    private float mContinueNetInterval = 1.0f;
    private float mContineuClickTime;

    void OnClick()
    {
        float time = Time.realtimeSinceStartup;

        if (mContinueClickInterval != 0)
        {
            if (time - mContineuClickTime < mContinueClickInterval)
                return;
            mContineuClickTime = time;
        }

        if (time - mNetTime >= mContinueNetInterval)
        {
            MsgManager.sWaitAction += OnWait;
            if (onClick != null)
                onClick(gameObject);
            MsgManager.sWaitAction -= OnWait;
        }

        ExecuteOnClick2();
    }

    public void ExecuteOnClick2()
    {
        if (onClick2 != null)
            onClick2();
    }

    void OnDoubleClick() { if (onDoubleClick != null) onDoubleClick(gameObject); }
    void OnHover(bool isOver) { if (onHover != null) onHover(gameObject, isOver); }

    BoxCollider mBoxCollider;
    Vector3 mBoxColliderSize;

    void OnPress(bool isPressed)
    {
        if (mBoxCollider == null)
        {
            mBoxCollider = gameObject.GetComponent<BoxCollider>();
            mBoxColliderSize = mBoxCollider.size;
        }

        if (isPressed)
        {
            mBoxCollider.size *= 1.2f;
        }
        else
        {
            if (mBoxCollider != null)
            {
                mBoxCollider.size = mBoxColliderSize;
            }
        }

        if (onPress != null)
            onPress(gameObject, isPressed);
    }

    float mNetTime;
    int mMsgID;
    void OnWait(int msgID)
    {
        mNetTime = Time.realtimeSinceStartup;
        mMsgID = msgID;

        MsgManager.sPackAction -= OnSend;
        MsgManager.sPackAction += OnSend;
    }

    void OnSend(int msgID)
    {
        if (mMsgID == msgID)
        {
            MsgManager.sPackAction -= OnSend;

            //mNetTime = Time.realtimeSinceStartup;

            MsgManager.sUnpackAction -= OnReceive;
            MsgManager.sUnpackAction += OnReceive;
        }
    }

    void OnReceive(int msgID)
    {
        MsgManager.sUnpackAction -= OnReceive;

        mNetTime = Time.realtimeSinceStartup;
    }

    void OnSelect(bool selected) { if (onSelect != null) onSelect(gameObject, selected); }
    void OnScroll(float delta) { if (onScroll != null) onScroll(gameObject, delta); }
    void OnDragStart() { if (onDragStart != null) onDragStart(gameObject); }
    void OnDrag(Vector2 delta) { if (onDrag != null) onDrag(gameObject, delta); }
    void OnDragOver() { if (onDragOver != null) onDragOver(gameObject); }
    void OnDragOut() { if (onDragOut != null) onDragOut(gameObject); }
    void OnDragEnd() { if (onDragEnd != null) onDragEnd(gameObject); }
    void OnDrop(GameObject go) { if (onDrop != null) onDrop(gameObject, go); }
    void OnKey(KeyCode key) { if (onKey != null) onKey(gameObject, key); }
    void OnTooltip(bool show) { if (onTooltip != null) onTooltip(gameObject, show); }

    static public GameUIEventListener Get(GameObject go, float continueNetInterval = 1.0f, float continueClickInterval = 0f)
    {
        GameUIEventListener listener = go.GetComponent<GameUIEventListener>();
        if (listener == null)
        {
            listener = go.AddComponent<GameUIEventListener>();
        }

        listener.mContinueNetInterval = continueNetInterval;
        listener.mContinueClickInterval = continueClickInterval;

        return listener;
    }
}
