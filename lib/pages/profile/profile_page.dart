import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/pages/profile/profile_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:festivia/utils/colors.dart' as utils;

import '../../models/Event.dart';
import '../../utils/DateParsed.dart';
import '../imageFullScreen/image_full_screen_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _controller = new ProfileController();

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
      bottomSheet: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: (() {
                  _controller.openDialog();
                }),
                child: Text(
                  "ELIMINAR CUENTA",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
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
            minHeight: MediaQuery.of(context).size.height * 0.50,
            maxHeight: MediaQuery.of(context).size.height * 0.50,
            body: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.4,
              child: GestureDetector(
                onTap: () {
                  /*Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ImageFullScreen(
                        tag: widget.tag, url: _controller.client.image);
                  }));*/
                },
                child: Container(
                  decoration: BoxDecoration(),
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
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: _titleSection()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(5),
                          width: 150,
                          height: 50,
                          child: ButtonApp(
                            color: utils.Colors.festiviaColor,
                            onPressed: _controller.goToMyEvents,
                            text: "Mis eventos",
                          )),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 150,
                        height: 50,
                        child: ButtonApp(
                          color: utils.Colors.festiviaColor,
                          onPressed: _controller.logout,
                          text: "Cerrar sesión",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _controller.client.username,
            style: TextStyle(
              fontFamily: "Ubuntu",
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
