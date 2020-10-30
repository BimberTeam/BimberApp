import 'package:bimber/ui/chat_info/chat_info_screen_view.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:flutter/material.dart';

class ChatInfoScreen extends StatelessWidget {
  final String groupId;

  const ChatInfoScreen({Key key, this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
          elevation: 1.0,
          title: Padding(
            padding: EdgeInsets.only(left: 8.00),
            child: Text(
             "Informacje o grupie",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo'),
            ),
          ),
        ),
        body: ChatInfoViewScreen(group: Fixtures.getGroup("some"), currentUserId: "id", canBeAdded: [],) //TODO bloc consumer, provider
    );
  }
}
