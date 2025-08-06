package com.goinggame.weijing;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.content.FileProvider;
import android.text.TextUtils;
import android.util.Log;
import android.view.WindowManager;
import android.widget.Toast;

import com.unity3d.player.UnityPlayer;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import android.content.IntentFilter;

public class MainActivity extends UnityPlayerActivity {

    //Appid final
    public static String APP_ID;
    private static MainActivity instance;
    Context mContext = null;
    public Activity activity;

    //这个对象用于封装支付参数
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

    }

    public static MainActivity GetInstance() {
        return instance;
    }


    public void GetDeviceOAID(String str){

    }

    //微信SDK初始化(注册)的接口
    public void WechatInit(String appid) {
        Log.i("WechatInit", appid);
    }

    public String getProductCode() {
        return "84515669224153577888773432148616";
    }

    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
    }

    //判断是否已经安装微信的接口
    public boolean IsWechatInstalled() {
        return false;
    }

    //判断当前微信的版本是否支持API调用
    public boolean IsWechatAppSupportAPI() {
        return false;
    }

    public void SetIsPermissionGranted(String appid) {
        Log.d("SetIsPermissionGranted", appid);

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
                //Log.i("Permissions", "Permissions WRITE_EXTERNAL_STORAGE 0");
                //permissionList.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
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

    //多个权限同时获取 this.activity.requestPermissions 的第二个参数为此处返回的requestCode  case100->GetPhoneNum
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
            case 100:
                //
                break;
            default:
        }
    }

    public static boolean isEmulator_1(Context context) {
        if (Build.FINGERPRINT.startsWith("generic")
                || Build.FINGERPRINT.startsWith("unknown")
                || Build.FINGERPRINT.toLowerCase().contains("vbox")
                || Build.FINGERPRINT.toLowerCase().contains("test-keys")
            // ...可以添加更多的模拟器识别字符串
        ) {
            return true;
        }
        return false;
    }

    public  boolean isEmulator_2(Context context)
    {
        return  false;
    }

    public void TapTapShare(String str)
    {
    }

    //qwertyuioptgbuytr
    //检测root 和 包名
    public void CallNative(String str) throws InterruptedException {
        //Log.i("CallNative_11", str);
        boolean root1 =  MainActivity.isRooted( );
        boolean root2 = isDeviceRooted( );
        String commandToExecute = "su";
        boolean root3 = executeShellCommand(commandToExecute);
        boolean root4 = false;
        boolean root5 = false;
        int root_num = ( root1 ? 10000 : 0 ) + ( root2 ? 1000 : 0 ) + ( root3 ? 100 : 0 ) + (root4 ? 10 : 0) + (root5 ? 1 : 0);
        UnityPlayer.UnitySendMessage("Global", "OnRecvRoot",  String.valueOf( root_num ) );

        boolean emulator1 = isEmulator_1(this);
        boolean emulator2 = isEmulator_2(this);
        int emulator_num = (emulator1 ? 10 : 0) + (emulator2 ? 1 : 0);
        UnityPlayer.UnitySendMessage("Global", "OnRecvEmulator",  String.valueOf( emulator_num ) );

        return;
    }

    final int REQUEST_CODE_ADDRESS = 100;

    public  void GetPhoneNum(String zone) {

        UnityPlayer.UnitySendMessage("Global", "OnRecvPhoneNum", "");
    }

    public  void GetPhoneNum_3(String zone) {

    }

    public void GetPhoneNum_2(String zone) {
        Log.i("GetPhoneNum", "111");
        String phoneNum = "";
        //READ_PHONE_STATE唯一标识符、手机号码以及SIM卡状态等信息
        UnityPlayer.UnitySendMessage("Global", "OnRecvPhoneNum", phoneNum);
    }

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
        return false;
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

    static String BuildTransaction(final String type) {
        return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
    }
}
