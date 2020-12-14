import 'package:cloud_firestore/cloud_firestore.dart';

class AddBiglietto {
  CollectionReference organizzazione = FirebaseFirestore.instance
      .collection("organizzazioni");

  Future<void> addBiglietto(int numbigl,String idO) {


    print("Sono in addbiglietto num= "+numbigl.toString()+" ido= "+idO.toString());
     return organizzazione.doc(idO).collection("coda")
         .add({
       'numero': numbigl,
       'servito' : "non servito",
       'stima' : "00:00:00",
     })
         .then((value) => print("Biglietto aggiunto con successo"))
         .catchError((error) => print("Non è stato possibile aggiungere il biglietto: $error"));
  }
}
