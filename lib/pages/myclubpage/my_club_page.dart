import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/pages/myclubpage/my_club_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:festivia/utils/colors.dart' as utils;

class MyClubPage extends StatefulWidget {
  @override
  _MyClubPageState createState() => _MyClubPageState();
}

class _MyClubPageState extends State<MyClubPage> {
  MyClubController _controller = new MyClubController();

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
            parallaxOffset: 0.5,
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.45,
            maxHeight: MediaQuery.of(context).size.height * 0.45,
            body: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.7,
              child: _controller.club?.image != null
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              _controller.club?.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Card(margin: EdgeInsets.all(10)),
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
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              Container(
                width: 250,
                child: Text(
                  _controller.club?.location ?? "",
                  style: const TextStyle(
                      fontFamily: 'NimbusSanL',
                      overflow: TextOverflow.ellipsis,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
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

  Row _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          height: 40,
          width: 150,
          child: ButtonApp(
            onPressed: () {
              _controller.navigateToEditPage(context);
            },
            icon: Icons.arrow_forward_ios,
            text: 'Editar datos',
            color: utils.Colors.festiviaColor,
            textColor: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          height: 40,
          width: 150,
          child: ButtonApp(
            text: 'Cerrar sesión',
            onPressed: () {
              _controller.logout();
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
