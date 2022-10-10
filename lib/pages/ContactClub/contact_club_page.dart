import 'package:festivia/pages/ContactClub/contact_club_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ContactClubPage extends StatefulWidget {
  @override
  State<ContactClubPage> createState() => _ContactClubPageState();
}

class _ContactClubPageState extends State<ContactClubPage> {
  ContactClubController _controller = new ContactClubController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

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
                    _controller.email,
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
                    _controller.phone,
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
                    _controller.location,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
