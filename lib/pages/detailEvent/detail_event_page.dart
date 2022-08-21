import 'package:cached_network_image/cached_network_image.dart';
import 'package:festivia/pages/detailEvent/detail_event_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:festivia/utils/colors.dart' as utils;

import '../../models/Event.dart';
import '../../utils/DateParsed.dart';
import '../imageFullScreen/image_full_screen_page.dart';

class DetailEvent extends StatefulWidget {
  final String tag;
  final String url;
  final Event event;

  DetailEvent(
      {Key key, @required this.tag, @required this.url, @required this.event})
      : assert(tag != null),
        assert(url != null),
        assert(event != null),
        super(key: key);

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  DetailEventController _controller = new DetailEventController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh, widget.event.id);
    });
  }

  bool _isOpen = false;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        child: Card(
            color: utils.Colors.BackgroundGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Estas interesado?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buttonReserve(),
              ],
            )),
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
                          tag: widget.tag, url: widget.event.image);
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
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20), child: _titleSection()),
                  _infoSection(),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        widget.event?.description,
                        style: TextStyle(fontSize: 18),
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
  Row _infoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _infoCell(title: 'Edad', value: widget.event?.ageMin),
        _infoCell(title: 'Musica', value: widget.event?.genders.toString()),
        _infoCell(title: 'Tipo', value: 'After party'),
      ],
    );
  }

  /// Info Cell
  _infoCell({String title, String value}) {
    return Container(
      height: 80,
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
              Text(title),
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.event?.tittle,
            style: TextStyle(
              fontFamily: 'NimbusSanL',
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Desde: ' +
                DateParse().DiaConHora(DateTime.parse(widget.event.dateStart)),
            style: TextStyle(
              fontFamily: 'NimbusSanL',
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hasta: ' +
                DateParse().DiaConHora(DateTime.parse(widget.event.dateStart)),
            style: TextStyle(
              fontFamily: 'NimbusSanL',
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              Container(
                width: 300,
                child: Text(
                  widget.event?.location,
                  style: TextStyle(
                      fontFamily: 'NimbusSanL',
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonReserve() {
    return Container(
      height: 50,
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(
        child: ButtonApp(
          onPressed: _controller.goToReserve,
          text: 'Reservar',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
