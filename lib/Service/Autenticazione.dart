import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartqueue/Model/User.dart' as Usr;

class Autenticazione {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Usr.User userFromFirebase(User user){
    return user != null ? Usr.User(uid: user.uid) : null;
  }



  Stream<Usr.User> get user {
    return auth.authStateChanges()
        .map(userFromFirebase);
  }


  Future autenticazione(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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

  Future registrazione(String email, String password) async {
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

}