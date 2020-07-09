import UIKit
import Flutter
import BigInt
import MinterCore
import MinterExplorer




struct MinterMethods {
    static let CREATE_ADDRESS = "create_address";
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    
    
    let nodeUrlString = "https://minter-node-1.testnet.minter.network:8841" // example of a node url

    MinterCoreSDK.initialize(urlString: nodeUrlString)
    
    let platformChannel = FlutterMethodChannel.init(name: "com.fusiongroup.fusion.wallet/natives", binaryMessenger: controller.binaryMessenger);
    
    
    platformChannel.setMethodCallHandler {(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        

            switch call.method {
                case MinterMethods.CREATE_ADDRESS:
                    self.create_address(res: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
     
  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    

    
    
    
    /**
                Generating mnemonic passphrase and relative keys, then sending it back through FlutterMethodChannel
     */
    private func create_address(res: FlutterResult) -> Void  {
        
        let mnemonic = String.generateMnemonicString() ?? ""
        let seed = RawTransactionSigner.seed(from: mnemonic, passphrase: "", language: .english) ?? ""
        let privateKey = PrivateKey(seed: Data(hex: seed))
        
        print("Creating new address on iOS")
        _ = try? privateKey
          .derive(at: 44, hardened: true)
          .derive(at: 60, hardened: true)
          .derive(at: 0, hardened: true)
          .derive(at: 0)
          .derive(at: 0)
        
        let publicKey = RawTransactionSigner.publicKey(privateKey: privateKey.raw, compressed: false)!.dropFirst();
        let address = RawTransactionSigner.address(publicKey: publicKey);
        _ = ["mnemonic", "seed", "public_key", "private_key", "address"]
        _ = [ mnemonic, seed, publicKey.fullHexString, privateKey.extended(), address ]
     
        let data: [String: Any] =   [   "mnemonic":mnemonic,
                                        "seed":seed,
                                        "public_key":publicKey.fullHexString,
                                        "private_key": privateKey.extended(),
                                        "address": address as Any  ];
        
        res(data)
    
    
    }
    
    

    // private func balances(args: Any?, res:  @escaping  FlutterResult) -> Void {
    //     // Map<COIN_SYMBOL, COIN_QTY>
    //     AccountManager.default.address(args as! String , with: { (data, err) in
    //                 print("Fetch balances: ", data)
    //     if(err != nil) {
    //         print(err?.localizedDescription)
    //     }
    //        res(data)
    //          })
    // }
  
}
