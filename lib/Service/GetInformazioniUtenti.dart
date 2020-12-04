import 'package:cloud_firestore/cloud_firestore.dart';

class GetInformazioniUtenti {
  CollectionReference organizzazioni = FirebaseFirestore.instance.collection("organizzazioni");



  Future<QuerySnapshot> get orgs {
    return organizzazioni.get();
  }

  Future<QuerySnapshot> get_dipendenti(String uid) {
    return organizzazioni.doc(uid).collection("dipendenti").get();
  }







}


