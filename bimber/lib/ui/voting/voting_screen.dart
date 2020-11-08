import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:bimber/ui/voting/voting_result.dart';
import 'package:build_context/build_context.dart';
import 'package:bimber/ui/invitations/invitations_list.dart';
import 'package:flutter/material.dart';

class VotingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen>
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
    Color currentColor = _tabController.index == index
        ? Theme.of(context).accentColor
        : Theme.of(context).colorScheme.primaryVariant;
    return Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                      color: currentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Baloo'),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  color: currentColor,
                  size: 30.0,
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kandydaci do grupy",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              _tabBar(icon: Icons.how_to_vote, index: 0, text: "Głosuj"),
              _tabBar(icon: Icons.bar_chart, index: 1, text: "Wyniki"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            InvitationsList<User>(
              list: Fixtures.getUSAPresidents(),
              onRefresh: () {},
              createLeadingWidget: (User user) => UserImageHero(
                  user: user,
                  size: Size(60, 60),
                  radius: BorderRadius.circular(15.0),
                  onTap: () {
                    context.pushNamed("/user-details", arguments: user);
                  }),
              createTitle: (User user) => user.name,
              createSubtitle: (User user) => user.age.toString(),
              onAccept: (User user) {},
              onDecline: (User user) {},
            ),
            VotingResults(
              candidates: Fixtures.getGroupCandidates(),
            )
          ],
        ));
  }
}
