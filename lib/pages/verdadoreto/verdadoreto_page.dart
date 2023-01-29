import 'package:festivia/pages/verdadoreto/verdadoreto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class VerdadoretoPage extends StatefulWidget {
  const VerdadoretoPage({Key key}) : super(key: key);

  @override
  _VerdadoretoPagePageState createState() => _VerdadoretoPagePageState();
}

class _VerdadoretoPagePageState extends State<VerdadoretoPage> {
  final VerdadORetoController _controller = VerdadORetoController();

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
              _buttonTrue(),
              _buttonChallenge()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonTrue() {
    return Container(
      height: 50.0,
      width: 200,
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          _controller.getVerdad();
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
              "Verdad",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: "Ubuntu"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonChallenge() {
    return Container(
      height: 50.0,
      width: 200,
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          _controller.getRetos();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 212, 27, 27),
                  Color.fromARGB(255, 249, 132, 42)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Reto",
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
