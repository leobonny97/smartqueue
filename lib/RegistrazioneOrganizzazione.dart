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
    String nomeorganizzazione='';
    String nometitolare='';
    String cognometitolare='';
    String email='';
    String password='';

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
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
                      style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome Organizzazione'
                      ),
                      onSubmitted: (String nomeorganizzazione2){
                        nomeorganizzazione = nomeorganizzazione2;
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome Titolare'
                      ),
                      onSubmitted: (String nometitolare2){
                        nometitolare = nometitolare2;
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Cognome Titolare'
                      ),
                      onSubmitted: (String cognometitolare2){
                        cognometitolare = cognometitolare2;
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password'
                      ),
                      onSubmitted: (String password2){
                        password = password2;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child:RaisedButton(
                onPressed: () {
                  print("ButtonLogin clicked nomeorganizzazione=$nomeorganizzazione nometitolare=$nometitolare cognometitolare=$cognometitolare email=$email  password= $password ");
                },
                color: Colors.blue,
                elevation: 10,
                child: Text("Conferma", style: TextStyle(fontSize: 25, color: Colors.white),),
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



