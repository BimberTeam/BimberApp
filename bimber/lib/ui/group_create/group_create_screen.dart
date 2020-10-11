import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/group_create/group_create_draggable_list.dart';
import 'package:flutter/material.dart';

class GroupCreateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
      body: GroupCreateDraggableList(friends: Fixtures.getUsersList())
    );
  }
}
