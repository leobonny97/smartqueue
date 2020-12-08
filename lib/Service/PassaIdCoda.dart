import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartqueue/Service/GetInformazioniUtenti.dart';

String idCoda;

class PassaIdCoda {
  CollectionReference organizzazioni = FirebaseFirestore.instance.collection("organizzazioni");

  String passaIdCoda(int num, String idO) {

    print("sono in passaidcoda "+num.toString()+"  "+idO);

    Future<QuerySnapshot> stream =  organizzazioni.doc(idO).collection("coda").get();

    stream.then((value) =>
        value.docs.forEach((element) {
                if (element.get("numero") == num) {
                  idCoda = element.id;
                }

        }));

    return idCoda;

  }
}
