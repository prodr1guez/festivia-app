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
              heightFactor: 0.45,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://scontent.fafa1-1.fna.fbcdn.net/v/t1.6435-9/209408089_939074876670084_6207235537546520818_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=n4luqbTggF0AX-ao0th&_nc_oc=AQnO8Dv1NsDZUcd-WNd65zwqsjPl1HuKGUBlUal0QNOCDXtrRuWYQTM7qoN0hBF_Rvo&_nc_ht=scontent.fafa1-1.fna&oh=00_AT_liW1FlFOUx3EOYQ822AVdwwo2SfVJwvptNungkzQtVQ&oe=626943A3"),
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
                    "A 120 personas les gusta este artista",
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
                        "Valentina Chaves es una joven DJ de la ciudad de Mendoza. Su sonido vanguardista, orientado hacia el Progressive y Deep House, se caracteriza por la prolijidad y la presencia de una fina selección musical en la cual el buen groove es imprescindible. La música la ha llevado a recorrer diversas discotecas de la región, conectándola con una amplia selección de artistas y referentes del Progressive House a nivel mundial como Hernan Cattaneo, Nick Warren, Sasha, Guy Mantzur, Henry Saiz, Graziano Raffa, John Cosani, Mariano Mellino, Kevin Di Serna, entre otros. Actualmente su foco está en el proceso de trasladar sus conocimientos y experiencias en la creación y producción musical de su autoría. Su primer contrato firmado fue para el sello ‘’Soundteller Records’’ con el track Frankie M & Valentina Chaves – La Prima (Original Mix) el cual recibió el support de muchos artistas y fue incluido en el episodio ‘’Resident 431’’ de Hernan Cattaneo. ",
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
        child: Text("#PROGRESSIVEHOUSE   #DEEPHOUSE  #ORGANICHOUSE",
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
              "Valentina Chaves",
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
