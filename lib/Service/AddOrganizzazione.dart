import 'package:cloud_firestore/cloud_firestore.dart';

class AddOrganizzazione {
  CollectionReference organizzazioni = Firestore.instance.collection("organizzazioni");

  Future<void> addOrganizzazione(String nome) {
  // Call the user's CollectionReference to add a new user
  return organizzazioni
      .add({
        'nome': nome, // John Doe
      })
      .then((value) => print("Organizzazione aggiunta con successo"))
      .catchError((error) => print("Non è stato possibile aggiungere l'organizzazione: $error"));
  }


}
