package com.mamadaliyev.abbos.tabriklar

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.content.pm.PackageManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Kanal nomi ixtiyoriy, lekin Flutter tomondan ham xuddi shu nomdan foydalanish kerak
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example/checkInstagram")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isInstagramInstalled" -> {
                        val isInstalled = isInstagramInstalled(this)
                        result.success(isInstalled)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun isInstagramInstalled(context: Context): Boolean {
        return try {
            // Instagram package nomi "com.instagram.android"
            context.packageManager.getApplicationInfo("com.instagram.android", 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
}
