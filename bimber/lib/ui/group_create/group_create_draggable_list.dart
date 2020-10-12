import 'package:bimber/models/user.dart';
import 'package:dotted_border/dotted_border.dart';
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
  final GlobalKey<AnimatedListState> membersListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    friendsAvailable = widget.friends;
    friendsAdded = [];
    super.initState();
  }

  Widget sizeIt(BuildContext context, User user, int index, animation) {
    return SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: CurvedAnimation(
            parent: animation,
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceIn),
        child: LongPressDraggable(
          child: _draggableChild(user, context),
          childWhenDragging: _draggableChild(user, context),
          feedback: _draggableChild(user, context),
          onDragStarted: () {
            userDragged = user;
            listKey.currentState.removeItem(index,
                (_, animation) => sizeIt(context, user, index, animation),
                duration: Duration(milliseconds: 700));
            setState(() {
              friendsAvailable.removeAt(index);
            });
          },
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            friendsAvailable.insert(index, userDragged);
            userDragged = null;
            listKey.currentState
                .insertItem(index, duration: Duration(milliseconds: 700));
          },
          onDragCompleted: () {
            friendsAdded.insert(0, userDragged);
            userDragged = null;
            membersListKey.currentState
                .insertItem(0, duration: Duration(milliseconds: 700));
          },
        ));
  }

  Widget _draggableChild(User user, BuildContext context) {
    return Opacity(
      opacity: user == userDragged ? 0 : 1,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(top: 5),
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryVariant,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(0.4))
              ]),
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
          )),
    );
  }

  Widget _animatedListTile(
      BuildContext context, User user, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn),
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryVariant,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: ListTile(
              leading: UserImageHero(
                  radius: BorderRadius.circular(15.0),
                  user: user,
                  size: Size(60, 60),
                  onTap: () {}),
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
              trailing: GestureDetector(
                onTap: () {
                  friendsAvailable.insert(0, user);
                  listKey.currentState
                      .insertItem(0, duration: Duration(milliseconds: 700));
                  membersListKey.currentState.removeItem(
                      index,
                      (_, animation) =>
                          _animatedListTile(context, user, index, animation),
                      duration: Duration(milliseconds: 700));
                  setState(() {
                    friendsAdded.removeAt(index);
                  });
                },
                child: Icon(Icons.delete, color: Colors.red, size: 25),
              ))),
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
                      physics: BouncingScrollPhysics(),
                      initialItemCount: friendsAvailable.length,
                      key: listKey,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index, animation) => sizeIt(
                          context, friendsAvailable[index], index, animation),
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
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: DragTarget(
              onWillAccept: (data) => true,
              builder: (BuildContext context, candidateData, rejectedData) {
                Color borderColor;
                if (candidateData.isEmpty)
                  borderColor = Colors.grey;
                else
                  borderColor = Colors.green;
                return DottedBorder(
                  radius: Radius.circular(15),
                  borderType: BorderType.RRect,
                  color: borderColor,
                  strokeWidth: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Stack(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Przytrzymaj i przeciągnij znajomych",
                              style: TextStyle(
                                color: friendsAdded.isEmpty
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant
                                    : Colors.transparent,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Baloo',
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Positioned.fill(
                            child: AnimatedList(
                          physics: BouncingScrollPhysics(),
                          initialItemCount: friendsAdded.length,
                          key: membersListKey,
                          scrollDirection: Axis.vertical,
                          itemBuilder:
                              (context, index, Animation<double> animation) =>
                                  _animatedListTile(context,
                                      friendsAdded[index], index, animation),
                        )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
