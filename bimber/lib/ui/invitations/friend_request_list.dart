import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class FriendRequestList extends StatelessWidget {
  final List<User> users;

  FriendRequestList({@required this.users});

  Widget _friendRequest(User user, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.primaryVariant,boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(3, 3),
                color: Colors.black.withOpacity(0.4))
      ]),
      child: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading:  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(3, -3),
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
          trailing: Container(
            width: MediaQuery.of(context).size.width*0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 50,
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.clear,
                    size: 25,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  minWidth: 50,
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.check,
                    size: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                )
              ],
            )),
          ),
    );
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
