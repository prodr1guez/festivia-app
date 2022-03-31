import 'package:festivia/models/Artist.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

class ArtistList extends StatelessWidget {
  AsyncSnapshot<List<Artist>> snapshot;

  ArtistList({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Artist artist = snapshot.data[index];
              return InkWell(
                onTap: () {
                  navigateToDetail(context, artist.id);
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ParallaxImage(
                        extent: 150, image: NetworkImage(artist.image)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10)),
              );
            }));
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'artist_page', arguments: id);
  }
}
