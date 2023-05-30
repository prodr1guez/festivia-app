import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/pages/artistDetailPage/artist_page_controller.dart';
import 'package:festivia/pages/imageFullScreen/image_full_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/Artist.dart';
import '../../models/News.dart';
import 'news_detail_controller.dart';

class NewsPage extends StatefulWidget {
  final String tag;
  final String url;
  final News news;

  NewsPage(
      {Key key, @required this.tag, @required this.url, @required this.news})
      : assert(tag != null),
        assert(url != null),
        assert(news != null),
        super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsController _controller = new NewsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(
          context, refresh, widget.news.id, widget.news.likes, widget.news);
    });
  }

  bool _isOpen = false;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Sliding Panel
            SlidingUpPanel(
              parallaxEnabled: true,
              parallaxOffset: 1,
              controller: _panelController,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
              ),
              minHeight: MediaQuery.of(context).size.height * 0.45,
              maxHeight: MediaQuery.of(context).size.height * 0.90,
              body: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 0.49,
                child: Hero(
                  tag: widget.tag,
                  child: GestureDetector(
                    onTap: (() {
                      //Navigator.pushNamed(context, 'image_full_screen',
                      //  arguments: {"url": _controller.artist.image});

                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ImageFullScreen(
                            tag: widget.tag, url: widget.news.image);
                      }));
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.url),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              panelBuilder: (ScrollController controller) =>
                  _panelBody(controller),
              onPanelSlide: (value) {
                if (value >= 0.2) {
                  if (!_isOpen) {
                    setState(() {
                      _isOpen = true;
                    });
                  }
                }
              },
              onPanelClosed: () {
                setState(() {
                  _isOpen = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************

  /// Panel Body
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 20;

    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              height: MediaQuery.of(context).size.height * 0.10,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _titleSection(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  Text(
                    " A " +
                        _controller.numLikes.toString() +
                        " personas les gusta",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Ubuntu",
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  Container(
                      height: 40,
                      margin: EdgeInsets.only(right: 20),
                      child: FloatingActionButton.extended(
                        label: Text(
                          'Me gusta',
                          style: TextStyle(
                            color: _controller.colorLike,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        backgroundColor: Colors.black,
                        icon: Icon(
                          // <-- Icon
                          Icons.favorite,
                          color: _controller.colorLike,
                          size: 24.0,
                        ),
                        onPressed: () {
                          _controller.setLike(
                              widget.news.id, widget.news.likes);
                        },
                      ))
                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Text(
                        widget.news.content.replaceAll('\\n', '\n'),
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Ubuntu",
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Action Section

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Text(
                widget.news.tittle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
