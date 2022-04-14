import 'package:festivia/models/Artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtistController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Artist artist = new Artist(
    id: "",
    name: "",
    instagram: "",
    facebook: "",
    soundcloud: "",
    youtube: "",
    likes: 0,
    bio: "",
    genres: [""],
    image: "",
  );

  String idEvent;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    artist = ModalRoute.of(context).settings.arguments as Artist;
    refresh();
  }
}
