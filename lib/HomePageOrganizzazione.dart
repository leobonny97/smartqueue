import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SmarQueue';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Scaffold(
        body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 36, 63, 254),
                          Color.fromARGB(255, 193, 121, 197),
                          Color.fromARGB(255, 255, 144, 35)
                        ]
                    )
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 35, left: 130, right: 130),
                                  child: Image.asset(
                                    "assets/images/Logo1.png",
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print("ButtonVisualizzaMembri clicked ");
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Visualizza Membri",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                        shape: StadiumBorder(
                                          side: BorderSide(color: Colors.white, width: 1),
                                        ),
                                      ),
                                    )
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print("ButtonAggiungiMembri clicked ");
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Aggiungi Membri",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                        shape: StadiumBorder(
                                          side: BorderSide(color: Colors.white, width: 1),
                                        ),
                                      ),
                                    )
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print("ButtonMostraQRcode clicked ");
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Mostra QR code",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                        shape: StadiumBorder(
                                          side: BorderSide(color: Colors.white, width: 1),
                                        ),
                                      ),
                                    )
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print("ButtonGestisciCoda clicked ");
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Gestisci coda",
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                        shape: StadiumBorder(
                                          side: BorderSide(color: Colors.white, width: 1),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                  ),
                ),
              ),
            ]
        )
    );
  }
}





