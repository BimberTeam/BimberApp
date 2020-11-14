import 'package:bimber/models/voting_result.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bimber/bloc/voting/voting_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Vote { FOR, AGAINST, NONE }

extension VoteString on Vote {
  String toPolishString() {
    switch (this) {
      case Vote.FOR:
        return "Za";
      case Vote.AGAINST:
        return "Przeciw";
      case Vote.NONE:
        return "Brak głosu";
    }
  }
}

class Votes {
  final Vote vote;
  final int number;
  final charts.Color color;

  Votes(this.vote, this.number, this.color);
}

class VotingResults extends StatelessWidget {
  final List<VotingResult> votingResults;

  const VotingResults({Key key, this.votingResults}) : super(key: key);

  _chartSeries(VotingResult votingResult, BuildContext context) {
    final data = [
      Votes(Vote.FOR, votingResult.votesInFavour,
          charts.ColorUtil.fromDartColor(indigoDye)),
      Votes(Vote.AGAINST, votingResult.votesAgainst,
          charts.ColorUtil.fromDartColor(sandyBrown)),
      Votes(
          Vote.NONE,
          votingResult.groupCount -
              votingResult.votesAgainst -
              votingResult.votesInFavour,
          charts.ColorUtil.fromDartColor(Colors.blueGrey))
    ];
    return [
      charts.Series<Votes, String>(
        seriesColor: charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.secondaryVariant),
        id: "Głosy",
        data: data,
        domainFn: (Votes vote, _) => vote.vote.toPolishString(),
        measureFn: (Votes vote, _) => vote.number,
        colorFn: (Votes vote, _) => vote.color,
        labelAccessorFn: (Votes votes, _) => votes.vote.toPolishString(),
      )
    ];
  }

  Widget _candidateListTile(VotingResult votingResult, BuildContext context) {
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
              user: votingResult.user,
              size: Size(60, 60),
              radius: BorderRadius.circular(15.0),
              onTap: () {
                context.pushNamed("/user-details",
                    arguments: votingResult.user);
              }),
        ),
        title: Text(
          votingResult.user.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          "Zagłosowało ${votingResult.votesAgainst + votingResult.votesInFavour} z ${votingResult.groupCount}",
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
              _chartSeries(votingResult, context),
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
            onRefresh: () {
              context.bloc<VotingBloc>().add(RefetchVoting());
              return Future.delayed(Duration(seconds: 1));
            },
            child: votingResults.isNotEmpty
                ? ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: votingResults
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
