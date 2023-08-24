using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.ObjectPool
{
    class UIInputNumRestrict
    {
        public enum RestrictType
        {
            CreatePlayer,
            AlterName,
            Friend,
            Chat,
        }

        private UIInput mUIInput;
        private string mText;
        private const int MAX_INPUT_NUM = 15;
        private const int MAX_NAME_NUM = 10;

        public UIInputNumRestrict(UIInput input)
        {
            mUIInput = input;
            mUIInput.onChange.Add(new EventDelegate(delegate()
            {
                string str = mUIInput.value;
                if (mText == str)
                {
                    return;
                }
                int nMaxChars = mUIInput.characterLimit;
                byte[] bytestr = System.Text.Encoding.UTF8.GetBytes(str);
                if (nMaxChars > 0 && bytestr.Length > nMaxChars)
                {
                    str = str.Substring(0, str.Length - 1);
                    while (System.Text.Encoding.Default.GetBytes(str).Length > nMaxChars)
                    {
                        str = str.Substring(0, str.Length - 1);
                    }
                }
                str = str.Replace("\r\n", "");
                str = str.Replace("\n", "");
                str = str.Replace("\t", "");
                str = str.Replace(" ", "");
                mText = str;
                mUIInput.value = str;
            }));
        }

        public static UIInputNumRestrict CreateInputNumRestrict(RestrictType type, UIInput input, int maxnum)
        {
            input.characterLimit = maxnum;
            UIInputNumRestrict restrict = new UIInputNumRestrict(input);
            mDicInputRestrict[type] = restrict;
            return restrict;
        }

        public static void RemoveInputNumRestrict(RestrictType type)
        {
            if (mDicInputRestrict.ContainsKey(type))
            {
                mDicInputRestrict[type].mUIInput.onChange.Clear();
            }
            mDicInputRestrict.Remove(type);
        }

        public static bool CheckNameLength(string name)
        {
            //byte[] bytestr = System.Text.Encoding.Default.GetBytes(name);

            if (CheckStringLength(name) > MAX_NAME_NUM)
            {
                
                return false;
            }

            if (CheckStringLength(name) < 4)
            {
              
                return false;
            }

            return true;
        }

        public void SheildWord(ref string name)
        {
            name.Replace("\r\n", "");
            name.Replace("\n", "");
            name.Replace("\t", "");
            name.Replace(" ", "");
        }

        public static int CheckStringLength(string str)
        {
            int nCount = 0;
            for (int i = 0; i < str.Length; i++ )
            {
                if ((int)str[i] > 127)
                {
                    nCount += 2;
                }
                else
                {
                    nCount += 1;
                }
            }
            return nCount;
        }

        private static Dictionary<RestrictType, UIInputNumRestrict> mDicInputRestrict = new Dictionary<RestrictType,UIInputNumRestrict>();
    }
}
