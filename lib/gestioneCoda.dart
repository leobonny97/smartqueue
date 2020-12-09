

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/Service/gestioneCodaService.dart';


final firestoreInstance = FirebaseFirestore.instance;
int prossimo;
String id_organizzazione;
String num;
String id_elemento_in_coda;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prossimo= await gestioneCodaService().prossimo_da_servire();
  print(prossimo);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String barcode;
  String id_coda;
  MyApp({Key key, @required this.barcode, @required this.id_coda}):super(key: key);


  Widget build(BuildContext context) {

    List<String> split=barcode.split(" ");
    id_organizzazione = split[0];
    num = split[1];
    id_elemento_in_coda = id_coda;

    firestoreInstance.collection("organizzazioni").doc('id_organizzazione').collection("Coda").snapshots().listen((event) {
      event.docChanges.forEach((element)  async {
        if(element.type == DocumentChangeType.modified){
          prossimo= await gestioneCodaService().prossimo_da_servire();
          print(prossimo);
          //Route route = MaterialPageRoute(builder: (context) => MyApp());
          //Navigator.push(context, route);
          runApp(MyApp());
        }
      });
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void change() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
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
                    left: 120,
                    right: 120,
                    top: 65,
                    child: Text("Il prossimo è:",
                      style: TextStyle(fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                    ),
                  ),

                  Positioned(
                    left: 50,
                    right: 50,
                    top: 100,
                    child: new CircleButton(number: prossimo,),
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
                        "Acquisisci numero",
                        style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.bold,),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 2,),
                      ),
                    ),
                  ),
                ],
              )
          );
        }
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