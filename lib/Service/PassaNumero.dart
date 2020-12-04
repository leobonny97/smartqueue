import 'package:cloud_firestore/cloud_firestore.dart';

int numero;

class PassaNumero {
  CollectionReference coda = FirebaseFirestore.instance
      .collection("organizzazioni")
      .doc("Vm6V4KpiKERSaFsptdx2")
      .collection("Coda");

  int passaNumero() {

    int indice;

    coda.get().
    then((value) =>
    {
      indice = value.docs.length,
      indice = indice + 1,
      numero = indice ,

    });

    return numero;
  }
}
