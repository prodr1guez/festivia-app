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
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: miniCardList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  navigateToDetail(context, miniCardList[index].id);
                },
                child: Card(
                    color: Colors.grey[100],
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          child: ParallaxImage(
                              extent: 150,
                              image: AssetImage(miniCardList[index].imageUrl)),
                        ),
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 5, bottom: 5),
                              child: Text(
                                miniCardList[index].tittle,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5)),
              );
            }));
  }

  navigateToDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, id, arguments: id);
  }
}
