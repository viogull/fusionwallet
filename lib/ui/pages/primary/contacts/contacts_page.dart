import 'package:flutter/material.dart';

import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/primary/contacts/contact_item.dart';
import 'package:random_string/random_string.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.title}) : super(key: key);
  final String title;
  static const String navId = '/contacts';
  @override
  _ContactsPageState createState() => new _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = [];
  var items = List<Contact>();

  void filterSearchResults(String query) {
    List<Contact> dummySearchList = List<Contact>();
    dummySearchList.addAll([]);
    if (query.isNotEmpty) {
      List<Contact> dummyListData = List<Contact>();
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll([]);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var loadContacts = StateContainer.of(context).selectedAccount.contacts;

    items.addAll(loadContacts == null ? [] : loadContacts);

    return FusionScaffold(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .inputSearchContactHint(),
                            hintText: AppLocalizations.of(context)
                                .inputSearchContactHint(),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)))),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: (items.isEmpty)
                        ? showEmptyView(context)
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ContactItem(data: items[index]);
                            },
                            itemCount: items.length,
                          ),
                  )
                ])));
  }

  Widget showEmptyView(BuildContext context) =>
      Center(child: Text(AppLocalizations.of(context).noContactsTitle()));
}
