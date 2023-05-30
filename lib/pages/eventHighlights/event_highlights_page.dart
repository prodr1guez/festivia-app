import 'package:festivia/widgets/events_highlights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../models/Event.dart';
import 'event_highlights_controller.dart';

class EventHighlightsPage extends StatefulWidget {
  @override
  State<EventHighlightsPage> createState() => _EventHighlightsPage();
}

class _EventHighlightsPage extends State<EventHighlightsPage> {
  EventHightlightsController _con = new EventHightlightsController();

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
                        "Proximas fiestas",
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
                      future: _con.getEvents(),
                      builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                        return EventsHighlistlist(snapshot: snapshot);
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
