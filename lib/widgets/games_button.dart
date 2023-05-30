import 'package:festivia/pages/games/games_page.dart';
import 'package:flutter/material.dart';

class GamesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(100)),
      child: GestureDetector(
        onTap: () => {navigateToGames(context)},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox.fromSize(
            size: Size.fromRadius(25), // Image radius
            child: Image.asset('assets/icon_dice.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  navigateToGames(BuildContext context) {
    //Navigator.pushNamed(context, 'detail_event', arguments: id);

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return GamesPage();
    }));
  }
}
