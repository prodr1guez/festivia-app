import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Artist.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/pages/artistDetailPage/artist_page.dart';
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
                  //navigateToDetail(context, artist);

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ArtistPage(
                        tag: "artistHighlight$index",
                        url: artist.image,
                        artist: artist);
                  }));
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Hero(
                          tag: "artistHighlight$index",
                          child: Container(
                              height: 170,
                              width: 400,
                              child: ParallaxImage(
                                  extent: 150,
                                  image: CachedNetworkImageProvider(
                                      artist.image))),
                        ),
                        Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              artist.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
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

  navigateToDetail(BuildContext context, Artist artist) {
    Navigator.pushNamed(context, 'artist_page', arguments: artist);
  }
}
