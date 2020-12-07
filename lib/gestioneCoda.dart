import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:io';


class Counter extends StatefulWidget {
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int val;


  void initState() {
    super.initState();
    val = 0;
  }

  void change() {
    final firestoreInstance = FirebaseFirestore.instance;
    int length = 0;
    List<int>arr_number = new List<int>();

    firestoreInstance.collection('organizzazioni').doc('zOavHmvgeGNM0IiVbtY0')
        .collection("Coda").get()
        .then((querySnapshot) {
      length = querySnapshot.docs.length;
      querySnapshot.docs.forEach((result) {
        arr_number.add(result.data()['numero']);
      });
      //print(arr_number.length);
      setState(() {
        val=arr_number[0];
      });
    });

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
            child: new CircleButton(number:val,),
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
                change();
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


class MyApp_gestioneCoda extends StatelessWidget {
  final String id_organizzazione;
  MyApp_gestioneCoda({Key key, @required this.id_organizzazione}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          child: Counter(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp_gestioneCoda());
}
