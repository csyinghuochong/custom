using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.Utils
{
    class StringUtil
    {

        const string cD2Format = "D2";
        /// <summary>
        /// 秒数转换成00:00:00
        /// </summary>
        /// <param name="second"></param>
        /// <returns></returns>
        public static string SecondsToString(int second)
        {
            int h = second / 3600;
            int m = (second % 3600) / 60;
            int s = (second % 3600) % 60;
            return h.ToString(cD2Format) + ":" + m.ToString(cD2Format) + ":" + s.ToString(cD2Format);
        }

        private const int HUNDRED_MILLION = 100000000;
        private const int TEN_THOUSAND = 10000;
        public static string GetSimpleExpression(int value)
        {
            if (value > HUNDRED_MILLION)
            {
                return value / HUNDRED_MILLION + "亿";
            }
            else if (value > TEN_THOUSAND * 10)
            {
                return value / TEN_THOUSAND + "万";
            }

            return value.ToString();
        }

        public static string SecondsToDHM(int second)
        {
            int d = second / (3600 * 24);
            int h = (second % (3600 * 24)) / 3600;
            int m = (second % 3600) / 60;
            return string.Format("{0}天{1}小时{2}分", d, h, m);
        }

        /// <summary>
        /// 时间格式化
        /// </summary>
        /// <param name="ts"></param>
        /// <returns></returns>
        public static string TimeFormatDHM(int second)
        {
            int d = second / (3600 * 24);
            if (d > 0)
            {
                return d + "天";
            }

            int h = second / 3600;
            if (h > 0)
            {
                return h + "小时";
            }

            int m = second / 60;
            if (m > 0)
            {
                return m + "分钟";
            }

            return second + "秒";
        }

        const string cLVFormat = "{0}级";
        //Lv.XX→XX级
        public static string LVFormat(int lv)
        {
            return string.Format(cLVFormat, lv);
        }

        const string cVFormat = "贵{0}";
        //V→贵
        public static string VFormat(int vip)
        {
            return string.Format(cVFormat, vip);
        }

        const string cVIPFormat = "贵族{0}";
        //VIP→贵族
        public static string VIPFormat(int vip)
        {
            return string.Format(cVIPFormat, vip);
        }

    }
}
