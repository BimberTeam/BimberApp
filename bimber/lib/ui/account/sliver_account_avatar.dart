import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SliverAccountHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  SliverAccountHeader({this.name, this.email, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        leading: Container(),
        expandedHeight: 350,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(background: _avatar(context)));
  }

  Widget _avatar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, image) {
              return Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(image: image),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: Offset(5, 5),
                      )
                    ],
                    color: Colors.grey),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Colors.red, size: 150),
          ),
          SizedBox(height: 15),
          Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Baloo",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 30)),
          SizedBox(height: 10),
          Text(email,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.grey, fontSize: 20))
        ],
      ),
    );
  }
}
