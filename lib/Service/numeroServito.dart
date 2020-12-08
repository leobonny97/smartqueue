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
    int max;
    QuerySnapshot snapshot = await coda.get();
    for(int i=0;i<snapshot.size;i++)
    {
      if(snapshot.docs[i].data()['servito']=="sto servendo"){
        max=snapshot.docs[i].data()['numero'];
        break;
      }
    }
    for(int j=0;j<snapshot.size;j++){
      if(snapshot.docs[j].data()['servito']=="sto servendo"){
        if(snapshot.docs[j].data()['numero']>max){
          max=snapshot.docs[j].data()['numero'];
        }
      }
    }
    return max;
  }

}