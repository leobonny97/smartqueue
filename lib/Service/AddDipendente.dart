import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartqueue/Model/User.dart' as Usr;

class AddDipendente {

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference organizzazioni = FirebaseFirestore.instance.collection("organizzazioni");


  Usr.User userFromFirebase(User user){
    return user != null ? Usr.User(uid: user.uid) : null;
  }


  Future registrazione_dipendente(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Nessun utente registrato con questa email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('La password è errata.');
        return null;
      }
    }
  }

  //seconda versione
  Future<void> addDipendente(String id_organizzazione, String id_dipendente, String nome_dipendente, String cognome_dipendente) {
      organizzazioni.doc(id_organizzazione)
          .collection("dipendenti")
          .doc(id_dipendente)
          .set({
        'nome' : nome_dipendente,
        'cognome' : cognome_dipendente,
        'titolare' : false
      })
          .then((value) => print("Dipendente dell'organizzazione aggiunto con successo"))
          .catchError((error) => print("Non è stato possibile aggiungere il dipendente: $error"));
  }


}
