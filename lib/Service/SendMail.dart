import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendMail {

  bool invioMail(String destinatario, String password_destinatario) {
    String username = "progettosmartqueue@gmail.com";
    String password = "smartqueueunisa2020";

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(destinatario) //recipent email
      ..subject = 'Credenziali di accesso a Smartqueue' //subject of the email
      ..text = 'Salve, questi sono i tuoi dati: \n Username: $destinatario \n Password: $password_destinatario'; //body of the email

    try {
      send(message, smtpServer);
      print('Mail inviata con successo');
      return true;
    } on MailerException catch (e) {
      print('Mail non inviata');
      return false;
    }
  }


}