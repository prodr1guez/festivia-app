import 'dart:math';

import 'package:festivia/models/YoNuncaWords.dart';
import 'package:flutter/material.dart';

class YonuncaController {
  BuildContext context;
  Function refresh;
  List<String> words = YoNuncaWords;
  String word = "-";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    words.shuffle();
  }

  void getWord() {
    final _random = new Random();
    var element = words[_random.nextInt(words.length)];
    word = element;
    refresh();
  }
}
