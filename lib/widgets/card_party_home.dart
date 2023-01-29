import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:flutter/material.dart';

import '../pages/detailEvent/detail_event_page.dart';

class CardPartyHome extends StatelessWidget {
  Event snapshot;

  CardPartyHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        navigateToDetail(context, snapshot.id);
      },
      child: Container(
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
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  snapshot.tittle,
                                  style: TextStyle(
                                    fontFamily: "Ubuntu",
                                    fontSize: 20,
                                  ),
                                )),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Container(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    width: 250,
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(
                                      snapshot.location,
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                          color: Colors.red),
                                    )),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  snapshot.dateStartParsed,
                                  style: TextStyle(
                                    fontFamily: "Ubuntu",
                                    fontSize: 16,
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10)),
      ),
    ));
  }

  navigateToDetail(BuildContext context, String id) {
    //Navigator.pushNamed(context, 'detail_event', arguments: id);

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailEvent(
          tag: "eventH$id", url: snapshot.image, event: snapshot);
    }));
  }
}
