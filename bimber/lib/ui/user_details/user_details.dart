import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/user_details/details_app_bar.dart';
import 'package:bimber/ui/user_details/details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class UserDetails extends StatefulWidget {
  final User user;

  UserDetails({
    @required this.user});

  @override
  State<StatefulWidget> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>{
  ScrollController _scrollController;
  int _distance = -1;

  @override
  void initState() {
    super.initState();
    initCurrentLocation(widget.user.location, (distanceInMeters) {
      setState(() {
        _distance = distanceInMeters~/1000;
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
              controller: _scrollController,
              shrinkWrap: false,
              slivers: <Widget>[
                DetailsAppBar(appBarHeight: _appBarHeight,
                  user: widget.user,
                ),
                DetailsList(user: widget.user,
                  distance: _distance,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}