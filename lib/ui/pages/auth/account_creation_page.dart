import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
);

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Center(
//        backgroundColor: Colors.transparent,

        child: SvgPicture.asset('assets/images/backgrounds/ic_man.svg'),
      ),
    );

    final email =  Container(

      child: Center(
        child:   TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Please, name your account',

          ),
        ),

      ),

    );




    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        padding: EdgeInsets.all(12),
        color: Colors.blue,
        child: Text('NEXT', style: TextStyle(color: Colors.white)),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 24.0),
            loginButton,

          ],
        ),
      ),
    );
  }
}
//  Widget build(BuildContext context) {
//
//
//    return Scaffold(
//      appBar: AppBar (
//        title: Text('New Account'),
//      ),
//    body: Container(
//      height: MediaQuery.of(context).size.height ,
//      width: MediaQuery.of(context).size.width,
//      child:
//          Container(
//      child :  Stack(
//        children: <Widget> [
//
//          Container(
//            child: Center(
//              child: Image.asset('assets/images/backgrounds/bg_greeting.png'),
//            ),
//
//          ),
//          SizedBox(height: 50,),
//          Text ('Account Name:', textAlign: TextAlign.left)  ,
//
//           SizedBox(height: 50,),
//           Container(
////             height: 800,
////               width: 300,
//               child: Center(
//                 child:   TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Please, name your account',
//
//                   ),
//                 ),
//
//               ),
//
//           ),
//
//        ]
////       Center(
////
////            child: Image.asset('assets/images/icons/ic_man.svg'),
////          ),
//
//          ),
//
//
//          ),
//
//
//
//
//    ),
//    );
//  }
