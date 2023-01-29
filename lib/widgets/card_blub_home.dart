import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Club.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:flutter/material.dart';

import '../pages/detailClub/detail_club_page.dart';

class CardClubHome extends StatelessWidget {
  Club snapshot;

  CardClubHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToDetail(context, snapshot.id);
      },
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Container(
                height: 130,
                width: 350,
                child: CachedNetworkImage(
                  imageUrl: snapshot.image,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              snapshot.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Ubuntu",
                              ),
                            )),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: const EdgeInsets.only(left: 2),
                                child: Text(
                                  snapshot.location,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: "Ubuntu",
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10)),
    );
  }

  navigateToDetail(BuildContext context, String id) {
    //Navigator.pushNamed(context, 'detail_club', arguments: id);

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailClubPage(
          tag: "club$id", url: snapshot.image, club: snapshot);
    }));
  }
}
