import 'package:bimber/models/group.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class GroupRequestList extends StatelessWidget {
  final List<Group> groups;

  GroupRequestList({@required this.groups});

  Widget _friendRequest(Group group, BuildContext context) {
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
        leading: GestureDetector(
          onTap: (){
            context.pushNamed("/group-details", arguments: group);
          },
          child: Container(
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
                child: GroupImageHero(group: group, size: Size(60, 60))
            ),
          ),
        ),
        title: Text(
          "Grupa",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          "${group.members.length.toString()} osób",
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
        children: groups.map((group) => _friendRequest(group, context)).toList(),
      ),
    );
  }
}
