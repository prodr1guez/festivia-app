import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/models/Club.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/pages/detailClub/detail_club_controller.dart';
import 'package:festivia/widgets/events_clubs.dart';
import 'package:flutter/material.dart';
import 'package:festivia/pages/detailEvent/detail_event_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/HostEvent.dart';
import '../../models/data.dart';
import '../../widgets/mini_card_home.dart';
import '../../widgets/my_events_list.dart';
import '../imageFullScreen/image_full_screen_page.dart';
import '../map/map_controller.dart';
import '../search/search_controller.dart';

class DetailClubPage extends StatefulWidget {
  final String tag;
  final String url;
  final Club club;

  DetailClubPage(
      {Key key, @required this.tag, @required this.url, @required this.club})
      : assert(tag != null),
        assert(url != null),
        assert(club != null),
        super(key: key);
  @override
  _DetailClubPageState createState() => _DetailClubPageState();
}

class _DetailClubPageState extends State<DetailClubPage> {
  DetailClubController _controller = new DetailClubController();
  MapController _con = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh, widget.club.id);
      _con.init(context, refresh);
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
            parallaxOffset: 0.5,
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.60,
            maxHeight: MediaQuery.of(context).size.height * 0.90,
            body: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.7,
              child: Hero(
                tag: widget.tag,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageFullScreen(
                          tag: "club", url: _controller.club?.image);
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.url),
                        fit: BoxFit.cover,
                      ),
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: _titleSection(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Proximos eventos:",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  FutureBuilder(
                      future: _controller.getEventsClub(),
                      builder:
                          (context, AsyncSnapshot<List<HostEvent>> snapshot) {
                        return EventsClubs(snapshot: snapshot);
                      }),
                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Info",
                        style: TextStyle(fontSize: 30),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Text(
                          _controller.club?.description ?? "",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
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
  Row _infoSection() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          width: 140,
          height: 70,
          color: Colors.black,
        ),
        Container(
          width: 140,
          height: 70,
          color: Colors.black,
        )
      ],
    );
  }

  /// Info Cell
  _infoCell({String title, String value}) {
    return Container(
      height: 100,
      width: 110,
      child: Card(
          color: utils.Colors.BackgroundGrey,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[200], width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  "https://developer.augmentedlogic.com/image/style/tcard/osm-og.jpg"),
              Container(
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  value ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Text(
          _controller.club?.name != null ? _controller.club?.name : "",
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        _rowButtons(),
        /*
        Container(
          height: 150,
          margin: EdgeInsets.only(top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: _googleMapsWidget(),
          ),
        ),*/
        //_buttonReserve()
      ],
    );
  }

  Widget _buttonReserve() {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: ButtonApp(
          onPressed: () => _con.navigateToDetail(context),
          icon: Icons.location_pin,
          text: 'Como llegar a Republic bar',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _googleMapsWidget() {
    return Image.network(
        "https://developer.augmentedlogic.com/image/style/tcard/osm-og.jpg");
  }

  Row _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          height: 40,
          width: 130,
          child: ButtonApp(
            onPressed: () {
              _controller.navigateToMapPage(context);
            },
            icon: Icons.arrow_forward_ios,
            text: 'Como llegar',
            color: utils.Colors.festiviaColor,
            textColor: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          height: 40,
          width: 130,
          child: ButtonApp(
            text: 'Contacto',
            onPressed: () {
              _controller.navigateToContactClub(context);
            },
            color: utils.Colors.festiviaColor,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
