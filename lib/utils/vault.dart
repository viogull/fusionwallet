import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../inject.dart';
import 'crypto.dart';
import 'shared_prefs.dart';

class Vault {
  static const _pincode_key = 'pincode_key';
  static const _last_account_key = 'last_used_account_key';

  static const _firstlaunch_key = 'first_launch_key';
  static const _secure_encryption_key = 'secure_encryption_key';

  static const String accountsBoxEncrypted = "accountBoxEncrypted";
  static const String prefsUiThemeMode = "prefsThemeMode";
  static const String prefsLanguage = "prefsLocale";
  static const String prefsEnableBiometric = "prefsEnableBiometric";
  static const String prefsShowRewards = "prefsEnableBiometric";
  static const String seedKey = 'fusion_seed';
  static const String encryptionKey = 'fusion_secret_phrase';
  static const String pinKey = 'fusion_pin';
  static const String mnemonicKey = 'fusion_passphrase';
  static const String sessionKey = 'fusion_session_key';
  static const String prefsCurrentAccountName = 'current_account_name';

  static const String lastReferalInviter = "fusion_referal_last";

  final log = injector.get<Logger>();
  Box<Account> _accountsBox;
  Box<dynamic> preferences;

  Vault();

  final FlutterSecureStorage secureStorage = new FlutterSecureStorage();

  Future<dynamic> getSecureEncryptionKey() async {
    var key = await secureStorage.read(key: _secure_encryption_key);

    return key;
  }

  Future<bool> isFirstStart() async {
    return await secureStorage.read(key: _firstlaunch_key) as bool;
  }

  void savePincode({@required String pin}) async {
    secureStorage.write(key: _pincode_key, value: pin);
  }

  Future<String> getCurrentPin() async {
    return secureStorage.read(key: _pincode_key);
  }

  Future<String> getBiometricEnabled() async {
    return secureStorage.read(key: Vault.prefsEnableBiometric);
  }

  Future<bool> legacy() async {
    return await injector.get<SharedPrefsUtil>().useLegacyStorage();
  }

  // Re-usable
  Future<String> _write(String key, String value) async {
    if (await legacy()) {
      await setEncrypted(key, value);
    } else {
      await secureStorage.write(key: key, value: value);
    }
    return value;
  }

  Future<String> _read(String key, {String defaultValue}) async {
    if (await legacy()) {
      return await getEncrypted(key);
    }
    return await secureStorage.read(key: key) ?? defaultValue;
  }

  Future<void> deleteAll() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(encryptionKey);
      await prefs.remove(seedKey);
      await prefs.remove(pinKey);
      await prefs.remove(sessionKey);
      return;
    }
    await secureStorage.deleteAll();
    return await Hive.box<Account>(accountsBox).clear();
  }

  // Specific keys
  Future<String> getSeed() async {
    return await _read(seedKey);
  }

  Future<String> setSeed(String seed) async {
    return await _write(seedKey, seed);
  }

  Future<void> deleteSeed() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(seedKey);
    }
    return await secureStorage.delete(key: seedKey);
  }

  Future<String> getEncryptionPhrase() async {
    return await _read(encryptionKey);
  }

  Future<String> writeEncryptionPhrase(String secret) async {
    return await _write(encryptionKey, secret);
  }

  /// Used to keep the seed in-memory in the session without being plaintext
  Future<String> getSessionKey() async {
    String key = await _read(sessionKey);
    if (key == null) {
      key = await updateSessionKey();
    }
    return key;
  }

  Future<String> updateSessionKey() async {
    String key = Encryptor.generateEncryptionSecret(25);
    await writeSessionKey(key);
    return key;
  }

  Future<String> writeSessionKey(String key) async {
    return await _write(sessionKey, key);
  }

  Future<void> deleteEncryptionPhrase() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(encryptionKey);
    }
    return await secureStorage.delete(key: encryptionKey);
  }

  Future<String> getPin() async {
    return await _read(pinKey);
  }

  Future<String> writePin(String pin) async {
    return await _write(pinKey, pin);
  }

  Future<void> deletePin() async {
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(pinKey);
    }
    return await secureStorage.delete(key: pinKey);
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Encryptor encrypter = new Encryptor(secret.substring(0, secret.length - 8),
        secret.substring(secret.length - 8));
    // Encrypt and save
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, encrypter.encrypt(value));
  }

  Future<String> getEncrypted(String key) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Encryptor encrypter = new Encryptor(secret.substring(0, secret.length - 8),
        secret.substring(secret.length - 8));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encrypted = prefs.get(key);
    if (encrypted == null) return null;
    return encrypter.decrypt(encrypted);
  }

  static const _channel = const MethodChannel('fappchannel');

  Future<String> getSecret() async {
    return await _channel.invokeMethod('getSecret');
  }

  setBiometricEnabled({String value}) {
    secureStorage.write(key: Vault.prefsEnableBiometric, value: value);
  }

  saveName({String name}) {
    secureStorage.write(key: Vault.prefsCurrentAccountName, value: name);
  }

  void setLastAccount(String name) {
    secureStorage.write(key: _last_account_key, value: name);
  }

  Future<String> getLastUsedAccount() async {
    return await secureStorage.read(key: _last_account_key);
  }

  Future<bool> isAccountPersisted() async {
    var account = _accountsBox.getAt(0);
    return account != null;
  }

  void saveAccount(String accountName, String pin, String mnemonic, String seed,
      String publicKey, String privateKey, String address) async {
    log.d("Creating and persisting new account $accountName");
    await writePin(pin);
  }

  Account get currentAccount => _accountsBox.getAt(0);

  Future addContact(Contact contact) {
    if (!contact.isInBox) {
      contact.save();
    } else {
      Hive.box(contactsBox).add(contact).then((value) {
        return value;
      }).catchError((err) {
        return null;
      });
    }
    return null;
  }

  Future<List<Account>> getAccounts() async {}

  Future<void> deleteAllAccounts() async {}

  Future<dynamic> setLastAuthentication({@required String uu}) async {}

  void saveLastReferalInviter(String ref) {
    secureStorage.write(key: lastReferalInviter, value: ref);
  }

  Future<String> getLastReferalInviter() async {
    return await secureStorage.read(key: lastReferalInviter);
  }

  Future<void> addAccount(
      {String name,
      String mnemonic,
      String seed,
      String address,
      String privKey,
      String publicKey}) async {
    log.d("Creating additional account $name [$address]");
    await Hive.box<Account>(additionalAccountsBox).add(new Account(
        name: name,
        address: address,
        mnemonic: mnemonic,
        seed: seed,
        publicKey: publicKey,
        privateKey: privKey));
  }

  List<Account> getAdditionals() =>
      Hive.box<Account>(additionalAccountsBox).values.toList();

  List<Account> getAllAccounts() {
    Box<Account> accs = Hive.box<Account>(accountsBox);
    Account root = accs.values.toList()[accs.values.length - 1];
    List<Account> list = List();
    list.add(root);
    log.d(root.name);
    list.addAll(getAdditionals());
    return list;
  }
}
