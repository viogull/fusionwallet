import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/information/transanction_history_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popup_page.dart';
import 'package:fusion_wallet/ui/providers/bottom_navigation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'auth/account_creation_page.dart';
import 'auth/biometric_features_page.dart';
import 'auth/intro_page.dart';
import 'auth/passphrase/scan_qr_page.dart';
import 'auth/password_creation_page.dart';
import 'auth/recover_account_page.dart';
import 'auth/terms_conditions_page.dart';
import 'primary/accounts_page.dart';
import 'primary/contacts_page.dart';
import 'primary/exchange_page.dart';
import 'primary/history_page.dart';
import 'primary/settings_page.dart';

final logger = Logger();

class BottomHomePage extends StatefulWidget {
  final String title;

  BottomHomePage({Key key, this.title}) : super(key: key);

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
    return SafeArea(
      child: Stack(
        children: <Widget>[
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.primaryColor,
              centerTitle: false,
              title: Text(
                AppLocalizations.of(context).inputAccountNameHintText(),
                style: GoogleFonts.notoSans(),
              ),
              toolbarOpacity: 0.95,
            ),
            drawerDragStartBehavior: DragStartBehavior.down,
            endDrawer: Drawer(
              elevation: 32,
              child: _buildDrawerBody(context),
            ),
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
          )
        ],
      ),
    );
  }

  Widget _buildDrawerBody(BuildContext context) => Column(
        children: <Widget>[
          _buildDrawerItem(context, 'IntroPage', IntroPage.navId),
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

  Widget _buildBottomNavItemIcon(String asset) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: SvgPicture.asset(asset,
                semanticsLabel: asset,
                color: Theme.of(context).colorScheme.onPrimary,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: PlatformCircularProgressIndicator())),
          ),
        ),
      );
}
