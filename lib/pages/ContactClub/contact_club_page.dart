import 'package:flutter/material.dart';

class ContactClubPage extends StatefulWidget {
  @override
  State<ContactClubPage> createState() => _ContactClubPageState();
}

class _ContactClubPageState extends State<ContactClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 20, top: 80),
                child: Text(
                  "Contacto del club",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                Icon(Icons.email),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "pablo@gmail.com",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                Icon(Icons.phone),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "2612541365",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "San Martin 300",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 20, top: 60),
                child: Text(
                  "RRPP",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
