import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    double _appBarHeight = MediaQuery.of(context).size.height*0.7;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            CustomScrollView(
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0.0,
                  forceElevated: true,
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
                  floating: true,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(user.name),
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          child: Image.network(user.imagePath, height: _appBarHeight, fit: BoxFit.cover,)
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 20.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
//                                  Row(
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.access_time,
//                                        color: Colors.cyan,
//                                      ),
//                                      Padding(
//                                        padding:
//                                        const EdgeInsets.all(8.0),
//                                        child: new Text("10:00  AM"),
//                                      )
//                                    ],
//                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.map,
//                                        color: Colors.cyan,
//                                      ),
//                                      Padding(
//                                        padding:
//                                        const EdgeInsets.all(8.0),
//                                        child: Text("15 MILES"),
//                                      )
//                                    ],
//                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 500,),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }

  
}