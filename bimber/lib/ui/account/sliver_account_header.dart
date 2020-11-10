import 'package:bimber/ui/common/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SliverAccountHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  final Function onEditAccount;

  static final editButtonColor = indigoDye;

  SliverAccountHeader(
      {this.name, this.email, this.imageUrl, this.onEditAccount});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        leading: Container(),
        expandedHeight: 390,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(background: _avatar(context)));
  }

  Widget _avatar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, image) {
                return Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: image, fit: BoxFit.fill),
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
              errorWidget: (context, url, error) {
                return Icon(Icons.error, color: Colors.red, size: 150);
              }),
          SizedBox(height: 15),
          Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Baloo",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 30)),
          SizedBox(height: 10),
          _button(Icons.perm_identity, "EDYTUJ", onEditAccount),
          SizedBox(height: 10),
          _button(Icons.logout, "WYLOGUJ", () {}),
        ],
      ),
    );
  }

  _button(IconData icon, String text, Function onPressed) {
    return RaisedButton.icon(
      padding: EdgeInsets.symmetric(horizontal: 30),
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
      color: editButtonColor,
      elevation: 5,
      label: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }
}
