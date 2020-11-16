import 'dart:math';
import 'dart:ui';
import 'package:bimber/bloc/discover/discover_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
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
  Group currentGroup;
  DialogUtils dialogUtils = DialogUtils();

  @override
  void initState() {
    super.initState();
  }

  _background() {
    return Center(
        child: Text("Brak imprezowiczów!",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 33,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo')));
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
              .add(SwipeGroup(swipeDirection: Swipe.LIKE, groupId: group.id));
        },
        onDismiss: (_) {
          _replaceSwipeCard();
          context.bloc<DiscoverBloc>().add(
              SwipeGroup(swipeDirection: Swipe.DISLIKE, groupId: group.id));
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
            groups.addAll(state.groupSuggestions);
            if (currentGroup == null) currentGroup = groups.removeLast();
          });
        } else if (state is DiscoverLoading) {
          //dont know what to put here
        } else if (state is DiscoverError) {
          showErrorSnackbar(context, message: state.message);
        } else if (state is DiscoverSwipeMatch) {
          dialogUtils.showIconDialog(Icons.favorite, Colors.green,
              "Użytkownik odzwzajemnił Twoje polubienie!", context);
          Future.delayed(Duration(milliseconds: 1500), () {
            dialogUtils.hideDialog(context);
          });
        }
      },
      child: Stack(
        children: [Positioned.fill(child: _background()), ..._stackElements()],
      ),
    );
  }
}
