import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartqueue/gestioneCoda.dart';
import 'package:smartqueue/homepage.dart';

final firestoreInstance = FirebaseFirestore.instance;
String num;
String id_elemento_in_coda;
bool is_servito;


class MyApp_servire extends StatelessWidget {
  // This widget is the root of your application.
  String id_prossimo;
  String num;
  MyApp_servire({Key key,@required this.id_prossimo, @required this.num}):super(key: key);


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(id_elemento_in_coda: id_prossimo, numeroAcquisito: num,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String id_elemento_in_coda;
  String numeroAcquisito;
  MyHomePage({Key key, @required this.id_elemento_in_coda, @required this.numeroAcquisito}):super(key:key);
  @override
  _MyHomePageState createState() => _MyHomePageState(id_elemento_in_coda,numeroAcquisito);
}

class _MyHomePageState extends State<MyHomePage> {
  String id_elemento_in_coda;
  String numeroAcquisito;
  _MyHomePageState(String id_elemento_in_coda,String numeroAcquisito){
    this.id_elemento_in_coda=id_elemento_in_coda;
    this.numeroAcquisito=numeroAcquisito;
  }


  Future<void> change() async{
    await termina_cliente(id_elemento_in_coda);
    Route route = MaterialPageRoute(builder: (context) =>MyApp_gestioneCoda());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
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
                    left: 100,
                    right: 0,
                    top: 65,
                    child: Text("Si serve il numero:",
                      style: TextStyle(fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Positioned(
                      left: 50,
                      right: 50,
                      top: 100,
                      child: CircleButton(number: int.parse(numeroAcquisito),)
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    top: 400,
                    child: FlatButton(
                      textColor: Colors.black,
                      color: Colors.transparent,
                      onPressed: ()  {
                            change();
                        },
                      child: Text(
                        "Termina",
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

Future<void> termina_cliente(String id_elemento_servito) async {
  //se lo stato è non servito => non cambiare altrimenti cambia
  await FirebaseFirestore.instance.collection("organizzazioni")
      .doc(id_organizzazione)
      .collection("coda")
      .doc(id_elemento_servito)
      .update({"servito": "servito"}).then((result) {

  });
}

