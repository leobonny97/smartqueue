import 'package:flutter/material.dart';
import 'package:smartqueue/Wrapper.dart';
import 'QRCode.dart';
import 'gestioneCoda.dart';
import 'package:smartqueue/Service/PassaNumero.dart';
import 'package:smartqueue/Service/PassaIdOrganizzazione.dart';

/// This is the main application widget.
class MenuDipendente extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 36, 63, 254),
                        Color.fromARGB(255, 193, 121, 197),
                        Color.fromARGB(255, 255, 144, 35)
                      ]
                  )
              ),
            ),
            SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 130, right: 130, bottom: 60),
                      child: Image.asset(
                        "assets/images/Logo1.png",
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              print("Mostra QR-Code");
                              int numero1 = PassaNumero().passaNumero(idOrganizzazione);
                              String idO= PassaIdOrganizzazione().passaIdOrganizzazione(user_uid);
                              if(numero1==null || idO==null || user_uid==null)
                              {
                                PassaNumero().passaNumero(idOrganizzazione);
                                PassaIdOrganizzazione().passaIdOrganizzazione(user_uid);
                              }

                              print("numero= "+numero1.toString()+" idO= "+idO+" useruid= "+user_uid);

                              Route route = MaterialPageRoute(builder: (context) => QRCode());
                              Navigator.push(context, route);
                            },
                            color: Color(0x00000000),
                            elevation: 50,
                            child: Text(
                              "Mostra QR-Code",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              print("Gestisci coda");
                              Route route = MaterialPageRoute(builder: (context) => MyApp_gestioneCoda(id_organizzazione: "Vm6V4KpiKERSaFsptdx2",));
                              Navigator.push(context, route);
                            },
                            color: Color(0x00000000),
                            elevation: 50,
                            child: Text(
                              "Gestisci coda",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        )
                    ),
                  ],
                )
            )
          ],
        )
    );
  }


}