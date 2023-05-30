import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:festivia/models/data.dart';
import 'package:festivia/pages/games/games_page.dart';
import 'package:festivia/widgets/banner_home.dart';
import 'package:festivia/widgets/card_blub_home.dart';
import 'package:festivia/widgets/card_party_home.dart';
import 'package:festivia/widgets/mini_card_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/Club.dart';
import '../../models/Event.dart';
import '../../widgets/games_button.dart';
import 'home_controller.dart';
import 'package:festivia/utils/colors.dart' as utils;

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
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 120,
                          margin: EdgeInsets.only(left: 10),
                          child: Image.asset("assets/logo_slogan_negro.png")),
                      Spacer(),
                      GamesButton(),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: _con.getBannerMain(),
                    builder: (context,
                        AsyncSnapshot<List<BannerMainHome>> snapshot) {
                      return (snapshot.hasData)
                          ? CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index, realindex) {
                                final item = snapshot.data[index];
                                return BannerHome(snapshot: item);
                              },
                              options: CarouselOptions(
                                  viewportFraction: 0.8,
                                  disableCenter: true,
                                  height: 200,
                                  autoPlay: false,
                                  scrollDirection: Axis.horizontal,
                                  autoPlayInterval: Duration(seconds: 7)),
                            )
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
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Ubuntu",
                        ),
                      )),
                ),
                FutureBuilder(
                    future: _con.getSuggestsParty(),
                    builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                      return (snapshot.hasData)
                          ? CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index, realindex) {
                                final item = snapshot.data[index];
                                return CardPartyHome(snapshot: item);
                              },
                              options: CarouselOptions(
                                  padEnds: false,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.scale,
                                  enlargeCenterPage: true,
                                  disableCenter: true,
                                  viewportFraction: 0.6,
                                  height: 150,
                                  autoPlay: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlayInterval: Duration(seconds: 4)),
                            )
                          : Container(
                              width: double.infinity,
                              height: 170.0,
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
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Clubs Recomendados",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Ubuntu",
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: FutureBuilder(
                      future: _con.getSuggestsClubs(),
                      builder: (context, AsyncSnapshot<List<Club>> snapshot) {
                        return (snapshot.hasData)
                            ? CarouselSlider.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index, realindex) {
                                  final item = snapshot.data[index];
                                  return CardClubHome(snapshot: item);
                                },
                                options: CarouselOptions(
                                    padEnds: false,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.scale,
                                    enlargeCenterPage: true,
                                    disableCenter: true,
                                    viewportFraction: 0.57,
                                    height: 170,
                                    autoPlay: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlayInterval: Duration(seconds: 5)),
                              )
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
                ),
              ],
            ),
          ),
        ));
  }

  void toGames() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return GamesPage();
    }));
  }

  void refresh() {
    setState(() {});
  }
}
