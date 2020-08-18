import 'package:bimber/models/group.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/ui/group_details/group_details_app_bar.dart';
import 'package:bimber/ui/group_details/group_details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';

class GroupDetails extends StatefulWidget{
  final Group group;
  final Function like;
  final Function dislike;

  GroupDetails({
    @required this.group,
    this.like,
    this.dislike});
  @override
  State<StatefulWidget> createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetails>{
  ScrollController _scrollController;
  double _opacity;
  int _distance = -1;

  @override
  void initState() {
    super.initState();
    _opacity = 1.0;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse &&
          _scrollController.offset > 50) {
        setState(() {
          _opacity = 0.0;
        });
      }
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward &&
          _scrollController.offset < 50) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
    _initCurrentLocation();
  }

  _initCurrentLocation() async {
    final Location location = widget.group.averageLocation;
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      double distanceInMeters = await Geolocator()
          .distanceBetween(position.latitude, position.longitude, location.latitude, location.longtitude);
      setState(() {
        _distance = distanceInMeters~/1000;
      });
    } catch(e){}

  }

  _swipeButton(IconData icon, Color iconColor, Function onTap, BuildContext context){
    return  ClipOval(
      child: Material(
        color: Theme.of(context).colorScheme.primaryVariant, // button color
        child: InkWell(
          splashColor: Theme.of(context).accentColor, // inkwell color
          child: Icon(icon, color: iconColor, size: 50),
          onTap: onTap,
        ),
      ),
    );
  }

  List<Widget> _bottomBar(BuildContext context){
    if(widget.like == null || widget.dislike == null) return  List<Widget>();
    return [
      _animatedOpacity(Container(height: 55, color: Theme.of(context).colorScheme.primary)),
      _animatedOpacity(Container(
        padding: EdgeInsets.all(10),
        height: 100,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _swipeButton(Icons.clear, Colors.red, widget.dislike, context),
            _swipeButton(Icons.check, Colors.green, widget.like, context)
          ],
        ),
      )),
    ];
  }

  _animatedOpacity(Widget child){
    return  AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: _opacity,
      child: child,
    );
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
                GroupDetailsAppBar(appBarHeight: _appBarHeight,
                  members: widget.group.members,),
                GroupDetailsList( age: widget.group.averageAge,
                  distance: _distance,
                  members: widget.group.members,)
              ],
            ),
          ] + _bottomBar(context),
        ),
      ),
    );
  }

}