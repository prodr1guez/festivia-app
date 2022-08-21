import 'package:festivia/models/Artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageFullScreenController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String url;
  String idEvent;
  var arguments;
  Future init(BuildContext context, Function refresh) async {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    this.context = context;
    this.refresh = refresh;
    refresh();
  }
}
