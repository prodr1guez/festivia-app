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
          child: CachedNetworkImage(
            imageUrl: snapshot.image,
            fit: BoxFit.cover,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10)),
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
