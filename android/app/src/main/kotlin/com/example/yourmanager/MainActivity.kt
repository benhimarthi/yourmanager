package com.example.yourmanager

import androidx.multidex.MultiDex
import io.flutter.embedding.android.FlutterActivity
import android.content.Context

class MainActivity: FlutterActivity() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}
