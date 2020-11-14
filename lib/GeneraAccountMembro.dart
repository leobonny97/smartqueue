import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SmarQueue';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        backgroundColor: Colors.orange,
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email='';
    String nome_cogn_membro='';
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome e Cognome Membro'
                      ),
                      onSubmitted: (String nome_cogn_membro2){
                        nome_cogn_membro = nome_cogn_membro2;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 8.0),

              ),
            ),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email'
                      ),
                      onSubmitted: (String email2){
                        email = email2;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: RaisedButton(
                onPressed: () {
                  print("ButtonGeneraAccount clicked nome e cognome= $nome_cogn_membro email=$email");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Genera Account", style: TextStyle(fontSize: 30, color: Colors.white),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}



