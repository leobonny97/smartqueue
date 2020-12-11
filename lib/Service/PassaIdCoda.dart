import 'package:cloud_firestore/cloud_firestore.dart';

String idCoda;

class PassaIdCoda {
  CollectionReference organizzazioni = FirebaseFirestore.instance.collection("organizzazioni");

  String passaIdCoda(int num, String idO) {

    Future<QuerySnapshot> stream =  organizzazioni.doc(idO).collection("coda").get();

    stream.then((value) =>
        value.docs.forEach((element) {
                if (element.get("numero") == num) {
                  idCoda = element.id;
                }

        }));

    print("sono in passaidcoda num= "+num.toString()+"  idO= "+idO.toString()+" idC= "+idCoda.toString());

    return idCoda;

  }
}
