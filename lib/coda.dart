import 'package:smartqueue/MostraQRCodeCliente.dart';
import 'package:smartqueue/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final firestoreInstance = FirebaseFirestore.instance;
String id_organizzazione;
String id_elemento_in_coda;
String num;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Widget numero_attualmenteServito(String id_org) {
  CollectionReference coda =
  FirebaseFirestore.instance.collection('organizzazioni').doc(id_org).collection("coda");
  int max;

  return StreamBuilder<QuerySnapshot>(
      stream: coda.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        max=null;
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

        if(max==null){
          max=0;
          for(int j=0;j<snapshot.data.docs.length;j++){
            if(snapshot.data.docs[j].data()['servito']=="servito"){
              if(snapshot.data.docs[j].data()['numero']>max){
                max=snapshot.data.docs[j].data()['numero'];
              }
            }
          }
        }


        if(max==int.parse(num))
          {
            _showNotificationWithDefaultSound("È il tuo turno");
          }
        else
          {
            _showNotificationWithDefaultSound("Stiamo servendo il numero: "+max.toString()+"\n Il tuo numero è: "+num);
          }

        if (snapshot.hasError) {
          return Text('Impossibile recuperare il tuo numero');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Text(max.toString()??'0');
      });
}

Widget stima(String id_org) {
  CollectionReference coda =
  FirebaseFirestore.instance.collection('organizzazioni').doc(id_org).collection("coda");
  String tempi_cliente;
  int media=0;
  int stima=0;

  return StreamBuilder<QuerySnapshot>(
      stream: coda.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int counter=0;
        int counter_attesa=0;
        int somma=0;
        if(snapshot.data == null) return Text("impossibile recuperare il numero");
        for(int i=0;i<snapshot.data.docs.length;i++) {
          if(snapshot.data.docs[i].data()['servito']=="servito") {
            counter++;
            tempi_cliente = snapshot.data.docs[i].data()['stima'];
            List<String> split = tempi_cliente.split(":");
            somma = somma + int.parse(split[0]) * 60;
            somma = somma + int.parse(split[1]);
          }else {
            if(snapshot.data.docs[i].data()['numero']<int.parse(num)){
              counter_attesa++;
            }
          }
        }
        media=(somma/counter).toInt();
        stima=media*counter_attesa;
        int ore=(stima/60).toInt();
        int min=stima%60;

        if (snapshot.hasError) {
          return Text('Impossibile recuperare la stima');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Text(ore.toString()+" ore "+min.toString()+" minuti"??'0');
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

    return MaterialApp(
      title: 'SmartQueue',
      home: Scaffold(
        body: Center(
            child: Coda(number: num, id_org: id_organizzazione) //numero del cliente
          ),
        ),
      );
  }
}

class Coda extends StatefulWidget {
  String number="0";
  String id_org;
  Coda({Key key, @required this.number, @required this.id_org}):super(key:key);
  @override
  State<StatefulWidget>createState() => _CodaState(number,id_org);
}

class _CodaState extends State<Coda>{

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS:initializationSettingsIOS );
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  String number="0";
  String id_org;
  _CodaState(String number,String id_org){
    this.number=number;
    this.id_org=id_org;
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
                  numero_attualmenteServito(id_org),    //numero che si sta servendo
                  Text("Tempo di attesa stimato: "),
                  stima(id_org),                        //ultima stima

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

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  // If you have skipped step 4 then Method 1 is not for you

}
// Method 2
Future _showNotificationWithDefaultSound(String contenuto) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics );
  await flutterLocalNotificationsPlugin.show(
    1,
    'Aggiornamento coda',
    contenuto,
    platformChannelSpecifics,
  );
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
  firestoreInstance.collection("organizzazioni").doc(id_organizzazione).collection("coda").doc(id_elemento_in_coda).delete().then((_) {
    print("success!");
  });
}

