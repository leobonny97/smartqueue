import 'package:smartqueue/MostraQRCodeCliente.dart';
import 'package:smartqueue/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


final firestoreInstance = FirebaseFirestore.instance;
String id_organizzazione;
String id_elemento_in_coda;
String num;

/*
* Future<void>main()async{
* WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  num_servito=await numeroServito().getNumeroServito();
  print(num_servito);

  runApp(MyApp_coda());
* }
*
* */
Widget numero_attualmenteServito() {
  CollectionReference coda =
  FirebaseFirestore.instance.collection('organizzazioni').doc(id_organizzazione).collection("coda");
    int max;
    //QuerySnapshot snapshot = await coda.get();

  return StreamBuilder<QuerySnapshot>(
      stream: coda.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.data == null) return Text("impossibile recuperare il numero");
        for(int i=0;i<snapshot.data.docs.length;i++)
        {
          if(snapshot.data.docs[i].data()['servito']=="sto servendo"){
            max=snapshot.data.docs[i].data()['numero'];
            break;
          }
        }
        for(int j=0;j<snapshot.data.docs.length;j++){
          if(snapshot.data.docs[j].data()['servito']=="sto servendo"){
            if(snapshot.data.docs[j].data()['numero']>max){
              max=snapshot.data.docs[j].data()['numero'];
            }
          }
        }


        if (snapshot.hasError) {
          return Text('Impossibile recuperare il tuo numero');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Text(max.toString(),);
      });
}


class MyApp_coda extends StatelessWidget {

  String barcode;
  String id_coda;
  MyApp_coda({Key key, @required this.barcode, @required this.id_coda}):super(key: key);

  //final String id_organizzazione;
  @override
  Widget build(BuildContext context) {
  List<String> split=barcode.split(" ");
  id_organizzazione = split[0];
  num = split[1];
  id_elemento_in_coda = id_coda;

/*
  firestoreInstance.collection("organizzazioni").doc(id_organizzazione).collection("Coda").snapshots().listen((event) {
    event.docChanges.forEach((element)  async {
      if(element.type == DocumentChangeType.modified){

        num_servito= await numeroServito().getNumeroServito();
        print(num_servito);
        runApp(MyApp_coda());
      }
    });
  });
*/

    return MaterialApp(
      title: 'SmartQueue',
      home: Scaffold(
        body: Center(
            child: Coda(number: num,),  //numero del cliente
          ),
        ),
      );
  }
}

class Coda extends StatefulWidget {
  String number="0";
  Coda({Key key,this.number}):super(key:key);
  @override
  State<StatefulWidget>createState() => _CodaState(number);
}

class _CodaState extends State<Coda>{

  String number="0";
  _CodaState(String number){
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
              left: 100,
              right: 100,
              top: 450,
              child:  RaisedButton(
                onPressed: ()  {
                  Route route = MaterialPageRoute(builder: (context) => MostraQRCodeCliente());
                  Navigator.push(context, route);
                },
                color: Color(0x00000000),
                elevation: 50,
                child: Text(
                  "Mostra QR code",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                ),
              )
          ),
          Positioned(
            left: 5,
            right: 5,
            top: 550,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Icon(Icons.timelapse,size: 72.0),
                  Text("Stiamo servendo il numero:"),
                  numero_attualmenteServito(),    //numero che si sta servendo
                  Text("Tempo di attesa stimato:"),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Abbandona la coda',
                          style: TextStyle(color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                            leaveCoda(id_organizzazione,id_elemento_in_coda); //id_coda
                            Route route = MaterialPageRoute(builder: (context) => homepage());
                            Navigator.push(context, route);
                          },
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

  final String number;
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

void leaveCoda(String id_organizzazione,String id_elemento_in_coda){
  firestoreInstance.collection("organizzazioni").doc(id_organizzazione).collection("Coda").doc(id_elemento_in_coda).delete().then((_) {
    print("success!");
  });
}

