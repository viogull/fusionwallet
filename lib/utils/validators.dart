import 'package:meta/meta.dart';

class Validator {
  static const passphrasePattern = "[\w ]{12}";

  static const addressPattern = "";
  static bool isMinterAddressValid({@required String address}) {}

  static bool isMnemonicValid({@required String mnemonic}) {
    return (mnemonic.split(" ").toList().length == 12);
  }
}
