import 'package:flutter/material.dart';






//class Sample1 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        appBar: MyCustomAppBar(
//          height: 150,
//          defaultAppBar: true,
//        ),
//        body: Center(
//          child: FlutterLogo(
//            size: MediaQuery.of(context).size.width / 2,
//          ),
//        ),
//      ),
//    );
//  }
//}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
     //     color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: defaultAppBar
                ? AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => null,
                ),
              ],
              title: Container(
           //     color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(10),

                  ),
                ),
              ),

            )
                : _customAppBar(context),
          ),
        ),
      ],
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(3),
      child: Row(children: [
        IconButton(
          icon: Icon(Icons.arrow_back),

        ),
        Expanded(
          child: Container(
   //         color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(19),
              ),
            ),
          ),
        ),

      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}


//import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomBottomBar(),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getCustomAppBar(

      ),
    );
  }
}

_getCustomAppBar(){
  return PreferredSize(

    preferredSize: Size.fromHeight(40.0),
    child: Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),

      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.tealAccent,
            Colors.redAccent,
          ],
        ),
      ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.backspace), onPressed: (){}),
          Text('Recover from Seed', style: TextStyle(fontSize: 18),),
          SizedBox(height: 20.0),


        ],),

    ),

  );
}

