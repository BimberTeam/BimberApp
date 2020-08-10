import 'package:bimber/ui/account/info_card.dart';
import 'package:flutter/material.dart';

// TODO: account screen is being used inside home screen and there should be sliver appbard
// help is here: https://stackoverflow.com/questions/50741732/how-to-implement-a-sliverappbar-with-a-tabbar
// or either paralax effect on account picture
class AccountScreen extends StatelessWidget {
  final backCardColor = Color.fromRGBO(40, 30, 50, 1.0);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      physics: PageScrollPhysics(),
      slivers: <Widget>[
        // _profileAvatar(context, "Duperka", "duperka@gmail.com"),
        _appBar(context),
        _information(context)
      ],
    );
  }

  _appBar(context) {
    return SliverAppBar(
        leading: Container(),
        expandedHeight: 350,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background:
                _profileAvatar(context, "Duperka", "duperka@gmail.com")));
  }

  _profileAvatar(BuildContext context, String name, String email) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    offset: Offset(5, 5),
                    // spreadRadius: 15,
                  )
                ],
                color: Colors.grey),
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

  _information(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: true,
      child: Container(
          decoration: BoxDecoration(
              color: backCardColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            children: <Widget>[
              divider,
              SizedBox(height: 10),
              Text("Informacje:",
                  style: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.blueGrey,
                      fontSize: 20)),
              SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50, maxHeight: 100),
                child: ListView(
                  shrinkWrap: true, //just set this property
                  // padding: const EdgeInsets.all(10.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InfoCard(
                        color: Colors.blue,
                        title: "Opis",
                        icon: Icons.access_alarm),
                    SizedBox(
                      width: 30,
                    ),
                    InfoCard(
                        color: Colors.red,
                        title: "Ulubiony alkohol",
                        icon: Icons.access_alarm),
                    SizedBox(
                      width: 30,
                    ),
                    InfoCard(
                        color: Colors.green,
                        title: "Preferencje",
                        icon: Icons.access_alarm)
                  ],
                ),
              )
            ],
          )),
    );
  }

  final divider = Container(
    margin: EdgeInsets.only(left: 50, right: 50, top: 15),
    height: 5,
    decoration: BoxDecoration(
        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
  );
}
