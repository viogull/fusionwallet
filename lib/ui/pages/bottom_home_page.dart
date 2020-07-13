import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/components/custom/passphrase_view.dart';
import 'package:fusion_wallet/ui/pages/auth/change_account_name.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_remove_account.dart';
import 'package:fusion_wallet/ui/pages/accounts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../components/fusion_sheet.dart';
import 'lockscreen/lockscreen.dart';
import 'primary/contacts/add_contact.dart';
import 'primary/contacts/contacts_page.dart';
import 'primary/exchange_page.dart';
import 'primary/history_page.dart';
import 'primary/settings_page.dart';
import 'primary/share_address.dart';
import 'v2/bloc.dart';

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
      appBar: SliverAppBar(
        elevation: 4,
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
                  builder: (_) => PassphraseViewWidget(),
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
    String title = StateContainer.of(context).selectedAccount.name;
    switch (index) {
      case 0:
        title = StateContainer.of(context).accountName;
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
                                color: Theme.of(context).colorScheme.surface),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, top: 8),
                              child: Text(
                                  AppLocalizations.of(context).appName(),
                                  style: GoogleFonts.poppins().copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.onPrimary,
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
          Icon(
            Icons.account_balance_wallet,
            size: 8,
          ),
          Text(
            _getToolbarTitle(context, currentIndex),
            style: GoogleFonts.firaSansCondensed().copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold),
          ),
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
