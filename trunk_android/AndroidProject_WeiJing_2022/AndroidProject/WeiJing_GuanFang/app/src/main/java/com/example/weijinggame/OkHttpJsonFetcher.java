package com.example.weijinggame;

import android.annotation.TargetApi;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import okhttp3.*;
import org.json.JSONObject;
import java.io.IOException;

public class OkHttpJsonFetcher {
    private OkHttpClient client;
    private static final Handler mainHandler = new Handler(Looper.getMainLooper());

    public interface JsonCallback {
        void onSuccess(JSONObject jsonObject);
        void onError(String errorMessage);
    }

    public OkHttpJsonFetcher() {
        client = new OkHttpClient.Builder()
                .connectTimeout(15, java.util.concurrent.TimeUnit.SECONDS)
                .readTimeout(15, java.util.concurrent.TimeUnit.SECONDS)
                .build();
    }

    public void fetch(String url, final JsonCallback callback) {
        Request request = new Request.Builder().url(url).build();

        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, final IOException e) {
                final String errorMsg = e.getMessage() != null ? e.getMessage() : "Network request failed";
                mainHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        callback.onError(errorMsg);
                    }
                });
            }

            @TargetApi(Build.VERSION_CODES.KITKAT)
            @Override
            public void onResponse(Call call, Response response) throws IOException {
                try (ResponseBody responseBody = response.body()) {
                    if (!response.isSuccessful() || responseBody == null) {
                        throw new IOException("Unexpected code: " + response.code());
                    }
                    String jsonString = responseBody.string();
                    final JSONObject jsonObject = new JSONObject(jsonString);
                    mainHandler.post(new Runnable() {
                        @Override
                        public void run() {
                            callback.onSuccess(jsonObject);
                        }
                    });
                } catch (final Exception e) {
                    final String errorMsg = e.getMessage() != null ? e.getMessage() : "Response parsing failed";
                    mainHandler.post(new Runnable() {
                        @Override
                        public void run() {
                            callback.onError(errorMsg);
                        }
                    });
                }
            }
        });
    }
}