import 'package:bimber/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupDetailsList extends StatelessWidget{
  final int age;
  final int distance;
  final List<User> members;

  GroupDetailsList({
    @required this.members,
    @required this.age,
    @required this.distance,
  });

  _iconText(IconData icon, String text, Color color){
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
  
  _membersList(List<User> members, Color color){
    return GridView.count(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 40.0,
        childAspectRatio: 110/125,
        padding: EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: members.map((e) => _memberAvatar(e, color)).toList()
    );
  }
  
  Widget _memberAvatar(User user, Color color){
    return Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: user.imageUrl,
            imageBuilder: (context, image) {
              return Container(
                width: 110.0,
                height: 110.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: image, fit: BoxFit.cover),
                ),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child:  FittedBox(
                      fit: BoxFit.contain,
                      child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 1,)),
                ),
            errorWidget: (context, url, error) =>
                Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child:Icon(Icons.error, color: Colors.red)),
                )
          ),
          Text("${user.name}", style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor= Theme.of(context).colorScheme.secondary;
    double containerHeight = MediaQuery.of(context).size.height - 100;
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: containerHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _iconText(Icons.group, "Liczba osób: ${members.length}", textColor),
                  _iconText(Icons.calendar_today, "Średni wiek: ${age}", textColor),
                  distance>=0 ? _iconText(Icons.location_on, "${distance}km", textColor) : Container(),
                  Divider(
                    height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  _membersList(members, textColor)
                ] ,
              ),
            )
        ),
      ]),
    );
  }

}