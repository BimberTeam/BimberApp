import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';

class GroupDetailsList extends StatelessWidget{
  final int age;
  final int distance;
  final List<User> members;

  GroupDetailsList({
    @required this.members,
    @required this.age,
    @required this.distance,
  });

  _iconText(IconData icon, String text, Color color){
    return Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(text, style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor= Theme.of(context).colorScheme.secondary;
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
                  _iconText(Icons.group, "Liczba osób: ${members.length}", textColor),
                  _iconText(Icons.calendar_today, "Średni wiek: ${age}", textColor),
                  distance>=0 ? _iconText(Icons.location_on, "${distance}km", textColor) : Container(),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                 //todo user list
                ],
              ),
            )
        ),
      ]),
    );
  }

}