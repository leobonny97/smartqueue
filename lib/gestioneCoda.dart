import 'package:qrscan/qrscan.dart' as scanner;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartqueue/Servire.dart';
import 'package:smartqueue/Wrapper.dart';
import 'package:smartqueue/homepage.dart';


final firestoreInstance = FirebaseFirestore.instance;

String id_prossimo;
String num;
String id_elemento_in_coda;


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
              id_prossimo=snapshot.data.docs[i].id;
              break;
            }
          }
        for(int j=0;j<snapshot.data.docs.length;j++){
          if(snapshot.data.docs[j].data()['servito']=="non servito"){
            if(snapshot.data.docs[j].data()['numero']<min){
              min=snapshot.data.docs[j].data()['numero'];
              id_prossimo=snapshot.data.docs[j].id;
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


class MyApp_gestioneCoda extends StatelessWidget {

  MyApp_gestioneCoda({Key key}):super(key: key);


  Widget build(BuildContext context) {

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
String barcode_acquisito;
  Future<void> change() async {
  barcode_acquisito= await _scan();

  List<String> split=barcode_acquisito.split(" ");
  num = split[1];
  id_elemento_in_coda=split[2];

   if(id_elemento_in_coda==id_prossimo){ //cambio lo stato

     FirebaseFirestore.instance.collection("organizzazioni")
         .doc(id_organizzazione)
         .collection("coda")
         .doc(id_prossimo)
         .update({"servito":"sto servendo"}).then((result) {
         Route route = MaterialPageRoute(builder: (context) =>MyApp_servire(id_prossimo: id_prossimo, num: num));
         Navigator.push(context, route);
     });
   }else{
      //alert non è il numero da servire
     await _showMyDialog();

   }

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
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 35, left: 60, right: 30),
                                  child: Text("Il prossimo è:",
                                    style: TextStyle(fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 50, right: 30),
                                  child: prossimonumero(),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Padding(
                                  padding: EdgeInsets.only(top: 35, left: 30, right: 30),
                                  child: SizedBox(
                                    width: double.infinity,
                                    // height: double.infinity,
                                    child: FlatButton(
                                      textColor: Colors.black,
                                      color: Colors.transparent,
                                      onPressed: () {
                                        // Respond to button press
                                        change();
                                      },
                                      child: Text(
                                        "Acquisisci numero",
                                        style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold,),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                      shape: StadiumBorder(
                                        side: BorderSide(color: Colors.white, width: 2,),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5)),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                                  child: SizedBox(
                                    width: double.infinity,
                                    // height: double.infinity,
                                    child: FlatButton(
                                      textColor: Colors.black,
                                      color: Colors.transparent,
                                      onPressed: () {
                                        leaveCoda(id_organizzazione,id_prossimo); //id_coda
                                        Route route = MaterialPageRoute(builder: (context) => Wrapper());
                                        Navigator.push(context, route);
                                      },
                                      child: Text(
                                        "Salta cliente",
                                        style: TextStyle(fontSize: 20.0, color: Colors.white,fontWeight: FontWeight.bold,),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                      shape: StadiumBorder(
                                        side: BorderSide(color: Colors.white, width: 2,),
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                          )
                      ]
                      ),
                    ),
                  ),
                ],
              )
          );
        }
    );
  }

  Future<String> _scan() async {
    String barcode = await scanner.scan();

    if (barcode == null) {
      print('nothing return.');
    } else {
      print('Il barcode del cliente è    '+barcode);
    }

    return barcode;
  }


Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Attenzione'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Non è il numero da servire.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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


void leaveCoda(String id_organizzazione,String id_elemento_in_coda){
  firestoreInstance.collection("organizzazioni").doc(id_organizzazione).collection("coda").doc(id_elemento_in_coda).delete().then((_) {
    print("success!");
  });
}

