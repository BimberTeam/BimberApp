import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/language_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';



class UserDetails extends StatefulWidget {
  final User user;
  final Function like;
  final Function dislike;

  UserDetails({
    @required this.user,
    this.like,
    this.dislike});

  @override
  State<StatefulWidget> createState() => UserDetailsState();
}

class UserDetailsState extends State<UserDetails>{
  ScrollController _scrollController;
  double _opacity;
  int distance = -1;

  @override
  void initState() {
    super.initState();
    _opacity = 1.0;
    _scrollController = new ScrollController();
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
    Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).then((position) async {
        print(position);
        double distanceInMeters = await Geolocator()
            .distanceBetween(position.latitude, position.longitude, widget.user.location.latitude, widget.user.location.longtitude);
        setState(() {
          distance = distanceInMeters~/1000;
        });
      }).catchError((e) {});
  }

  ClipOval createButton(IconData icon, Color iconColor, Function onTap, BuildContext context){
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

  Row createName(Color color){
    return Row(
      children: <Widget>[
        Text("${widget.user.name}, ${widget.user.age}", style: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),),
      ]
    );
  }

  Row createStatsRow(IconData icon, String text, Color color){
    return Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(text, style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),),
        )
      ],
    );
  }

  Container createBottomBar(BuildContext context){
    if(widget.like != null && widget.dislike != null){
      return  Container(
        padding: EdgeInsets.all(10),
        height: 100,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            createButton(Icons.clear, Colors.red, widget.dislike, context),
            createButton(Icons.check, Colors.green, widget.like, context)
          ],
        ),
      );
    } else{
      return Container();
    }
  }

  Row createDescription(String text, Color color){
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(text, style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),),
        )
      ],
    );
  }

  AnimatedOpacity animatedOpacity(Widget child){
    return  AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: _opacity,
        child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _appBarHeight = MediaQuery.of(context).size.height*0.7;
    Color textColor= Theme.of(context).colorScheme.secondary;
    double containerHeight = MediaQuery.of(context).size.height - 100;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                    ),
                  ),
                  expandedHeight: _appBarHeight,
                  pinned: true,
                  floating: false,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: LayoutBuilder(
                      builder: ((BuildContext context, BoxConstraints constraints) {
                        if(constraints.biggest.height < 85){
                          return Text("${widget.user.name}");
                        } else{
                          return Container();
                        }
                      }),
                    ),
                    background: Image.network(widget.user.imagePath, height: _appBarHeight, fit: BoxFit.cover, )
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                   Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: containerHeight),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            createName(textColor),
                            createStatsRow(Icons.person, widget.user.gender.readable(), textColor),
                            createStatsRow(Icons.local_bar, "${widget.user.favoriteAlcohol.type.readable()}: ${widget.user.favoriteAlcohol.name}", textColor),
                            distance>=0 ? createStatsRow(Icons.location_on, "${distance}km", textColor) : Container(),
                            Divider(
                              height: 20,
                              thickness: 2,
                              indent: 0,
                              endIndent: 0,
                            ),
                            createDescription(widget.user.description, textColor),
                          ],
                        ),
                      )
                    ),
                  ]),
                ),
              ],
            ),
           animatedOpacity(Container(height: 55, color: Theme.of(context).colorScheme.primary)),
           animatedOpacity(createBottomBar(context))
          ],
        ),
      ),
    );
  }

  
}