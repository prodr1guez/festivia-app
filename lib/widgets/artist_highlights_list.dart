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
    return ListView.builder(
        padding: const EdgeInsets.all(30),
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
            child: Container(
              height: 250,
              child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: artist.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  artist.name,
                                  style: TextStyle(
                                      fontFamily: "Ubuntu",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 23,
                                      shadows: [
                                        Shadow(
                                            // bottomLeft
                                            offset: Offset(-1.5, -1.5),
                                            color: Colors.black),
                                        Shadow(
                                            // bottomRight
                                            offset: Offset(1.5, -1.5),
                                            color: Colors.black),
                                        Shadow(
                                            // topRight
                                            offset: Offset(1.5, 1.5),
                                            color: Colors.black),
                                        Shadow(
                                            // topLeft
                                            offset: Offset(-1.5, 1.5),
                                            color: Colors.black),
                                      ]),
                                ),
                              ],
                            ),
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
            ),
          );
        });
  }

  navigateToDetail(BuildContext context, Artist artist) {
    Navigator.pushNamed(context, 'artist_page', arguments: artist);
  }
}

/*

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

                        */