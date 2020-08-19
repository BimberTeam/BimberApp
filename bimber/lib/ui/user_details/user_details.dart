import 'package:bimber/models/location.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/user_details/details_app_bar.dart';
import 'package:bimber/ui/user_details/details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

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
    _initCurrentLocation();
  }

  _initCurrentLocation() async {
    final Location location = widget.user.location;
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      double distanceInMeters = await Geolocator()
          .distanceBetween(position.latitude, position.longitude, location.latitude, location.longtitude);
      setState(() {
        _distance = distanceInMeters~/1000;
      });
    } catch(e){}

  }

  @override
  Widget build(BuildContext context) {
    double _appBarHeight = MediaQuery.of(context).size.height*0.7;
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
                  userName: widget.user.name,
                  imageUrl: widget.user.imageUrl,),
                DetailsList(userName: widget.user.name,
                  age: widget.user.age,
                  favouriteAlcohol: widget.user.favouriteAlcohol,
                  distance: _distance,
                  gender: widget.user.gender,
                  description: widget.user.description,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}