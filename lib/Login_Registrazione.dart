import 'package:flutter/material.dart';
import 'package:smartqueue/Wrapper.dart';
import 'MenuDipendente.dart';
import 'RegistrazioneOrganizzazione.dart';
import 'HomePageOrganizzazione.dart';
import 'package:smartqueue/Service/Autenticazione.dart';


class Login_Registrazione extends StatelessWidget {
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
  String email, nome, password;

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 35, left: 130, right: 130),
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
                                        this.email = value;
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
                                          this.password = value;
                                        });
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
                                          print("ButtonLogin clicked email=$email password=$password");
                                          dynamic result = await autenticazione.autenticazione(email, password);
                                          if(result == null) {
                                            print("Accesso non riuscito");
                                          } else {
                                            print("Accesso riuscito");
                                            print(result);
                                            Route route = MaterialPageRoute(builder: (context) => Wrapper());
                                            Navigator.push(context, route);
                                          }
                                          /*
                                          if(email=="1") {
                                            Route route = MaterialPageRoute(builder: (context) => MenuDipendente());
                                            Navigator.push(context, route);
                                          }
                                          else {
                                            Route route = MaterialPageRoute(builder: (context) => HomePageOrganizzazione());
                                            Navigator.push(context, route);
                                          }
                                           */
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
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:110.0),
                                    child: Text("OPPURE", style: TextStyle(fontSize: 20, color: Colors.white,),textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 30, right: 30),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print("ButtonRegistrazione clicked ");
                                          Route route = MaterialPageRoute(builder: (context) => RegistraOrganizzazione());
                                          Navigator.push(context, route);
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Registra Organizzazione",
                                          style: TextStyle(
                                              fontSize: 20,
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





