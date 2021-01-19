import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smartqueue/homepage.dart';
import 'package:smartqueue/homepageTablet.dart';

int numero_tablet;

class generaQRcodeTablet extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<generaQRcodeTablet> {

  Uint8List bytes = Uint8List(0);
  static const String _title = 'SmartQueue';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          backgroundColor: Colors.orange,
          body: Stack(
            children: [
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
              Builder(
                builder: (BuildContext context) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 35, left: 250, right: 250),
                        child: Image.asset(
                          "assets/images/Logo1.png",
                        ),
                      ),
                      _qrCodeWidget(this.bytes, context),
                    ],
                  );
                },
              ),
            ],
          )
      ),
    );
  }


  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 25, color: Colors.green),
                  Text('  Scannerizza il QRCode', style: TextStyle(fontSize: 25)),
                  Spacer(),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 40, bottom: 40),
              child: Column(
                children: <Widget>[
                  getNumero(bytes),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }


  Widget getNumero(Uint8List bytes) {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("organizzazioni").doc(id_organizzazione_tablet).collection("coda");

    return StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Impossibile recuperare la coda');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          bool prima_volta=true;

          snapshot.data.docs.forEach((element) {
            if(prima_volta==true)
            {
              prima_volta=false;
              numero_tablet = element.data()["numero"];
            }
            else
            {
              if(element.data()["numero"] > numero_tablet)
              {
                numero_tablet = element.data()["numero"];
              }
            }
          });

          numero_tablet = numero_tablet + 1;

          /*
          collectionReference.snapshots().listen((event) {
            event.docChanges.forEach((element)  async {
              if(element.type == DocumentChangeType.added){
                await _generateBarCode(id_organizzazione+" "+numero.toString());
              }
            });
          });*/


          print("IL NUMERO TABLET" +numero_tablet.toString());
          print("ID ORG: "+id_organizzazione_tablet.toString());

          return new SizedBox(
            height: 300,
            child: bytes.isEmpty
                ? _generateBarCode(id_organizzazione_tablet+" "+numero_tablet.toString())
                : Image.memory(bytes),

          );
        });
  }

}



