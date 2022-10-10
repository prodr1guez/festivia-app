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
                  navigateToDetail(context, miniCardList[index].id);
                },
                child: Card(
                    color: Colors.grey[100],
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
                          width: 150,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              miniCardList[index].tittle,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
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
    Navigator.pushNamed(context, id, arguments: id);
  }
}
