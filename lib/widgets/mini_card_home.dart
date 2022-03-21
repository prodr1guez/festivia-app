import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/MiniCard.dart';
import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

class MiniCardHome extends StatelessWidget {
  final List<MiniCard> miniCardList;

  const MiniCardHome({
    Key key,
    @required this.miniCardList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            itemCount: miniCardList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  navigateToDetail(context, "ada");
                },
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          child: ParallaxImage(
                              extent: 180,
                              image: AssetImage(miniCardList[index].imageUrl)),
                        ),
                        Container(
                          height: 30,
                          child: Center(
                            child: Text(
                              miniCardList[index].tittle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10)),
              );
            }));
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, 'detail_event', arguments: id);
  }
}
