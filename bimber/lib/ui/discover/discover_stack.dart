import 'dart:math';
import 'dart:ui';

import 'package:bimber/ui/common/utils.dart';
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

  @override
  void initState() {
    super.initState();

    cards = List.generate(100,
            (index) => DiscoverCard(size: widget.size, color: randomColor()))
        .toList();
  }

  _background() {
    return Container();
  }

  _createDiscoverSwipe(DiscoverCard card) {
    return DiscoverSwipe(
        card: card,
        onAccept: (_) {
          setState(() {
            print("calling on accept");
          });
        },
        onDismiss: (_) {
          setState(() {
            print("calling on dismiss");
          });
        },
        onCancel: (card) {
          setState(() {
            print("calling on cancel");
            cards.add(card);
          });
        });
  }

  List<Widget> _stackElements(List<DiscoverCard> cards) {
    if (cards.isEmpty) return [];

    List<Widget> elements = List<Widget>();
    var card = cards.removeLast();

    if (cards.isNotEmpty) {
      elements.addAll(cards.sublist(cards.length - min(cards.length, 3)));
    }
    elements.add(_createDiscoverSwipe(card));
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
