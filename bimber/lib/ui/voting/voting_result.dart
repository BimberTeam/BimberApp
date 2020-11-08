import 'package:bimber/models/group_candidate.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Votes {
  final String vote;
  final int number;
  final charts.Color color;

  Votes(this.vote, this.number, this.color);
}

class VotingResults extends StatelessWidget {
  final List<GroupCandidate> candidates;

  const VotingResults({Key key, this.candidates}) : super(key: key);

  _chartSeries(GroupCandidate candidate, BuildContext context) {
    final data = [
      Votes("Za", candidate.votesInFavour, charts.Color(r: 0, g: 255, b: 0)),
      Votes(
          "Przeciw", candidate.votesAgainst, charts.Color(r: 255, g: 0, b: 0)),
      Votes(
          "Brak",
          candidate.groupCount -
              candidate.votesAgainst -
              candidate.votesInFavour,
          charts.Color(r: 150, g: 150, b: 150))
    ];
    return [
      charts.Series<Votes, String>(
        seriesColor: charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.secondaryVariant),
        id: "Głosy",
        data: data,
        domainFn: (Votes vote, _) => vote.vote,
        measureFn: (Votes vote, _) => vote.number,
        colorFn: (Votes vote, _) => vote.color,
        labelAccessorFn: (Votes votes, _) => votes.vote,
      )
    ];
  }

  Widget _candidateListTile(GroupCandidate candidate, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryVariant,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: Offset(3, 3),
                color: Colors.black.withOpacity(0.4))
          ]),
      child: ExpansionTile(
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, -3),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: UserImageHero(
              user: candidate.user,
              size: Size(60, 60),
              radius: BorderRadius.circular(15.0),
              onTap: () {
                context.pushNamed("/user-details", arguments: candidate.user);
              }),
        ),
        title: Text(
          candidate.user.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          "Zagłosowało ${candidate.votesAgainst + candidate.votesInFavour} z ${candidate.groupCount}",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: charts.PieChart(
              _chartSeries(candidate, context),
              animate: true,
              animationDuration: Duration(seconds: 1),
              behaviors: [
                charts.DatumLegend(
                  position: charts.BehaviorPosition.end,
                  horizontalFirst: false,
                  cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                  entryTextStyle: charts.TextStyleSpec(
                      color: charts.ColorUtil.fromDartColor(
                          Theme.of(context).colorScheme.secondaryVariant),
                      fontSize: 20,
                      fontFamily: 'Baloo'),
                  showMeasures: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
            onRefresh: () {},
            child: candidates.isNotEmpty
                ? ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: candidates
                        .map((element) => _candidateListTile(element, context))
                        .toList(),
                  )
                : LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                            height: viewportConstraints.maxHeight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Zagłosuj na kadydatów by zobaczyć ich wyniki",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Baloo'),
                                textAlign: TextAlign.center,
                              ),
                            )));
                  })));
  }
}
