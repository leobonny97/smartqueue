import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartQueue',
      home: Scaffold(
        body:Center(
            child:Coda(number: 2,)
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

          Positioned(
            top: 145,
            right: 100,
            left: 100,
            child: Center(
              child: new Text(
                      'Il tuo numero è',textAlign: TextAlign.start,
                style: TextStyle(fontSize: 22.0, color: Colors.white,fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          Positioned(
            left: 100,
            right: 100,
            top: 180,
            child: new CircleButton(number:number,),
          ),
          //card remaining time and current number
          Positioned(
            left: 5,
            right: 5,
            top: 550,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.timelapse,size: 72.0),
                    title: Text('Stiamo servendo il numero: 1'),
                    subtitle: Text('Tempo di attesa stimato: 5 minuti'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Abbandona la coda',
                           style: TextStyle(color: Colors.red,
                           ),
                          ),
                          onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
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
          ),
      ),
    );
  }
}