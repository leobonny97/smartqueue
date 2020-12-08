import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartqueue/coda.dart';
int min;
class gestioneCodaService {
  CollectionReference coda =
  Firestore.instance.collection('organizzazioni').doc('Vm6V4KpiKERSaFsptdx2').collection("Coda");
  
  

  Future<int> prossimo_da_servire() async{
    int min;
    QuerySnapshot snapshot = await coda.get();
    for(int i=0;i<snapshot.size;i++)
      {
        if(snapshot.docs[i].data()['servito']=="non servito"){
          min=snapshot.docs[i].data()['numero'];
          break;
        }
      }
    for(int j=0;j<snapshot.size;j++){
      if(snapshot.docs[j].data()['servito']=="non servito"){
        if(snapshot.docs[j].data()['numero']<min){
          min=snapshot.docs[j].data()['numero'];
        }
      }
    }
    return min;
  }
}