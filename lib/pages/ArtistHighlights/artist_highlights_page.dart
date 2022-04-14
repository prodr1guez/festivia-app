import 'package:festivia/models/Artist.dart';
import 'package:festivia/pages/ArtistHighlights/artist_highlights_controller.dart';
import 'package:festivia/utils/colors.dart';
import 'package:festivia/widgets/artist_highlights_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class ArtistHighlights extends StatefulWidget {
  @override
  State<ArtistHighlights> createState() => _ArtistHighlightsState();
}

class _ArtistHighlightsState extends State<ArtistHighlights> {
  ArtistHighlightsController _con = new ArtistHighlightsController();
  bool _isOpen = false;
  PanelController _panelController = PanelController();

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
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /// Sliding Panel
          SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: 0.90,
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.87,
            maxHeight: MediaQuery.of(context).size.height * 0.87,
            body: Container(
              color: Color(0xffa3cbe6),
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 0.45,
                child: Container(
                    margin: EdgeInsets.only(top: 55, left: 25),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Artistas destacados 🔥",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Los dj's mas reconocidos de la escena",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    )),
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

  FutureBuilder<List<Artist>> listArtist() {
    return FutureBuilder(
        future: _con.getArtist(),
        builder: (context, AsyncSnapshot<List<Artist>> snapshot) {
          return ArtistList(snapshot: snapshot);
        });
  }

  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 20;

    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: listArtist(),
    );
  }

  void refresh() {
    setState(() {});
  }
}
