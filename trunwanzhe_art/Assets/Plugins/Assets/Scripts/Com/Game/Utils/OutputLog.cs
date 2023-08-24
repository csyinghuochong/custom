using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public sealed class OutputLog : MonoBehaviour
    {
        private static List<string> mErrorList = new List<string>();
        private static List<string> mLogList = new List<string>();
        private static string mOutPath;
        private static string mOutErrorPath;

        private static string mSaveFileName;

        private float mCurTime = 0;
        private bool mLogError = false;

        public static void SetSaveFileName(string name)
        {
            if (string.IsNullOrEmpty(mSaveFileName))
                mSaveFileName = name;
        }

        void Awake()
        {
            Application.RegisterLogCallback(HandleLog);

            if (mOutPath == null)
            {
                mOutErrorPath = Application.persistentDataPath + "/outputError.txt";
                mOutPath = Application.persistentDataPath + "/outputLog.txt";


                if (System.IO.File.Exists(mOutPath))
                {
                    File.Delete(mOutPath);
                }

                if (System.IO.File.Exists(mOutErrorPath))
                {
                    File.Delete(mOutErrorPath);
                }

                Debug.Log("outPath:" + mOutPath);
            }
        }

        void Start()
        {
            mCurTime = Time.realtimeSinceStartup;

            string str = DateTime.Now.ToString();
            Debug.Log(str + "...启动游戏...");
        }

        void Update()
        {
            if (DebugControl.writeLog == false)
                return;

            SaveLog(mLogList, mOutPath, true);

            if (Time.realtimeSinceStartup - mCurTime >= 5.0f)
            {
                mCurTime = Time.realtimeSinceStartup;

                SaveLog(mErrorList, mOutErrorPath, true);

                if (mLogError)
                {
                    mLogError = false;

                    if (DebugControl.ftpSendError && string.IsNullOrEmpty(mSaveFileName) == false)
                        FtpHelper.Upload(mOutErrorPath, "ftp://192.168.0.250/debug_log/", mSaveFileName);
                }
            }
        }

        private void SaveLog(List<string> logList, string path, bool clear = false)
        {
            if (logList.Count > 0)
            {
                using (StreamWriter writer = new StreamWriter(path, true, Encoding.UTF8))
                {
                    for (int i = 0, count = logList.Count; i < count; i++)
                    {
                        writer.WriteLine(logList[i]);
                    }
                }

                if (clear)
                    logList.Clear();
            }
        }

        void HandleLog(string logString, string stackTrace, LogType type)
        {
            mLogList.Add(logString);
            if (type == LogType.Error || type == LogType.Exception)
            {
                //AddLog(logString);
                AddLog(stackTrace);

                mLogList.Add(stackTrace);

                mLogError = true;
            }
        }

        void AddLog(string text)
        {
            mErrorList.Add(text);
        }

        void OnGUI()
        {
            if (DebugControl.writeLog == false)
                return;

            GUI.color = Color.red;
            for (int i = 0, imax = mErrorList.Count; i < imax; ++i)
            {
                GUILayout.Label(mErrorList[i]);
            }
        }
    }
}
