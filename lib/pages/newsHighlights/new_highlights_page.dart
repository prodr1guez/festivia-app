import 'package:festivia/pages/myTickets/my_tickets_controller.dart';
import 'package:festivia/widgets/clubs_highlights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../models/Club.dart';
import '../../models/News.dart';
import '../../models/Ticket.dart';
import '../../widgets/my_tickets_list.dart';
import '../../widgets/new_highlists_list.dart';
import 'new_highlights_controller.dart';

class NewHighlightsPage extends StatefulWidget {
  @override
  State<NewHighlightsPage> createState() => _NewHighlightsPage();
}

class _NewHighlightsPage extends State<NewHighlightsPage> {
  NewHightlightsController _con = new NewHightlightsController();

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
                        "Noticias",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Ubuntu",
                        ),
                      )),
                ),
                Container(
                  height: 730,
                  child: FutureBuilder(
                      future: _con.getNews(),
                      builder: (context, AsyncSnapshot<List<News>> snapshot) {
                        return NewHighlistlist(snapshot: snapshot);
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
