import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/Service/Autenticazione.dart';
import 'package:smartqueue/Wrapper.dart';
import 'package:smartqueue/benvenuto_Cliente.dart';
import 'Login_Registrazione.dart';
import 'package:smartqueue/Model/User.dart' as Usr;
import 'package:smartqueue/homepageTablet.dart';
String id_organizzazione;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(homepage());
}

/// This is the main application widget.
class homepage extends StatelessWidget {
  static const String _title = 'SmartQueue';

  @override
  Widget build(BuildContext context) {
    String device = getDeviceType();
    if(device == "tablet"){
      //Route route = MaterialPageRoute(builder: (context) => homepageTablet());
      //Navigator.push(context, route);
      return StreamProvider<Usr.User>.value(
        value: Autenticazione().user,
        child: homepageTablet(),
      );
    }else{  //phone
      return StreamProvider<Usr.User>.value(
        value: Autenticazione().user,
        child: MaterialApp(
          title: _title,
          home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: MyStatelessWidget(),
          ),
        ),
      );
    }

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
            SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 130, right: 130, bottom: 60),
                      child: Image.asset(
                        "assets/images/Logo1.png",
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              print("Gestore o dipendente");
                              Route route = MaterialPageRoute(builder: (context) => Wrapper());
                              Navigator.push(context, route);
                            },
                            color: Color(0x00000000),
                            elevation: 50,
                            child: Text(
                              "Gestore o dipendente",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 32, left: 60, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              print("Cliente");
                              Route route = MaterialPageRoute(builder: (context) => benvenuto_Cliente());
                              Navigator.push(context, route);
                            },
                            color: Color(0x00000000),
                            elevation: 50,
                            child: Text(
                              "Cliente",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        )
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
}
String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' :'tablet';
}