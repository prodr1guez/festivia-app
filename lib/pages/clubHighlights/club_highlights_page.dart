import 'package:festivia/pages/myTickets/my_tickets_controller.dart';
import 'package:festivia/widgets/clubs_highlights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../models/Club.dart';
import '../../models/Ticket.dart';
import '../../widgets/my_tickets_list.dart';
import 'club_highlights_controller.dart';

class ClubHighlightsPage extends StatefulWidget {
  @override
  State<ClubHighlightsPage> createState() => _ClubHighlightsPage();
}

class _ClubHighlightsPage extends State<ClubHighlightsPage> {
  ClubHightlightsController _con = new ClubHightlightsController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Clubs",
                        style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                    future: _con.getClubs(),
                    builder: (context, AsyncSnapshot<List<Club>> snapshot) {
                      return clubsHighlistlist(snapshot: snapshot);
                    }),
              ],
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
