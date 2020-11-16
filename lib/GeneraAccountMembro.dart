import 'package:flutter/material.dart';


class GeneraAccountMembro extends StatelessWidget {
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

  final _formKey = GlobalKey<FormState>();
  String email,nomeOr, nomeM,cognomeM;

  String _validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 120.0),
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
                                      hintText: 'Nome Membro',
                                      labelText: 'Nome Membro ',
                                    ),
                                    onChanged: (String value) {
                                      this.nomeM = value;
                                    },
                                    validator: _validateName,
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
                                      hintText: 'Cognome Membro',
                                      labelText: 'Cognome Membro ',
                                    ),
                                    onChanged: (String value) {
                                      this.cognomeM = value;
                                    },
                                    validator: _validateName,
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
                                      this.email = value;
                                    },
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 50)),
                              Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      onPressed: () {
                                        print("ButtonGeneraAccount clicked Nome membro=$nomeM Cognome membro=$cognomeM email=$email");
                                      },
                                      color: Color(0x00000000),
                                      elevation: 50,
                                      child: Text(
                                        "Genera Account",
                                        style: TextStyle(
                                            fontSize: 22,
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
      maxLength: 8,
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





