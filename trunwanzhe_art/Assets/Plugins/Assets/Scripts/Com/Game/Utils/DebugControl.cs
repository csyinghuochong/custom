using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public static class DebugControl
    {
        //只在编辑器运行时候会执行，移动端，正式发布不执行
        public static bool debugOnEditor { get;  set; }

        //在编辑器和移动端都会执行，正式发布的时候不执行
        public static bool debugOnMobile { get;  set; }

        //调试比较频繁的输出,默认是false，需要调试的时候再手动打开。
        public static bool debugOnFrequent { get;  set; }

        //用于策划加载指定配置，方便测试
        public static bool debugLoadPersistentConfig { get; private set; }

        public static bool debugForVersion { get; private set; }

        public static bool writeLog { get; private set; }

        public static bool ftpSendError { get; private set; }

        static DebugControl()
        {
            debugOnEditor = Application.isEditor;

            debugOnMobile = true;

            debugOnFrequent = Application.isEditor;

            debugLoadPersistentConfig = false;

            writeLog = Application.platform != RuntimePlatform.WindowsPlayer;

            ftpSendError = false;

            debugForVersion = true;
        }
    }
}
