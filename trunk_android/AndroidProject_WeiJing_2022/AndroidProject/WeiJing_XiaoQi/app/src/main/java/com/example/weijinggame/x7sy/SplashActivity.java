package com.example.weijinggame.x7sy;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;

/**
 * 小7接入闪屏：使用 SDK 提供的 x7_act_splash 布局，延时后进入 MainActivity。
 */
public class SplashActivity extends Activity {

    private static final long SPLASH_DELAY_MS = 2000L;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // 固定横屏（Manifest 已声明，代码再兜一层）
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER_LANDSCAPE);
        super.onCreate(savedInstanceState);
        // 使用小7 SDK 的闪屏布局
        setContentView(R.layout.x7_act_splash);

        // 从后台切回或重复点击图标时避免重复拉起
        if ((getIntent().getFlags() & Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT) != 0) {
            finish();
            return;
        }

        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(SplashActivity.this, MainActivity.class);
                startActivity(intent);
                finish();
            }
        }, SPLASH_DELAY_MS);
    }
}
