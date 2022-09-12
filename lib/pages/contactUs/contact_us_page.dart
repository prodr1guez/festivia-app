import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 300,
                width: 300,
                child: Image.asset("assets/contactus.png")),
            Text(
              "¡Contáctanos!",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Para promocionar tu evento o club en nuestra plataforma y/o redes sociales por favor contáctate con nosotros mediante los siguientes medios:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "2612541365",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail_rounded,
                  color: Colors.lightBlue,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "pablo@festivia.app",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
