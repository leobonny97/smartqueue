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
  String email, nome;

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.email, color: Colors.white,),
                              hintText: 'Your email address',
                              labelText: 'E-mail',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String value) {
                              this.email = value;
                              print('email=$email');
                            },
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.accessibility_outlined, color: Colors.white,),
                              hintText: 'Your name',
                              labelText: 'Nome',
                            ),
                            keyboardType: TextInputType.name,
                            onSaved: (String value) {
                              this.nome = value;
                              print('nome=$nome');
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                print("ButtonLogin clicked email=$email");
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
                ),
              )
            ]
        )
    );
  }
}



