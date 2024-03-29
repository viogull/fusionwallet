








import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../inject.dart';

part 'erc20_store.g.dart';

class Erc20Store = _Erc20Store with _$Erc20Store;




abstract class _Erc20Store with Store {
  final api = injector.get<MinterRest>();
  final log = injector.get<Logger>();
  final _erc20Box = Hive.box<Erc20Wallet>(erc20walletsBox);

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
      log.d("Address $address");
      privateKey = wallet.privateKey.toString();
    } else {
      isWalletPersisted = false;
    }
  }

  void init()  {
    log.i("Initialization  of ErcWalletUi");
     loadErc20Wallets();
  }


  @action
  Future createErc20Wallet({String name, String password}) async {



    return _erc20Box.getAt(0);
    
  }


}