import 'package:bimber/models/group.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/group_details/group_details_app_bar.dart';
import 'package:bimber/ui/group_details/group_details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GroupDetails extends StatefulWidget {
  final Group group;

  GroupDetails({@required this.group});

  @override
  State<StatefulWidget> createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetails> {
  int _distance = -1;

  @override
  void initState() {
    super.initState();
    calculateCurrentDistanceFrom(widget.group.averageLocation,
        (distanceInMeters) {
      setState(() {
        _distance = distanceInMeters ~/ 1000;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _appBarHeight = MediaQuery.of(context).size.height * 0.7;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            CustomScrollView(
              shrinkWrap: false,
              slivers: <Widget>[
                GroupDetailsAppBar(
                  appBarHeight: _appBarHeight,
                  group: widget.group,
                ),
                GroupDetailsList(
                  age: widget.group.averageAge,
                  distance: _distance,
                  members: widget.group.members,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
