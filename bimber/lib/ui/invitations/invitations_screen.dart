import 'package:flutter/material.dart';

class InvitationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InvitationsScreenState();
}

class InvitationsScreenState extends State<InvitationsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.index = 0;
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBar({int index, IconData icon, String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(
              color: _tabController.index == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).colorScheme.primaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),)),
        Align(
            alignment: Alignment.centerRight,
            child: Icon(
              icon,
              color: _tabController.index == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).colorScheme.primaryVariant,
              size: 30.0,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zaproszenia", style: TextStyle(
              color: Theme.of(context).colorScheme.primaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo')),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              _tabBar(icon: Icons.person, index: 0, text: "Znajomi"),
              _tabBar(icon: Icons.people, index: 1, text: "Grupy"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            Text("Znajomi"),
            Text("Grupy")
          ],
        ));
  }
}
