import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartqueue/homepage.dart';



class AddOrganizzazione {
  CollectionReference organizzazioni = FirebaseFirestore.instance.collection("organizzazioni");

  //prima versione
  Future<void> addOrganizzazione1(String nome_organizzazione, String nome_titolare, String cognome_titolare)  {
    int indice;
    organizzazioni.get()
        .then((value) => {
      indice = value.docs.length,
      indice = indice + 1,

      organizzazioni
          .doc('$indice')
          .set({
      'nome' : nome_organizzazione
      })
          .then((value) => {
            print("Organizzazione aggiunta con successo"),
            organizzazioni
                .doc('$indice')
                .collection("dipendenti")
                .add({
              'nome' : nome_titolare,
              'cognome' : cognome_titolare,
              'titolare' : true
            })
            .then((value) => print("Proprietario aggiunto con successo"))
            .catchError((error) => print("Non è stato possibile aggiungere il proprietario: $error"))
          })
          .catchError((error) => print("Non è stato possibile aggiungere l'organizzazione e il proprietario: $error")),
    });
  }


  //seconda versione
  Future<void> addOrganizzazione(String uid, String nome_organizzazione, String nome_titolare, String cognome_titolare) {
    organizzazioni.add({
      'nome' : nome_organizzazione
    })
        .then((value) => {
      id_organizzazione = value.id,
      print("Organizzazione aggiunta con successo"),
      organizzazioni.doc(value.id)
          .collection("dipendenti")
          .doc('$uid')
          .set({
        'nome' : nome_titolare,
        'cognome' : cognome_titolare,
        'titolare' : true
      })
          .then((value) => print("Proprietario dell'organizzazione aggiunto con successo"))
          .catchError((error) => print("Non è stato possibile aggiungere il proprietario: $error"))
    })
        .catchError((error) => print("Non è stato possibile aggiungere l'organizzazione e il proprietario: $error"));
  }


}
