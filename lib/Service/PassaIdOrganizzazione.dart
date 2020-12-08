import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartqueue/Service/GetInformazioniUtenti.dart';

String idOrganizzazione;

class PassaIdOrganizzazione {

  String passaIdOrganizzazione(String idDipendente) {
    Future<QuerySnapshot> stream = GetInformazioniUtenti().orgs;
    stream.then((value) =>
        value.docs.forEach((element1) {
          Future<QuerySnapshot> stream2 = GetInformazioniUtenti()
              .get_dipendenti(element1.id);
          stream2.then((value) =>
              value.docs.forEach((element2) {
                if (element2.id == idDipendente) {
                  idOrganizzazione=element1.id;
                }
              }));
        }));

    return idOrganizzazione;
  }
}
