import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:intl/intl.dart';

import '../models/Ticket.dart';
import '../utils/DateParsed.dart';

class EventsHighlistlist extends StatelessWidget {
  AsyncSnapshot<List<Event>> snapshot;

  EventsHighlistlist({this.snapshot});
  var shadows = [
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: Colors.black26),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: Colors.black26),
    Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: Colors.black26),
    Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: Colors.black26),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data == null ? 0 : snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = snapshot.data[index];

          bool isSameDate = true;

          final DateTime date = DateTime.parse(event.dateStart);
          final item = event;

          if (index == 0) {
            isSameDate = false;
          } else {
            final String prevDateString = snapshot.data[index - 1].dateStart;
            final DateTime prevDate = DateTime.parse(prevDateString);

            var dateTest = DateTime.parse(event.dateStart.split(" ").first);
            var dateTest2 = DateTime.parse(prevDateString.split(" ").first);

            isSameDate = dateTest.isAtSameMomentAs(dateTest2);
          }

          if (index == 0 || !(isSameDate)) {
            var fecha = DateParse().DiaConMesYAno(date);

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        child: Text(
                          fecha,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  CardEvent(context, index, event)
                ]);
          } else {
            return CardEvent(context, index, event);
          }

          //return CardEvent(context, index, event);
        });
  }

  InkWell CardEvent(BuildContext context, int index, Event event) {
    return InkWell(
      onTap: () {
        //navigateToDetail(context, event.id);

        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailEvent(
              tag: "eventH$index", url: event.image, event: event);
        }));
      },
      child: Container(
        height: 250,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: event.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            event.tittle,
                            style: TextStyle(
                                fontFamily: "Ubuntu",
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                                shadows: shadows),
                          ),
                          Text(event.location,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  shadows: shadows))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10)),
      ),
    );
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }

  void pushRoute(BuildContext context, String id) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (BuildContext context) => DetailEvent()));
  }
}
