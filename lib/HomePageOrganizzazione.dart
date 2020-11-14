import 'package:flutter/material.dart';
import 'package:smartqueue/QR.dart';

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
        body: HomePageOrganizzazione(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class HomePageOrganizzazione extends StatelessWidget {
  HomePageOrganizzazione({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.orange,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 120,
              right: 50,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                  print("ButtonVisualizzaMembri clicked");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Visualizza Membri", style: TextStyle(fontSize: 25, color: Colors.white),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            Positioned(
              top: 250,
              right: 50,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                  print("ButtonAggiungiMembri clicked");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Aggiungi Membri", style: TextStyle(fontSize: 25, color: Colors.white),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            Positioned(
              bottom: 250,
              right: 50,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                  print("ButtonMostraQR clicked");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Mostra QR code", style: TextStyle(fontSize: 25, color: Colors.white),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 50,
              left: 50,
              child: RaisedButton(
                onPressed: () {
                  print("ButtonGestisciCoda clicked");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Gestisci coda", style: TextStyle(fontSize: 25, color: Colors.white),),
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