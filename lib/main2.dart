import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

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
      body: Container(
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
              child: Text('Benvenuto'),
            ),
          ),
        ),
      ),

    );
  }
}