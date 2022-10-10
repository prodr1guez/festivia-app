import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/BannerMainHome.dart';
import 'package:flutter/material.dart';

class BannerHome extends StatelessWidget {
  BannerMainHome snapshot;

  BannerHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        //navigateToDetail(context, snapshot.type, snapshot.id);
      },
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CachedNetworkImage(
            imageUrl: snapshot.image,
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10)),
    ));
  }

  navigateToDetail(BuildContext context, String type, String id) {
    Navigator.pushNamed(context, 'detail_club', arguments: id);
  }
}
