import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class GroupDetailsList extends StatelessWidget {
  final double age;
  final int distance;
  final List<User> members;

  GroupDetailsList({
    @required this.members,
    @required this.age,
    @required this.distance,
  });

  _iconText(IconData icon, String text, Color color) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
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

  _membersList(
      BuildContext context, List<User> members, Color color, double size) {
    return GridView.count(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: size / (size + 15),
        padding: EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: members
            .map((e) => _memberAvatar(context, e, color, size))
            .toList());
  }

  Widget _memberAvatar(
      BuildContext context, User user, Color color, double size) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(5, -5),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: UserImageHero(
            radius: BorderRadius.circular(15.0),
            user: user,
            size: Size(size, size),
            onTap: () {
              context.pushNamed("/user-details", arguments: user);
            },
            showGradient: false,
          ),
        ),
        Text(
          "${user.name}",
          style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.secondary;
    double containerHeight = MediaQuery.of(context).size.height - 100;
    double avatarSize = (MediaQuery.of(context).size.width - 100) / 2;
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: containerHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _iconText(
                      Icons.group, "Liczba osób: ${members.length}", textColor),
                  _iconText(Icons.calendar_today, "Średni wiek: ${age.round()}",
                      textColor),
                  distance >= 0
                      ? _iconText(Icons.location_on, "$distance km", textColor)
                      : Container(),
                  Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  _membersList(context, members, textColor, avatarSize)
                ],
              ),
            )),
      ]),
    );
  }
}
