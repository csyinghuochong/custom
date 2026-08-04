package com.example.weijinggame.x7sy;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import com.smwl.smsdk.abstrat.SMInitListener;
import com.smwl.smsdk.abstrat.SMLoginListener;
import com.smwl.smsdk.abstrat.SMLoginOutListener;
import com.smwl.smsdk.abstrat.SMPayListener;
import com.smwl.smsdk.app.SMPlatformManager;
import com.smwl.smsdk.bean.PayInfo;
import com.smwl.smsdk.bean.RoleInfo;
import com.smwl.smsdk.bean.SMUserInfo;
import com.unity3d.player.UnityPlayer;

import org.json.JSONObject;

public class X7SdkBridge {

    private static final String TAG = "X7SdkBridge";
    private static final String UNITY_OBJECT = "Global";
    private static final String APP_KEY = "8e4a4fc224dc249ff012e2623f670b83";
    /** 支付接入签名版本，新游戏按文档传 2507 */
    private static final String GAME_ACCESS_VERSION = "2507";
    /** 角色上报无法取值时按文档传 -1 */
    private static final String ROLE_DEFAULT = "-1";

    private final Activity activity;

    public X7SdkBridge(Activity activity) {
        this.activity = activity;
    }

    private void sendUnity(String method, String data) {
        Log.i(TAG, method + " -> " + data);
        UnityPlayer.UnitySendMessage(UNITY_OBJECT, method, data == null ? "" : data);
    }

    public void init() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                SMPlatformManager.getInstance().setCurrentActivityBeforeInit(activity);
                SMPlatformManager.getInstance().init(activity, APP_KEY, new SMInitListener() {
                    @Override
                    public void onSuccess() {
                        sendUnity("OnX7InitResult", "success");
                    }

                    @Override
                    public void onFail(String msg) {
                        sendUnity("OnX7InitResult", "fail:" + safe(msg));
                    }
                });
            }
        });
    }

    public void login() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                SMPlatformManager.getInstance().login(activity, new SMLoginListener() {
                    @Override
                    public void onLoginSuccess(SMUserInfo userInfo) {
                        String token = userInfo != null ? userInfo.getTokenkey() : "";
                        sendUnity("OnX7LoginResult", "success:" + safe(token));
                    }

                    @Override
                    public void onLoginFailed(String msg) {
                        sendUnity("OnX7LoginResult", "fail:" + safe(msg));
                    }

                    @Override
                    public void onLoginCancell(String msg) {
                        sendUnity("OnX7LoginResult", "cancel:" + safe(msg));
                    }

                    @Override
                    public void onLogoutSuccess(boolean switchAccount) {
                        // 文档：注销/切换小号都走登录监听里的 onLogoutSuccess(boolean isSwitch)
                        // isSwitch=true：切换小号；false：普通登出
                        if (switchAccount) {
                            sendUnity("OnX7SwitchAccountResult", "success");
                        } else {
                            sendUnity("OnX7LogoutResult", "success");
                        }
                    }
                });
            }
        });
    }

    public void logout() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                SMPlatformManager.getInstance().logout();
            }
        });
    }

    public void pay(final String json) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    JSONObject obj = new JSONObject(json);
                    PayInfo payInfo = new PayInfo();
                    payInfo.game_price = obj.optString("game_price");
                    payInfo.game_orderid = obj.optString("game_orderid");
                    payInfo.game_role_id = obj.optString("game_role_id");
                    payInfo.game_role_name = obj.optString("game_role_name");
                    payInfo.game_area = obj.optString("game_area");
                    payInfo.game_level = obj.optString("game_level");
                    payInfo.game_sign = obj.optString("game_sign");
                    payInfo.game_guid = obj.optString("game_guid");
                    // 固定使用最新接入签名版本 2507（Unity 侧签名也需同步为 2507）
                    payInfo.game_access_version = GAME_ACCESS_VERSION;
                    payInfo.game_currency = obj.optString("game_currency", "CNY");
                    payInfo.notify_id = obj.optString("notify_id");
                    payInfo.subject = obj.optString("subject");
                    payInfo.extends_info_data = obj.optString("extends_info_data");

                    SMPlatformManager.getInstance().pay(activity, payInfo, new SMPayListener() {
                        @Override
                        public void onPaySuccess(Object msg) {
                            sendUnity("OnX7PayResult", "success:" + payInfo.game_orderid);
                        }

                        @Override
                        public void onPayFailed(Object msg) {
                            sendUnity("OnX7PayResult", "fail:" + String.valueOf(msg));
                        }

                        @Override
                        public void onPayCancell(Object msg) {
                            sendUnity("OnX7PayResult", "cancel:" + payInfo.game_orderid);
                        }
                    });
                } catch (Exception e) {
                    Log.e(TAG, "pay parse error", e);
                    sendUnity("OnX7PayResult", "fail:" + e.getMessage());
                }
            }
        });
    }

    public void reportRole(final String json) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    JSONObject obj = new JSONObject(json);
                    RoleInfo roleInfo = new RoleInfo();
                    roleInfo.game_role_id = obj.optString("game_role_id");
                    roleInfo.game_role_name = obj.optString("game_role_name");
                    roleInfo.game_area = obj.optString("game_area");
                    roleInfo.game_area_id = obj.optString("game_area_id");
                    roleInfo.game_guid = obj.optString("game_guid");
                    roleInfo.roleLevel = obj.optString("roleLevel");
                    // 不能正常传递时传 -1
                    roleInfo.roleCE = optOrDefault(obj, "roleCE", ROLE_DEFAULT);
                    roleInfo.roleStage = optOrDefault(obj, "roleStage", ROLE_DEFAULT);
                    roleInfo.roleRechargeAmount = optOrDefault(obj, "roleRechargeAmount", ROLE_DEFAULT);
                    roleInfo.roleGuildId = optOrDefault(obj, "roleGuildId", ROLE_DEFAULT);
                    roleInfo.roleGuild = optOrDefault(obj, "roleGuild", ROLE_DEFAULT);

                    SMPlatformManager.getInstance().smAfterChooseRoleSendInfo(activity, roleInfo);
                    sendUnity("OnX7ReportRoleResult", "success");
                } catch (Exception e) {
                    Log.e(TAG, "reportRole parse error", e);
                    sendUnity("OnX7ReportRoleResult", "fail:" + e.getMessage());
                }
            }
        });
    }

    public void exitApp() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                SMPlatformManager.getInstance().exitApp(new SMLoginOutListener() {
                    @Override
                    public void loginOutSuccess() {
                        sendUnity("OnX7ExitResult", "success");
                        activity.finish();
                        System.exit(0);
                    }

                    @Override
                    public void loginOutFail(String msg) {
                        sendUnity("OnX7ExitResult", "fail:" + safe(msg));
                    }

                    @Override
                    public void loginOutCancel() {
                        sendUnity("OnX7ExitResult", "cancel");
                    }
                });
            }
        });
    }

    private void runOnUiThread(Runnable runnable) {
        if (activity == null) {
            return;
        }
        activity.runOnUiThread(runnable);
    }

    private static String safe(String value) {
        return TextUtils.isEmpty(value) ? "" : value;
    }

    /** 空串 / 缺省 / "0" 时回退为 defaultValue（-1） */
    private static String optOrDefault(JSONObject obj, String key, String defaultValue) {
        String value = obj.optString(key, "");
        if (TextUtils.isEmpty(value) || "0".equals(value)) {
            return defaultValue;
        }
        return value;
    }
}
