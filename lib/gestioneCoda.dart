import 'package:qrscan/qrscan.dart' as scanner;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartqueue/Service/gestioneCodaService.dart';
import 'package:smartqueue/homepage.dart';

import 'Service/PassaIdCoda.dart';


final firestoreInstance = FirebaseFirestore.instance;
int prossimo;
String num;
String id_elemento_in_coda;

/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prossimo= await gestioneCodaService().prossimo_da_servire();
  print(prossimo);

  runApp(MyApp());
}
*/


Widget prossimonumero(){
  CollectionReference coda =
  FirebaseFirestore.instance.collection('organizzazioni').doc(id_organizzazione).collection("coda");
  int min;
  //QuerySnapshot snapshot = await coda.get();

  return StreamBuilder<QuerySnapshot>(
      stream: coda.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.data == null) return Text("impossibile recuperare il numero");
          for(int i=0;i<snapshot.data.docs.length;i++)
          {
            if(snapshot.data.docs[i].data()['servito']=="non servito"){
              min=snapshot.data.docs[i].data()['numero'];
              break;
            }
          }
        for(int j=0;j<snapshot.data.docs.length;j++){
          if(snapshot.data.docs[j].data()['servito']=="non servito"){
            if(snapshot.data.docs[j].data()['numero']<min){
              min=snapshot.data.docs[j].data()['numero'];
            }
          }
        }


        if (snapshot.hasError) {
          return Text('Impossibile recuperare i dipendenti');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return CircleButton(number: min,);
      });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String barcode;
  String id_coda;
  //MyApp({Key key, @required this.barcode, @required this.id_coda}):super(key: key);


  Widget build(BuildContext context) {

    //List<String> split=barcode.split(" ");
    //id_organizzazione = split[0];
    //num = split[1];
    //id_elemento_in_coda = id_coda;

    firestoreInstance.collection("organizzazioni").doc(id_organizzazione).collection("coda").snapshots().listen((event) {
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
   _scan();
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
                    child: prossimonumero(),
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

  Future _scan() async {
    String barcode = await scanner.scan();

    if (barcode == null) {
      print('nothing return.');
    } else {
      print('Il barcode è    '+barcode);

      List<String> split=barcode.split(" ");
      String idO = split[0];
      String numero1 = split[1];

      String idC = PassaIdCoda().passaIdCoda(int.parse(numero1), idO);

     // Route route = MaterialPageRoute(builder: (context) => MyApp_coda(barcode: barcode,id_coda: idC));
    //  Navigator.push(context, route);
    }
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