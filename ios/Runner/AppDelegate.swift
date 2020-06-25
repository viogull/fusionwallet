import UIKit
import Flutter
import Flutter
import MinterCore
import MinterExplorer

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    
    let platformChannel = FlutterMethodChannel.init(name: "com.fusiongroup.fusion.wallet/natives", binaryMessenger: controller.binaryMessenger);
    
      platformChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "address":
                 self.generate_address(result: result)
            
            default:
                result(FlutterMethodNotImplemented)
            }
        }
     
  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    
    /**
                Generating mnemonic passphrase and relative keys, then sending it back through FlutterMethodChannel
     */
    private func generate_address(result: FlutterResult) -> Void  {

        let mnemonics = String.generateMnemonicString() ?? ""
        let res = RawTransactionSigner.seed(from: mnemonics, passphrase: " ", language: .english) ?? ""
        let privateKey = PrivateKey(seed: Data(hex: res))
        let key = try? privateKey
          .derive(at: 44, hardened: true)
          .derive(at: 60, hardened: true)
          .derive(at: 0, hardened: true)
          .derive(at: 0)
          .derive(at: 0)
        
        
        let publicKey = RawTransactionSigner.publicKey(privateKey: privateKey.raw, compressed: false)!.dropFirst();

        
        let address = RawTransactionSigner.address(publicKey: publicKey);
        
        let keys = ["mnemonic", "seed", "public_key", "private_key", "address"]
        let values = [ mnemonics, res, publicKey.fullHexString, privateKey.extended(), address ]
        

        var dict =   ["mnemonics":mnemonics,"seed":res, "public_key":publicKey.fullHexString, "private_key": privateKey.extended(), "address": address];
        
        result(dict)

    }



}
