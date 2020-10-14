import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/ui/account/sliver_account_header.dart';
import 'package:bimber/ui/account/sliver_fill_account_info.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double bottomSheetOpacity = 0;
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      final position = controller.position;
      setState(() {
        bottomSheetOpacity = position.extentBefore / position.maxScrollExtent;
      });
    });
    super.initState();
  }

  final AccountData accountData = AccountData(
      name: "Duperka",
      gender: Gender.FEMALE,
      age: 20,
      description: """
    This might be a lengthy description and that is due to testing needs of myself.
    Here we go with another line of no interesting facts about me.
    I like to party like no one, literally no one, I hate this shit.
    Get used to this, no one likes people, and I might be one of them.
    """,
      email: "duperka@gmail.com",
      imageUrl: "https://m.media-amazon.com/images/I/81v6uFs25CL._SS500_.jpg",
      genderPreference: Gender.MALE,
      agePreferenceFrom: 18,
      agePreferenceTo: 25,
      favoriteAlcoholName: "Harnaś",
      favoriteAlcoholType: AlcoholType.BEER,
      alcoholPreference: AlcoholType.VODKA);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: PageScrollPhysics(),
      slivers: <Widget>[
        SliverAccountHeader(
            name: accountData.name,
            email: accountData.email,
            imageUrl: accountData.imageUrl,
            onEditAccount: () {
              context.pushNamed("/edit-account", arguments: accountData);
            }),
        SliverFillAccountInfo(
            infoOpacity: bottomSheetOpacity, accountData: accountData)
      ],
    );
  }
}
