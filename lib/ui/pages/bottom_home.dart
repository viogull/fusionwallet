import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/accounts.dart';
import 'package:fusion_wallet/ui/pages/auth/change_account_name.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_remove_account.dart';
import 'package:fusion_wallet/ui/pages/show_passphrase.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/flasher.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:fusion_wallet/utils/io_tools.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import './../../ui/pages/pages.dart';
import '../../inject.dart';
import 'auth/intro.dart';
import 'auth/share_passphrase.dart';
import 'auth/lockscreen.dart';

import 'auth/splash.dart';
import 'contacts/contacts.dart';
import 'exchange_page.dart';
import 'history_page.dart';
import 'settings.dart';
import 'share_address.dart';

final logger = Logger();

class BottomHomePage extends StatefulWidget {
  final String title;

  BottomHomePage({Key key, this.title}) : super(key: key);

  static const double drawerWidthRatio = 320 / 255;
  static const double drawerHeaderHeightRatio = 66 / 568;

  @override
  State<StatefulWidget> createState() {
    return _BottomHomePageState();
  }
}

class _BottomHomePageState extends State<BottomHomePage> {
  Account _account;

  final List<Widget> tabs = [
    AccountsPage(),
    ExchangePage(),
    ContactsPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    if (_account == null) {
      Box<Account> box = Hive.box<Account>(accountsBox);
      _account = box.getAt(box.length - 1);
      logger.d("Account is ${_account.name}");
      Future.delayed(const Duration(milliseconds: 300), () {
        StateContainer.of(context).loadAccount(account: _account);
      });
    }
    loadDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationProvider>(context);

    final ThemeData theme = Theme.of(context);
    return FusionScaffold(
      child: Stack(
        children: <Widget>[
          tabs[provider.currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.set(index);
                },
                showUnselectedLabels: true,
                backgroundColor: theme.colorScheme.primary,
                selectedItemColor: theme.colorScheme.onPrimary,
                unselectedItemColor:
                    theme.colorScheme.onPrimary.withOpacity(0.6),
                selectedFontSize: 13,
                unselectedFontSize: 12,
                iconSize: 30,
                elevation: 8,
                type: BottomNavigationBarType.fixed,
                items: _bottomBarItems(context, theme),
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: buildToolbarTitle(context, provider.currentIndex),
        actions: _buildToolbarActions(context, provider.currentIndex),
        iconTheme: FusionTheme.iconThemeColored
            .copyWith(color: theme.colorScheme.primary),
      ),
      drawer: _buildFusionDrawer(context, [
        DrawerItemData(title: "", icon: Icon(Icons.add_shopping_cart)),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemShowQR(),
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Icon(
                AntDesign.qrcode,
                size: 22,
              ),
            ),
            onClick: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context, controller) {
                    return ShareAddressPage(
                        "${StateContainer.of(context).selectedAccount.address}");
                  });
            }),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemSetDefaults(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_default_settings.svg", true),
            navId: LockUi.navId),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemViewPassphrase(),
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Icon(FontAwesome.user_secret),
            ),
            onClick: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (BuildContext context, ScrollController controller) {
                    return ShowPassphraseUi(
                        mnemonic: StateContainer.of(context)
                            .selectedAccount
                            .mnemonic);
                  });
            }),
        DrawerItemData(
          title: AppLocalizations.of(context).menuItemEditAccountName(),
          icon:
              _buildBottomNavItemIcon("assets/images/icons/ic_edit.svg", true),
          onClick: () {
            showBarModalBottomSheet(
                context: context,
                elevation: 24,
                builder: (BuildContext context, ScrollController controller) {
                  return ChangeAccountNameForm();
                });
          },
        ),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemRemoveAccount(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_folder.svg", true),
            onClick: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (BuildContext context, ScrollController controller) {
                    return PopupsRemoveAccount(onClearSelected: () async {
                      await injector.get<Vault>().deleteAll();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AuthUi.navId,
                          (route) => (route.settings.name == Splash.navId));
                    });
                  });
            }),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemWithdrawFunds(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_withdraw.svg", true),
            navId: LockUi.navId),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemReferalLink(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_copy.svg", true),
            onClick: () async {
              injector.get<HapticUtil>().selection();
              final link = await _createDynamicLink(
                  true, StateContainer.of(context).selectedAccount.address);
              logger.d("Link ${link as dynamic}");
              IOTools.setSecureClipboardItem((link as dynamic).toString());

              FlashHelper.successBar(context,
                  message: AppLocalizations.of(context).pushLinkWasCopied());
            }),
      ]),
    );
  }

  void loadDynamicLinks() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;

    if (deepLink != null) {
      logger.d('Deeplink attached ', deepLink);
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _createDynamicLink(bool short, String address) async {
    final host = Uri.parse('https://fusiongroup.page.link/promo/Mx$address');
    logger.d("Deeplink pre -> $host");
    final params = DynamicLinkParameters(
      uriPrefix: 'https://fusiongroup.page.link',
      link: host,
      androidParameters: AndroidParameters(
        packageName: "com.fusiongroup.fusion.wallet",
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: "com.fusiongroup.wallet",
        minimumVersion: '0',
      ),
    );
    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await params.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await params.buildUrl();
    }
    return url.toString();
  }

  String _getToolbarTitle(BuildContext context, int index) {
    String title = StateContainer.of(context).selectedAccount.name;
    switch (index) {
      case 0:
        title = StateContainer.of(context).selectedAccount.name;
        break;
      case 1:
        title = AppLocalizations.of(context).toolbarExchangeTitle();
        break;
      case 2:
        title = AppLocalizations.of(context).toolbarContactsTitle();
        break;
      case 3:
        title = AppLocalizations.of(context).toolbarHistoryTitle();
        break;
      case 4:
        title = AppLocalizations.of(context).navigationItemSettings();
        break;
      default:
        title = StateContainer.of(context).selectedAccount.name;
    }
    debugPrint("Title $title");
    return (title == null)
        ? StateContainer.of(context).selectedAccount.name
        : title;
  }

  Future<String> buildReferalLink(bool short) async {
    final params = DynamicLinkParameters(
      uriPrefix: '',
      link: Uri.parse('https://fusion-push.cash/ref?id=' +
          StateContainer.of(context).selectedAccount.publicKey),
      androidParameters: AndroidParameters(
        packageName: "com.fusiongroup.fusion.wallet",
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: "com.fusiongroup.wallet",
        minimumVersion: '0',
      ),
    );
    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await params.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await params.buildUrl();
    }
    debugPrint("Referal Url created ${url.toString()}");
    return url.toString();
  }

  String buildReferal(BuildContext context) =>
      "https://fusion-push.cash/ref/${StateContainer.of(context).selectedAccount.address}";

  List<BottomNavigationBarItem> _bottomBarItems(
          BuildContext context, ThemeData theme) =>
      [
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationLabelAccounts()),
            icon:
                _buildBottomNavItemIcon("assets/images/icons/ic_accounts.svg")),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationLabelExchange()),
            icon:
                _buildBottomNavItemIcon("assets/images/icons/ic_exchange.svg")),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemContacts()),
            icon:
                _buildBottomNavItemIcon("assets/images/icons/ic_contacts.svg")),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemHistory()),
            icon:
                _buildBottomNavItemIcon("assets/images/icons/ic_history.svg")),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemSettings()),
            icon:
                _buildBottomNavItemIcon("assets/images/icons/ic_settings.svg")),
      ];

  Widget _buildBottomNavItemIcon(String asset, [bool isDrawerIcon = false]) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: SvgPicture.asset(asset,
                semanticsLabel: asset,
                color: (isDrawerIcon)
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onPrimary,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: PlatformCircularProgressIndicator())),
          ),
        ),
      );

  _buildFusionDrawer(BuildContext context, List<DrawerItemData> items) =>
      Drawer(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset(
                (StateContainer.of(context).darkModeEnabled)
                    ? "assets/images/backgrounds/bg_primary.svg"
                    : "assets/images/backgrounds/bg_primary_light.svg",
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              width: MediaQuery.of(context).size.width *
                  BottomHomePage.drawerWidthRatio,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return LimitedBox(
                        maxHeight: MediaQuery.of(context).size.height *
                            BottomHomePage.drawerHeaderHeightRatio,
                        child: DrawerHeader(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, top: 8),
                              child: Text(
                                  (StateContainer.of(context)
                                              .selectedAccount
                                              .name !=
                                          null)
                                      ? StateContainer.of(context)
                                          .selectedAccount
                                          .name
                                      : AppLocalizations.of(context).appName(),
                                  style: GoogleFonts.robotoCondensed().copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 24)),
                            )),
                      );
                    else {
                      return DrawerItem(data: items[index]);
                    }
                  },
                  separatorBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox();
                    } else
                      return Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                          thickness: 0.25,
                        ),
                      );
                  },
                  itemCount: items.length),
            )
          ],
        ),
      );

  Widget buildToolbarTitle(BuildContext context, currentIndex) {
    final theme = Theme.of(context);

    if (currentIndex == 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_getToolbarTitle(context, currentIndex),
              style: GoogleFonts.robotoCondensed()
                  .copyWith(color: theme.colorScheme.primary)),
        ],
      );
    } else
      return Text(
        _getToolbarTitle(context, currentIndex),
        style: GoogleFonts.roboto().copyWith(
            color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold),
      );
  }

  List<Widget> _buildToolbarActions(BuildContext ctx, currentIndex) {
    if (currentIndex == 2) {
      return [
        IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddContactPage(
                      acc: StateContainer.of(context).selectedAccount),
                  fullscreenDialog: true));
            })
      ];
    } else {
      return [];
    }
  }
}

typedef DrawerItemClickCallback = void Function();

class DrawerItemData {
  final String title;
  final Widget icon;
  final String navId;
  final DrawerItemClickCallback onClick;
  DrawerItemData({this.title, this.icon, this.navId, this.onClick});
}

class DrawerItem extends StatelessWidget {
  final DrawerItemData data;

  DrawerItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.data.onClick != null) {
          this.data.onClick();
        } else
          Navigator.of(context).pushNamed(data.navId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: data != null ? data.icon : Icon(Icons.error),
            ),
            Flexible(
                flex: 7,
                child: Text(
                  data != null ? data.title : "",
                  textAlign: TextAlign.left,
                ))
          ],
        ),
      ),
    );
  }
}

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  bool _isLocked = false;

  get currentIndex => _currentIndex;

  get isLocked => _isLocked;

  Future<void> setLocked(bool lock) async {
    _isLocked = lock;
    logger.d('Notifing pages about lock providing: $lock');
    notifyListeners();
  }

  Future<void> set(int index) async {
    _currentIndex = index;
    logger.d('Notifing pages about navigation to index: $index');
    notifyListeners();
  }
}
