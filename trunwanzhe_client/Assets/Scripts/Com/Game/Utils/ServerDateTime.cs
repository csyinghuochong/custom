using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public class ServerDateTime
    {
        static DateTime sDateTime;
        public static uint sSecond { get; private set; }

        static ServerDateTime()
        {
            sDateTime = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
        }

        static float mCurTime = 0;
        public static void UpdateTime(uint second)
        {
            mCurTime = Time.realtimeSinceStartup;
            sSecond = second;
        }

        public static DateTime Now()
        {
            return GetDateTime(GetServerTime());
        }

        public static uint GetServerTime()
        {
            if( mCurTime >0 )
                return sSecond + (uint)(Time.realtimeSinceStartup - mCurTime );

            return sSecond;
        }

        public static DateTime GetDateTime(uint second)
        {
            return sDateTime.AddSeconds(second);
        }

        /// <summary>
        /// 时间格式化
        /// </summary>
        /// <param name="ts"></param>
        /// <returns></returns>
        public static string TimeFormatDHM(TimeSpan ts)
        {
            string time = "";
            if (ts.TotalDays > 0)
            {
                time = (int)ts.TotalDays + "天";
            }
            else
                if (ts.TotalHours > 0)
                {
                    time = (int)ts.TotalHours + "小时";
                }
                else
                    if (ts.TotalMinutes > 0)
                    {
                        time = (int)ts.TotalMinutes + "分钟";
                    }
            return time;
        }

        public static string TimeFormatDHM2(TimeSpan ts)
        {
            string time = "";
            if (ts.TotalDays > 1)
            {
                time = (int)ts.Days + "天";
                if (ts.Hours > 0)
                {
                    time = time + (int)ts.Hours + "小时";
                } 
            }
            else
            {
                if (ts.TotalHours > 1)
                {
                    time = (int)ts.Hours + "小时";
                    if (ts.Minutes > 0)
                    {
                        time = time + (int)ts.Minutes + "分钟";
                    } 
                }
                else
                {
                    time = (int)ts.TotalMinutes + "分钟";
                }
            }
            return time;
        }

        //与之前计算天数
        public static int TimerCompareDays(uint ts)
        {
            int time = 0;

            DateTime now = Now();
            DateTime last = GetDateTime(ts);

            DateTime nowDate = new DateTime(now.Year, now.Month, now.Day);
            DateTime lastDate = new DateTime(last.Year, last.Month, last.Day);
            int days = (nowDate - lastDate).Days;

            if (days > 0)
            {
                time = days;
            }

            return time;
        }

        //与未来计算天数
        public static int TimerCompareFutureDays(uint ts)
        {
            int time = 0;

            DateTime now = Now();
            DateTime future = GetDateTime(ts);

            DateTime nowDate = new DateTime(now.Year, now.Month, now.Day);
            DateTime futureDate = new DateTime(future.Year, future.Month, future.Day);
            int days = (futureDate - nowDate).Days;

            if (days > 0)
            {
                time = days;
            }

            return time;
        }

        public static int ConvertDateTimeInt(DateTime time)
        {
            DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            return (int)(time - startTime).TotalSeconds;
        }


    }
}
