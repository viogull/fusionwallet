
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
import 'package:fusion_wallet/ui/pages/information/add_contact_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_history_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.title}) : super(key: key);
  final String title;
  static const String navId = '/ContactsPage';
  @override
  _ContactsPageState createState() => new _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {


  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //DateTime selectedDate = DateTime.now();

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final labelAccount = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        'No Conract Found',
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final buttonResult = Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child:  Expanded( //Expanded is used so that all the widget get fit into the available screen
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, i) => SizedBox(
            height: 120.0,
            child:  Card(
              borderOnForeground: false,
              elevation: 16,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.2, color:Colors.white),
                borderRadius: FusionTheme.borderRadius,
              ),
              margin: const EdgeInsets.only(bottom: 40, top:  0),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:8,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin:  EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                            child: SvgPicture.asset(
                              ('assets/images/icons/ic_man.svg'),
                              // color: Colors.white,
                              fit: BoxFit.fill,
                              height: 50,
                              width: 50,
                            ),
                          ),


                     Container(
                       margin:  EdgeInsets.only(top: 5, bottom:  35),
                       child: Text('Account Name',
                              textAlign: TextAlign.center,
                            ),
                     ),

                        SizedBox(height:10 ,),
                      ],
                    ),
                  ),
                  SizedBox(height:10 ,),

                ],
              ),
            ),
          ),
        ),
      ),
    );








    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
//                crossAxisAlignment: Alignment.bottomCenter,
                children: <Widget>[
                  AppBar(
                    title: Text(AppLocalizations.of(context)
                        .toolbarContactsTitle()),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                    actions: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: () => Navigator.of(context).pushNamed(AddContactPage.navId),

                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search Contacts",
                          border: OutlineInputBorder(

                              borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                    ),
                  ),
                    buttonResult,
//                  SizedBox(height: 20,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
