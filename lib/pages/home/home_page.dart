import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:festivia/models/data.dart';
import 'package:festivia/widgets/banner_home.dart';
import 'package:festivia/widgets/card_blub_home.dart';
import 'package:festivia/widgets/card_party_home.dart';
import 'package:festivia/widgets/mini_card_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/HostEvent.dart';
import '../../widgets/my_events_list.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = new HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 30,
                      width: 120,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Image.asset("assets/festivia-cut.png")),
                ),
                FutureBuilder(
                    future: _con.getBannerMain(),
                    builder: (context,
                        AsyncSnapshot<List<BannerMainHome>> snapshot) {
                      return (snapshot.hasData)
                          ? BannerHome(snapshot: snapshot)
                          : Container(
                              width: double.infinity,
                              height: 200.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white,
                                child: Card(margin: EdgeInsets.all(10)),
                              ),
                            );
                      ;
                    }),
                Container(
                  child: MiniCardHome(
                    miniCardList: miniCardList,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Fiestas Recomendadas",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                    future: _con.getSuggestsParty(),
                    builder:
                        (context, AsyncSnapshot<List<SuggestParty>> snapshot) {
                      return (snapshot.hasData)
                          ? CardPartyHome(snapshot: snapshot)
                          : Container(
                              width: double.infinity,
                              height: 200.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white,
                                child: Card(margin: EdgeInsets.all(10)),
                              ),
                            );
                    }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Clubs Recomendados",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                ),
                FutureBuilder(
                    future: _con.getSuggestsClubs(),
                    builder:
                        (context, AsyncSnapshot<List<SuggestClub>> snapshot) {
                      return (snapshot.hasData)
                          ? Container(
                              margin: EdgeInsets.only(bottom: 80),
                              child: CardClubHome(snapshot: snapshot))
                          : Container(
                              width: double.infinity,
                              height: 200.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white,
                                child: Card(margin: EdgeInsets.all(10)),
                              ),
                            );
                    }),
              ],
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
