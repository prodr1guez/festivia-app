import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/pages/artistDetailPage/artist_page_controller.dart';
import 'package:festivia/pages/imageFullScreen/image_full_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/Artist.dart';

class ArtistPage extends StatefulWidget {
  final String tag;
  final String url;
  final Artist artist;

  ArtistPage(
      {Key key, @required this.tag, @required this.url, @required this.artist})
      : assert(tag != null),
        assert(url != null),
        assert(artist != null),
        super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  ArtistController _controller = new ArtistController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh, widget.artist.id, widget.artist.likes,
          widget.artist);
    });
  }

  bool _isOpen = false;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
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
            minHeight: MediaQuery.of(context).size.height * 0.60,
            maxHeight: MediaQuery.of(context).size.height * 0.90,
            body: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.45,
              child: Hero(
                tag: widget.tag,
                child: GestureDetector(
                  onTap: (() {
                    //Navigator.pushNamed(context, 'image_full_screen',
                    //  arguments: {"url": _controller.artist.image});

                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageFullScreen(
                          tag: widget.tag, url: widget.artist.image);
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
              height: MediaQuery.of(context).size.height * 0.12,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _titleSection(),
                  _infoSection(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('assets/facebook.png'),
                    onPressed: () {
                      _controller.navigateToUrl(
                          context, widget.artist.facebook);
                    },
                  ),
                  IconButton(
                      icon: Image.asset('assets/instagram.png'),
                      onPressed: () {
                        _controller.navigateToUrl(
                            context, widget.artist.instagram);
                      }),
                  IconButton(
                      icon: Image.asset('assets/soundcloud.png'),
                      onPressed: () {
                        _controller.navigateToUrl(
                            context, widget.artist.soundcloud);
                      }),
                  IconButton(
                      icon: Image.asset('assets/youtube.png'),
                      onPressed: () {
                        _controller.navigateToUrl(
                            context, widget.artist.youtube);
                      })
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
                        " personas les gusta este artista",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Ubuntu",
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Bio",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    Container(
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
                                widget.artist.id, widget.artist.likes);
                          },
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Text(
                        widget.artist.bio,
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

  /// Info Section
  Widget _infoSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var item in widget.artist.genres)
            Expanded(
              child: Text(item,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey)),
            ),
        ],
      ),
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.artist.name,
              style: TextStyle(
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.verified_rounded,
                color: Colors.blue,
              ),
            )
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ARTISTA DESTACADO',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
