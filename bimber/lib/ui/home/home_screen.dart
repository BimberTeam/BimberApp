import 'package:bimber/ui/account/account_screen.dart';
import 'package:bimber/ui/chat_list/chat_list_screen.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/discover/discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.index = 1;
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBarIcon({int index, IconData icon}) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Icon(
          icon,
          color: _tabController.index == index
              ? Theme.of(context).colorScheme.secondaryVariant
              : Theme.of(context).accentColor,
          size: 30.0,
        ));
  }

  Widget _floatingActionButton(){
    if(_tabController.index == 2){
      return FloatingActionButton(onPressed: () => context.pushNamed("/group-create"), child: Icon(Icons.group_add, color: indigoDye,), backgroundColor: lemonMeringue,);
    } else return null;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 30),
          child: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              _tabBarIcon(icon: Icons.account_circle, index: 0),
              _tabBarIcon(icon: Icons.local_bar, index: 1),
              _tabBarIcon(icon: Icons.message, index: 2),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            AccountScreen(),
            DiscoverScreen(),
            ChatListScreen()
          ],
        ),
      floatingActionButton: _floatingActionButton(),);
  }
}
