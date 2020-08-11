import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/language_utils.dart';

class UserDetails extends StatelessWidget{
  final User user;
  final Function like;
  final Function dislike;
  UserDetails({
  @required this.user,
  this.like,
  this.dislike});

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
        Text("${user.name}, ${user.age}", style: TextStyle(
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
    if(like != null && dislike != null){
      return  Container(
        padding: EdgeInsets.all(10),
        height: 100,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            createButton(Icons.clear, Colors.red, dislike, context),
            createButton(Icons.check, Colors.green, like, context)
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
                          return Text("${user.name}");
                        } else{
                          return Container();
                        }
                      }),
                    ),
                    background: Image.network(user.imagePath, height: _appBarHeight, fit: BoxFit.cover, )
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
                            createStatsRow(Icons.person, user.gender.readable(), textColor),
                            createStatsRow(Icons.local_bar, "${user.favoriteAlcohol.type.readable()}: ${user.favoriteAlcohol.name}", textColor),
                            createStatsRow(Icons.location_on, "10km", textColor),
                            Divider(
                              height: 20,
                              thickness: 2,
                              indent: 0,
                              endIndent: 0,
                            ),
                            createDescription(user.description, textColor),
                          ],
                        ),
                      )
                    ),
                  ]),
                ),
              ],
            ),
           Container(height: 55, color: Theme.of(context).colorScheme.primary),
           createBottomBar(context)
          ],
        ),
      ),
    );
  }

  
}