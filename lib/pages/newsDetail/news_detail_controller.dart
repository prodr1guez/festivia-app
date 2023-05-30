import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/likes_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/News.dart';

class NewsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  LikeProvider _likeProvider = LikeProvider();
  ClientProvider _clientProvider = ClientProvider();
  AuthProvider _authProvider = AuthProvider();

  bool like = false;
  int numLikes = 0;

  Color colorLike;
  News news;

  String idEvent;
  Future init(BuildContext context, Function refresh, String idNews, int likes,
      News news) async {
    this.context = context;
    this.refresh = refresh;
    numLikes = likes;
    this.news = news;
    await getLike(idNews);

    refresh();
  }

  getLike(String idNews) async {
    like = await _clientProvider.getLikeNewById(
        _authProvider.getUser().uid, idNews);

    if (like) {
      colorLike = Colors.red;
    } else {
      colorLike = Colors.white;
    }
    refresh();
  }

  setLike(String idNews, int likes) {
    if (!like) {
      _clientProvider.addLikeNews(_authProvider.getUser().uid, idNews);
      _likeProvider.increaseLikeNews(idNews);
      numLikes = numLikes + 1;
      colorLike = Colors.red;
      like = true;
    } else {
      _clientProvider.removeLikeNews(_authProvider.getUser().uid, idNews);
      _likeProvider.decreaseLikeNews(idNews);
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
