import 'dart:math';
import 'dart:ui';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/discover/discover_card.dart';
import 'package:bimber/ui/discover/discover_swipe.dart';
import 'package:bimber/ui/discover/discover_card_content.dart';
import 'package:flutter/material.dart';

class DiscoverStack extends StatefulWidget {
  final Size size;

  DiscoverStack({@required this.size});

  @override
  State<StatefulWidget> createState() => _DiscoverStackState();
}

class _DiscoverStackState extends State<DiscoverStack> {
  List<DiscoverCard> cards;
  DiscoverCard currentCard;

  @override
  void initState() {
    super.initState();

    cards = [
      DiscoverCard(
          size: widget.size,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: DiscoverCardContent(
                  group: Fixtures.getGroup(),
                  size: Size(widget.size.width - 10, widget.size.height - 10))))
    ];

    currentCard = cards.removeLast();
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

  _createDiscoverSwipe(DiscoverCard card) {
    return DiscoverSwipe(
        card: card,
        onAccept: (_) {
          _replaceSwipeCard();
        },
        onDismiss: (_) {
          _replaceSwipeCard();
        },
        onCancel: (card) {});
  }

  _replaceSwipeCard() {
    setState(() {
      if (cards.isEmpty) {
        currentCard = null;
      } else {
        currentCard = cards.removeLast();
      }
    });
  }

  List<Widget> _stackElements(List<DiscoverCard> cards) {
    if (cards.isEmpty && currentCard == null) return [];

    List<Widget> elements = List<Widget>();
    if (cards.isNotEmpty) {
      elements.addAll(cards.sublist(cards.length - min(cards.length, 3)));
    }
    elements.add(_createDiscoverSwipe(currentCard));
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _background()),
        ..._stackElements(cards)
      ],
    );
  }
}
