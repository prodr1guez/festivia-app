import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var arguments;
  int index = null;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      index = arguments["index"];
    }

    refresh();
  }
}
