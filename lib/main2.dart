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
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 300,
                  height: 100,
                  child: Text('Benvenuto, \nscannerizza il qr code e partecipa alla fila'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: RaisedButton(
              onPressed: () {
                print("Button clicked");
                },
              color: Colors.blue,
              elevation: 10,
              child: Text("Avanti", style: TextStyle(fontSize: 20, color: Colors.white),),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              shape: StadiumBorder(
                side: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
        ],
      )
    );
  }
}