import 'package:bimber/bloc/add_friends/add_friend_bloc.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/group_create/draggable_animated_list.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class AddFriendsScreen extends StatelessWidget {
  final DialogUtils dialogUtils = DialogUtils();
  final String groupId;

  AddFriendsScreen({Key key, this.groupId}) : super(key: key);

  Widget _draggableAnimatedList(BuildContext context, List<User> friends) {
    return DraggableAnimatedList(
      users: friends,
      onPressed: (List<User> friendsAdded) {
        context.bloc<AddFriendsBloc>().add(AddFriendsToGroup(
            memberIds: friendsAdded.map((e) => e.id).toList()));
      },
      buttonLabel: "Dodaj",
    );
  }

  Widget _initialScreen(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 130,
        child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary),
                strokeWidth: 3.0)),
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  )),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(children: [
                Expanded(
                    flex: 6,
                    child: DottedBorder(
                        radius: Radius.circular(15),
                        borderType: BorderType.RRect,
                        color: Colors.grey,
                        strokeWidth: 3,
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40))),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20),
                    child: ThemedPrimaryButton(
                      label: "Dodaj",
                      onPressed: null,
                    ),
                  ),
                )
              ])))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Dodaj znajomych do grupy",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
        ),
        body: BlocProvider<AddFriendsBloc>(
            create: (context) => AddFriendsBloc(
                groupRepository: context.repository<GroupRepository>(),
                groupId: groupId)
              ..add(InitAddFriends()),
            child: BlocConsumer<AddFriendsBloc, AddFriendsState>(
                listener: (context, state) {
              if (state is AddFriendsLoading) {
                dialogUtils.showLoadingIndicatorDialog(context, "Ładowanie...");
              } else if (state is AddFriendsFailure) {
                dialogUtils.hideDialog(context);
                dialogUtils.showIconDialog(Icons.error, Colors.red,
                    "Nie udało się dodać znajomych", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  dialogUtils.hideDialog(context);
                  context.pop();
                });
              } else if (state is AddFriendsSuccess) {
                dialogUtils.hideDialog(context);
                dialogUtils.showIconDialog(Icons.check_circle, Colors.green,
                    "Wysłano zaproszenia do grupy", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  dialogUtils.hideDialog(context);
                  context.pop();
                });
              } else if (state is AddFriendsError) {
                dialogUtils.hideDialog(context);
              }
            }, builder: (context, state) {
              if (state is AddFriendsInitial)
                return _initialScreen(context);
              else if (state is AddFriendsError) {
                return Container(
                    alignment: Alignment.center,
                    child: Text(state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Baloo')));
              } else
                return _draggableAnimatedList(context,
                    (state as AddFriendsResources).getPossibleMembers());
            })));
  }
}
