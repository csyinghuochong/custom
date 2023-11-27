package com.example.weijinggame;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import android.view.WindowManager;
import android.widget.Toast;

import com.bytedance.ttgame.tob.common.host.api.GBCommonSDK;
import com.bytedance.ttgame.tob.common.host.api.callback.InitCallback;
import com.bytedance.ttgame.tob.optional.share.api.IShareService;
import com.bytedance.ttgame.tob.optional.share.api.TTShareContentType;
import com.bytedance.ttgame.tob.optional.share.api.TTShareItemType;
import com.bytedance.ttgame.tob.optional.share.api.TTShareModel;
import com.bytedance.ttgame.tob.optional.share.api.TTShareResult;
import com.bytedance.ttgame.tob.optional.share.api.callback.TTShareEventCallback;
import com.bytedance.ttgame.tob.optional.union.api.IUnionService;
import com.bytedance.ttgame.tob.optional.union.api.account.IAccountCallback;
import com.bytedance.ttgame.tob.optional.union.api.account.ISwitchCallback;
import com.bytedance.ttgame.tob.optional.union.api.account.UserInfoResult;
import com.bytedance.ttgame.tob.optional.union.api.pay.IPayCallback;
import com.bytedance.ttgame.tob.optional.union.api.pay.PayInfo;
import com.bytedance.ttgame.tob.optional.union.api.pay.PayResult;
import com.example.weijinggame.wxapi.WXPayEntryActivity;
import com.quicksdk.Sdk;
import com.quicksdk.utility.AppConfig;
import com.ss.android.download.api.clean.IJsonable;
import com.tencent.mm.sdk.modelpay.PayReq;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.unity3d.player.UnityPlayer;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import gbsdk.android.support.annotation.Nullable;
import gbsdk.android.support.graphics.drawable.VectorDrawableCompat;

import com.google.gson.Gson;

import org.json.JSONObject;


public class MainActivity extends UnityPlayerActivity {


    //Appid final
    public static String APP_ID;
    private static MainActivity instance;
    Context mContext = null;
    public Activity activity;

    //这个对象用于封装支付参数
    private PayReq req = new PayReq();
    //微信API 用于调起支付接口
    private IWXAPI wxAPI = null; //WXAPIFactory.createWXAPI(this, null);
    private String CallAliObjName;//CallAliObjName,CallAliFuncName
    private String CallAliFuncName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
        instance = this;
        mContext = this;
        activity = this;
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        Log.i("MainActivity", "onCreateMain");

        // 请对齐游戏的application的onCreate时机，不要延后调用
        Log.i("GBCommonSDK", "GBCommonSDK.onCreate0");
        GBCommonSDK.onCreate(this);
        Log.i("GBCommonSDK", "GBCommonSDK.onCreate1");

