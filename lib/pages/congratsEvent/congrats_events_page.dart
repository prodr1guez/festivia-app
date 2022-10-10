import 'package:flutter/material.dart';

import '../../widgets/button_app.dart';
import 'package:festivia/utils/colors.dart' as utils;

class CongratsEvent extends StatefulWidget {
  @override
  State<CongratsEvent> createState() => _CongratsEventState();
}

class _CongratsEventState extends State<CongratsEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 130,
                height: 130,
                child: Image.asset("assets/check.png")),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text(
                "El evento se creo con exito!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: const Text(
                "Puedes ver todos tus eventos creados y las estadisticas del mismo en la seccion de tu Perfil -> Mis eventos",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20), child: _buttonContinue())
          ],
        ),
      ),
    );
  }

  Widget _buttonContinue() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Continuar',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: () => navigateToCongrats(context),
      ),
    );
  }

  navigateToCongrats(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, 'navigation', (route) => false);
  }
}
