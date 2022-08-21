import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

import '../models/Ticket.dart';

class EventsHighlistlist extends StatelessWidget {
  AsyncSnapshot<List<Event>> snapshot;

  EventsHighlistlist({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Event event = snapshot.data[index];
              return InkWell(
                onTap: () {
                  //navigateToDetail(context, event.id);

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailEvent(
                        tag: "eventH$index", url: event.image, event: event);
                  }));
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Hero(
                          tag: "eventH$index",
                          child: Container(
                              height: 130,
                              width: 400,
                              child: ParallaxImage(
                                  extent: 150,
                                  image:
                                      CachedNetworkImageProvider(event.image))),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              event.tittle,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
              );
            }));
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }

  void pushRoute(BuildContext context, String id) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (BuildContext context) => DetailEvent()));
  }
}
