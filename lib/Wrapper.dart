import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartqueue/HomePageOrganizzazione.dart';
import 'package:smartqueue/Login_Registrazione.dart';
import 'package:smartqueue/Model/User.dart' as Usr;

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Usr.User>(context);

    if (user == null) {
      return Login_Registrazione();
    } else {
      print(user.uid);
      return HomePageOrganizzazione();
    }
  }
}