import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                _qrCodeWidget(this.bytes, context),
              ],
            );
          },
        ),
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
                        ? _generateBarCode("0")
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