import 'package:festivia/pages/start_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final StartController _controller = StartController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.laoding == true
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Column(),
          )
        : Scaffold(
            body: DecoratedBox(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/backu.png"),
                      fit: BoxFit.cover)),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      child: Image.asset(
                        'assets/festivia_slogan_blanco.png',
                        width: 270.0,
                        height: 270.0,
                      ),
                      padding: EdgeInsets.only(top: 190, left: 20, right: 20),
                    ),
                    _buttonLogin(),
                    _buttonRegisterText(),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _textTermsAndConditions(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buttonRegisterText() {
    return InkWell(
      onTap: () => toRegister(),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: const Text(
            "Registrar ahora",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _textTermsAndConditions() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                  text:
                      'Al hacer clic en cualquiera de las opciones anteriores, estarás aceptando los',
                  style:
                      TextStyle(color: Colors.grey[400], fontFamily: "Ubuntu")),
              TextSpan(
                  text: ' Términos de uso',
                  recognizer: TapGestureRecognizer()
                    ..onTap = (() {
                      toTermsAndConditions();
                    }),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Ubuntu")),
              TextSpan(
                  text: ' y la ',
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    color: Colors.grey[400],
                  )),
              // ignore: unnecessary_new
              new TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = (() {
                      toPrivacyPolicy();
                    }),
                  text: 'Política de privacidad ',
                  style: const TextStyle(
                      fontFamily: "Ubuntu", fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'de Festivia',
                  style:
                      TextStyle(fontFamily: "Ubuntu", color: Colors.grey[400])),
            ],
          ),
        ));
  }

  Widget _buttonLogin() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: ButtonApp(
        text: 'Iniciar Sesión',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: toLogin,
      ),
    );
  }

  void toLogin() {
    Navigator.pushNamed(context, 'login');
  }

  void toTermsAndConditions() {
    Navigator.pushNamed(context, 'terms_and_conditions');
  }

  void toPrivacyPolicy() {
    Navigator.pushNamed(context, 'privacy_policy');
  }

  void toRegister() {
    Navigator.pushNamed(context, 'select_type_user');
  }

  void refresh() {
    setState(() {});
  }
}
