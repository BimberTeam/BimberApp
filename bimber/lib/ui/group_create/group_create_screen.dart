import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';

class GroupCreateScreen extends StatelessWidget {
  _draggableChild(User friend, double size) {
    return UserImageHero(
        radius: BorderRadius.circular(15.0),
        user: friend,
        size: Size(size, size),
        onTap: () {});
  }

  Widget _draggableFriend(User friend, double size) {
    return Draggable(
        data: friend,
        child: _draggableChild(friend, size),
        feedback: _draggableChild(friend, size));
  }

  _friendList(BuildContext context, List<User> friends, double size) {
    return GridView.count(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 1,
        padding: EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        children: friends.map((e) => _draggableFriend(e, size)).toList());
  }

  @override
  Widget build(BuildContext context) {
    double avatarSize = (MediaQuery.of(context).size.width - 100) / 4;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Stwórz grupę",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo')),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: DragTarget(
              builder: (context, List<int> candidateData, rejectedData) {
                print(candidateData);
                return Container();
              },
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {},
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Text("Wybierz członków",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondaryVariant,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Baloo')),
                    _friendList(context, Fixtures.getUsersList(), avatarSize)
                  ],
                )),
          )
        ],
      ),
    );
  }
}
