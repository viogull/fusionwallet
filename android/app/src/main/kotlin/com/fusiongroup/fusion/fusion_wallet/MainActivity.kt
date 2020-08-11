package com.fusiongroup.fusion.wallet


import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import network.minter.core.MinterSDK
import network.minter.core.bip39.NativeBip39
import network.minter.core.bip39.NativeHDKeyEncoder
import network.minter.core.crypto.BytesData
import network.minter.core.crypto.MinterAddress
import network.minter.explorer.MinterExplorerSDK
import network.minter.explorer.models.AddressBalance
import network.minter.explorer.models.ExpResult
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import timber.log.Timber


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

            val address = MinterAddress(publicKey)

            return HashMap<String, String>().apply {
                put("mnemonic", mnemonicResult.mnemonic)
                put("seed", seed.toHexString())
                put("private_key", privateKey.toHexString())
                put("public_key", publicKey.toHexString())
                put("address", address.toHexString() )
            }
        }


        fun getTransactions(address: String) : HashMap<Any, Any> = HashMap()

        const val CHANNEL_NAME = "com.fusiongroup.fusion.wallet/natives"

        const val CREATE_ADDRESS = "create_address";
        const val GET_BALANCES = "balances";
        const val GET_TRANSACTIONS = "transactions";





    }


    override fun configureFlutterEngine( flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        initializeMinterSdk();
        MethodChannel(flutterEngine.dartExecutor, CHANNEL_NAME).setMethodCallHandler {
            call, result ->
            Log.d("NativePlugins", " [Call] -> ${call.method}")
            if (call.method == CREATE_ADDRESS) {
                Log.d("NativePlugins", "Generated address ")
                result.success(generateAddress())
            }
            else {
                Log.e("NativePlugins", "Not impletemented")
                result.notImplemented()
            }
        }
    }




    private fun initializeMinterSdk() {
       try {
           MinterSDK.initialize()
           MinterExplorerSDK.initialize()


       } catch (ex: Exception) {
           ex.printStackTrace()
       }
    }



}s