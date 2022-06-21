import 'package:flutter/material.dart';

import '../../widgets/button_app.dart';
import 'package:festivia/utils/colors.dart' as utils;

class EventStatsPage extends StatefulWidget {
  @override
  State<EventStatsPage> createState() => _EventStatsPageState();
}

class _EventStatsPageState extends State<EventStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Estadisticas - Festivia Party",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemStats(
                  "Asistiran",
                  328,
                  "personas",
                  Color(0xFFE78EA9),
                ),
                Container(width: 10),
                ItemStats(
                  "Vendidos",
                  150,
                  "free",
                  Color(0xFFFEB139),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemStats(
                  "Vendidos",
                  20,
                  "generales",
                  Color(0xFFFFD59E),
                ),
                Container(width: 10),
                ItemStats(
                  "Vendidos",
                  150,
                  "vip",
                  Color(0xFFB9F8D3),
                ),
              ],
            ),
            Gains(),
            _buttonViewLists(),
            _buttonOutMoney(),
            _buttonPromotionate(),
          ],
        ),
      ),
    ));
  }

  Card Gains() {
    return Card(
      color: Color(0xFFFFFBE7),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        "Ganancias",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "3200\$",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card ItemStats(String tittle, int number, String descrip, Color color) {
    return Card(
      color: color,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Text(
              tittle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              number.toString(),
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              descrip,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buttonOutMoney() {
    return Container(
      height: 50,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          child: RaisedButton(
        onPressed: () {},
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Liquidar ganancias",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 50,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      )),
    );
  }

  Widget _buttonPromotionate() {
    return Container(
      height: 50,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
          child: RaisedButton(
        onPressed: () {},
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Promocionar evento",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 50,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      )),
    );
  }

  Widget _buttonViewLists() {
    return Container(
      height: 50,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
          child: RaisedButton(
        onPressed: () {},
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Administrar listas de asistentes",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 50,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      )),
    );
  }
}
