using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Numerics;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ET
{
    [ObjectSystem]
    public class ReChargeXQComponentAwakeSystem : AwakeSystem<ReChargeXQComponent>
    {
        public override void Awake(ReChargeXQComponent self)
        {
            self.ListenerXiaoQiPayResult();
        }
    }

    public static class ReChargeXQComponentSystem
    {
        public static string XiaoQiPay(this ReChargeXQComponent self, M2R_RechargeRequest request)
        {
            string nowTime = TimeHelper.ServerNow().ToString();
            if (self.dingdanlastTime != nowTime)
            {
                self.dingdanXuHao = 0;
            }
            else
            {
                self.dingdanXuHao++;
            }

            string dingDanID = $"xq{nowTime}{self.dingdanXuHao}_{request.Zone}_{request.RechargeNumber}";
            self.dingdanlastTime = nowTime;

            if (self.orderDic.ContainsKey(dingDanID))
            {
                self.orderDic.Remove(dingDanID);
            }

            XiaoQiOrderInfo orderInfo = self.AddChild<XiaoQiOrderInfo>();
            orderInfo.zone = request.Zone;
            orderInfo.userId = request.UnitId;
            orderInfo.amount = request.RechargeNumber;
            orderInfo.UnitName = request.UnitName;
            orderInfo.RechargeType = request.RechargeType;
            self.orderDic.Add(dingDanID, orderInfo);

            Console.WriteLine($"{TimeInfo.Instance.ToDateTime(TimeHelper.ServerNow())} XiaoQiPay.dingDanID: {dingDanID} unitId:{request.UnitId}");

            if (ComHelp.IsInnerNet())
            {
                self.TestRecharge(dingDanID).Coroutine();
            }

            return dingDanID;
        }

        private static async ETTask TestRecharge(this ReChargeXQComponent self, string orderId)
        {
            await TimerComponent.Instance.WaitAsync(1000);

            if (!self.orderDic.TryGetValue(orderId, out XiaoQiOrderInfo orderInfo))
            {
                return;
            }

            string serverName = ServerHelper.GetGetServerItem(false, orderInfo.zone).ServerName;
            Log.Warning($"支付成功[小7-内测]: 区：{serverName} 玩家名字：{orderInfo.UnitName} 充值额度：{orderInfo.amount} 时间:{TimeHelper.DateTimeNow()}");
            RechargeHelp.OnPaySucessToGate(orderInfo.zone, orderInfo.userId, orderInfo.amount, orderId, PayTypeEnum.XiaoQi, orderInfo.RechargeType).Coroutine();
            self.orderDic.Remove(orderId);
            orderInfo.Dispose();
        }

        public static void ListenerXiaoQiPayResult(this ReChargeXQComponent self)
        {
            if (ComHelp.IsInnerNet())
            {
                self.httpListenerUrl = @"http://127.0.0.1:20006/";
            }

            self.httpListener = new HttpListener();
            self.httpListener.Prefixes.Add(self.httpListenerUrl);
            self.httpListener.Start();
            self.httpListener.BeginGetContext(self.CheckXiaoQiPayResult, null);
        }

        public static void CheckXiaoQiPayResult(this ReChargeXQComponent self, IAsyncResult ar)
        {
            try
            {
                self.httpListener.BeginGetContext(self.CheckXiaoQiPayResult, null);

                HttpListenerContext context = self.httpListener.EndGetContext(ar);
                HttpListenerRequest request = context.Request;

                Console.WriteLine($"CheckXiaoQiPayResult: {context.ToString()}");

                StreamReader body = new StreamReader(request.InputStream, Encoding.UTF8);
                string payNotice = HttpUtility.UrlDecode(body.ReadToEnd(), Encoding.UTF8);

                if (string.IsNullOrEmpty(payNotice))
                {
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                Dictionary<string, string> payResult = self.StringToDictionary(payNotice);
                if (payResult == null)
                {
                    Log.Warning($"小7支付回调参数解析失败: {payNotice}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                // UrlDecode 会把 Base64 里的 '+' 变成空格，验签/解密前必须还原
                NormalizeBase64Fields(payResult, "encryp_data", "sign_data", "game_sign");

                if (!payResult.TryGetValue("encryp_data", out string encrypData) || string.IsNullOrEmpty(encrypData))
                {
                    Log.Warning($"小7支付回调缺少encryp_data: {payNotice}");
                    Console.WriteLine($"小7支付回调缺少encryp_data: {payNotice}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                // 文档：对 sign_data 做 SHA1withRSA 验签（不是 MD5(game_sign)）
                if (!self.CheckSignData(payResult))
                {
                    Log.Warning($"小7支付回调验签失败: {payNotice}");
                    Console.WriteLine($"小7支付回调验签失败: {payNotice}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                string decryptData = self.DecryptEncrypData(encrypData);
                if (string.IsNullOrEmpty(decryptData))
                {
                    Log.Warning($"小7支付回调解密失败: {encrypData}");
                    Console.WriteLine($"小7支付回调解密失败: {encrypData}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                Dictionary<string, string> decryptResult = self.ParseKeyValueString(decryptData);
                if (decryptResult == null)
                {
                    Log.Warning($"小7支付回调解密数据解析失败: {decryptData}");
                    Console.WriteLine($"小7支付回调解密数据解析失败: {decryptData}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                string gameOrderId = GetValue(payResult, decryptResult, "game_orderid");
                if (string.IsNullOrEmpty(gameOrderId))
                {
                    Log.Warning($"小7支付回调缺少game_orderid: {decryptData}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                string payStatus = GetValue(payResult, decryptResult, "pay_status");
                if (!string.IsNullOrEmpty(payStatus) && payStatus != "1")
                {
                    Log.Warning($"小7支付回调状态失败: order={gameOrderId} status={payStatus}");
                    self.ResponseXiaoQi(context, "fail");
                    return;
                }

                if (!self.orderDic.TryGetValue(gameOrderId, out XiaoQiOrderInfo orderInfo))
                {
                    Log.Warning($"小7支付回调订单不存在: {gameOrderId}");
                    self.ResponseXiaoQi(context, "success");
                    return;
                }

                if (decryptResult != null && decryptResult.TryGetValue("pay_price", out string payPriceStr)
                    && float.TryParse(payPriceStr, out float payPrice)
                    && Math.Abs(payPrice - orderInfo.amount) > 1)
                {
                    Log.Warning($"小7支付金额不匹配: order={gameOrderId} payPrice={payPrice} amount={orderInfo.amount}");
                }

                string serverName = ServerHelper.GetGetServerItem(false, orderInfo.zone).ServerName;
                Log.Warning($"支付成功[小7]: 区：{serverName} 玩家名字：{orderInfo.UnitName} 充值额度：{orderInfo.amount} 时间:{TimeHelper.DateTimeNow()}");

                RechargeHelp.OnPaySucessToGate(orderInfo.zone, orderInfo.userId, orderInfo.amount, gameOrderId, PayTypeEnum.XiaoQi, orderInfo.RechargeType).Coroutine();
                self.orderDic.Remove(gameOrderId);
                orderInfo.Dispose();

                self.ResponseXiaoQi(context, "success");
            }
            catch (Exception e)
            {
                Log.Error($"小7支付结果解析报错: {e}");
            }
        }

        private static string GetValue(Dictionary<string, string> payResult, Dictionary<string, string> decryptResult, string key)
        {
            if (payResult != null && payResult.TryGetValue(key, out string value) && !string.IsNullOrEmpty(value))
            {
                return value;
            }

            if (decryptResult != null && decryptResult.TryGetValue(key, out value) && !string.IsNullOrEmpty(value))
            {
                return value;
            }

            return string.Empty;
        }

        /// <summary>
        /// 小7支付回调验签（官方文档）：
        /// 1) sign_data base64_decode
        /// 2) 除 sign_data 外参数按字典序拼成 key=value&key=value（无需 urlencode）
        /// 3) SHA1withRSA + 小7RSA公钥 verify
        /// </summary>
        public static bool CheckSignData(this ReChargeXQComponent self, Dictionary<string, string> payResult)
        {
            if (payResult == null || !payResult.TryGetValue("sign_data", out string signData) || string.IsNullOrEmpty(signData))
            {
                // 兼容极旧回调：game_sign = MD5(appKey + encryp_data)
                if (payResult != null
                    && payResult.TryGetValue("game_sign", out string gameSign)
                    && payResult.TryGetValue("encryp_data", out string encrypData)
                    && !string.IsNullOrEmpty(gameSign)
                    && !string.IsNullOrEmpty(encrypData))
                {
                    string localSign = MD5Helper.StringMD5_2(self.appKey + encrypData);
                    return gameSign.Equals(localSign, StringComparison.OrdinalIgnoreCase);
                }

                return false;
            }

            try
            {
                string sourceStr = BuildSignSourceString(payResult);
                byte[] signature = Convert.FromBase64String(signData.Replace(" ", "+"));
                using RSA rsa = CreateX7PublicRsa(self.x7PublicKey);
                return rsa.VerifyData(Encoding.UTF8.GetBytes(sourceStr), signature, HashAlgorithmName.SHA1, RSASignaturePadding.Pkcs1);
            }
            catch (Exception e)
            {
                Log.Error($"小7支付验签异常: {e}");
                return false;
            }
        }

        private static string BuildSignSourceString(Dictionary<string, string> payResult)
        {
            List<string> keys = new List<string>(payResult.Count);
            foreach (KeyValuePair<string, string> kv in payResult)
            {
                if (kv.Key == "sign_data")
                {
                    continue;
                }

                keys.Add(kv.Key);
            }

            keys.Sort(StringComparer.Ordinal);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < keys.Count; i++)
            {
                if (i > 0)
                {
                    sb.Append('&');
                }

                sb.Append(keys[i]);
                sb.Append('=');
                sb.Append(payResult[keys[i]] ?? string.Empty);
            }

            return sb.ToString();
        }

        private static void NormalizeBase64Fields(Dictionary<string, string> payResult, params string[] keys)
        {
            foreach (string key in keys)
            {
                if (payResult.TryGetValue(key, out string value) && !string.IsNullOrEmpty(value) && value.IndexOf(' ') >= 0)
                {
                    payResult[key] = value.Replace(" ", "+");
                }
            }
        }

        private static RSA CreateX7PublicRsa(string publicKeyBase64)
        {
            RSA rsa = RSA.Create();
            byte[] keyBytes = Convert.FromBase64String(publicKeyBase64);
            try
            {
                rsa.ImportSubjectPublicKeyInfo(keyBytes, out _);
            }
            catch
            {
                // 部分环境公钥是 PKCS#1，兜底转成 SPKI 再导入
                rsa.ImportRSAPublicKey(keyBytes, out _);
            }

            return rsa;
        }

        public static string DecryptEncrypData(this ReChargeXQComponent self, string encrypData)
        {
            try
            {
                using RSA rsa = CreateX7PublicRsa(self.x7PublicKey);

                byte[] cipherBytes = Convert.FromBase64String(encrypData.Replace(" ", "+"));
                int keySize = rsa.KeySize / 8;
                using MemoryStream ms = new MemoryStream();

                for (int i = 0; i < cipherBytes.Length; i += keySize)
                {
                    int blockLen = Math.Min(keySize, cipherBytes.Length - i);
                    byte[] block = new byte[keySize];
                    Buffer.BlockCopy(cipherBytes, i, block, 0, blockLen);
                    byte[] plain = RsaPublicDecryptBlock(rsa, block);
                    if (plain.Length == 0)
                    {
                        return string.Empty;
                    }

                    ms.Write(plain, 0, plain.Length);
                }

                return Encoding.UTF8.GetString(ms.ToArray());
            }
            catch (Exception e)
            {
                Log.Error($"小7支付解密异常: {e}");
                return string.Empty;
            }
        }

        private static byte[] RsaPublicDecryptBlock(RSA rsa, byte[] cipherText)
        {
            RSAParameters param = rsa.ExportParameters(false);
            BigInteger modulus = new BigInteger(param.Modulus, isUnsigned: true, isBigEndian: true);
            BigInteger exponent = new BigInteger(param.Exponent, isUnsigned: true, isBigEndian: true);
            BigInteger cipher = new BigInteger(cipherText, isUnsigned: true, isBigEndian: true);
            BigInteger plain = BigInteger.ModPow(cipher, exponent, modulus);

            int keySize = rsa.KeySize / 8;
            byte[] plainBytes = plain.ToByteArray(isUnsigned: true, isBigEndian: true);
            if (plainBytes.Length < keySize)
            {
                byte[] padded = new byte[keySize];
                Buffer.BlockCopy(plainBytes, 0, padded, keySize - plainBytes.Length, plainBytes.Length);
                plainBytes = padded;
            }

            int separatorIndex = -1;
            for (int i = 2; i < plainBytes.Length; i++)
            {
                if (plainBytes[i] == 0)
                {
                    separatorIndex = i;
                    break;
                }
            }

            if (separatorIndex < 0 || separatorIndex + 1 >= plainBytes.Length)
            {
                return Array.Empty<byte>();
            }

            byte[] data = new byte[plainBytes.Length - separatorIndex - 1];
            Buffer.BlockCopy(plainBytes, separatorIndex + 1, data, 0, data.Length);
            return data;
        }

        public static Dictionary<string, string> StringToDictionary(this ReChargeXQComponent self, string value)
        {
            if (string.IsNullOrEmpty(value))
            {
                return null;
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            string[] dicStrs = value.Split('&');
            foreach (string str in dicStrs)
            {
                if (string.IsNullOrEmpty(str))
                {
                    continue;
                }

                string[] strs = str.Split(new char[] { '=' }, 2);
                if (strs.Length == 2)
                {
                    dic[strs[0]] = strs[1];
                }
            }

            return dic;
        }

        public static Dictionary<string, string> ParseKeyValueString(this ReChargeXQComponent self, string value)
        {
            return self.StringToDictionary(value);
        }

        public static void ResponseXiaoQi(this ReChargeXQComponent self, HttpListenerContext context, string responseString)
        {
            byte[] buffer = Encoding.UTF8.GetBytes(responseString);
            context.Response.StatusCode = 200;
            context.Response.ContentLength64 = buffer.Length;
            Stream output = context.Response.OutputStream;
            output.Write(buffer, 0, buffer.Length);
            output.Close();
            context.Response.Close();
        }
    }
}
