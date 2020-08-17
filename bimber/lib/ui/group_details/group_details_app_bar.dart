import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';

class GroupDetailsAppBar extends StatelessWidget{
  final double appBarHeight;
  final List<User> members;
  GroupDetailsAppBar({
    @required this.appBarHeight,
    @required this.members});

  _backgroundImage(double height){
    // todo grid view image
    return  Container(
      color: Colors.black
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
      expandedHeight: appBarHeight,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
          title: LayoutBuilder(
            builder: ((BuildContext context, BoxConstraints constraints) {
              if(constraints.biggest.height < 85){
                return Text("Grupa");
              } else{
                return Container();
              }
            }),
          ),
          background: _backgroundImage(appBarHeight)
      ),
    );
  }

}