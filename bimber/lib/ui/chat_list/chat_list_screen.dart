import 'package:bimber/bloc/chat_list/chat_list_bloc.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/chat_list/friends_horizontal_list.dart';
import 'package:bimber/ui/chat_list/group_list.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bimber/ui/common/theme.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            )),
        child: BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(
              friendRepository: context.repository<FriendRepository>(),
              chatRepository: context.repository<ChatRepository>())
            ..add(InitChatList()),
          child: BlocConsumer<ChatListBloc, ChatListState>(
            listener: (context, state) {
              if (state is ChatListLoading) {
                showLoadingSnackbar(context, message: "");
              } else if (state is ChatListDeleteFailure) {
                showErrorSnackbar(context,
                    message: "Nie udało się usunąć znajomego");
              } else if (state is ChatListDeleteSuccess) {
                showSuccessSnackbar(context, message: "Usunięto znajomego.");
              }
            },
            builder: (context, state) {
              if (state is ChatListInitial) {
                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(lemonMeringue),
                          strokeWidth: 3.0)),
                );
              } else if (state is ChatListError) {
                return Container(); //TODO error message
              } else {
                return ChatListView(
                  friends: (state as ChatListResources).getFriends(),
                  chatThumbnails: (state as ChatListResources).getChats(),
                );
              }
            },
          ),
        ));
  }
}

class ChatListView extends StatelessWidget {
  final List<User> friends;
  final List<ChatThumbnail> chatThumbnails;

  ChatListView({@required this.chatThumbnails, @required this.friends});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          context.bloc<ChatListBloc>().add(RefreshChatList());
          return Future.delayed(Duration(seconds: 1));
        },
        child: Column(
          children: <Widget>[
            FriendsHorizontalList(friends: friends),
            GroupChatList(chatThumbnails: chatThumbnails)
          ],
        ));
  }
}
