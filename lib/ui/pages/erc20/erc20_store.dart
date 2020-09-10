








import 'package:fusion_wallet/core/abstract/account.dart';
import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/main.dart';
import 'package:fusion_wallet/ui/pages/erc20_ui.dart';
import 'package:fusion_wallet/utils/wallets.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:web3dart/credentials.dart';

import '../../../inject.dart';

part 'erc20_store.g.dart';

class Erc20Store = _Erc20Store with _$Erc20Store;




abstract class _Erc20Store with Store {
  final api = injector.get<MinterRest>();
  final log = injector.get<Logger>();
  final _erc20Box = Hive.box<Erc20Wallet>(erc20walletsBox);
  final _accountsBox = Hive.box<Account>(accountsBox);

  @observable
  bool isWalletPersisted = false;

  @observable
  String address = '';

  @observable
  String privateKey;


  @action
  Future loadErc20Wallets() async {
    isWalletPersisted  = _erc20Box.isNotEmpty;
    if(_erc20Box.isNotEmpty) {
      log.d("Detected ERC20 wallets. Fetching...");
      final wallet = _erc20Box.getAt(0);
      address = wallet.address;
      privateKey = wallet.privateKey.toString();
    }
  }

  void init() async {
    log.i("Initialization  of ErcWalletUi");
    await loadErc20Wallets();
  }


  @action
  Future createErc20Wallet({String name, String password}) async {

    Wallet wallet  = await  Wallets.createEthWallet(password: password);
    final address = await wallet.privateKey.extractAddress();

    Erc20Wallet _boxWallet = Erc20Wallet(name: name,
        privateKey: wallet.privateKey.privateKey , address: address.hex);

    _erc20Box.add(_boxWallet);
    this.address = address.toString();
    this.privateKey = wallet.privateKey.toString();
    this.isWalletPersisted = _erc20Box.isNotEmpty;

    return _boxWallet;
    
  }


}