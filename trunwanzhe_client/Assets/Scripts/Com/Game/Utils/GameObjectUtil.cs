using Assets.Scripts.Com.Game.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public static class GameObjectUtil
    {
        public static UnityEngine.Object Instantiate(UnityEngine.Object original)
        {
            return GameObject.Instantiate(original);
        }

        public static void SetUIGameObjectEnable(GameObject go, bool isEnable = true, bool loopChild = true)
        {
            Color color = isEnable ? Color.white : Color.black;

            UIWidget widget = go.GetComponent<UIWidget>();

            if (widget != null)
                widget.color = color;

            if (loopChild)
            {
                UIWidget[] childList = go.GetComponentsInChildren<UIWidget>();

                for (int i = 0, count = childList.Length; i < count; i++)
                {
                    childList[i].color = color;
                }
            }
        }

        public static void SetUIGameObjectsEnable(List<GameObject> gameObjects, bool isEnable = true)
        {
            for (int i = 0, count = gameObjects.Count; i < count; i++)
            {
                SetUIGameObjectEnable(gameObjects[i], isEnable, false);
            }
        }

        public static void SetLayer(GameObject go, int layer, bool loopChild = false)
        {
            go.layer = layer;
            if (loopChild)
            {
                Transform t = go.transform;
                for (int i = 0, imax = t.childCount; i < imax; ++i)
                {
                    Transform child = t.GetChild(i);
                    SetLayer(child.gameObject, layer, loopChild);
                }
            }
        }

        public static void SetTag(GameObject go, string tag, bool loopChild = false)
        {
            go.tag = tag;
            if (loopChild)
            {
                Transform t = go.transform;
                for (int i = 0, imax = t.childCount; i < imax; ++i)
                {
                    Transform child = t.GetChild(i);
                    SetTag(child.gameObject, tag, loopChild);
                }
            }
        }

        public static void Reset(GameObject go, bool isWorldChange = false)
        {
            Transform t = go.transform;
            if (isWorldChange)
            {
                t.position = Vector3.zero;
                t.rotation = Quaternion.identity;
                t.localScale = Vector3.one;
            }
            else
            {
                t.localPosition = Vector3.zero;
                t.localRotation = Quaternion.identity;
                t.localScale = Vector3.one;
            }
        }

        public static void AddChild(GameObject parent, GameObject child)
        {
            Transform transform = child.transform;

            transform.parent = parent.transform;
            transform.localScale = parent.transform.localScale;
            transform.localPosition = Vector3.zero;
        }

        /// <summary>
        /// 显示多少个星星
        /// </summary>
        /// <param name="starList"></param>
        /// <param name="num"></param>
        public static void ShowStar(List<UISprite> starList, int num, string name_light = "", string name_dark = "")
        {
            int count = starList.Count;

            if (name_light != "")
            {
                for (var i = 0; i < count; i++)
                {
                    if (i < num)
                        starList[i].spriteName = name_light;
                    else
                        starList[i].spriteName = name_dark;
                }
                return;
            }

            for (var i = 0; i < count; i++)
            {
                if (i < num)
                    starList[i].gameObject.SetActive(true);
                else
                    starList[i].gameObject.SetActive(false);
            }
        }

        // 初始化panel位置
        public static void InitPanelPos(UIGrid grid, Vector3 pos, Vector2 offset)
        {
            UIPanel panel = grid.transform.parent.gameObject.GetComponent<UIPanel>();
            panel.transform.localPosition = pos;
            panel.clipOffset = offset;
            SpringPanel spring = panel.gameObject.GetComponent<SpringPanel>();
            if (spring != null)
            {
                spring.enabled = false;
                spring.target = pos;
            }
            grid.transform.localPosition = Vector3.zero;
        }

        //按钮样式
        public static void UIButtonEnable(UIButton btn, bool enabled, string label = "")
        {
            btn.isEnabled = enabled;
            if (!string.IsNullOrEmpty(label))
            {
                UILabel btnLabel = btn.transform.Find(label).GetComponent<UILabel>();
                btnLabel.effectStyle = enabled ? UILabel.Effect.Outline : UILabel.Effect.None;
            }
        }
    }
}
