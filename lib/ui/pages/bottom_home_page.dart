import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/state_container.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_remove_account.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/accounts_page.dart';
import 'package:fusion_wallet/ui/pages/primary/share_qr_address_page.dart';
import 'package:fusion_wallet/ui/providers/bottom_navigation_provider.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../fusion_scaffold.dart';
import 'auth/passphrase/scan_qr_page.dart';
import 'information/add_contact_page.dart';
import 'primary/contacts_page.dart';
import 'primary/exchange_page.dart';
import 'primary/history_page.dart';
import 'primary/settings_page.dart';

final logger = Logger();

class BottomHomePage extends StatefulWidget {
  final String title;

  BottomHomePage({Key key, this.title}) : super(key: key);

  static const double drawerWidthRatio = 320 / 255;
  static const double drawerHeaderHeightRatio = 66 / 568;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomHomePageState();
  }
}

class _BottomHomePageState extends State<BottomHomePage> {
  final List<Widget> tabs = [
    AccountsPage(),
    ExchangePage(),
    ContactsPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationProvider>(context);

    final ThemeData theme = Theme.of(context);
    final isDarkEnabled =
        StateContainer.of(context).themeMode == ThemeMode.dark;
    final bottomBarItems = _bottomBarItems(context, theme);

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
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.set(index);
                },
                showUnselectedLabels: false,
                backgroundColor: theme.colorScheme.primary,
                selectedItemColor: theme.colorScheme.onPrimary,
                unselectedItemColor:
                    theme.colorScheme.onPrimary.withOpacity(0.6),
                selectedFontSize: 15,
                unselectedFontSize: 13,
                iconSize: 30,
                elevation: 8,
                type: BottomNavigationBarType.fixed,
                items: _bottomBarItems(context, theme),
              ),
            ),
          )
        ],
      ),
      appBar: SliverAppBar(
        elevation: 1,
        stretch: true,
        floating: true,
        pinned: false,
        primary: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          _getToolbarTitle(context, provider.currentIndex),
          style: GoogleFonts.roboto().copyWith(
              color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold),
        ),
        actions: (provider.currentIndex == 2)
            ? <Widget>[
                new IconButton(
                  icon: new Icon(Icons.add),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AddContactPage.navId),
                ),
              ]
            : [],
        iconTheme: FusionTheme.iconThemeColored
            .copyWith(color: theme.colorScheme.primary),
      ),
      drawer: _buildFusionDrawer(context, [
        DrawerItem(title: "", icon: Icon(Icons.add_shopping_cart)),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemShowQR(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_qrcodescan.svg", true),
            onClick: () {
              Navigator.pushNamed(context, ShareQrPage.navId);
            }),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemSetDefaults(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_default_settings.svg", true),
            onClick: () {}),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemViewPassphrase(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_passwordellipse.svg", true),
            onClick: () {
              Navigator.pushNamed(context, ScanQrPage.navId);
            }),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemEditAccountName(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_edit.svg", true),
            onClick: () {
              Navigator.pushNamed(context, ScanQrPage.navId);
            }),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemRemoveAccount(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_folder.svg", true),
            onClick: () {
              showPlatformDialog(
                  context: context,
                  builder: (context) => PopupsRemoveAccount());
            }),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemWithdrawFunds(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_withdraw.svg", true),
            onClick: () {
              Navigator.pushNamed(context, ScanQrPage.navId);
            }),
        DrawerItem(
            title: AppLocalizations.of(context).menuItemReferalLink(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_copy.svg", true),
            onClick: () {
              Navigator.pushNamed(context, ScanQrPage.navId);
            }),
      ]),
    );
  }

  String _getToolbarTitle(BuildContext context, int index) {
    String title = "";

    switch (index) {
      case 0:
        title = AppLocalizations.of(context).toolbarNewAccountTitle();
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
        title = AppLocalizations.of(context).appName();
    }

    return title;
  }

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
                    ? Colors.white
                    : Theme.of(context).colorScheme.onPrimary,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: PlatformCircularProgressIndicator())),
          ),
        ),
      );

  _buildFusionDrawer(BuildContext context, List<DrawerItem> items) => Drawer(
        child: Container(
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
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "AccountName",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                      ),
                    ),
                  );
                else {
                  return _buildFusionDrawerItem(context, items[index]);
                }
              },
              separatorBuilder: (context, index) {
                if (index == 0) {
                  return Container();
                } else
                  return Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Divider(
                      color: Theme.of(context).colorScheme.onSurface,
                      thickness: 0.25,
                    ),
                  );
              },
              itemCount: items.length),
        ),
      );

  _buildFusionDrawerItem(BuildContext context, DrawerItem item,
          [String navigationId]) =>
      GestureDetector(
        onTap: () {
          item.onClick.call();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: item.icon,
              ),
              Flexible(
                  flex: 7,
                  child: Text(
                    item.title,
                    textAlign: TextAlign.left,
                  ))
            ],
          ),
        ),
      );
}

typedef DrawerItemClickCallback = void Function();

class DrawerItem {
  final String title;
  final Widget icon;
  final DrawerItemClickCallback onClick;
  DrawerItem({this.title, this.icon, @required this.onClick});
}
