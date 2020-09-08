import 'package:flutter/material.dart';

class GroupChatList extends StatelessWidget {
  Widget _groupAvatar(BuildContext context, Color color) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          radius: 30,
        ),
        title: Text(
          "Harnas, Zubr, Tatra, Warka, Perłą",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          "Last message",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        trailing: Column(
          children: <Widget>[
            Text(
              "12:00",
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo'),
            ),
            Icon(
              Icons.new_releases,
              color: Colors.red,
              size: 20,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                "Grupy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Baloo'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 4.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                      _groupAvatar(context, Colors.white),
                    ],
                  )),
            )
          ],
        ));
  }
}
