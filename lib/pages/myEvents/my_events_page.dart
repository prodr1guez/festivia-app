import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/pages/myEvents/my_events_controller.dart';
import 'package:festivia/widgets/my_events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  MyEventController _con = new MyEventController();

  @override
  void initState() {
    // TODO: implement initState
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
                        "Eventos creados",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                    future: _con.getMyEvents(),
                    builder:
                        (context, AsyncSnapshot<List<HostEvent>> snapshot) {
                      return MyEventslist(snapshot: snapshot);
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
