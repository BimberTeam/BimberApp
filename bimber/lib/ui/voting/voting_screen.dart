import 'package:bimber/bloc/voting/voting_bloc.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/models/voting_result.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:bimber/ui/voting/voting_result.dart';
import 'package:build_context/build_context.dart';
import 'package:bimber/ui/invitations/invitations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotingScreen extends StatefulWidget {
  final String groupId;

  const VotingScreen({@required this.groupId});

  @override
  State<StatefulWidget> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<User> groupCandidates = [];
  List<VotingResult> votingResults = [];

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

  Widget _buildFromState(BuildContext context, VotingState state) {
    if (state is VotingInitial) {
      return Center(
        child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondaryVariant),
                strokeWidth: 3.0)),
      );
    } else if (state is VotingError) {
      return Center(
          child: Text(state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')));
    } else {
      return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          InvitationsList<User>(
            list: groupCandidates,
            onRefresh: () {
              context.bloc<VotingBloc>().add(RefetchVoting());
              return Future.delayed(Duration(seconds: 1));
            },
            createLeadingWidget: (User user) => UserImageHero(
                user: user,
                size: Size(60, 60),
                radius: BorderRadius.circular(15.0),
                onTap: () {
                  context.pushNamed("/user-details", arguments: user);
                }),
            createTitle: (User user) => user.name,
            createSubtitle: (User user) => user.age.toString(),
            onAccept: (User user) {
              context.bloc<VotingBloc>().add(VoteFor(userId: user.id));
            },
            onDecline: (User user) {
              context.bloc<VotingBloc>().add(VoteAgainst(userId: user.id));
            },
            emptyListMessage: "Brak kandydatów do grupy",
          ),
          VotingResults(
            votingResults: votingResults,
          )
        ],
      );
    }
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
        body: BlocProvider<VotingBloc>(
          create: (context) => VotingBloc(
              groupRepository: context.repository<GroupRepository>(),
              groupId: widget.groupId)
            ..add(InitVoting()),
          child: BlocConsumer<VotingBloc, VotingState>(
            listener: (context, state) {
              if (state is VotingFetchedCandidatesAndResults) {
                setState(() {
                  groupCandidates = state.groupCandidates;
                  votingResults = state.votingResults;
                });
              } else if (state is VotingLoading) {
                showLoadingSnackbar(context, message: "");
              } else if (state is VotingFailure) {
                showErrorSnackbar(context,
                    message:
                        "Nie udało się oddać głosu. Spróbuj ponownie później!");
              } else if (state is VotingSuccess) {
                showSuccessSnackbar(context,
                    message: "Oddano głos na kandydata");
              }
            },
            builder: _buildFromState,
          ),
        ));
  }
}
