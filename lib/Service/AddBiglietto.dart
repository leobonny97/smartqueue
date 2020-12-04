import 'package:cloud_firestore/cloud_firestore.dart';

class AddBiglietto {
  CollectionReference coda = FirebaseFirestore.instance
      .collection("organizzazioni")
      .doc("Vm6V4KpiKERSaFsptdx2")
      .collection("Coda");

  Future<void> addBiglietto(int numbigl) {

     return coda
         .add({
       'numero': numbigl,
       'servito' : false,
     })
         .then((value) => print("Biglietto aggiunto con successo"))
         .catchError((error) => print("Non è stato possibile aggiungere il biglietto: $error"));


  }
}