        GBCommonSDK.setGameActivity(activity);
    }

    public static MainActivity GetInstance() {
        return instance;
    }

    //微信SDK初始化(注册)的接口
    public void WechatInit(String appid) {
        if (wxAPI == null) {
            this.APP_ID = appid;
            wxAPI = WXAPIFactory.createWXAPI(this, appid);
            wxAPI.registerApp(appid);
        }
        Log.i("WechatInit", appid);
    }

    public  void TikTokInit(String appid) {
        Log.i("GBCommonSDK", "GBCommonSDK.CallNative0");
        //一般游戏也会弹自己的隐私协议及申请必要的权限，建议先完成游戏自己的隐私协议展示及权限申请后再调SDK的初始化(即GBCommonSDK.init)。
        GBCommonSDK.init(activity, new InitCallback() {
            @Override
            public void onSuccess() {
                Toast.makeText(activity, "初始化成功", Toast.LENGTH_SHORT).show();

                //test
                //keyValuePairs.Add("app_id", "1234");
                //keyValuePairs.Add("access_token", "q3fafa33sHFU+V9h32h0v8weVEH/04hgsrHFHOHNNQOBC9fnwejasubw==");
                //keyValuePairs.Add("ts", "1555912969");
                //test
            }

            @Override
            public void onFailed(int code, String msg) {
                Toast.makeText(activity, "初始化失败: " + code + ", " + msg, Toast.LENGTH_SHORT).show();
            }
        });

        Log.i("GBCommonSDK", "GBCommonSDK.CallNative1");
    }

    public void  TikTokIsLogin(String appid) {
        boolean islogin = GBCommonSDK.getService(IUnionService.class).isLogin();
        if(islogin)
        {
            Log.i("GBCommonSDK", "islogin. true");
        }
        else
        {
            Log.i("GBCommonSDK", "islogin. false");
        }
    }

    public  void TikTokSwitchLogin()
    {
        GBCommonSDK.getService(IUnionService.class).switchLogin(this, new ISwitchCallback<UserInfoResult>() {
            @Override
            public void onSuccess(@Nullable UserInfoResult userInfoResult) {
                // 由接入方实现，通过游戏服务端向抖音游戏服务端校验用户登录态、获取sdk_open_id，参考服务端接入登录验证部分
                // verifyGameUser(userInfoResult);
            }

            @Override
            public void onFailed(@Nullable UserInfoResult userInfoResult) {
                Toast.makeText(activity, "切换登录失败", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onLogout(@Nullable UserInfoResult userInfoResult) {
                Toast.makeText(activity, "账号登出", Toast.LENGTH_SHORT).show();
            }
        });
    }

    public  void TikTokLogout()
    {
        GBCommonSDK.getService(IUnionService.class).logout( this,new IAccountCallback<UserInfoResult>() {
            @Override
            public void onSuccess(@Nullable UserInfoResult userInfoResult) {
                // 由接入方实现，通过游戏服务端向抖音游戏服务端校验用户登录态、获取sdk_open_id，参考服务端接入登录验证部分
                // verifyGameUser(userInfoResult);
                Log.i("GBCommonSDK", "Loginout 1: "+  userInfoResult.toString());

            }

            @Override
            public void onFailed(@Nullable UserInfoResult userInfoResult) {
                Toast.makeText(activity, "Loginout2 faild", Toast.LENGTH_SHORT).show();
            }
        });
    }

    public void  TikTokLogin(String appid) {

        GBCommonSDK.getService(IUnionService.class).login(this, new IAccountCallback<UserInfoResult>() {
            @Override
            public void onSuccess(@Nullable UserInfoResult userInfoResult) {
                // 由接入方实现，通过游戏服务端向抖音游戏服务端校验用户登录态、获取sdk_open_id，参考服务端接入登录验证部分
                // verifyGameUser(userInfoResult);
                Log.i("GBCommonSDK", "Login1: "+  userInfoResult.toString());

                // 创建Gson对象
                Gson gson = new Gson();

                // 将学生对象转换为JSON字符串
                String jsonString = gson.toJson(userInfoResult);
                Log.i("GBCommonSDK", "Login2:" + jsonString);

                //登录之后可以通过以下接口查询年龄段的枚举值(IUnionService类)。如果游戏需要针对用户年龄做额外限制，
                // 可通过该接口获取年龄段并自行限制登录，即在SDK登录完成回调之后在游戏侧进行限制。
                //防沉迷功能无需额外调接口，SDK在登录时、游戏中会自动触发。

                int age = GBCommonSDK.getService(IUnionService.class).getAgeType();
                Log.i("GBCommonSDK", "Login3 age:" + age);
                //// access_token，用于换取 sdk_open_id

                long timestamp = System.currentTimeMillis() / 1000;
                Map<String, Object> map = new HashMap<>();
                map.put("app_id", "554726");
                map.put("access_token", userInfoResult.data.getToken());
                map.put("ts", timestamp);
                String sign = TikTokGetSign(map, "gacT8bvbGb9X3f52j8bZDtjvkAkhrOZy");
                Log.i("GBCommonSDK", "GBCommonSDKapp_id: " + "554726");
                Log.i("GBCommonSDK", "GBCommonSDKaccess_token: " + userInfoResult.data.getToken());
                Log.i("GBCommonSDK", "GBCommonSDKts: " + timestamp);
                Log.i("GBCommonSDK", "GBCommonSDKsign: " + sign);

                UnityPlayer.UnitySendMessage("Global", "OnRecvTikTokAccesstoken", userInfoResult.data.getToken());
            }

            @Override
            public void onFailed(@Nullable UserInfoResult userInfoResult) {
                // 创建Gson对象
                Gson gson = new Gson();
                // 将学生对象转换为JSON字符串
                String jsonString = gson.toJson(userInfoResult);
                Log.i("GBCommonSDK", "Login2:" + jsonString);

                Log.i("GBCommonSDK", "Login3 onFailed:" + jsonString);
                Toast.makeText(activity, "login faild", Toast.LENGTH_SHORT).show();
            }
        });
    }

    //分享图片
    public void TikTokShareImage( ArrayList<String> imageList)  {
        Log.i("GBCommonSDK", "TikTokShareImage" );
        // 抖音图片分享
        TTShareModel model = new TTShareModel.Builder()
                .setImageList(imageList)
                .setShareType(TTShareItemType.DY)
                .setShareContentType(TTShareContentType.IMAGE)
                .setEventCallBack(new TTShareEventCallback() {
                    @Override
                    public void onShareResultEvent(TTShareResult ttShareResult) {
                        Toast.makeText(activity,ttShareResult.toString(),Toast.LENGTH_LONG).show();
                    }
                })
                .build();
        GBCommonSDK.getService(IShareService.class).share(activity, model);
    }

    public String TikTokGetSign(Map<String, Object> params, String secretKey){
        //给参数进行排序，游戏方自己实现排序算法，通过各种方式都可以，只要实现key按字母从小到大排序即可
        Map<String, Object> sortMap = new TreeMap<>(new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareTo(o2);
            }
        });
        sortMap.putAll(params);

        //拼接成字符串
        StringBuilder sb = new StringBuilder();
        Iterator<String> iterator = sortMap.keySet().iterator();
        while (iterator.hasNext()) {
            String key = iterator.next();
            String value = String.valueOf(sortMap.get(key));
            sb.append(key).append("=").append(value);
            if(iterator.hasNext()){
                sb.append("&");
            }
        }

        //使用密钥进行Hmac-sha1加密
        Mac mac;
        try {
            mac = Mac.getInstance("HmacSHA1");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
        SecretKeySpec spec = new SecretKeySpec(secretKey.getBytes(), "HmacSHA1");
        try {
            mac.init(spec);
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }
        mac.update(sb.toString().getBytes());

        //Sample A (using org.apache.commons.codec.binary.Base64):
        //Base64.encodeBase64("foobar".getBytes());
        //Sample B (using android.util.Base64):
        //Base64.encode("foobar".getBytes(), Base64.DEFAULT);

        //base64编码获得最终的sign  import org.apache.commons.codec.binary.Base64;
        // return Base64.encodeBase64String(mac.doFinal());
        return   Base64.encodeToString(mac.doFinal(), Base64.DEFAULT);
    }

    /**
     * IUnionService
     * 获取预下单所需要的风控信息，服务端预下单时需要携带当前参数
     * 服务端每次预下单前获取，下单时携带
     */
    public  void GetTikTokRiskControlInfo(String appid) {
        String riskControlInfo = GBCommonSDK.getService(IUnionService.class).getRiskControlInfo();
        UnityPlayer.UnitySendMessage("Global", "OnRecvRiskControlInfo", riskControlInfo);
    }

    /**
     * IUnionService
     * 支付
     * cpOrderId      string  订单id，长度限制为80字节
     * amountInCent   int32    商品金额，单位：分
     * productId      string    商品id，长度限制为80字节
     * productName    string  商品名称，长度限制为100字节，注：需体现所购买商品名称和数量
     *productType     string   商品类型，例如："coins"
     * productNumber  int32   商品数量
     * sdkParam       string  预下单时返回的参数
     */
    public  void  TikTokPay(String cpOrderId, int amountInCent, String productId, String productName, String sdkParam)
    {
        PayInfo payInfo = new PayInfo();

        payInfo.setCpOrderId(cpOrderId);
        payInfo.setAmountInCent(amountInCent);
        payInfo.setProductId(productId);
        payInfo.setProductName(productName);
        payInfo.setProductNumber(1);
        payInfo.setSdkParam(sdkParam);  // 服务端预下单成功返回的 sdk_param

        // 支付完成后 抖音游戏server 会将结果回调给 厂商游戏server
        // 请在客户端收到SDK的支付回调后（onSuccess and onFail 都需要）去 厂商游戏server 进行查单
        // 最终的支付结果以 厂商游戏server 为准
        GBCommonSDK.getService(IUnionService.class).pay(MainActivity.this, payInfo, new IPayCallback<PayResult>() {
            @Override
            public void onSuccess(@Nullable PayResult result) {
                Toast.makeText(MainActivity.this, "支付成功", Toast.LENGTH_SHORT).show();
                // 前往 server 查单
            }

            @Override
            public void onFailed(@Nullable PayResult exception) {
                Toast.makeText(MainActivity.this, "支付失败", Toast.LENGTH_SHORT).show();
                // 前往 server 查单
            }
        });
    }

    ///测试通讯
    public void CallNative(String str) {
        Log.i("CallNative_11", str);
    }

    public String getProductCode() {
        Log.i("product_code:  ", AppConfig.getInstance().getConfigValue("product_code"));
        return AppConfig.getInstance().getConfigValue("product_code");
    }

    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Sdk.getInstance().exit(activity);
    }

    //判断是否已经安装微信的接口
    public boolean IsWechatInstalled() {
        return wxAPI.isWXAppInstalled();
    }

    //判断当前微信的版本是否支持API调用
    public boolean IsWechatAppSupportAPI() {
        return wxAPI.isWXAppSupportAPI();
    }

    public void SetIsPermissionGranted(String appid) {
        Log.d("SetIsPermissionGranted", appid);

    }

    //微信登录的接口
    /*
    public  void LoginWechat(String appid,String state,String ObjName,String funName) {
        wxAPI.registerApp(APP_ID);
        Log.d("Unity","进入登录环节");
        WXEntryActivity.GameObjectName=ObjName;
        WXEntryActivity.CallBackFuncName=funName;
        // 发送授权登录信息，来获取code
        SendAuth.Req req = new SendAuth.Req();
        // 设置应用的作用域，获取个人信息msgApi  api

        req.scope = "snsapi_userinfo";
        req.state = state;
        wxAPI.sendReq(req);
    }
    */

    //微信充值的接口（Unity调用到此方法）
    public void WeChatPayReq(String APP_ID, String MCH_ID, String prepayid, String noncestr, String timestamp, String sign, String callBackBackObjectName, String CallBackFuncName) {
        Log.i("unity: ", "拉起微信支付！！");

        //设置支付结果通知Unity的回调
        WXPayEntryActivity.GameObjectName = callBackBackObjectName;
        WXPayEntryActivity.CallBackFuncName = CallBackFuncName;
        //支付请求的参数
        req.appId = APP_ID;
        req.partnerId = MCH_ID;
        req.prepayId = prepayid;
        req.packageValue = "Sign=WXPay";
        req.nonceStr = noncestr;
        req.timeStamp = timestamp;
        req.sign = sign;
        //通过APPID校验应用
        //msgApi.registerApp(APP_ID);
        //这里是发起微信支付请求了（此处会调用支付的相关界面,在WxPayEntryActivity中进行监听回调结果）
        wxAPI.sendReq(req);
    }

    //获取系统时间戳
    public void ReqSystemTime(String str) {
        long time1 = System.currentTimeMillis();
        UnityPlayer.UnitySendMessage("Global", "onRecvSysTime", String.valueOf(time1));
    }

    //获取电池电量
    public void getBatteryStatus() {
        Intent intent = registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        int rawlevel = intent.getIntExtra("level", -1);
        int scale = intent.getIntExtra("scale", -1);
        int status = intent.getIntExtra("status", -1);
        double level = -1;
        if (rawlevel >= 0 && scale > 0)
            level = (rawlevel * 1.0) / scale;
        UnityPlayer.UnitySendMessage("Global", "onRecvBattery", String.valueOf(level));
    }

    public void QuDaoRequestPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //多个权限同时获取
            List<String> permissionList = new ArrayList<>();

           // if (this.mContext.checkSelfPermission(Manifest.permission.INTERNET) != PackageManager.PERMISSION_GRANTED)
            {
                Log.i("Permissions", "Permissions INTERNET 0");
                permissionList.add(Manifest.permission.INTERNET);
            }
           // if (this.mContext.checkSelfPermission(Manifest.permission.ACCESS_NETWORK_STATE) != PackageManager.PERMISSION_GRANTED)
            {
                Log.i("Permissions", "Permissions ACCESS_NETWORK_STATE 0");
                permissionList.add(Manifest.permission.ACCESS_NETWORK_STATE);
            }

            //WRITE_EXTERNAL_STORAGE权限是用于授予应用程序对外部存储(即SD卡)进行读写操作的权限
            //if (this.mContext.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED)
            {
                Log.i("Permissions", "Permissions WRITE_EXTERNAL_STORAGE 0");
                permissionList.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
            }

            //if (this.mContext.checkSelfPermission(Manifest.permission.REQUEST_INSTALL_PACKAGES) != PackageManager.PERMISSION_GRANTED)
            {
                //Log.i("Permissions", "Permissions REQUEST_INSTALL_PACKAGES 0");
                //permissionList.add(Manifest.permission.REQUEST_INSTALL_PACKAGES);
            }
            //if (this.mContext.checkSelfPermission(Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED)
            //{
            //    Log.i("Permissions", "Permissions READ_PHONE_NUMBERS 0");
            //    permissionList.add(Manifest.permission.READ_PHONE_NUMBERS);
            //}
            //if (this.mContext.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED)
            {
                //Log.i("Permissions", "Permissions READ_PHONE_STATE 0");
                //permissionList.add(Manifest.permission.READ_PHONE_STATE);
            }

            if (!permissionList.isEmpty()) {
                String[] permissions = permissionList.toArray(new String[permissionList.size()]);
                this.activity.requestPermissions(permissions, 1);
            }
            else {
                Log.i("Permissions2", "Permissions 1_1");
                UnityPlayer.UnitySendMessage("Global", "onRequestPermissionsResult", "1_1");
            }
        } else {
            Log.i("Permissions1", "Permissions 1_1");
            UnityPlayer.UnitySendMessage("Global", "onRequestPermissionsResult", "1_1");
        }
    }

    //多个权限同时获取
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case 1:
                for (int result : grantResults) {
                    Log.i("Permissions111", result + "");
                }
                for (String result : permissions) {
                    Log.i("Permissions222", result + "");
                }

                if (grantResults.length > 0) {
                    int i = 0;
                    for (int result : grantResults) {
                        if (result != PackageManager.PERMISSION_GRANTED) {
                            Toast.makeText(this, "请同意所以请求才能运行程序", Toast.LENGTH_SHORT).show();
                            UnityPlayer.UnitySendMessage("Global", "onRequestPermissionsResult", permissions[i] + "_0");
                            //finish();
                            return;
                        }
                        UnityPlayer.UnitySendMessage("Global", "onRequestPermissionsResult", permissions[i] + "_1");
                        i++;
                    }
                } else {
                    Toast.makeText(this, "发生权限请求错误,程序关闭", Toast.LENGTH_SHORT).show();
                    finish();
                }
                break;
            default:
        }
    }

    final int REQUEST_CODE_ADDRESS = 100;

    public  void GetPhoneNum(String zone) {
        Log.i("GetPhoneNum_2a", "111");
        String phoneNum = "";

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
                this.mContext.checkSelfPermission(Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED
                && this.mContext.checkSelfPermission(Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED
                && this.mContext.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED)
        {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            //申请权限，permissions是要申请的权限数组
            String[] permissions = new  String[]
                    {
                            Manifest.permission.READ_SMS, Manifest.permission.READ_PHONE_NUMBERS, Manifest.permission.READ_PHONE_STATE
                    };
            ActivityCompat.requestPermissions(this, permissions, REQUEST_CODE_ADDRESS);
            Log.i("GetPhoneNum_2b", "222");
            return;
        }
        Log.i("GetPhoneNum_2c", "333");

        try
        {
            TelephonyManager mTelephoneManager = (TelephonyManager) mContext.getSystemService(Context.TELEPHONY_SERVICE);
            String ret = mTelephoneManager.getLine1Number() != null ? mTelephoneManager.getLine1Number() : "";
            if (TextUtils.isEmpty(ret))
            {
                phoneNum = ret;
                Log.i("GetPhoneNum_2d", phoneNum+"");
            }
            else
            {
                ret = ret.substring(3,14);
                phoneNum =  ret;
                Log.i("GetPhoneNum_2", phoneNum+"");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            Log.i("GetPhoneNum_2e", e.toString());
        }

        UnityPlayer.UnitySendMessage("Global", "OnRecvPhoneNum", phoneNum);
    }

    public  void GetPhoneNum_3(String zone) {

    }

    public void GetPhoneNum_2(String zone) {
        Log.i("GetPhoneNum", "111");
        String phoneNum = "";
        //READ_PHONE_STATE唯一标识符、手机号码以及SIM卡状态等信息
        TelephonyManager mTelephoneManager = (TelephonyManager) mContext.getSystemService(Context.TELEPHONY_SERVICE);
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED
                && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED
                && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            //申请权限，permissions是要申请的权限数组
            String[] permissions = new  String[]
                    {
                            Manifest.permission.READ_SMS, Manifest.permission.READ_PHONE_NUMBERS, Manifest.permission.READ_PHONE_STATE
                    };
            ActivityCompat.requestPermissions(this, permissions, REQUEST_CODE_ADDRESS);
            Log.i("GetPhoneNum", "222");
            return;
        }
        Log.i("GetPhoneNum", "333");
        String ret = mTelephoneManager.getLine1Number() != null ? mTelephoneManager.getLine1Number() : "";
        if (TextUtils.isEmpty(ret))
        {
            phoneNum = ret;
        }
        else
        {
            ret = ret.substring(3,14);
            phoneNum =  ret;
        }
        UnityPlayer.UnitySendMessage("Global", "OnRecvPhoneNum", phoneNum);
    }

    //微信文字分享的接口
    /*
    public  void WXShareText(int shareType, String text,String objName,String funName) {

        WXEntryActivity.GameObjectName = objName;
        WXEntryActivity.CallBackFuncName = funName;//Unity层的回调

        WXTextObject textObj = new WXTextObject();
        textObj.text = text;

        WXMediaMessage msg = new WXMediaMessage();
        msg.mediaObject = textObj;
        msg.description = text;

        SendMessageToWX.Req req = new SendMessageToWX.Req();

        req.transaction = BuildTransaction("text");
        req.message = msg;

        req.scene = shareType;
        wxAPI.sendReq(req);
    }
    */

    //微信图片分享的接口
    /*
    public  void WXShareImage(int scene, byte[] imgData, byte[] thumbData,String objName,String funName) {

        WXEntryActivity.GameObjectName = objName;
        WXEntryActivity.CallBackFuncName = funName;//分享的物体名称和方法

        WXImageObject imgObj = new WXImageObject(imgData);
        WXMediaMessage msg = new WXMediaMessage();
        msg.mediaObject = imgObj;
        msg.thumbData = thumbData;

        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = BuildTransaction("img");
        req.message = msg;
        req.scene = scene;
        wxAPI.sendReq(req);
    }
    */

    //微信网页分享的接口
    /*
    public  void WXShareWebPage(int shareType, String url, String title, String content, byte[] thumb,String objName,String funName) {
        WXEntryActivity.GameObjectName = objName;
        WXEntryActivity.CallBackFuncName = funName;//Unity层的回调

        WXWebpageObject webpage = new WXWebpageObject();
        webpage.webpageUrl = url;
        WXMediaMessage msg = new WXMediaMessage(webpage);
        msg.title = title;
        msg.description = content;
        msg.thumbData = thumb;

        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = BuildTransaction("webpage");
        req.message = msg;
        req.scene = shareType;
        wxAPI.sendReq(req);
    }
    */

    /**
     * 是否root
     *
     * @return the boolean
     */
    public static boolean isRooted() {
        // nexus 5x "/su/bin/"
        String[] paths = {"/system/xbin/", "/system/bin/", "/system/sbin/", "/sbin/", "/vendor/bin/", "/su/bin/"};
        try {
            for (int i = 0; i < paths.length; i++) {
                String path = paths[i] + "su";
                if (new File(path).exists()) {
                    String execResult = exec(new String[]{"ls", "-l", path});
                    Log.d("cyb", "isRooted=" + execResult);
                    if (TextUtils.isEmpty(execResult) || execResult.indexOf("root") == execResult.lastIndexOf("root")) {
                        return false;
                    }
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static String exec(String[] exec)
    {
        String ret = "";
        ProcessBuilder processBuilder = new ProcessBuilder(exec);
        try {
            Process process = processBuilder.start();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                ret += line;
            }
            process.getInputStream().close();
            process.destroy();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    public boolean isDeviceRooted() {
        if (checkRootMethod1()){return true;}
        if (checkRootMethod2()){return true;}
        if (checkRootMethod3()){return true;}
        return false;
    }

    public boolean checkRootMethod1(){
        String buildTags = android.os.Build.TAGS;

        if (buildTags != null && buildTags.contains("test-keys")) {
            return true;
        }
        return false;
    }

    public boolean checkRootMethod2(){
        try {
            File file = new File("/system/app/Superuser.apk");            if (file.exists()) {
                return true;
            }
        } catch (Exception e) { }

        return false;
    }

    public boolean checkRootMethod3() {
        if (new ExecShell().executeCommand(ExecShell.SHELL_CMD.check_su_binary) != null){
            return true;
        }else{
            return false;
        }
    }

    private boolean executeShellCommand(String command){
        Process process = null;
        try{
            process = Runtime.getRuntime().exec(command);
            return true;
        } catch (Exception e) {
            return false;
        } finally{
            if(process != null){
                try{
                    process.destroy();
                }catch (Exception e) {
                }
            }
        }
    }

     /**
     * 检查手机上是否安装了指定的软件
     * @param context
     * @param packageNam
     * @return
     */
    public static boolean isAvilible(Context context, String packageName) {
        final PackageManager packageManager = context.getPackageManager();
        List<PackageInfo> packageInfos = packageManager.getInstalledPackages(0);
        List<String> packageNames = new ArrayList<String>();

        if (packageInfos != null) {
            for (int i = 0; i < packageInfos.size(); i++) {
                String packName = packageInfos.get(i).packageName;
                packageNames.add(packName);
            }
        }
        // 判断packageNames中是否有目标程序的包名，有TRUE，没有FALSE
        return packageNames.contains(packageName);
    }

    static String BuildTransaction(final String type) {
        return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
    }
}
