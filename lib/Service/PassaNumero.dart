import 'package:cloud_firestore/cloud_firestore.dart';

int numero;

class PassaNumero {
  CollectionReference organizzazione = FirebaseFirestore.instance
      .collection("organizzazioni");

  int passaNumero(String idO) {

    bool prima_volta=true;

    organizzazione.doc(idO).collection("coda").get().
    then((value) =>
    {
      if(value.docs.isEmpty)
      {
        print("è vuotooooooooooo "),
      }
      else
      {
        value.docs.forEach((element) {
          if(prima_volta==true)
          {
            prima_volta=false;
            numero = element.data()["numero"];
          }
          else
          {
            if(element.data()["numero"] > numero)
            {
              numero = element.data()["numero"];
            }
          }
        }),
      }
    });

    numero = numero + 1;

    return numero;
  }
}
