import 'package:flutter/material.dart';
import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/core/models/coin_list_response.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:nanodart/nanodart.dart';

import '../inject.dart';
import '../utils/vault.dart';
import 'abstract/preferences.dart';
import 'models/available_currency.dart';
import 'models/available_language.dart';
import 'models.dart';

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
  final Preferences preferences;

  StateContainer(
      {@required this.child,
      @required this.accounts,
      @required this.preferences});

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

  String referalInviter;

  Preferences preferences() => widget.preferences;

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

  AddressData addressData;
  List<MinterCoin> coins;


  double erc20Balance;


  Box<Erc20Wallet> erc20WalletsBox = Hive.box<Erc20Wallet>(erc20walletsBox);

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
      log.d("Accounts exists");

      selectedAccount = widget.accounts.getAt(widget.accounts.length - 1);

      log.d("Expected pin ${selectedAccount.pin}");

      setState(() {
        this.selectedAccount = selectedAccount;
      });
    } else {
      selectedAccount = Account();
      widget.accounts.add(selectedAccount);
    }
    // Get default language setting
    final locale = widget.preferences.locale;

    // Get theme default
    final preferencesTheme = widget.preferences.darkThemeEnabled;
    final currentTheme = (preferencesTheme != null && preferencesTheme);

    var currentAccountMnemonic = selectedAccount.mnemonic;

    final currentLocale =
        (locale == 'en') ? Locale('en', '') : Locale('ru', '');
    log.d(
        "Preferences Theme Selected $preferencesTheme , Theme Mode: $currentTheme");
    log.d(
        "Preferences Language Selected $locale , Theme Mode: $currentLocale");

    final rewardsEnabled = selectedAccount.showRewards;

    updateName(name: selectedAccount.name);
    updateMnemonicPassphrase(currentAccountMnemonic);
    updateTheme(isDarkModeEnabled: currentTheme);
    updateLanguage(currentLocale);
    setBiometric(widget.preferences.biometricEnabled);
    setRewardsVisibility(rewardsEnabled);

    loadAdditionals();
  }

  void updateName({String name}) async {
    log.d(
        "Updating name with new $name. Accounts In Box ${selectedAccount.isInBox}");
    log.d("Writing $name to prefs storage");
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
    log.d(
        "Updating theme with new $isDarkModeEnabled. Accounts In Box ${selectedAccount.isInBox}");
    log.d("Writing $isDarkModeEnabled to prefs storage");
    checkAccountsBox();
    widget.preferences.darkThemeEnabled = isDarkModeEnabled;
    widget.preferences.save();
    setState(() {
      this.darkModeEnabled = isDarkModeEnabled;
    });
  }

  void setBiometric(@required bool isEnabled, {bool save = false}) async {
    log.d("Updating [biometric] with new $isEnabled");

    log.d("Writing new biometric status $isEnabled to secure storage");
    widget.preferences.biometricEnabled = isEnabled;
    widget.preferences.save();

    setState(() {
      this.biometricEnabled = isEnabled;
    });
  }

  void setRewardsVisibility(bool isShowRewardsEnabled,
      {bool save = false}) async {
    debugPrint(
        "Updating [Show Rewards] prefserence with new $isShowRewardsEnabled");

    log.d("Writing $isShowRewardsEnabled to prefs storage");
    //      await widget.preferences
    //          .put(Vault.prefsShowRewards, isShowRewardsEnabled);
    selectedAccount.showRewards = isShowRewardsEnabled;
    selectedAccount.save();

    setState(() {
      this.showRewards = isShowRewardsEnabled;
    });
  }

  void updateLanguage(Locale updatedLocale, {bool save = false}) {
    log.d("Updating language with new $updatedLocale, save mode -> $save");
    if (save) {
      log.d("Writing $updatedLocale to prefs storage");
      widget.preferences.locale = updatedLocale.languageCode;
      widget.preferences.save();
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

  void checkAccountsBox() async {
    try {
      selectedAccount = Hive.box<Account>(accountsBox).getAt(0);
    } on HiveError catch (e) {}
  }

  void loadAccount({Account account}) async {
    Box<Account> box = Hive.box<Account>(accountsBox);
    var _ = (account == null) ? box.getAt(box.length - 1) : account;
    setState(() {
      this.selectedAccount = _;
    });
  }

  void updateInviter(String referalInviter) {
    setState(() {
      this.referalInviter = referalInviter;
    });
  }

  Future<AddressData> loadAddressData({String address}) async {
    log.d("Fetching address data for state container");
    final data =
        await injector.get<MinterRest>().fetchAddressData(address: address);
    setState(() {
      this.addressData = data;
    });
  }

  void loadAdditionals() async  {
   //  final balances =
   // // await injector.get<MinterRest>().fetchAddressData(address: selectedAccount.address);
   //
   //  setState(() {
   //    this.addressData = balances;
   //  });
  }

  void loadNotifications() {
    injector.get<MinterRest>().fetchNotifications().then((value) => {
          Hive.box<AdminNotification>(notificationsBox)
              .addAll((value).notifications)
        });
  }



}
