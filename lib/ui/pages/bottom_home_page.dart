import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/providers/bottom_navigation_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationProvider>(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).inputAccountNameHintText()),
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: _buildDrawerBody(),
      ),
      body: tabs[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        items: _bottomBarItems(context, theme),
      ),
    );
  }

  Widget _buildDrawerBody() => ListView(
        children: <Widget>[],
      );

  List<BottomNavigationBarItem> _bottomBarItems(
          BuildContext context, ThemeData theme) =>
      [
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationLabelAccounts()),
            icon: Icon(Icons.account_box)),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationLabelExchange()),
            icon: Icon(Icons.account_balance)),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemHistory()),
            icon: Icon(Icons.account_box)),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemContacts()),
            icon: Icon(Icons.contacts)),
        BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).navigationItemSettings()),
            icon: Icon(Icons.settings)),
      ];

  static buildBody() {}
}
