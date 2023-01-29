import 'dart:math';

import 'package:festivia/models/YoNuncaWords.dart';
import 'package:flutter/material.dart';

import '../../models/VerdadRetoWords.dart';

class VerdadORetoController {
  BuildContext context;
  Function refresh;
  List<String> words = YoNuncaWords;
  List<String> retos = RetoWords;
  String word = "...";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    words.shuffle();
  }

  void getVerdad() {
    final _random = new Random();
    var element = words[_random.nextInt(words.length)];
    word = element;
    refresh();
  }

  void getRetos() {
    final _random = new Random();
    var element = retos[_random.nextInt(retos.length)];
    word = element;
    refresh();
  }
}
