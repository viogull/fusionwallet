import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:nanodart/nanodart.dart';

import 'models.dart';
import 'models/available_currency.dart';
import 'models/available_language.dart';
import '../inject.dart';
import '../utils/vault.dart';

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final Box<Account> accounts;

  StateContainer({@required this.child, @required this.accounts});

  @override
  State<StatefulWidget> createState() => StateContainerState();

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class StateContainerState extends State<StateContainer> {
  final Logger log = injector.get<Logger>();
  final storage = injector.get<Vault>();

  String receiveThreshold = BigInt.from(10).pow(24).toString();

  String encryptedSeed = "";

  String currencyLocale;
  Locale locale = Locale('en', '');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  // Currently selected account
  Account selectedAccount;

  dynamic balances;
  // Two most recently used accounts

  bool darkModeEnabled = false;
  bool showRewards = false;

  Future<dynamic> areRewardsVisible() async {
    return true;
  }

  String accountName;
  bool biometricEnabled = false;
  String localeCode = 'en';

  // If callback is locked
  bool _locked = false;

  // Maps all pending receives to previous blocks

  // When wallet is encrypted
  String encryptedSecret;

  @override
  void initState() {
    super.initState();

    if (widget.accounts.length > 0) {
      selectedAccount = widget.accounts.getAt(widget.accounts.length - 1);
    } else {
      selectedAccount = Account();
    }
    // Get default language setting
    final locale = selectedAccount.locale;

    // Get theme default
    var preferencesTheme = selectedAccount.darkModeEnabled;
    final currentTheme = (preferencesTheme != null && preferencesTheme);

    var currentAccountMnemonic = selectedAccount.mnemonic;

    final currentLocale =
        (locale == 'en') ? Locale('en', '') : Locale('ru', '');
    debugPrint(
        "Preferences Theme Selected $preferencesTheme , Theme Mode: $currentTheme");
    debugPrint(
        "Preferences Language Selected $locale , Theme Mode: $currentLocale");

    final rewardsEnabled = selectedAccount.showRewards;

    updateName(name: selectedAccount.name);
    updateMnemonicPassphrase(currentAccountMnemonic);
    updateTheme(isDarkModeEnabled: currentTheme);
    updateLanguage(currentLocale);
    setBiometric(biometricEnabled);
    setRewardsVisibility(rewardsEnabled);
  }

  void updateName({String name}) async {
    debugPrint(
        "Updating name with new $name. Accounts In Box ${selectedAccount.isInBox}");
    debugPrint("Writing $name to prefs storage");
    checkAccountsBox();
    selectedAccount.name = name;
    selectedAccount.save();
    setState(() {
      this.accountName = name;
    });
  }

  /*
          Set save:true to persist preference into storage.
       */
  void updateTheme({bool isDarkModeEnabled}) async {
    debugPrint(
        "Updating theme with new $isDarkModeEnabled. Accounts In Box ${selectedAccount.isInBox}");
    debugPrint("Writing $isDarkModeEnabled to prefs storage");
    checkAccountsBox();
    selectedAccount.darkModeEnabled = isDarkModeEnabled;
    selectedAccount.save();
    setState(() {
      this.darkModeEnabled = isDarkModeEnabled;
    });
  }

  void setBiometric(@required bool isEnabled, {bool save = false}) async {
    debugPrint("Updating [biometric] with new $isEnabled");

    debugPrint("Writing new biometric status $isEnabled to secure storage");
    selectedAccount.biometricEnabled = isEnabled;
    selectedAccount.save();

    setState(() {
      this.biometricEnabled = isEnabled;
    });
  }

  void setRewardsVisibility(bool isShowRewardsEnabled,
      {bool save = false}) async {
    debugPrint(
        "Updating [Show Rewards] prefserence with new $isShowRewardsEnabled");

    debugPrint("Writing $isShowRewardsEnabled to prefs storage");
    //      await widget.preferences
    //          .put(Vault.prefsShowRewards, isShowRewardsEnabled);
    selectedAccount.showRewards = isShowRewardsEnabled;
    selectedAccount.save();

    setState(() {
      this.showRewards = isShowRewardsEnabled;
    });
  }

  void updateLanguage(Locale updatedLocale, {bool save = false}) {
    debugPrint("Updating language with new $updatedLocale, save mode -> $save");
    if (save) {
      debugPrint("Writing $updatedLocale to prefs storage");
      selectedAccount.locale = updatedLocale.languageCode;
      selectedAccount.save();
    }
    setState(() {
      locale = updatedLocale;
    });
  }

  @override
  void dispose() {
    widget.accounts.close();
    super.dispose();
  }

  void logOut() {
    setState(() {
      // wallet = AppWallet();
      encryptedSecret = null;
    });
    //  sl.get<DBHelper>().dropAccounts();
  }

  Future<String> getSeed() async {
    String seed;
    if (encryptedSecret != null) {
      seed = NanoHelpers.byteToHex(NanoCrypt.decrypt(
          encryptedSecret, await injector.get<Vault>().getSessionKey()));
    } else {
      seed = await injector.get<Vault>().getSeed();
    }
    return seed;
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  void update({Account account}) {}

  void persistPassphrase(String mnemonic) async {
    //widget.preferences.put(Vault.mnemonicKey, mnemonic);
  }

  void updateMnemonicPassphrase(currentAccountMnemonic) {}

  void checkAccountsBox() {
    if (!selectedAccount.isInBox) {
      selectedAccount.save();
    }
  }

  void loadAccount() {
    setState(() {
      this.selectedAccount = widget.accounts.getAt(0);
    });
  }
}
