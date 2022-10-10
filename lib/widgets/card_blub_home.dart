import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:flutter/material.dart';

class CardClubHome extends StatelessWidget {
  SuggestClub snapshot;

  CardClubHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToDetail(context, snapshot.type, snapshot.id);
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
                  fit: BoxFit.fill,
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
                            child: const Text(
                              "Festivia",
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
                                child: const Text(
                                  "San Martin 300",
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

  navigateToDetail(BuildContext context, String type, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }
}
