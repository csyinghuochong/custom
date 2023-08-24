using UnityEngine;
using System.Collections;

/// <summary>
/// 根据设备的宽高比，调整camera.orthographicSize. 以保证UI在不同分辨率(宽高比)下的自适应
/// 须与UIAnchor配合使用
/// 将该脚本添加到UICamera同一节点上
/// </summary>
namespace Assets.Scripts.Com.Game.Mono.Utils
{
    [RequireComponent(typeof(UICamera))]
    public class UICameraAdjustor : MonoBehaviour
    {
        public const int standard_width = 960;
        public const int standard_height = 640;

        public static int device_width = 0;
        public static int device_height = 0;
        public static float standard_aspect = 0f;
        public static float device_aspect = 0f;

        void Awake()
        {
            if (device_width == 0)
            {
                device_width = Screen.width;
                device_height = Screen.height;

                standard_aspect = (float)standard_width / (float)standard_height;
                device_aspect = (float)device_width / (float)device_height;

                //print(string.Format("dw:{0},dh:{1},da{2};sw:{3},sh{4},sa{5}", device_width, device_height, device_aspect, standard_width, standard_height, standard_aspect));
            }

            SetCameraSize();
        }

        private void SetCameraSize()
        {
            float adjustor = 0f;

            if (device_aspect < standard_aspect)
            {
                adjustor = standard_aspect / device_aspect;
                GetComponent<Camera>().orthographicSize = adjustor;
            }
        }
    }
}