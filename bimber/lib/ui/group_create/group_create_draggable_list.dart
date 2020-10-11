import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';

class GroupCreateDraggableList extends StatefulWidget {
  final List<User> friends;

  GroupCreateDraggableList({@required this.friends});

  @override
  State<StatefulWidget> createState() => _GroupCreateDraggableListState();
}

class _GroupCreateDraggableListState extends State<GroupCreateDraggableList> {
  List<User> friendsAvailable;
  List<User> friendsAdded;
  User userDragged;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    friendsAvailable = widget.friends;
    friendsAdded = [];
    super.initState();
  }

  Widget sizeIt(BuildContext context, User user, int index, animation) {
    return SizeTransition(
      axis: Axis.horizontal,
      sizeFactor: animation,
      child: SizedBox(
        width: 100,
        child: LongPressDraggable(
          child: _animatedListTile(user, context),
          childWhenDragging: _animatedListTile(user, context),
          feedback: _animatedListTile(user, context),
          onDragStarted: () {
            userDragged = user;
            listKey.currentState.removeItem(
                index, (_, animation) => sizeIt(context, user, index, animation),
                duration: Duration(milliseconds: 500));
            friendsAvailable.removeAt(index);
          },
          onDraggableCanceled: (Velocity velocity, Offset offset){
            friendsAvailable.insert(index, userDragged);
            listKey.currentState.insertItem(index,
                duration: Duration(milliseconds: 500));
          },
        )
      ),
    );
  }

  Widget _animatedListTile(User user, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryVariant,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(3, 3),
                color: Colors.black.withOpacity(0.4))
          ]),
      child: Row(
          children: [
          Container(
              padding: EdgeInsets.only(top: 5),
              width: 90,
              child: Column(
                children: [
                  UserImageHero(
                      radius: BorderRadius.circular(15.0),
                      user: user,
                      size: Size(60, 60),
                      onTap: () {}),
                  Text(
                    user.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo',
                        decoration: TextDecoration.none),
                  )
                ],
              )
          ),
            Container(
              child: Column(
                children: [
                  AnimatedContainer(
                    width: 0,
                    height: 0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      user.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                    ),
                  ),
                  AnimatedContainer(
                    width: 0,
                    height: 0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      user.age.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              width: 0,
              height: 0,
              duration: Duration(milliseconds: 500),
              child: Icon(Icons.delete, color: Colors.transparent, size: 15),
            )
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 180,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: 130,
                    child: AnimatedList(
                      initialItemCount: friendsAvailable.length,
                      key: listKey,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index, animation) => sizeIt(context, friendsAvailable[index], index, animation),
                )),
                Text("Wybierz członków",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo')),
              ],
            )),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  )),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),),
        )
      ],
    );
  }
}
