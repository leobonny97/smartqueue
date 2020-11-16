import 'package:flutter/material.dart';


class GestioneCoda extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmartQueue',
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body:Stack(
              children: <Widget>[
                Center(
                    child:_GestioneCoda(number: 0,),
                ),
            ],
          ),
        ),
       );
  }
}

class _GestioneCoda extends StatefulWidget {
  int number=0;
  _GestioneCoda({Key key,this.number}):super(key:key);
  @override
  State<StatefulWidget>createState() => _GestioneCodaState(number);
}

class _GestioneCodaState extends State<_GestioneCoda>{
   int number=0;
  _GestioneCodaState(int number){
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
            left: 90,
            right: 0,
            top: 65,
            child: Text("Il cliente servito è",
              style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.bold,),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            top: 100,
            child: new CircleButton(number:number,),
          ),
          Positioned(
            left: 50,
            right: 50,
            top: 400,
            child: FlatButton(
              textColor: Colors.black,
              color: Colors.transparent,
              onPressed: () {
                // Respond to button press
                setState(() {
                  number++;
                });
              },
              child: Text(
                "Prossimo",
                style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.bold,),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              shape: StadiumBorder(
                side: BorderSide(color: Colors.white, width: 2,),
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
                color: Colors.grey.withOpacity(0.5),
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