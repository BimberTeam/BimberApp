import 'dart:ui';

import 'package:bimber/ui/common/position.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverStack extends StatefulWidget {
  final Size size;

  DiscoverStack({@required this.size});

  @override
  State<StatefulWidget> createState() => _DiscoverStackState();
}

class _DiscoverStackState extends State<DiscoverStack> {
  final Position _defaultPosition =
      Position(top: 0, left: 0, right: 0, bottom: 0);

  List<DiscoverCard> cards;
  DiscoverCard _currentCard;

  OverlayEntry _discoverCardEntry;
  Position _currentDragPosition;
  SwipeCardLabelOpacities _opacitiesNotifier =
      SwipeCardLabelOpacities(likeOpacity: 0, dislikeOpacity: 0);

  @override
  void initState() {
    super.initState();
    _currentDragPosition = _defaultPosition.copy();

    cards = List.generate(100, (index) => randomColor())
        .map((color) => DiscoverCard(size: widget.size, color: color))
        .toList();
  }

  _onPanStart(DragDownDetails details) {
    if (cards.isNotEmpty) {
      RenderBox renderBox = context.findRenderObject();
      var offset = renderBox.localToGlobal(Offset.zero);

      setState(() {
        _currentCard = cards.removeLast();
        _discoverCardEntry = OverlayEntry(builder: (context) {
          final width = widget.size.width;

          print(_currentDragPosition.left);
          final degrees = interpolate(_currentDragPosition.left,
              inputFrom: -width, inputTo: width, outputFrom: 15, outputTo: -15);

          final likeOpacity = interpolate(_currentDragPosition.left,
              inputFrom: 0, inputTo: width / 2, outputFrom: 0, outputTo: 1);

          final dislikeOpacity = interpolate(_currentDragPosition.left,
              inputFrom: -width / 2, inputTo: 0, outputFrom: 1, outputTo: 0);

          _opacitiesNotifier.setOpacities(
              likeOpacity: likeOpacity, dislikeOpacity: dislikeOpacity);

          return Positioned(
              height: _currentCard.size.height,
              // I have no idea why this '36' have to be here. It stays here for now.
              width: _currentCard.size.width + 36,
              top: offset.dy + _currentDragPosition.top,
              left: offset.dx + _currentDragPosition.left,
              child: ChangeNotifierProvider<SwipeCardLabelOpacities>.value(
                  value: _opacitiesNotifier,
                  child: Transform.rotate(
                      angle: radians(degrees), child: _currentCard)));
        });

        Overlay.of(context).insert(_discoverCardEntry);
      });
    }
  }

  _animateToLike() {
    print("Animating to like");
  }

  _animateToDislike() {
    print("Animating to dislike");
  }

  _animateBack() {
    print("Animating back");
    cards.add(_currentCard);
  }

  _onPanEnd(DragEndDetails details) {
    final leftThreshold = 0.35;
    final rightThreshold = 0.65;
    var progress = rangeProgress(
        -widget.size.width, widget.size.width, _currentDragPosition.left);
    if (leftThreshold < progress && progress < rightThreshold) {
      _animateBack();
    }

    if (progress <= leftThreshold) {
      _animateToDislike();
    }
    if (progress >= rightThreshold) {
      _animateToLike();
    }

    setState(() {
      _currentDragPosition = _defaultPosition.copy();
    });
    _discoverCardEntry?.remove();
    _discoverCardEntry = null;
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (_discoverCardEntry != null) {
      setState(() {
        _currentDragPosition.top += details.delta.dy;
        _currentDragPosition.bottom -= details.delta.dy;
        _currentDragPosition.left += details.delta.dx;
        _currentDragPosition.right -= details.delta.dx;
      });
      _discoverCardEntry.markNeedsBuild();
    }
  }

  _background() {
    return Container(color: Colors.pink);
  }

  _lastThreeOrLess(List<DiscoverCard> cards) {
    if (cards.length >= 3) {
      return cards.sublist(cards.length - 3);
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _onPanStart,
      onPanEnd: _onPanEnd,
      onPanUpdate: _onPanUpdate,
      child: Stack(
        children: [
          Positioned.fill(child: _background()),
          ..._lastThreeOrLess(cards)
        ],
      ),
    );
  }
}
