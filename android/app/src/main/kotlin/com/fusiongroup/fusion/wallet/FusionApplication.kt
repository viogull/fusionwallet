



package com.fusiongroup.fusion.wallet


import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.app.FlutterApplication;
import io.flutter.plugins.GeneratedPluginRegistrant



import java.security.SecureRandom



class FusionApplication: FlutterApplication() {

    override fun onCreate() {
        val invocationEvents: ArrayList<String> = ArrayList()
        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE)
        InstabugFlutterPlugin().start(this@FusionApplication, "d1b6a52e4472dc8189e4acc091569f17",
                invocationEvents)
        super.onCreate();
    }
}