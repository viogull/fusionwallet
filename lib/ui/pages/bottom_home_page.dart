import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/account_name.dart';
import 'package:fusion_wallet/ui/pages/auth/change_account_name.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/auth/splash.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_remove_account.dart';
import 'package:fusion_wallet/ui/pages/accounts_page.dart';
import 'package:fusion_wallet/ui/pages/v2/ui.dart';
import 'package:fusion_wallet/ui/providers/bottom_navigation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_dialog.dart';

import '../components/fusion_sheet.dart';
import 'auth/passphrase/passphrase_widget.dart';
import '../components/custom/passphrase_view.dart';
import 'primary/contacts/add_contact.dart';
import 'primary/contacts/contacts_page.dart';
import 'primary/exchange_page.dart';
import 'primary/history_page.dart';
import 'primary/settings_page.dart';
import 'primary/share_address.dart';

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
    return FusionScaffold(
      child: SafeArea(
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
            ? [
                IconButton(
                    icon: new Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddContactPage(),
                          fullscreenDialog: true));
                    })
              ]
            : [],
        iconTheme: FusionTheme.iconThemeColored
            .copyWith(color: theme.colorScheme.primary),
      ),
      drawer: _buildFusionDrawer(context, [
        DrawerItemData(title: "", icon: Icon(Icons.add_shopping_cart)),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemShowQR(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_qrcodescan.svg", true),
            onClick: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => ShareAddressPage(
                      "Mx${StateContainer.of(context).selectedAccount.address}"),
                  fullscreenDialog: true));
            }),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemSetDefaults(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_default_settings.svg", true),
            navId: LockUi.navId),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemViewPassphrase(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_passwordellipse.svg", true),
            onClick: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SlideDialog(
                      backgroundColor: theme.colorScheme.background,
                      pillColor: theme.colorScheme.primaryVariant,
                      child: PassphraseViewWidget()),
                  fullscreenDialog: true));
            }),
        DrawerItemData(
          title: AppLocalizations.of(context).menuItemEditAccountName(),
          icon:
              _buildBottomNavItemIcon("assets/images/icons/ic_edit.svg", true),
          onClick: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChangeAccountNameDialog(),
                fullscreenDialog: false));
          },
        ),
        DrawerItemData(
            title: AppLocalizations.of(context).menuItemRemoveAccount(),
            icon: _buildBottomNavItemIcon(
                "assets/images/icons/ic_folder.svg", true),
            onClick: () {
              Sheets.showFusionBottomSheet(
                  context: context, widget: PopupsRemoveAccount());
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
            navId: LockUi.navId),
      ]),
    );
  }

  String _getToolbarTitle(BuildContext context, int index) {
    String title = "";

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
        title = AppLocalizations.of(context).appName();
    }

    return (title == null) ? AppLocalizations.of(context).appName() : title;
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
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
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
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context).appName(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ),
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            thickness: 0.25,
                          ),
                        );
                    },
                    itemCount: items.length),
              )
            ],
          ),
        ),
      );
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
    // TODO: implement build
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
