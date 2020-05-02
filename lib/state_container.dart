import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fusion_wallet/themes.dart';
import 'package:fusion_wallet/utils/crypto.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:nanodart/nanodart.dart';
import 'package:uni_links/uni_links.dart';

import 'core/db_helper.dart';
import 'core/models/account.dart';
import 'core/models/available_currency.dart';
import 'core/models/available_language.dart';
import 'core/models/state_block.dart';
import 'service_locator.dart';
import 'utils/vault.dart';

const String prefsUiThemeMode = "prefsThemeMode";
const String prefsLanguage = "prefsLocale";

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final Box preferences;

  StateContainer({@required this.child, @required this.preferences});

  @override
  State<StatefulWidget> createState() => StateContainerState();

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class StateContainerState extends State<StateContainer> {
  final Logger log = sl.get<Logger>();
  String receiveThreshold = BigInt.from(10).pow(24).toString();

  String currencyLocale;
  Locale locale = Locale('en', '');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  BaseTheme curTheme = LightTheme();
  // Currently selected account
  Account selectedAccount =
      Account(id: 1, name: "AB", index: 0, lastAccess: 0, selected: true);
  // Two most recently used accounts
  Account recentLast;
  Account recentSecondLast;

  ThemeMode themeMode = ThemeMode.light;

  // If callback is locked
  bool _locked = false;

  // Initial deep link
  String initialDeepLink;
  // Deep link changes
  StreamSubscription _deepLinkSub;

  // This map stashes pending process requests, this is because we need to update these requests
  // after a blocks_info with the balance after send, and sign the block
  Map<String, StateBlock> previousPendingMap = Map();

  // Maps previous block requested to next block
  Map<String, StateBlock> pendingResponseBlockMap = Map();

  // Maps all pending receives to previous blocks

  Map<String, StateBlock> pendingBlockMap = Map();

  // When wallet is encrypted
  String encryptedSecret;

  @override
  void initState() {
    super.initState();
    // Register RxBus
    _registerBus();

    // Get default language setting
    final locale = widget.preferences.get(prefsLanguage);
    // Get theme default
    var preferencesTheme = widget.preferences.get(prefsUiThemeMode);
    final currentTheme =
        (preferencesTheme == null) ? ThemeMode.dark : preferencesTheme;

    final currentLocale =
        (locale == 'en') ? Locale('en', '') : Locale('ru', '');
    debugPrint(
        "Preferences Theme Selected $preferencesTheme , Theme Mode: $currentTheme");
    debugPrint(
        "Preferences Language Selected $locale , Theme Mode: $currentLocale");

    updateTheme(currentTheme);
    updateLanguage(currentLocale);
    // Get initial deep link
    getInitialLink().then((initialLink) {
      setState(() {
        initialDeepLink = initialLink;
      });
    });
    // Cache ninja API if don't already have it
  }

  // Register RX event listenerss
  void _registerBus() {
    // Balances for our accounts

    // Deep link has been updated
    _deepLinkSub = getLinksStream().listen((String link) {
      setState(() {
        initialDeepLink = link;
      });
    });
  }

  @override
  void dispose() {
    widget.preferences.close();
    super.dispose();
  }

  void updateTheme(ThemeMode theme, {bool save = false}) {
    debugPrint("Updating theme with new $theme");
    if (save) {
      debugPrint("Writing $theme to prefs storage");
      widget.preferences.put(prefsUiThemeMode, theme);
    }
    setState(() {
      themeMode = theme;
    });
  }

  void updateLanguage(Locale updatedLocale, {bool save = false}) {
    debugPrint("Updating language with new $updatedLocale");
    if (save) {
      debugPrint("Writing $updatedLocale to prefs storage");
      widget.preferences.put(prefsLanguage, updatedLocale.countryCode);
    }
    setState(() {
      locale = updatedLocale;
    });
  }

  void logOut() {
    setState(() {
      // wallet = AppWallet();
      encryptedSecret = null;
    });
    sl.get<DBHelper>().dropAccounts();
  }

  Future<String> _getPrivKey() async {
    String seed = await getSeed();
    return await CryptoUtil()
        .seedToPrivateInIsolate(seed, selectedAccount.index);
  }

  Future<String> getSeed() async {
    String seed;
    if (encryptedSecret != null) {
      seed = NanoHelpers.byteToHex(NanoCrypt.decrypt(
          encryptedSecret, await sl.get<Vault>().getSessionKey()));
    } else {
      seed = await sl.get<Vault>().getSeed();
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
}
