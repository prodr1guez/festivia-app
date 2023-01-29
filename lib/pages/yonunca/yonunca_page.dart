import 'package:festivia/pages/start_controller.dart';
import 'package:festivia/pages/yonunca/yonunca_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class YonuncaPage extends StatefulWidget {
  const YonuncaPage({Key key}) : super(key: key);

  @override
  _YonuncaPagePageState createState() => _YonuncaPagePageState();
}

class _YonuncaPagePageState extends State<YonuncaPage> {
  final YonuncaController _controller = YonuncaController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backu.png"), fit: BoxFit.cover)),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Yo nunca...",
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  _controller.word,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              _buttonGames()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonGames() {
    return Container(
      height: 50.0,
      width: 200,
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          _controller.getWord();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff3e2b57), Colors.indigo[900]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Siguiente",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: "Ubuntu"),
            ),
          ),
        ),
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
