import 'package:bimber/ui/common/position.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

class DiscoverSwipe extends StatefulWidget {
  final DiscoverCard card;
  final Size size;

  final void Function(DiscoverCard) onAccept;
  final void Function(DiscoverCard) onDismiss;
  final void Function(DiscoverCard) onCancel;

  DiscoverSwipe(
      {@required this.card,
      this.onAccept,
      this.onDismiss,
      this.onCancel,
      BuildContext context})
      : size = card.size;

  @override
  State<StatefulWidget> createState() => _DiscoverSwipeState();
}

class _DiscoverSwipeState extends State<DiscoverSwipe>
    with TickerProviderStateMixin {
  final Position _defaultPosition =
      Position(top: 0, left: 0, right: 0, bottom: 0);

  double dragChildOpacity = 1.0;

  OverlayEntry _discoverCardEntry;
  Position _currentDragPosition;
  final _opacitiesNotifier =
      SwipeCardLabelOpacities(likeOpacity: 0, dislikeOpacity: 0);

  AnimationController controller;

  Animation<double> _translateX;
  Animation<double> _translateY;
  bool animating = false;

  @override
  void initState() {
    super.initState();
    dragChildOpacity = 1.0;
    _currentDragPosition = _defaultPosition.copy();
  }

  @override
  void didUpdateWidget(DiscoverSwipe oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      dragChildOpacity = 1.0;
      _currentDragPosition = _defaultPosition.copy();
    });
  }

  Animation<double> get translateX => _translateX;
  Animation<double> get translateY => _translateY;

  void Function(AnimationStatus) _onAnimationStatusChange(
      void Function(DiscoverCard) onEnd) {
    return (AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        onEnd(widget.card);

        setState(() {
          _currentDragPosition = _defaultPosition.copy();
          _discoverCardEntry?.remove();
          _translateX = null;
          _translateY = null;
          _discoverCardEntry = null;
          animating = false;
          dragChildOpacity = 1.0;
        });
      }
    };
  }

  _animateTo(double left,
      {void Function(DiscoverCard) onEnd,
      bool animateY,
      Duration duration = const Duration(milliseconds: 300)}) {
    setState(() {
      animating = true;

      controller?.dispose();
      controller = AnimationController(vsync: this, duration: duration);

      final curve = Sprung.custom(
        damping: 7,
        stiffness: 100,
        mass: 1.0,
      );

      final curveAnimation = CurvedAnimation(parent: controller, curve: curve);

      _translateX =
          Tween<double>(begin: 0, end: left - _currentDragPosition.left)
              .animate(curveAnimation);
      if (animateY) {
        _translateY = Tween<double>(begin: 0, end: -_currentDragPosition.top)
            .animate(curveAnimation);
      }
      controller.addStatusListener(_onAnimationStatusChange(onEnd));
      controller.addListener(() {
        _discoverCardEntry?.markNeedsBuild();
      });
      controller.forward();
    });
  }

  _animateToLike() {
    final size = MediaQuery.of(context).size;
    _animateTo(2 * size.width, onEnd: widget.onAccept, animateY: false);
  }

  _animateToDislike() {
    final size = MediaQuery.of(context).size;
    _animateTo(-2 * size.width, onEnd: widget.onDismiss, animateY: false);
  }

  _animateBack() {
    _animateTo(0,
        onEnd: widget.onCancel,
        animateY: true,
        duration: Duration(milliseconds: 500));
  }

  _onPanStart(DragStartDetails details) {
    if (animating) return;

    setState(() {
      dragChildOpacity = 0.0;
    });

    RenderBox renderBox = context.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);

    _discoverCardEntry = OverlayEntry(builder: (context) {
      final width = widget.size.width;
      final xPos = (translateX?.value ?? 0) + _currentDragPosition.left;

      final degrees = interpolate(xPos,
          inputFrom: -width, inputTo: width, outputFrom: 15, outputTo: -15);

      final likeOpacity = interpolate(xPos,
          inputFrom: 0, inputTo: width / 2, outputFrom: 0, outputTo: 1);

      final dislikeOpacity = interpolate(xPos,
          inputFrom: -width / 2, inputTo: 0, outputFrom: 1, outputTo: 0);

      _opacitiesNotifier.setOpacities(
          likeOpacity: likeOpacity, dislikeOpacity: dislikeOpacity);

      return Positioned(
          height: widget.card.size.height,
          // TODO: fix that
          // I have no idea why this '36' have to be here. It stays here for now.
          width: widget.card.size.width + 36,
          top: (translateY?.value ?? 0) + offset.dy + _currentDragPosition.top,
          left:
              (translateX?.value ?? 0) + offset.dx + _currentDragPosition.left,
          child: ChangeNotifierProvider<SwipeCardLabelOpacities>.value(
              value: _opacitiesNotifier,
              child: Transform.rotate(
                  angle: radians(degrees), child: widget.card.copy())));
    });

    Overlay.of(context).insert(_discoverCardEntry);
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (animating) return;
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

  _onPanEnd(DragEndDetails details) {
    if (animating) return;
    final leftThreshold = 0.35;
    final rightThreshold = 0.65;

    var progress = rangeProgress(
        -widget.size.width, widget.size.width, _currentDragPosition.left);

    if (leftThreshold < progress && progress < rightThreshold) {
      _animateBack();
      return;
    }

    if (progress <= leftThreshold) {
      _animateToDislike();
      return;
    }
    if (progress >= rightThreshold) {
      _animateToLike();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Opacity(opacity: dragChildOpacity, child: widget.card));
  }
}
