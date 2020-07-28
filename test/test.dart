import 'package:fusion_wallet/utils/validators.dart';
import 'package:test/test.dart';

void main() {
  

    test('Mnemonic Valid', () {
      expect(
          Validator.isMnemonicValid(
              mnemonic:
                  "ill_like wise coyote obey improve extra frog treat tortoise hint split"),
          equals(true));
    });
  
}
