import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DraggableAnimatedList<T> extends StatefulWidget {
  final List<T> elements;
  final Function itemThumbnail;
  final Function itemCardLeading;
  final Function itemCardTitleText;
  final Function itemCardSubtitleText;
  final Widget listPlaceholder;
  final Function onPressed;
  final String buttonLabel;

  DraggableAnimatedList(
      {@required this.elements,
      @required this.itemThumbnail,
      @required this.itemCardLeading,
      @required this.itemCardSubtitleText,
      @required this.itemCardTitleText,
      @required this.listPlaceholder,
      @required this.onPressed,
      @required this.buttonLabel});

  @override
  State<StatefulWidget> createState() => _DraggableAnimatedListState<T>();
}

class _DraggableAnimatedListState<T> extends State<DraggableAnimatedList> {
  List<T> available;
  List<T> added;
  T currentlyDragged;
  final GlobalKey<AnimatedListState> availableListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> addedListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    available = widget.elements;
    added = [];
    super.initState();
  }

  Widget _animatedDraggable(
      BuildContext context, T element, int index, animation) {
    return SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: CurvedAnimation(
            parent: animation,
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceIn),
        child: LongPressDraggable(
          child: _draggableChild(element, context),
          childWhenDragging: _draggableChild(element, context),
          feedback: _draggableChild(element, context),
          onDragStarted: () {
            currentlyDragged = element;
            availableListKey.currentState.removeItem(
                index,
                (_, animation) =>
                    _animatedDraggable(context, element, index, animation),
                duration: Duration(milliseconds: 700));
            setState(() {
              available.removeAt(index);
            });
          },
          onDraggableCanceled: (_, __) {
            available.insert(index, currentlyDragged);
            currentlyDragged = null;
            availableListKey.currentState
                .insertItem(index, duration: Duration(milliseconds: 700));
          },
          onDragCompleted: () {
            added.insert(0, currentlyDragged);
            currentlyDragged = null;
            addedListKey.currentState
                .insertItem(0, duration: Duration(milliseconds: 700));
          },
        ));
  }

  Widget _draggableChild(T element, BuildContext context) {
    return Opacity(
      opacity: element == currentlyDragged ? 0 : 1,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(top: 5),
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryVariant,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: widget.itemThumbnail(element)),
    );
  }

  Widget _animatedListTile(
      BuildContext context, T element, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn),
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryVariant,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: ListTile(
              leading: widget.itemCardLeading(element),
              title: Text(
                widget.itemCardTitleText(element),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Baloo'),
              ),
              subtitle: Text(
                widget.itemCardSubtitleText(element),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Baloo'),
              ),
              trailing: GestureDetector(
                onTap: () {
                  available.insert(0, element);
                  availableListKey.currentState
                      .insertItem(0, duration: Duration(milliseconds: 700));
                  addedListKey.currentState.removeItem(
                      index,
                      (_, animation) =>
                          _animatedListTile(context, element, index, animation),
                      duration: Duration(milliseconds: 700));
                  setState(() {
                    added.removeAt(index);
                  });
                },
                child: Icon(Icons.delete, color: Colors.red, size: 25),
              ))),
    );
  }

  Widget _itemsVerticalList(Color borderColor) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: DottedBorder(
            radius: Radius.circular(15),
            borderType: BorderType.RRect,
            color: borderColor,
            strokeWidth: 3,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Stack(
                children: [
                  Opacity(
                    opacity: added.isEmpty ? 1 : 0,
                    child: Container(
                        alignment: Alignment.center,
                        child: widget.listPlaceholder),
                  ),
                  Positioned.fill(
                      child: AnimatedList(
                    physics: BouncingScrollPhysics(),
                    initialItemCount: added.length,
                    key: addedListKey,
                    scrollDirection: Axis.vertical,
                    itemBuilder:
                        (context, index, Animation<double> animation) =>
                            _animatedListTile(
                                context, added[index], index, animation),
                  )),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20),
            child: ThemedPrimaryButton(
              label: widget.buttonLabel,
              onPressed: added.isEmpty
                  ? null
                  : () {
                      widget.onPressed(added);
                    },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 130,
            child: AnimatedList(
              physics: BouncingScrollPhysics(),
              initialItemCount: available.length,
              key: availableListKey,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index, animation) => _animatedDraggable(
                  context, available[index], index, animation),
            )),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: DragTarget(
              onWillAccept: (data) => true,
              builder: (BuildContext context, candidateData, rejectedData) {
                Color borderColor;
                if (candidateData.isEmpty)
                  borderColor = Colors.grey;
                else
                  borderColor = Colors.green;
                return _itemsVerticalList(borderColor);
              },
            ),
          ),
        ),
      ],
    );
  }
}
