import 'package:flutter/material.dart';

// void main() => runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     )
// );

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height /1.6  ,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/backgrounds/bg_greeting.png'),
                      fit: BoxFit.fill
                  )
              ),
                child:  Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 200),
                    child: Center(
                      child: Text("LOGO", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Container(
                    //	margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text("Some greeting text", style: TextStyle(color: Colors.black, fontSize: 14),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: Center(
                      child: Text("Some greeting text", style: TextStyle(color: Colors.black, fontSize: 14),),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[

                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ]
                        )
                    ),
                      child: RaisedButton(
                        //onPressed: () {},
                        child: Center(
                          child:  Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),

                  Text("Already have an account?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
                  SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      height: 50,
                      child:  RaisedButton(
                          //onPressed: () {},
                          child: Center(
                            child: Text(
                          "RECOVERY FROM PASSPHRASE",
                          style: TextStyle(color: Colors.white),),
                        ),
                      ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}