import 'package:cloud_firestore/cloud_firestore.dart';
int numero_servito;
int numero_stoServendo;

class numeroServito{
  /*CollectionReference coda = FirebaseFirestore.instance
      .collection("organizzazioni")
      .doc("Vm6V4KpiKERSaFsptdx2")
      .collection("Coda");*/
  CollectionReference coda =
  Firestore.instance.collection('organizzazioni').doc('Vm6V4KpiKERSaFsptdx2').collection("Coda");

  Future<int> getNumeroServito() async{
    bool servito=false;
    bool stoServendo=false;
    QuerySnapshot snapshot = await coda.get();
    snapshot.docs.forEach((element) {
      if(element.data()['servito']=="servito"){
        numero_servito=element.data()['numero'];
        servito=true;
      }
    });
    snapshot.docs.forEach((element) {
      if(element.data()['servito']=="sto servendo"){
        numero_stoServendo=element.data()['numero'];
        stoServendo=true;
      }
    });

    if(servito==true){
      if(stoServendo==true){
        return numero_stoServendo;
      }else{
        return numero_servito;
      }
    }else{
      return 0;
    }
  }
}