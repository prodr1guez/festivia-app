import 'package:festivia/pages/home_stats/home_club_controller.dart';
import 'package:flutter/material.dart';

import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class HomeStatsPage extends StatefulWidget {
  @override
  State<HomeStatsPage> createState() => _HomeStatsPageState();
}

class _HomeStatsPageState extends State<HomeStatsPage> {
  HomeClubController _controller = new HomeClubController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: 40,
                  width: 120,
                  margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                  child: Image.asset("assets/festivia-cut.png")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemStatsRevenueYear(
                  "Ganancias 2022",
                  _controller.club.revenueYear,
                  Color(0xFFE78EA9),
                ),
                Container(width: 10),
                ItemStatsTickerYear(
                  "Total tickets vendidos en 2022",
                  _controller.club.ticketsYear,
                  Color(0xFFFEB139),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemStatsTicketNextEvent(
                  "Tickets vendidos en proximos eventos",
                  _controller.club.ticketsNextEvents,
                  Color(0xFFFFD59E),
                ),
                Container(width: 10),
                ItemStatsNextEvents(
                  "Proximos eventos",
                  _controller.club.nextEvents,
                  Color(0xFFB9F8D3),
                ),
              ],
            ),
            Gains(),
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
                        "Ganancias sin liquidiar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "\$" + _controller.club.currentRevenue.toString(),
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

  Card ItemStatsNextEvents(String tittle, int number, Color color) {
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              number.toString(),
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }

  Card ItemStatsTickerYear(String tittle, int number, Color color) {
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            )),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  number.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Card ItemStatsTicketNextEvent(String tittle, int number, Color color) {
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              number.toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }

  Card ItemStatsRevenueYear(String tittle, double number, Color color) {
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
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              number.toString() + "K",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
          child: RaisedButton(
        onPressed: () {
          _controller.navigateToLiquidateRevenue(context);
        },
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
        onPressed: () {
          _controller.navigateToContactUs(context);
        },
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
                    "Promocionar evento o club",
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
        onPressed: () {
          _controller.navigateToContactUs(context);
        },
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

  void refresh() {
    setState(() {});
  }
}
