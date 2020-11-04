import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmarQueue',
      home: Scaffold(
        body:Center(
            child:Coda(number: 0,)
        ),
      ),
    );
  }
}

class Coda extends StatefulWidget {
  int number=0;
  Coda({Key key,this.number}):super(key:key);
  @override
  State<StatefulWidget>createState() => _CodaState(number);
}

class _CodaState extends State<Coda>{
  int number=0;
  _CodaState(int number){
    this.number=number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 35,
            right: 225,
            top: 150,
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

                  ),
                  width: 300,
                  height: 45,
                  child: Center(
                    child: new Text(
                      'Serviamo il numero:',textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
          left: 50,
          right: 50,
          top: 600,
            child: Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),

              child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                  color: Colors.green,
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
                height: 45,
                  child: Center(
                   child: new Text(
                      'Tra 10 minuti è il tuo turno',textAlign: TextAlign.start,
                    ),
                  ),
             ),
            ),
            ),
          ),
          Positioned(
            left: 180,
            right: 50,
            top: 80,
                child: new CircleButton(number:number,),
            ),
          Positioned(
            left: 35,
            right: 222,
            top: 375,
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

                  ),
                  width: 300,
                  height: 50,
                  child: Center(
                    child: new Text(
                      'Il tuo numero è:',textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 180,
            right: 50,
            top: 320,
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
                  height: 150,
                  child: Center(
                    child: new Text(
                      '0',textAlign: TextAlign.left, style: TextStyle(fontSize: 51.0, color: Colors.black,),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            top: 680,
            child: FlatButton(
              textColor: Colors.black,
              color: Colors.red,
              onPressed: () {
                // Respond to button press
              },
              child: Text("Lascia la coda"),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              shape: StadiumBorder(
                side: BorderSide(color: Colors.black38, width: 2,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {

  final int number;
  const CircleButton({Key key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 180.0;

    return new InkResponse(
      child: new Container(
          width: size,
          height: size,
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

          child: Center(
            child: new Text(
              number.toString(), textScaleFactor: 4.0,
            ),
          )
      ),
    );
  }
}