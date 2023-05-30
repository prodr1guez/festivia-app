import 'package:festivia/pages/games/games_controller.dart';
import 'package:festivia/pages/start_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:flutter/scheduler.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key key}) : super(key: key);
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  GamesController _controller = GamesController();
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
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "¡Previá con Festivia!",
                  style: TextStyle(
                      color: Colors.white, fontSize: 30, fontFamily: "Ubuntu"),
                ),
              ),
              _itemGame("YO NUNCA", "silence.png", "yonunca_page"),
              _itemGame("VERDAD O RETO", "choose.png", "verdad_o_reto_page"),
              _itemGame("TODOS SEÑALAN", "point.png", "point_game_page"),
              _itemGame("REY MANDA", "crown.png", ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemGame(String name, String icon, String navigatePage) {
    return InkWell(
      onTap: (() {
        _controller.navigate(navigatePage);
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
                        overflow: TextOverflow.ellipsis,
                        fontSize: 17,
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 10),
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

  void refresh() {
    setState(() {});
  }
}
