package com.yinhuochong.mjcs;

        import android.app.Activity;
        import android.content.Context;
        import android.content.pm.PackageInfo;
        import android.content.pm.PackageManager;
        import android.os.Bundle;
        import android.util.Log;
        import com.tencent.mm.sdk.modelpay.PayReq;
        import com.tencent.mm.sdk.openapi.IWXAPI;
        import com.unity3d.player.UnityPlayer;
        import java.util.ArrayList;
        import java.util.List;



public class MainActivity extends UnityPlayerActivity {

    //Appid final
    public static  String APP_ID ;
    private static MainActivity instance;
    Context mContext = null;
    public Activity activity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        instance = this;
        mContext = this;
        activity = this;
    }

    public static MainActivity GetInstance() {
       return instance;
     }

    //检测root 和 包名
    public void CallNative(  String str )
    {
        Log.i("CallNative", str);
        UnityPlayer.UnitySendMessage("Init","CallNative", "native to unity");
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
