import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  InfoCard({this.title, this.icon, this.color});

  final titleStyle = TextStyle(
      fontFamily: "Baloo",
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 10);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
            boxShadow: [
              BoxShadow(color: color, offset: Offset(5, 5), blurRadius: 15)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            Text(title, style: titleStyle),
            SizedBox(height: 10),
          ],
        ));
  }
}
