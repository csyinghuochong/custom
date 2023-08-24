using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.UI
{
    class DragScrollViewExtend:UIDragScrollView
    {
        /// <summary>
        /// 拖拽不能超出边界
        /// </summary>
        /// <param name="delta"></param>
        void OnDrag(Vector2 delta)
        {
            if (scrollView && NGUITools.GetActive(this))
            {
                scrollView.Drag();
                scrollView.RestrictWithinBounds(true, scrollView.canMoveHorizontally, scrollView.canMoveVertically);
            }
        }
    }
}
