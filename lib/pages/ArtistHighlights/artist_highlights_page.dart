import 'package:festivia/models/Artist.dart';
import 'package:festivia/pages/ArtistHighlights/artist_highlights_controller.dart';
import 'package:festivia/widgets/artist_highlights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ArtistHighlights extends StatefulWidget {
  @override
  State<ArtistHighlights> createState() => _ArtistHighlightsState();
}

class _ArtistHighlightsState extends State<ArtistHighlights> {
  ArtistHighlightsController _con = new ArtistHighlightsController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Artistas mas popularess 🔥",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                    future: _con.getArtist(),
                    builder: (context, AsyncSnapshot<List<Artist>> snapshot) {
                      return ArtistList(snapshot: snapshot);
                    }),
              ],
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
