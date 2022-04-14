import 'package:festivia/models/Artist.dart';
import 'package:festivia/providers/artist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ArtistHighlightsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  ArtistProvider _artistsProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _artistsProvider = new ArtistProvider();
    refresh();
  }

  Future<List<Artist>> getArtist() async {
    var artist = await _artistsProvider.getArtists();

    return artist;
  }
}
