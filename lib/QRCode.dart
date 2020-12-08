import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smartqueue/Service/PassaIdCoda.dart';
import 'package:smartqueue/Service/PassaIdOrganizzazione.dart';
import 'package:smartqueue/Service/PassaNumero.dart';
import 'package:smartqueue/Wrapper.dart';

class QRCode extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QRCode> {


  Uint8List bytes = Uint8List(0);
  static const String _title = 'SmartQueue';

  @override
  initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        backgroundColor: Colors.orange,
        body: Stack(
          children: [
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
            Builder(
              builder: (BuildContext context) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 130, right: 130),
                      child: Image.asset(
                        "assets/images/Logo1.png",
                      ),
                    ),
                    _qrCodeWidget(this.bytes, context),
                  ],
                );
              },
            ),
          ],
        )
      ),
    );
  }


  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 18, color: Colors.green),
                  Text('  Scannerizza il QRCode', style: TextStyle(fontSize: 15)),
                  Spacer(),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 40, bottom: 40),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? _generateBarCode(idOrganizzazione+" "+numero.toString())
                        : Image.memory(bytes),
                  ),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}