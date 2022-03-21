import 'package:festivia/models/BannerMainHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class BannerHome extends StatelessWidget {
  AsyncSnapshot<List<BannerMainHome>> snapshot;

  BannerHome({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: CarouselSlider.builder(
          unlimitedMode: true,
          slideBuilder: (index) {
            BannerMainHome sliderImage = snapshot.data[index];
            return InkWell(
              onTap: () {
                navigateToDetail(context, sliderImage.type, sliderImage.id);
              },
              child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    sliderImage.image,
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10)),
            );
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          slideTransform: CubeTransform(rotationAngle: 0),
          enableAutoSlider: false,
        ));
  }

  navigateToDetail(BuildContext context, String type, String id) {
    Navigator.pushNamed(context, 'detail_club', arguments: id);
  }
}
