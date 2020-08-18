import 'package:bimber/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GroupDetailsAppBar extends StatelessWidget{
  final double appBarHeight;
  final List<User> members;
  GroupDetailsAppBar({
    @required this.appBarHeight,
    @required this.members});

  _backgroundImage(List<String> imageUrls, double height, double width){
      int crossAxisCount = sqrt(imageUrls.length).ceil();
      return GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: (width/height),
          children: imageUrls.map((String url) {
            return GridTile(
                child: _cachedImage(url));
          }).toList()
      );
  }

  _cachedImage(String imageUrl){
    return  CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, image) {
        return FittedBox(
          fit: BoxFit.cover,
          child: Image(image: image),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          FittedBox(
              fit: BoxFit.contain,
              child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 1,)),
      errorWidget: (context, url, error) =>
        FittedBox(
          fit: BoxFit.contain,
          child:Icon(Icons.error, color: Colors.red)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: appBarHeight,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: LayoutBuilder(
            builder: ((BuildContext context, BoxConstraints constraints) {
              if(constraints.biggest.height < 85){
                return Text("Grupa");
              } else{
                return Container();
              }
            }),
          ),
          background: _backgroundImage(members.map((e) => e.imageUrl).toList(), appBarHeight, MediaQuery.of(context).size.width)
      ),
    );
  }

}