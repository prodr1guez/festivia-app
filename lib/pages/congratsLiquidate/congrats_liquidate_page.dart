import 'package:flutter/material.dart';

import '../../widgets/button_app.dart';
import 'package:festivia/utils/colors.dart' as utils;

class CongratsLiquidate extends StatefulWidget {
  @override
  State<CongratsLiquidate> createState() => _CongratsLiquidateState();
}

class _CongratsLiquidateState extends State<CongratsLiquidate> {
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
                "Se realizó la petición para liquidar tus ganancias",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu"),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text(
                "Nos pondremos en contacto al numero de telefono que ingresaste. Recuerda que podemos demorar hasta 3 dias habiles en realizar la transferencia, en caso de cualquier inconveniente puede contactar al equipo de FESTIVIA al mail info@festivia.app",
                style: TextStyle(fontSize: 16, fontFamily: "Ubuntu"),
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
    var arguments = ModalRoute.of(context).settings.arguments as Map;

    String type = arguments["type"];

    if (type == "client") {
      Navigator.pushNamedAndRemoveUntil(
          context, 'navigation', (route) => false);
    } else if (type == "club") {
      Navigator.pushNamedAndRemoveUntil(
          context, 'navigation_club', (route) => false);
    }
  }
}
