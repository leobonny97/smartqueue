import 'package:flutter/material.dart';
import 'package:smartqueue/HomePageOrganizzazione.dart';
import 'package:smartqueue/Wrapper.dart';
import 'Service/AddOrganizzazione.dart';
import 'Service/Autenticazione.dart';
import 'package:smartqueue/Model/User.dart' as Usr;

String email_titolare, password_titolare;

class RegistraOrganizzazione extends StatelessWidget {
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

class MyCustomFormState extends State<MyCustomForm> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  final Autenticazione autenticazione = Autenticazione();

  final _formKey = GlobalKey<FormState>();
  String nomeOr, nomeT,cognomeT, email_titolare1, password_titolare1;

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
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.person, color: Colors.white,),
                                        hintText: 'Nome Organizzazione',
                                        labelText: 'Nome Organizzazione ',
                                      ),
                                      onChanged: (String value) {
                                        this.nomeOr = value;
                                      },
                                      validator: (nomeOr){
                                        if (nomeOr.isEmpty) return 'Nome Organizzazione is required.';
                                        final RegExp nameExp = RegExp(r'^[A-Za-z0-9 ]+$');
                                        if (!nameExp.hasMatch(nomeOr)) {
                                          return 'Please enter only alphabetical or numeric characters.';
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
                                    child:  TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.person, color: Colors.white,),
                                        hintText: 'Nome Titolare',
                                        labelText: 'Nome Titolare ',
                                      ),
                                      onChanged: (String value) {
                                        this.nomeT = value;
                                      },
                                      validator: (nomeT){
                                        if (nomeT.isEmpty) return 'Name is required.';
                                        final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                                        if (!nameExp.hasMatch(nomeT)) {
                                          return 'Please enter only alphabetical characters.';
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
                                    child:  TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.person, color: Colors.white,),
                                        hintText: 'Cognome Titolare',
                                        labelText: 'Cognome Titolare ',
                                      ),
                                      onChanged: (String value) {
                                        this.cognomeT = value;
                                      },
                                      validator: (cognomeT){
                                        if (cognomeT.isEmpty) return 'Cognome is required.';
                                        final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                                        if (!nameExp.hasMatch(cognomeT)) {
                                          return 'Please enter only alphabetical characters.';
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
                                        email_titolare = value;
                                        email_titolare1 = email_titolare;
                                      },
                                      validator: (email_titolare1){
                                        if (email_titolare1.isEmpty) return 'Email is required.';
                                        final RegExp nameExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                        if (!nameExp.hasMatch(email_titolare1)) {
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
                                          password_titolare = value;
                                        });
                                      },
                                      validator: (password_titolare1){
                                        if (password_titolare1.isEmpty) return 'Password is required.';
                                        final RegExp nameExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                                        if(password_titolare1.length < 8){
                                          return 'Please enter a Minimum 8 characters';
                                        }
                                        else if (!nameExp.hasMatch(password_titolare1)) {
                                          return 'Please enter a Minimum 1 Upper case,\n1 lowercase,1 Numeric Number.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState.validate()){
                                            print("Registrazione Nome Organizzazione=$nomeOr Nome titolare=$nomeT Cognome Titolare=$cognomeT email=$email_titolare password=$password_titolare");
                                            Usr.User  result = await autenticazione.registrazione(email_titolare, password_titolare);
                                            if(result == null) {
                                              print("Registrazione non riuscita");
                                            } else {
                                              print("Registrazione effettuata con successo");
                                              print(result);
                                              AddOrganizzazione().addOrganizzazione(result.uid ,nomeOr, nomeT, cognomeT);
                                              Route route = MaterialPageRoute(builder: (context) => Wrapper());
                                              Navigator.push(context, route);
                                            }
                                          }
                                        },
                                        color: Color(0x00000000),
                                        elevation: 50,
                                        child: Text(
                                          "Conferma",
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





