import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:smartqueue/Service/AddBiglietto.dart';
import 'package:smartqueue/Service/PassaIdCoda.dart';
import 'package:smartqueue/coda.dart';

class benvenuto_Cliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SmartQueue';


    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Splash2(),
      ),
    );
  }
}

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
  }

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
            Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 130, right: 130),
                    child: Image.asset(
                      "assets/images/Logo1.png",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: EdgeInsets.only(left: 60, right: 60, top: 70),
                              child: Container(
                                child: Text(
                                  'Benvenuto, \nscannerizza il codice QR e prendi parte alla fila',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                          )
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            _scan();
                          },
                          color: Color(0x00000000),
                          elevation: 50,
                          child: Text(
                            "Avanti",
                            style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            )
          ],
        ));
  }


  Future _scan() async {
    String barcode = await scanner.scan();

    if (barcode == null) {
      print('nothing return.');
    } else {
      print('Il barcode è    '+barcode);

      List<String> split=barcode.split(" ");
      String idO = split[0];
      String numero1 = split[1];

      AddBiglietto().addBiglietto(int.parse(numero1),idO);
      String idC = PassaIdCoda().passaIdCoda(int.parse(numero1), idO);

      Route route = MaterialPageRoute(builder: (context) => MyApp_coda(barcode: barcode,id_coda: idC));
      Navigator.push(context, route);
    }
  }

}