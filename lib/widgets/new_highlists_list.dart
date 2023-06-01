import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/pages/detailEvent/detail_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:intl/intl.dart';

import '../models/News.dart';
import '../pages/newsDetail/news_detail_page.dart';
import '../utils/DateParsed.dart';

class NewHighlistlist extends StatelessWidget {
  AsyncSnapshot<List<News>> snapshot;

  NewHighlistlist({this.snapshot});
  var shadows = [
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: Colors.black26),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: Colors.black26),
    Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: Colors.black26),
    Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: Colors.black26),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data == null ? 0 : snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          News news = snapshot.data[index];
          return CardNews(context, index, news);
        });
  }

  InkWell CardNews(BuildContext context, int index, News news) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return NewsPage(
              tag: "newsHighlight$index", url: news.image, news: news);
        }));
      },
      child: Container(
        height: 400,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: news.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            news.tittle,
                            style: TextStyle(
                                fontFamily: "Ubuntu",
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                                shadows: shadows),
                          ),
                          Text(news.date,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  shadows: shadows))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10)),
      ),
    );
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }

  void pushRoute(BuildContext context, String id) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (BuildContext context) => DetailEvent()));
  }
}
