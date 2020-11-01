import 'package:bimber/bloc/chat_info/chat_info_bloc.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/chat_info/chat_info_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocProvider<ChatInfoBloc>(
          create: (context) => ChatInfoBloc(
              friendRepository: context.repository<FriendRepository>(),
              groupRepository: context.repository<GroupRepository>(),
              accountRepository: context.repository<AccountRepository>(),
              groupId: groupId)
            ..add(InitChatInfo()),
          child: ChatInfoViewScreen(),
        ));
  }
}
