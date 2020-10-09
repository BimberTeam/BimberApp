import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvitationsList<T> extends StatelessWidget {
  final List<T> list;
  final Function onRefresh;
  final Function createLeadingWidget;
  final Function createTitle;
  final Function createSubtitle;
  final Function onAccept;
  final Function onDecline;

  InvitationsList(
      {@required this.list,
      @required this.onRefresh,
      @required this.createLeadingWidget,
      @required this.createTitle,
      @required this.createSubtitle,
      @required this.onAccept,
      @required this.onDecline});

  Widget _invitationListTile(T element, BuildContext context) {
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
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, -3),
                    color: Colors.black.withOpacity(0.4))
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: createLeadingWidget(element)),
        ),
        title: Text(
          createTitle(element),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          createSubtitle(element),
          style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        trailing: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 50,
                  onPressed: (){
                    onDecline(element);
                    list.remove(element);
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.clear,
                    size: 25,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  minWidth: 50,
                  onPressed: (){
                    onAccept(element);
                    list.remove(element);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.check,
                    size: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: list
            .map((element) => _invitationListTile(element, context))
            .toList(),
      ),
    ));
  }
}
