import 'package:flutter/material.dart';
import 'package:smartqueue/QR.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        backgroundColor: Colors.orange,
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
        backgroundColor: Colors.orange,
        body: Stack(
            children: <Widget>[
                  Center(
                    child: getList(),
                  ),
              ],
        ),
    );
  }
}
Widget getList() {
  final members = [
    'nome e cognome',
    'nome e cognome',
  ];
  final icons = [
    Icons.delete
  ];
  ListView myList = new ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return new ListTile(
          leading: const Icon(Icons.delete, size: 25.0, color: Colors.red),
          title: new Text(members[index]),
        );
      });
  return myList;
}
