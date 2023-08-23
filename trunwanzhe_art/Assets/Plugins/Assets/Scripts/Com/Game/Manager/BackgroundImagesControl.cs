using Assets.Scripts.Com.Game.Mono.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Manager
{
    [Flags]
    public enum BackgroundAdjustType
    {
        WIDTH = 1,
        HEIGHT = 2,
        WIDTH_HEIGHT = WIDTH | HEIGHT
    }

    public class BackgroundImagesControl
    {
        //场景加载的时候可以看见缝隙,只能手动调整
        private const int OFFSET_HEIGHT = 4;
        private const int OFFSET_WIDTH = 4;

        public static void SetBackgroundSize(UIWidget widget, BackgroundAdjustType adjustType = BackgroundAdjustType.WIDTH_HEIGHT)
        {
            if (widget == null)
                return;

            if (UICameraAdjustor.standard_aspect < UICameraAdjustor.device_aspect)
            {
                if ((adjustType & BackgroundAdjustType.HEIGHT) == BackgroundAdjustType.HEIGHT)
                    widget.height = UICameraAdjustor.standard_height + OFFSET_HEIGHT;

                if ((adjustType & BackgroundAdjustType.WIDTH) == BackgroundAdjustType.WIDTH)
                    widget.width = (int)(UICameraAdjustor.standard_height * UICameraAdjustor.device_aspect) + OFFSET_WIDTH;
            }
            else
            {
                if ((adjustType & BackgroundAdjustType.WIDTH) == BackgroundAdjustType.WIDTH)
                    widget.width = UICameraAdjustor.standard_width + OFFSET_WIDTH;

                if ((adjustType & BackgroundAdjustType.HEIGHT) == BackgroundAdjustType.HEIGHT)
                    widget.height = (int)(UICameraAdjustor.standard_width / UICameraAdjustor.device_aspect) + OFFSET_HEIGHT;
            }
        }
    }
}
