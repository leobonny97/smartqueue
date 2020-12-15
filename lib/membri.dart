import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartqueue/QR.dart';
import 'homepage.dart';
import 'Service/GetInformazioniUtenti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() => runApp(MyApp());

/// This is the main application widget.
class membri extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),

        body: Stack(
            children: <Widget>[
              Container(
                child: MyStatelessWidget(),
              ),
            ],
        ),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);


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
                  Center(
                    child: getList(),
                  ),
              ],
        ),
    );
  }
}


Widget getList() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("organizzazioni").doc(id_organizzazione).collection("dipendenti");
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Impossibile recuperare i dipendenti');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            if(document.data()['titolare'] == true) {
              return new Card(
                  child : ListTile(
                    title: new Text(document.data()['nome'] + " " + document.data()['cognome'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,),),
                    subtitle: new Text("titolare"),
                  )
              );
            } else {
              return new Card(
                  child : ListTile(
                    trailing: RaisedButton(
                      child: const Icon(Icons.delete, size: 25.0, color: Colors.red,),
                      onPressed: () {
                        print("cliccato su elimina");
                         FirebaseFirestore.instance.collection("organizzazioni").doc(id_organizzazione).collection("dipendenti").doc(document.id).delete();
                      },
                    ),
                    title: new Text(document.data()['nome'] + " " + document.data()['cognome'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,),),
                    subtitle: new Text("dipendente"),
                  )
              );
            }
          }).toList(),
    );
  });


}


