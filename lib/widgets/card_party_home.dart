import 'package:festivia/models/SuggestParty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class CardPartyHome extends StatelessWidget {
  AsyncSnapshot<List<SuggestParty>> snapshot;

  CardPartyHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        child: CarouselSlider.builder(
          unlimitedMode: true,
          slideBuilder: (index) {
            SuggestParty sliderImage = snapshot.data[index];
            return InkWell(
              onTap: () {
                navigateToDetail(context, sliderImage.type, sliderImage.id);
              },
              child: Container(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 450,
                          child: Image.network(
                            sliderImage.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Festivia",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(
                                    "San Martin 300",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red),
                                  )),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Desde sab. 21 a las 12hs",
                                style: TextStyle(fontSize: 16),
                              )),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10)),
              ),
            );
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          slideTransform: CubeTransform(rotationAngle: 0),
          enableAutoSlider: true,
        ));
  }

  navigateToDetail(BuildContext context, String type, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }
}
