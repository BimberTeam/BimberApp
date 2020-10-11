import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/language_utils.dart';

class DetailsList extends StatelessWidget {
  final User user;
  final int distance;

  DetailsList({@required this.user, @required this.distance});

  _description(String text, Color color) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
        )
      ],
    );
  }

  _name(Color color) {
    return Row(children: <Widget>[
      Text(
        "${user.name}, ${user.age}",
        style: TextStyle(
            color: color,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            fontFamily: 'Baloo'),
      ),
    ]);
  }

  _iconText(IconData icon, String text, Color color) {
    return Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.secondary;
    double containerHeight = MediaQuery.of(context).size.height - 100;
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: containerHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _name(textColor),
                  _iconText(Icons.person, user.gender.readable(), textColor),
                  _iconText(
                      Icons.local_bar,
                      "${user.favoriteAlcoholType.readable()}: ${user.favoriteAlcoholName}",
                      textColor),
                  distance >= 0
                      ? _iconText(Icons.location_on, "${distance}km", textColor)
                      : Container(),
                  Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  _description(user.description, textColor),
                ],
              ),
            )),
      ]),
    );
  }
}
