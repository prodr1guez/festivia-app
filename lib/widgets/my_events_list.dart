import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

class MyEventslist extends StatelessWidget {
  AsyncSnapshot<List<HostEvent>> snapshot;

  MyEventslist({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              HostEvent event = snapshot.data[index];
              return InkWell(
                onTap: () {
                  //navigateToDetail(context, event.id);

                  navigateToDetail(context, event.id);
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
                              event.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ubuntu",
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
              );
            }));
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'detail_event_host', arguments: id);
  }
}
