package com.guangying.yongshi;

        import android.Manifest;
        import android.app.Activity;
        import android.content.Context;
        import android.content.Intent;
        import android.content.pm.PackageInfo;
        import android.content.pm.PackageManager;
        import android.os.Build;
        import android.os.Bundle;
        import android.support.annotation.NonNull;
        import android.text.TextUtils;
        import android.util.Log;
        import android.widget.Toast;

        import com.guangying.yongshi.wxapi.WXPayEntryActivity;
        import com.tencent.mm.sdk.modelpay.PayReq;
        import com.tencent.mm.sdk.openapi.IWXAPI;
        import com.tencent.mm.sdk.openapi.WXAPIFactory;

        import com.unity3d.player.UnityPlayer;

        import java.io.BufferedReader;
        import java.io.File;
        import java.io.InputStreamReader;
        import java.util.ArrayList;
        import java.util.List;

        import android.content.IntentFilter;

        import com.quicksdk.Sdk;
        import com.quicksdk.utility.AppConfig;


public class MainActivity extends UnityPlayerActivity {


    //Appid final
    public static  String APP_ID ;
    private static MainActivity instance;
    Context mContext = null;
    public Activity activity;

    //这个对象用于封装支付参数
    private PayReq req = new PayReq();
    //微信API 用于调起支付接口
    private   IWXAPI wxAPI =null; //WXAPIFactory.createWXAPI(this, null);
    private String CallAliObjName;//CallAliObjName,CallAliFuncName
    private  String CallAliFuncName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
        instance = this;
        mContext = this;
        activity = this;
    }

    public static MainActivity GetInstance() {
       return instance;
     }

    //微信SDK初始化(注册)的接口
    public void WechatInit(String appid){
        if(wxAPI == null) {
            this.APP_ID=appid;
            wxAPI = WXAPIFactory.createWXAPI(this, appid);
            wxAPI.registerApp(appid);
        }
    }

    public String getProductCode() {

        Log.i( "product_code:  ", AppConfig.getInstance().getConfigValue("product_code") );
        return AppConfig.getInstance().getConfigValue("product_code");
    }

    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Sdk.getInstance().exit(activity);
    }

    //判断是否已经安装微信的接口
    public  boolean IsWechatInstalled () {
        return wxAPI.isWXAppInstalled();
    }

    //判断当前微信的版本是否支持API调用
    public  boolean IsWechatAppSupportAPI() {
        return wxAPI.isWXAppSupportAPI();
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
    public  void WeChatPayReq(String APP_ID,String MCH_ID ,String prepayid ,String noncestr,String timestamp,String sign,String callBackBackObjectName,String CallBackFuncName){

        Log.i( "unity: ", "拉起微信支付！！"  );

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
    public  void ReqSystemTime( String str )
    {
        long time1 = System.currentTimeMillis();
        UnityPlayer.UnitySendMessage("WWW_Set","onRecvSysTime",  String.valueOf(time1));
    }

    //获取电池电量
    public void getBatteryStatus(  )
    {
        Intent intent = registerReceiver(null,new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        int rawlevel = intent.getIntExtra("level", -1);
        int scale = intent.getIntExtra("scale", -1);
        int status = intent.getIntExtra("status", -1);
        double level = -1;
        if(rawlevel >= 0 && scale > 0)
            level = (rawlevel * 1.0) / scale;
        UnityPlayer.UnitySendMessage("WWW_Set","onRecvBattery",  String.valueOf(level));
    }

    public  void QuDaoRequestPermissions()
    {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
        {
            //多个权限同时获取
            List<String> permissionList=new ArrayList<>();
            if (this.mContext.checkSelfPermission(Manifest.permission.READ_PHONE_STATE)!=PackageManager.PERMISSION_GRANTED){
                permissionList.add(Manifest.permission.READ_PHONE_STATE);
            }
            if (this.mContext.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)!=PackageManager.PERMISSION_GRANTED){
                permissionList.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
            }
            if (this.mContext.checkSelfPermission(Manifest.permission.REQUEST_INSTALL_PACKAGES)!=PackageManager.PERMISSION_GRANTED){
                permissionList.add(Manifest.permission.REQUEST_INSTALL_PACKAGES);
            }

            if (!permissionList.isEmpty()){
                String [] permissions=permissionList.toArray(new String [permissionList.size()]);
                this.activity.requestPermissions( permissions, 1);
            }
        }
        else
        {
            UnityPlayer.UnitySendMessage("WWW_Set","onRequestPermissionsResult",  "1");
        }
    }

    //多个权限同时获取
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode){
            case 1:
                if (grantResults.length>0){
                    for (int result:grantResults){
                        if (result!=PackageManager.PERMISSION_GRANTED){
                            Toast.makeText(this,"请同意所以请求才能运行程序",Toast.LENGTH_SHORT).show();
                            doSomething_Ex("0");
                            finish();
                            return;
                        }
                        doSomething_Ex("1");
                    }
                }else {
                    Toast.makeText(this,"发生权限请求错误,程序关闭",Toast.LENGTH_SHORT).show();
                    finish();
                }
                break;
            default:
        }
    }

    public  void doSomething_Ex( String str)
    {
        UnityPlayer.UnitySendMessage("WWW_Set","onRequestPermissionsResult",  str);
    }

    //检测root 和 包名
    public void excuteCheckAction(  String str )
    {
        boolean root1 =  MainActivity.isRooted( );
        boolean root2 = isDeviceRooted( );
        String commandToExecute = "su";
        boolean root3 = executeShellCommand(commandToExecute);
        boolean root4 = CheckRoot.checkBusybox();
        boolean root5 = CheckRoot.checkAccessRootData();
        int root_num = ( root1 ? 10000 : 0 ) + ( root2 ? 1000 : 0 ) + ( root3 ? 100 : 0 ) + (root4 ? 10 : 0) + (root5 ? 1 : 0);
        UnityPlayer.UnitySendMessage("WWW_Set","onRecvRoot",  String.valueOf( root_num ) );

        String[] packsssList = str.split("&_&");
        String returnPack = "";
        for( int i = 0; i < packsssList.length; i++ )
        {
            boolean exist = MainActivity.isAvilible( mContext, packsssList[ i ] );
            if ( i == 0 )
            {
                returnPack = packsssList[ i ] + "&_&" + (exist ?  "1" : "0");
            }
            else
            {
                returnPack = returnPack +"&_&" + packsssList[ i ] + "&_&" + (exist ?  "1" : "0");
            }
        }
        UnityPlayer.UnitySendMessage("WWW_Set","onCheckPackage",returnPack);
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
            File file = new File("/system/app/Superuser.apk");
            if (file.exists()) {
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
     * @param packageName
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
