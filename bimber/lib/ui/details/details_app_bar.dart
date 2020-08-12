import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsAppBar extends StatelessWidget{
  final double appBarHeight;
  final String userName;
  final String imageUrl;
  DetailsAppBar({
  @required this.appBarHeight,
  @required this.userName,
  @required this.imageUrl});

  _backgroundImage(double height){
    return  CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, image) {
        return FittedBox(
          fit: BoxFit.cover,
          child: Image(image: image),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          SizedBox(
              height: height,
              child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red, size: 150),
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
               return Text("${userName}");
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