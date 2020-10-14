import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final void Function() onTap;

  InfoTile({this.title, this.icon, this.color, this.onTap});

  final titleStyle = TextStyle(
      fontFamily: "Baloo",
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 10);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
            boxShadow: [
              BoxShadow(color: color, offset: Offset(5, 5), blurRadius: 15)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  icon,
                  size: 40,
                  color: Colors.grey,
                ),
                Text(title, style: titleStyle),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
