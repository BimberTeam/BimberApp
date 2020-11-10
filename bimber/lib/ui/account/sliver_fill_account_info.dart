import 'package:bimber/models/account_data.dart';
import 'package:bimber/ui/account/info_card.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/language_utils.dart';
import 'package:tinycolor/tinycolor.dart';

class SliverFillAccountInfo extends StatefulWidget {
  final AccountData accountData;
  final double infoOpacity;

  SliverFillAccountInfo(
      {@required this.accountData, @required this.infoOpacity});

  @override
  State<StatefulWidget> createState() => _SliverFillAccountInfoState();
}

class _SliverFillAccountInfoState extends State<SliverFillAccountInfo> {
  static final backCardColor = indigoDye;
  static final infoCardColor = TinyColor(indigoDye).darken(10).color;

  final divider = Container(
    margin: EdgeInsets.only(left: 50, right: 50, top: 15),
    height: 5,
    decoration: BoxDecoration(
        color: Colors.grey, borderRadius: BorderRadius.circular(10)),
  );

  final fillDecoration = BoxDecoration(
      color: backCardColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)));

  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        fillOverscroll: true,
        hasScrollBody: true,
        child: Container(
            decoration: fillDecoration,
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
                Container(
                  height: 100,
                  child: ListView(
                    shrinkWrap: true, //just set this property
                    padding: const EdgeInsets.all(10.0),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[..._infoTiles()],
                  ),
                ),
                _infoWheelScroll(context)
              ],
            )));
  }

  void _animateToIndex(int index) {
    controller.animateTo((2 * index) * 300.0,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  List<Widget> _infoTiles() {
    return [
      InfoTile(
          color: infoCardColor,
          title: "Opis",
          icon: Icons.description,
          onTap: () => _animateToIndex(0)),
      SizedBox(
        width: 30,
      ),
      InfoTile(
          color: infoCardColor,
          title: "Alkohol",
          icon: Icons.local_bar,
          onTap: () => _animateToIndex(1)),
      SizedBox(
        width: 30,
      ),
      InfoTile(
          color: infoCardColor,
          title: "Preferencje",
          icon: Icons.layers,
          onTap: () => _animateToIndex(2))
    ];
  }

  final titleStyle = TextStyle(
      fontFamily: "Baloo",
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 30);

  Widget _infoWheelScroll(BuildContext context) {
    return Expanded(
      child: Opacity(
        opacity: widget.infoOpacity,
        child: ListWheelScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          itemExtent: 300,
          children: <Widget>[
            _description(),
            Container(),
            _alcohol(),
            Container(),
            _preferences()
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text("Opis", style: titleStyle),
          SizedBox(height: 10),
          Text(widget.accountData.description,
              textAlign: TextAlign.justify, style: TextStyle())
        ],
      ),
    );
  }

  Widget _alcohol() {
    return Column(
      children: <Widget>[
        Text("Ulubiony napój", style: titleStyle),
        SizedBox(height: 10),
        Text(widget.accountData.favoriteAlcoholName),
        SizedBox(height: 20),
        Text("Preferowany typ trunku", style: titleStyle),
        SizedBox(height: 10),
        Text(widget.accountData.alcoholPreference.readable()),
      ],
    );
  }

  Widget _preferences() {
    final data = widget.accountData;
    final ageFrom = data.agePreferenceFrom;
    final ageTo = data.agePreferenceTo;
    return Column(
      children: <Widget>[
        Text("Preferencje płciowe", style: titleStyle),
        SizedBox(height: 10),
        Text(widget.accountData.genderPreference.readable()),
        SizedBox(height: 20),
        Text("Przedział wiekowy", style: titleStyle),
        SizedBox(height: 10),
        Text("($ageFrom - $ageTo)"),
      ],
    );
  }
}
