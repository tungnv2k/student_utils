package com.se.su.app.student_utils_app;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class MainActivity extends FlutterActivity {
	@Override
	public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
		GeneratedPluginRegistrant.registerWith(flutterEngine);
	}

	private final Map<String, String> sharedData = new HashMap<>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		// Handle intent when app is initially opened
		handleSendIntent(getIntent());

		new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), "app.channel.shared.data").setMethodCallHandler(
				(call, result) -> {
					if (call.method.contentEquals("getSharedData")) {
						result.success(sharedData);
						sharedData.clear();
					}
				}
		);
	}

	@Override
	protected void onNewIntent(@NonNull Intent intent) {
		// Handle intent when app is resumed
		super.onNewIntent(intent);
		handleSendIntent(intent);
	}

	private void handleSendIntent(Intent intent) {
		String action = intent.getAction();
		String type = intent.getType();

		// Sharing intent that contains plain text
		if (Intent.ACTION_SEND.equals(action) && type != null) {
			if ("text/plain".equals(type)) {
				sharedData.put("subject", intent.getStringExtra(Intent.EXTRA_SUBJECT));
				sharedData.put("text", intent.getStringExtra(Intent.EXTRA_TEXT));
			}
		}
	}
}
