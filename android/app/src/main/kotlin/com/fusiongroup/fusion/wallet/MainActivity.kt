package com.fusiongroup.fusion.wallet


import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import network.minter.core.MinterSDK
import network.minter.core.bip39.NativeBip39
import network.minter.core.bip39.NativeHDKeyEncoder
import network.minter.core.crypto.BytesData
import network.minter.explorer.MinterExplorerApi
import java.security.SecureRandom


class MainActivity: FlutterFragmentActivity() {


    

    companion object {



        fun generateAddress() : HashMap<String, String> {
            val random = SecureRandom();
            val mnemonicResult = NativeBip39.encodeBytes(random.generateSeed(16));
            val seed = BytesData(mnemonicResult.toSeed());
            val rootKey = NativeHDKeyEncoder.makeBip32RootKey(seed.bytes);
            val extKey = NativeHDKeyEncoder.makeExtenderKey(rootKey);


            val privateKey = extKey.privateKey;
            val publicKey = extKey.publicKey;

            return HashMap<String, String>().apply {
                put("mnemonic", mnemonicResult.mnemonic)
                put("seed", seed.stringValue())
                put("private_key", privateKey.stringValue())
                put("public_key", publicKey.stringValue())
            }

        }

        const val CHANNEL_NAME = "com.fusiongroup.fusion.wallet/natives"

        const val address = "address";
        const val send = "send_funds";
        const val transanctions = "transanctions";
        const val receive = "receive_funds";
        const val unconfirmed_transanctions = "unconfirmed_transanctions";
        const val delegate = "delegate";
        const val unbound = "unbound";
        const val check = "check";




    }


    override fun configureFlutterEngine( flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        initializeMinterSdk();

        MethodChannel(flutterEngine?.dartExecutor, CHANNEL_NAME).setMethodCallHandler {
            call, result ->

            Log.d("NarivePlugins", " [Call] -> ${call.method}")
            if (call.method == address) {

                Log.d("NativePlugins", "Generated address ")
                result.success(generateAddress())

            } else {
                Log.e("NativePlugins", "Not impletemented")
                result.notImplemented()
            }
        }
    }




    private fun initializeMinterSdk() {
       try {
           MinterSDK.initialize()
       } catch (ex: Exception) {
           ex.printStackTrace()
       }
    }



}
