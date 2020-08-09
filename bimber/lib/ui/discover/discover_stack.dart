import 'dart:math';
import 'dart:ui';

import 'package:bimber/ui/discover/discover_card.dart';
import 'package:bimber/ui/discover/discover_swipe.dart';
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
      Colors.white,
      Colors.lightGreen,
      Colors.purple,
      Colors.grey,
      Colors.yellowAccent
    ]
        .map((color) => DiscoverCard(
            size: widget.size,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: color))))
        .toList();

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
          print("calling on accept");
          _replaceSwipeCard();
        },
        onDismiss: (_) {
          print("calling on dismiss");
          _replaceSwipeCard();
        },
        onCancel: (card) {
          print("calling on cancel");
        });
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
    print("creating swipe, ${cards.length} left");
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
