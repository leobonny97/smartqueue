import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmarQueue',
        home: Scaffold(
          body:Center(
              child:GestioneCoda(number: 0,)
          ),

        ),
       );
  }
}

class GestioneCoda extends StatefulWidget {
  int number=0;
  GestioneCoda({Key key,this.number}):super(key:key);
  @override
  State<StatefulWidget>createState() => _GestioneCodaState(number);
}

class _GestioneCodaState extends State<GestioneCoda>{
   int number=0;
  _GestioneCodaState(int number){
    this.number=number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: <Widget>[
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
              color: Colors.green,
              onPressed: () {
                // Respond to button press
                setState(() {
                  number++;
                });
              },
              child: Text(
                "Prossimo",
                style: TextStyle(fontSize: 25.0, color: Colors.black,),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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