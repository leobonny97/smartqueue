import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/HomePageOrganizzazione.dart';
import 'package:smartqueue/Login_Registrazione.dart';
import 'package:smartqueue/MenuDipendente.dart';
import 'package:smartqueue/Model/User.dart' as Usr;
import 'package:smartqueue/Service/GetInformazioniUtenti.dart';

bool a;

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usr.User>(context);


    if (user == null) {
      return Login_Registrazione();
    }
    else {
      Future<QuerySnapshot> stream = GetInformazioniUtenti().orgs;
      stream.then((value) =>
          value.docs.forEach((element) {
            Future<QuerySnapshot> stream2 = GetInformazioniUtenti()
                .get_dipendenti(element.id);
            stream2.then((value) =>
                value.docs.forEach((element) async {
                  if (element.id == user.uid) {
                    if (element.get("titolare") == true) {
                      a = await true;
                    }
                    else {
                      a = await false;
                    }
                  }
                }));
          }));
      if(a == true) {
        return HomePageOrganizzazione();
      } else {
        return MenuDipendente();
      }
    }



  }
}