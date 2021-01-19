import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/Service/GetInformazioniUtenti.dart';
import 'package:smartqueue/Wrapper.dart';
import 'MenuDipendente.dart';
import 'RegistrazioneOrganizzazione.dart';
import 'HomePageOrganizzazione.dart';
import 'package:smartqueue/Service/Autenticazione.dart';
import 'package:smartqueue/generaQRcodeTablet.dart';
import 'package:smartqueue/Model/User.dart' as Usr;

String email_titolare2, password_titolare2;
String id_organizzazione_tablet;
String uid_tablet;
class homepageTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SmartQueue';

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
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final Autenticazione autenticazione = Autenticazione();
  final _formKey = GlobalKey<FormState>();
  String email_titolare3, password_titolare3;

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
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 35, left: 200, right: 200),
                                child: Image.asset(
                                  "assets/images/Logo1.png",
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 30)),
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
                                    onChanged: (String value) {
                                      email_titolare2 = value;
                                      email_titolare3 = email_titolare2;
                                    },
                                    validator: (email_titolare3){
                                      if (email_titolare3.isEmpty) return 'Email is required.';
                                      final RegExp nameExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                      if (!nameExp.hasMatch(email_titolare3)) {
                                        return 'Please enter a validate email .';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PasswordField(
                                    fieldKey: _passwordFieldKey,
                                    //helperText: 'No more than 8 characters.',
                                    labelText: 'Password ',
                                    onFieldSubmitted: (String value) {
                                      setState(() {
                                        password_titolare2 = value;
                                        password_titolare3 = password_titolare2;
                                      });
                                    },
                                    validator: (password_titolare3){
                                      if (password_titolare3.isEmpty) return 'Password is required.';
                                      final RegExp nameExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                                      if(password_titolare3.length < 8){
                                        return 'Please enter a Minimum 8 characters';
                                      }
                                      else if (!nameExp.hasMatch(password_titolare3)) {
                                        return 'Please enter a Minimum 1 Upper case,\n1 lowercase,1 Numeric Number.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 32, left: 30, right: 30),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()){
                                          print("ButtonLogin clicked email=$email_titolare2 password=$password_titolare2");
                                          dynamic result = await autenticazione.autenticazione(email_titolare2, password_titolare2);
                                          if(result == null) {
                                            print("Accesso non riuscito");
                                          } else {
                                            print("Accesso riuscito");
                                            uid_tablet=autenticazione.auth.currentUser.uid;
                                            Future<QuerySnapshot> stream = GetInformazioniUtenti().orgs;
                                            stream.then((value) =>
                                                value.docs.forEach((element2) {
                                                  Future<QuerySnapshot> stream2 = GetInformazioniUtenti()
                                                      .get_dipendenti(element2.id);
                                                  stream2.then((value) =>
                                                      value.docs.forEach((element) {
                                                        if (element.id == uid_tablet) {
                                                          id_organizzazione_tablet = element2.id;
                                                        }
                                                      }));
                                                }));
                                            print(result);
                                            Route route = MaterialPageRoute(builder: (context) => generaQRcodeTablet());
                                            Navigator.push(context, route);
                                          }
                                        }
                                      },
                                      color: Color(0x00000000),
                                      elevation: 50,
                                      child: Text(
                                        "Login",
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
                    ],
                  ),
                ),
              ),
            ]
        )
    );
  }
}



class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      //maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        icon: Icon(Icons.lock, color: Colors.white,),
        fillColor: Colors.white,
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}





