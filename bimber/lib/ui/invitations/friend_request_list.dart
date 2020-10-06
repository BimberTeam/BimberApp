import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class FriendRequestList extends StatelessWidget {
  final List<User> users;

  FriendRequestList({@required this.users});

  Widget _friendRequest(User user, BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        leading:  Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    offset: Offset(5, -5),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: UserImageHero(
                user: user,
                size: Size(60, 60),
                onTap: () {
                  context.pushNamed("/user-details", arguments: user);
                }),
          ),
        ),
        title: Text(
          user.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          user.age.toString(),
          style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        trailing: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 120,
              height: 35,
              child: RaisedButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.green,
                child: Text("Akceptuj",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo')),
              ),
              ),
            GestureDetector(
              onTap: (){},
              child: Text("Odrzuć", style:  TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: users.map((user) => _friendRequest(user, context)).toList(),
      ),
    );
  }
}
