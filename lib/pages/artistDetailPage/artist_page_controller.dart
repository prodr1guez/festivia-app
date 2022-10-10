import 'package:festivia/models/Artist.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/likes_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  LikeProvider _likeProvider = LikeProvider();
  ClientProvider _clientProvider = ClientProvider();
  AuthProvider _authProvider = AuthProvider();

  bool like = false;
  int numLikes;

  Color colorLike;
  Artist artist;

  String idEvent;
  Future init(BuildContext context, Function refresh, String idArtist,
      int likes, Artist artist) async {
    this.context = context;
    this.refresh = refresh;
    numLikes = likes;
    this.artist = artist;
    await getLike(idArtist);

    refresh();
  }

  getLike(String idArtist) async {
    like = await _clientProvider.getLikeById(
        _authProvider.getUser().uid, idArtist);

    if (like) {
      colorLike = Colors.red;
    } else {
      colorLike = Colors.white;
    }
    refresh();
  }

  setLike(String idArtist, int likes) {
    if (!like) {
      _clientProvider.addLikeArtist(_authProvider.getUser().uid, idArtist);
      _likeProvider.increaseLikeArtist(idArtist);
      numLikes = numLikes + 1;
      colorLike = Colors.red;
      like = true;
    } else {
      _clientProvider.removeLikeArtist(_authProvider.getUser().uid, idArtist);
      _likeProvider.decreaseLikeArtist(idArtist);
      numLikes = numLikes - 1;

      colorLike = Colors.white;
      like = false;
    }

    refresh();
  }

  navigateToUrl(BuildContext context, String url) async {
    if (url == null) return;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open';
    }
  }
}
