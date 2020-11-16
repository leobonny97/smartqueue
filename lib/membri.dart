import 'package:flutter/material.dart';
import 'package:smartqueue/QR.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class membri extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),

        body: Stack(
            children: <Widget>[
              Container(
                child: MyStatelessWidget(),
              ),
            ],
        ),
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
                  Center(
                    child: getList(),
                  ),
              ],
        ),
    );
  }
}
Widget getList() {
  //l'array deve essere dato in input a getList
  final members = [
    'Benedetto Sommese',
    'Daniele Cesarano',
    'Francesco Auriemma',
  ];
  final icons = [
    Icons.delete
  ];
  ListView myList = new ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return new Card(
          child: ListTile(
            leading: const Icon(Icons.delete, size: 25.0, color: Colors.red,),
            title: Text(members[index], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,),),
            subtitle: Text("Ruolo: Dipendente"),
          ),
        );
      });
  return myList;
}
