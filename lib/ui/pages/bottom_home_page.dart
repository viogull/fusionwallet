import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popup_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/accounts_page.dart';
import 'package:fusion_wallet/ui/providers/bottom_navigation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'auth/account_creation_page.dart';
import 'auth/biometric_features_page.dart';
import 'auth/passphrase/scan_qr_page.dart';
import 'auth/password_creation_page.dart';
import 'auth/recover_account_page.dart';
import 'auth/terms_conditions_page.dart';
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
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationProvider>(context);
    final ThemeData theme = Theme.of(context);
    return Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SvgPicture.asset(
          "assets/images/backgrounds/bg_primary.svg",
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        drawerScrimColor: theme.primaryColor,
        body: NestedScrollView(
          body: Stack(
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
                    backgroundColor: theme.colorScheme.primary,
                    selectedItemColor: theme.colorScheme.onPrimary,
                    unselectedItemColor:
                        theme.colorScheme.onPrimary.withOpacity(0.6),
                    iconSize: 30,
                    elevation: 8,
                    type: BottomNavigationBarType.fixed,
                    items: _bottomBarItems(context, theme),
                  ),
                ),
              )
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  elevation: 4,
                  stretch: true,
                  floating: true,
                  pinned: false,
                  primary: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: theme.colorScheme.primary,
                  centerTitle: false,
                  title: Text(
                    AppLocalizations.of(context).inputAccountNameHintText(),
                    style: GoogleFonts.notoSans()
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              ),
            ];
          },
        ),
        drawer: _buildFusionDrawer(context, [
          DrawerItem("", Icon(Icons.add_shopping_cart)),
          DrawerItem(
              AppLocalizations.of(context).menuItemShowQR(),
              _buildBottomNavItemIcon(
                  "assets/images/icons/ic_qrcodescan.svg", false)),
          DrawerItem(
              AppLocalizations.of(context).menuItemSetDefaults(),
              _buildBottomNavItemIcon(
                  "assets/images/icons/ic_default_settings.svg", true)),
          DrawerItem(
              AppLocalizations.of(context).menuItemViewPassphrase(),
              _buildBottomNavItemIcon(
                  "assets/images/icons/ic_passwordellipse.svg", true)),
          DrawerItem(AppLocalizations.of(context).menuItemEditAccountName(),
              _buildBottomNavItemIcon("assets/images/icons/ic_edit.svg", true)),
          DrawerItem(
              AppLocalizations.of(context).menuItemRemoveAccount(),
              _buildBottomNavItemIcon(
                  "assets/images/icons/ic_folder.svg", true)),
          DrawerItem(
              AppLocalizations.of(context).menuItemWithdrawFunds(),
              _buildBottomNavItemIcon(
                  "assets/images/icons/ic_withdraw.svg", true)),
          DrawerItem(AppLocalizations.of(context).menuItemReferalLink(),
              Icon(Icons.content_copy)),
        ]),
      ),
    ]);
  }

  Widget _buildDrawerBody(BuildContext context) => Column(
        children: <Widget>[
          _buildDrawerItem(context, 'AccountsPage', AccountsPage.navId),
          _buildDrawerItem(context, 'AccountCreationNamePage',
              AccountCreationNamePage.navId),
          _buildDrawerItem(
              context, 'RecoverAccountPage', RecoverAccountPage.navId),
          _buildDrawerItem(
              context, 'TermsConditionsPage', TermsConditionsPage.navId),
          _buildDrawerItem(
              context, 'PasswordCreationPage', PasswordCreationPage.navId),
          _buildDrawerItem(
              context, 'Biometric Feature', BiometricAuthPage.navId),
          _buildDrawerItem(
              context, 'Passphrase Creation', PassphraseCreationPage.navId),
          _buildDrawerItem(
              context, 'Share Passphrase QR', PassphraseShareQrPage.navId),
          _buildDrawerItem(context, 'Scan QR', ScanQrPage.navId),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text('Show Passphrase Verified Popup'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (_) {
                    return PopupDialogWidget(
                        AppLocalizations.of(context).popupPassVerifiedTitle(),
                        "assets/images/icons/ic_taskdone.svg",
                        AppLocalizations.of(context).popupPassVerifiedBody());
                  },
                  fullscreenDialog: true));
            },
          )
        ],
      );

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

  Widget _buildDrawerItem(
      BuildContext context, String text, String navigationId) {
    return ListTile(
      title: Text(text),
      onTap: () {
        Navigator.of(context).pushNamed(navigationId);
      },
    );
  }

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
                  return _buildFusionDrawerItem(
                      context, items[index].title, items[index].icon);
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

  _buildFusionDrawerItem(BuildContext context, String title, Widget icon,
          [String navigationId]) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: icon,
            ),
            Flexible(
                flex: 7,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                ))
          ],
        ),
      );
}

class DrawerItem {
  final String title;
  final Widget icon;
  DrawerItem(this.title, this.icon);
}
