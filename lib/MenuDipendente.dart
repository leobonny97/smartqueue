import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        backgroundColor: Colors.orange,
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.orange,
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: () {
                      //ancora niente
                    },
                    color: Colors.blue,
                    elevation: 10,
                    child: Text("Gestisci coda", style: TextStyle(fontSize: 20, color: Colors.white),),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: () {
                      //ancora niente
                    },
                    color: Colors.blue,
                    elevation: 10,
                    child: Text("Mostra QR Code", style: TextStyle(fontSize: 20, color: Colors.white),),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }


}