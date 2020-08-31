import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';

class DetailsAppBar extends StatelessWidget {
  final double appBarHeight;
  final User user;

  DetailsAppBar({@required this.appBarHeight, @required this.user});

  _backgroundImage(double width) {
    return UserImageHero(
      user: user,
      width: width,
      height: appBarHeight,
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
              if (constraints.biggest.height < (silverAppBarHeight + 5)) {
                return Text("${user.name}");
              } else {
                return Container();
              }
            }),
          ),
          background: _backgroundImage(MediaQuery.of(context).size.width)),
    );
  }
}
