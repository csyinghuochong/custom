using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Net
{
    public class RC4Crypto
    {
        static public byte[] sBox;

        public static void InitCiphertext(String pass)
        {
            sBox = GetKey(Encoding.UTF8.GetBytes(Convert.ToBase64String(Encoding.UTF8.GetBytes(pass))));
        }

        public static byte[] EncryptEx(byte[] data)
        {
            byte[] output = new byte[data.Length];
            int i = 0;
            int j = 0;

            byte[] box = sBox;

            int len = box.Length;

            // 加密  
            for (int offset = 0; offset < data.Length; offset++)
            {
                i = (i + 1) % len;
                j = (j + box[i]) % len;
                byte temp = box[i];
                box[i] = box[j];
                box[j] = temp;
                byte a = data[offset];
                byte b = box[(box[i] + box[j]) % len];
                output[offset] = (byte)(a ^ b);
            }
            return output;
        }

        public static byte[] DecryptEx(byte[] data)
        {
            return EncryptEx(data);
        }
        /// <summary>  
        /// 打乱密码  
        /// </summary>  
        /// <param name="pass">密码</param>  
        /// <param name="kLen">密码箱长度</param>  
        /// <returns>打乱后的密码</returns>  
        static public byte[] GetKey(byte[] pass)
        {
            int kLen = 256;
            byte[] mBox = new byte[kLen];
            for (int i = 0; i < kLen; i++)
            {
                mBox[i] = (byte)i;
            }
            int j = 0;
            for (int i = 0; i < kLen; i++)
            {
                j = (j + mBox[i] + pass[i % pass.Length]) % kLen;
                byte temp = mBox[i];
                mBox[i] = mBox[j];
                mBox[j] = temp;
            }
            return mBox;
        }

        static RC4Crypto()
        {

        }
    }
}
