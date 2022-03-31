import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtistController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }
}
