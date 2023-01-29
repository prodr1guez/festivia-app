import 'package:festivia/pages/start_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
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
              _itemGame("REY MANDA", "crown.png", ""),
              _itemGame("YO NUNCA", "silence.png", "yonunca_page"),
              _itemGame("VERDAD O RETO", "choose.png", "verdad_o_reto_page"),
              _itemGame("TODOS SEÑALAN", "point.png", "point_game_page")
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemGame(String name, String icon, String navigatePage) {
    return InkWell(
      onTap: (() {
        navigate(navigatePage);
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        height: 100,
        child: Card(
            color: Colors.pink[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        child: Image.asset(
                          'assets/' + icon,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _buttonGames() {
    return Container(
      height: 40.0,
      width: 120,
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {},
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
              "JUGAR",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu"),
            ),
          ),
        ),
      ),
    );
  }

  void navigate(String navigate) {
    Navigator.pushNamed(context, navigate);
  }

  void refresh() {
    setState(() {});
  }
}
