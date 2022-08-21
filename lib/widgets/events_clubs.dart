import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

import '../pages/detailEvent/detail_event_page.dart';

class EventsClubs extends StatelessWidget {
  AsyncSnapshot<List<HostEvent>> snapshot;

  EventsClubs({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              HostEvent event = snapshot.data[index];
              return InkWell(
                onTap: () {
                  navigateToDetail(context, event.id, index);
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Hero(
                          tag: "event$index",
                          child: Container(
                              width: 160,
                              height: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        CachedNetworkImageProvider(event.image),
                                    fit: BoxFit.cover),
                              )),
                        ),
                        Container(
                          width: 160,
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                event.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                event.name,
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.only(right: 15, bottom: 15)),
              );
            }));
  }

  navigateToDetail(BuildContext context, String id, int index) async {
    Event event = await EventProvider().getById(id) as Event;

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailEvent(tag: "event$index", url: event.image, event: event);
    }));
    //Navigator.pushNamed(context, 'detail_event', arguments: id);
  }
}
