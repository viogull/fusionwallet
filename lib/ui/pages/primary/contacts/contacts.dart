import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/pages/primary/contacts/contact_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'add_contact.dart';
export 'contacts.dart';

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

    return ValueListenableBuilder(
      valueListenable: Hive.box<Contact>(contactsBox).listenable(),
      builder: (context, Box<Contact> contacts, _) {
        final _contacts = contacts.values.toList();

        return Container(

            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.99,
            ),
            child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
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
                      child: AnimationLimiter(
                        child:(_contacts.isEmpty)
                            ? showEmptyView(context)
                            : ListView.builder(
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              child: FadeInAnimation(
                                  duration: Duration(milliseconds: 500),
                                  child: ContactItem(data: _contacts[index])
                              ),
                            );
                          },
                          physics: ClampingScrollPhysics(),
                          itemCount: _contacts.length,
                        ) ,
                      )
                  )
                ]));
      },
    );
  }

  Widget showEmptyView(BuildContext context) =>
      Center(child: Text(AppLocalizations.of(context).noContactsTitle()));
}
