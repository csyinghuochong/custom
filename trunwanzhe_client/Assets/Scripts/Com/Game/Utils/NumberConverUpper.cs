﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.Utils
{
    class NumberConvertUpper
    {
        /// <summary>   数字转为大写金额
        public string MoneyToChinese(string LowerNumber)
        {

            string functionReturnValue = null;

            // 是否是负数   
            bool IsNegative = false;

            if (LowerNumber.Trim().Substring(0, 1) == "-")
            {
                // 是负数则先转为正数       
                LowerNumber = LowerNumber.Trim().Remove(0, 1);
                IsNegative = true;
            }

            string strLower = null;
            string strUpart = null;
            string strUpper = null;

            int iTemp = 0;

            // 保留两位小数 123.489→123.49　　123.4→123.4    

            //LowerNumber = Math.Round(double.Parse(LowerNumber), 2).ToString();

            if (LowerNumber.IndexOf(".") > 0)
            {
                if (LowerNumber.IndexOf(".") == LowerNumber.Length - 2)
                {
                    LowerNumber = LowerNumber + "0";
                }
            }
            else
            {
                LowerNumber = LowerNumber + ".00";
            }

            strLower = LowerNumber;
            iTemp = 1;
            strUpper = "";
            while (iTemp <= strLower.Length)
            {
                switch (strLower.Substring(strLower.Length - iTemp, 1))
                {
                    case ".":
                        strUpart = ".";
                        break;
                    case "0":
                        strUpart = "0";
                        break;
                    case "1":
                        strUpart = "一";
                        break;
                    case "2":
                        strUpart = "二";
                        break;
                    case "3":
                        strUpart = "三";
                        break;
                    case "4":
                        strUpart = "四";
                        break;
                    case "5":
                        strUpart = "五";
                        break;
                    case "6":
                        strUpart = "六";
                        break;
                    case "7":
                        strUpart = "七";
                        break;
                    case "8":
                        strUpart = "八";
                        break;
                    case "9":
                        strUpart = "九";
                        break;
                }

                switch (iTemp)
                {
                    case 1:
                        strUpart = strUpart + "分";
                        break;
                    case 2:
                        strUpart = strUpart + "角";
                        break;
                    case 3:
                        strUpart = strUpart + "";
                        break;
                    case 4:
                        strUpart = strUpart + "";
                        break;
                    case 5:
                        strUpart = strUpart + "拾";
                        break;
                    case 6:
                        strUpart = strUpart + "佰";
                        break;
                    case 7:
                        strUpart = strUpart + "仟";
                        break;
                    case 8:
                        strUpart = strUpart + "万";
                        break;
                    case 9:
                        strUpart = strUpart + "拾";
                        break;
                    case 10:
                        strUpart = strUpart + "佰";
                        break;
                    case 11:
                        strUpart = strUpart + "仟";
                        break;
                    case 12:
                        strUpart = strUpart + "亿";
                        break;
                    case 13:
                        strUpart = strUpart + "拾";
                        break;
                    case 14:
                        strUpart = strUpart + "佰";
                        break;
                    case 15:
                        strUpart = strUpart + "仟";
                        break;
                    case 16:
                        strUpart = strUpart + "万";
                        break;
                    default:
                        strUpart = strUpart + "";
                        break;
                }

                strUpper = strUpart + strUpper;
                iTemp = iTemp + 1;
            }

            strUpper = strUpper.Replace("零拾", "零");
            strUpper = strUpper.Replace("零佰", "零");
            strUpper = strUpper.Replace("零仟", "零");
            strUpper = strUpper.Replace("零零零", "零");
            strUpper = strUpper.Replace("零零", "零");
            strUpper = strUpper.Replace("零角零分", "整");
            strUpper = strUpper.Replace("零分", "整");
            strUpper = strUpper.Replace("零角", "零");
            strUpper = strUpper.Replace("零亿零万零圆", "亿圆");
            strUpper = strUpper.Replace("亿零万零圆", "亿圆");
            strUpper = strUpper.Replace("零亿零万", "亿");
            strUpper = strUpper.Replace("零万零圆", "万圆");
            strUpper = strUpper.Replace("零亿", "亿");
            strUpper = strUpper.Replace("零万", "万");
            strUpper = strUpper.Replace("零圆", "圆");
            strUpper = strUpper.Replace("零零", "零");


            // 对壹圆以下的金额的处理   
            if (strUpper.Substring(0, 1) == "圆")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }

            if (strUpper.Substring(0, 1) == "零")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }

            if (strUpper.Substring(0, 1) == "角")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }

            if (strUpper.Substring(0, 1) == "分")
            {

                strUpper = strUpper.Substring(1, strUpper.Length - 1);

            }

            if (strUpper.Substring(0, 1) == "整")
            {

                strUpper = "零圆整";

            }

            functionReturnValue = strUpper;

            if (IsNegative == true)
            {
                return "负" + functionReturnValue;
            }
            else
            {
                return functionReturnValue;
            }
        }
    }

    //new MoneyConvertChinese().MoneyToChinese(str));   Console.ReadLine(); } 
}
