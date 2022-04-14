import 'package:festivia/pages/artistDetailPage/artist_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/pages/detailEvent/detail_event_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:festivia/utils/colors.dart' as utils;

class ArtistPage extends StatefulWidget {
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
      _controller.init(context, refresh);
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(_controller.artist.image == null
                          ? ""
                          : _controller.artist.image),
                      fit: BoxFit.cover),
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
              height: MediaQuery.of(context).size.height * 0.15,
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
                  ),
                  IconButton(
                    icon: Image.asset('assets/instagram.png'),
                  ),
                  IconButton(
                    icon: Image.asset('assets/soundcloud.png'),
                  ),
                  IconButton(
                    icon: Image.asset('assets/youtube.png'),
                  )
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
                        _controller.artist.likes.toString() +
                        " personas les gusta este artista",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
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
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          label: Text('Me gusta'), // <-- Text
                          backgroundColor: Colors.black,
                          icon: Icon(
                            // <-- Icon
                            Icons.favorite_border,
                            size: 24.0,
                          ),
                          onPressed: () {},
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Text(
                        _controller.artist.bio,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Montserrat",
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
  Container _infoSection() {
    return Container(
      child: Center(
        child: Text(_controller.artist.genres[0],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'NimbusSanL',
                fontStyle: FontStyle.italic,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey)),
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
              _controller.artist.name,
              style: TextStyle(
                fontFamily: 'NimbusSanL',
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
