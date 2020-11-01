import 'package:bimber/bloc/group_info/group_info_bloc.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/group_info/group_info_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInfoScreen extends StatelessWidget {
  final String groupId;

  const GroupInfoScreen({Key key, this.groupId}) : super(key: key);

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
        body: BlocProvider<GroupInfoBloc>(
          create: (context) => GroupInfoBloc(
              friendRepository: context.repository<FriendRepository>(),
              groupRepository: context.repository<GroupRepository>(),
              accountRepository: context.repository<AccountRepository>(),
              groupId: groupId)
            ..add(InitGroupInfo()),
          child: GroupInfoViewScreen(),
        ));
  }
}
