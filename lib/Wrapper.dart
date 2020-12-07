import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/AggiuntaDipendenteRiuscita.dart';
import 'package:smartqueue/GeneraAccountMembro.dart';
import 'package:smartqueue/HomePageOrganizzazione.dart';
import 'package:smartqueue/LoginRegistrazioneRiusciti.dart';
import 'package:smartqueue/Login_Registrazione.dart';
import 'package:smartqueue/MenuDipendente.dart';
import 'package:smartqueue/Model/User.dart' as Usr;
import 'package:smartqueue/Service/GetInformazioniUtenti.dart';
import 'homepage.dart';

bool a;
String user_uid;

class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usr.User>(context);
    if (user == null) {
      return Login_Registrazione();
    }
    else {
      user_uid = user.uid;
      Future<QuerySnapshot> stream = GetInformazioniUtenti().orgs;
      stream.then((value) =>
          value.docs.forEach((element2) {
            Future<QuerySnapshot> stream2 = GetInformazioniUtenti()
                .get_dipendenti(element2.id);
            stream2.then((value) =>
                value.docs.forEach((element) {
                  if (element.id == user.uid) {
                    id_organizzazione = element2.id;
                    if (element.get("titolare") == true) {
                      a = true;
                    } else {
                      a = false;
                    }
                  }
                }));
          }));

      if(aggiunta_dipendente == true) {
        aggiunta_dipendente = false;
        return AggiuntaDipendenteRiuscita();
      }

      if(a == true) {
        return HomePageOrganizzazione();
      } else if (a == false){
        return MenuDipendente();
      } else {
        return LoginRegistrazioneRiusciti();
        }

      }
    }



  }