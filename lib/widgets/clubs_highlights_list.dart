import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

import '../models/Club.dart';
import '../models/Ticket.dart';

class clubsHighlistlist extends StatelessWidget {
  AsyncSnapshot<List<Club>> snapshot;

  clubsHighlistlist({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Club club = snapshot.data[index];
              return InkWell(
                onTap: () {
                  navigateToDetail(context, club.id);
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Container(
                            height: 130,
                            width: 400,
                            child: ParallaxImage(
                                extent: 150, image: NetworkImage(club.image))),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              club.name,
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
    Navigator.pushNamed(context, 'detail_club', arguments: id);
  }
}
