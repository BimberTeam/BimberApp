import 'dart:math';
import 'dart:ui';
import 'package:bimber/bloc/discover/discover_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/discover/discover_card.dart';
import 'package:bimber/ui/discover/discover_swipe.dart';
import 'package:bimber/ui/discover/discover_card_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverStack extends StatefulWidget {
  final Size size;

  DiscoverStack({@required this.size});

  @override
  State<StatefulWidget> createState() => _DiscoverStackState();
}

class _DiscoverStackState extends State<DiscoverStack> {
  List<Group> groups = [];
  Set<String> uniqueGroups = {};
  Group currentGroup;
  DialogUtils dialogUtils = DialogUtils();

  @override
  void initState() {
    super.initState();
  }

  _background() {
    return BlocBuilder<DiscoverBloc, DiscoverState>(builder: (context, state) {
      if (state is DiscoverInitial) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(indigoDye),
                  strokeWidth: 3.0)),
        );
      } else {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Brak imprezowiczów!",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
          Text(
              "Zwiększ preferencję odległości by poszukać imprez dalej od Ciebie.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Baloo')),
        ]);
      }
    });
  }

  _createDiscoverSwipe(Group group) {
    return DiscoverSwipe(
        card: DiscoverCard(
            size: widget.size,
            child: LayoutBuilder(builder: (context, constraints) {
              return DiscoverCardContent(
                  group: group, size: constraints.smallest);
            })),
        onAccept: (_) {
          _replaceSwipeCard();
          context
              .bloc<DiscoverBloc>()
              .add(SwipeGroup(swipeType: SwipeType.LIKE, groupId: group.id));
        },
        onDismiss: (_) {
          _replaceSwipeCard();
          context
              .bloc<DiscoverBloc>()
              .add(SwipeGroup(swipeType: SwipeType.DISLIKE, groupId: group.id));
        },
        onCancel: (card) {});
  }

  _replaceSwipeCard() {
    setState(() {
      if (groups.isEmpty) {
        currentGroup = null;
      } else {
        currentGroup = groups.removeLast();
      }
    });
  }

  List<Widget> _stackElements() {
    if (groups.isEmpty && currentGroup == null) return [];

    List<Widget> elements = List<Widget>();
    if (groups.isNotEmpty) {
      elements.addAll(groups
          .sublist(groups.length - min(groups.length, 3))
          .map((group) => DiscoverCard(
              size: widget.size,
              child: LayoutBuilder(builder: (context, constraints) {
                return DiscoverCardContent(
                    group: group, size: constraints.smallest);
              }))));
    }
    elements.add(_createDiscoverSwipe(currentGroup));
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscoverBloc, DiscoverState>(
        listener: (context, state) {
          if (state is DiscoverFetched) {
            setState(() {
              var newSuggestions = state.groupSuggestions;
              newSuggestions = newSuggestions
                  .where((group) => !uniqueGroups.contains(group.id))
                  .toList();
              uniqueGroups.addAll(newSuggestions.map((group) => group.id));
              groups.insertAll(max(0, groups.length - 1), newSuggestions);
              if (currentGroup == null && groups.isNotEmpty)
                currentGroup = groups.removeLast();
            });
            if (currentGroup == null && groups.isEmpty) {
              context.bloc<DiscoverBloc>().add(NoGroupsLeft());
            }
          } else if (state is DiscoverLoading) {
            //dont know what to put here
          } else if (state is DiscoverError) {
            showErrorSnackbar(context, message: state.message);
          } else if (state is DiscoverSwipeMatched) {
            dialogUtils.showInfoDialog(Icons.favorite, Colors.green,
                "Użytkownik odzwzajemnił Twoje polubienie!", "", context);
          }
        },
        child: Stack(
          children: [
            Positioned.fill(child: _background()),
            ..._stackElements()
          ],
        ));
  }
}
