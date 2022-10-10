import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class CardPartyHome extends StatelessWidget {
  SuggestParty snapshot;

  CardPartyHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        navigateToDetail(context, snapshot.type, snapshot.id);
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
                    fit: BoxFit.fill,
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
                                  "Festivia",
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
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(
                                      snapshot.location,
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
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
                                  snapshot.date,
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

  navigateToDetail(BuildContext context, String type, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }
}
