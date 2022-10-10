import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/pages/detailClub/detail_club_page.dart';
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
                  //navigateToDetail(context, club.id);

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailClubPage(
                        tag: "club$index", url: club.image, club: club);
                  }));
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Hero(
                          tag: "club$index",
                          child: Container(
                              height: 130,
                              width: 400,
                              child: ParallaxImage(
                                  extent: 150,
                                  image:
                                      CachedNetworkImageProvider(club.image))),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              club.name,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
