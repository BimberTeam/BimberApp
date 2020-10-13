import 'package:bimber/bloc/group_create/group_create_bloc.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/group_create/group_create_draggable_list.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class GroupCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Stwórz grupę",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
        ),
        body: BlocProvider<GroupCreateBloc>(
            create: (context) => GroupCreateBloc(
                groupRepository: context.repository<GroupRepository>(),
                friendRepository: context.repository<FriendRepository>())
              ..add(InitGroupCreate()),
            child: BlocConsumer<GroupCreateBloc, GroupCreateState>(
                listener: (context, state) {
              if (state is GroupCreateLoading) {
                DialogBuilder(context).showLoadingIndicator("Ładowanie...");
              } else if (state is GroupCreateFailure) {
                DialogBuilder(context).hideOpenDialog();
                DialogBuilder(context).showIconDialog(
                    Icons.error, Colors.red, "Nie udało się stworzyć grupy");
                Future.delayed(Duration(milliseconds: 1500), () {
                  DialogBuilder(context).hideOpenDialog();
                  context.pop();
                });
              } else if (state is GroupCreateSuccess) {
                DialogBuilder(context).hideOpenDialog();
                DialogBuilder(context).showIconDialog(Icons.check_circle,
                    Colors.green, "Wysłano zaproszenia do grupy");
                Future.delayed(Duration(milliseconds: 1500), () {
                  DialogBuilder(context).hideOpenDialog();
                  context.pop();
                });
              }
            }, builder: (context, state) {
              if (state is GroupCreateInitial) {
                return Column(children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 130,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.primary),
                                strokeWidth: 3.0)),
                      )),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              )),
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: Column(children: [
                            Expanded(
                                flex: 6,
                                child: DottedBorder(
                                    radius: Radius.circular(15),
                                    borderType: BorderType.RRect,
                                    color: Colors.grey,
                                    strokeWidth: 3,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40))),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 20),
                                child: ThemedPrimaryButton(
                                  label: "Stwórz",
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ])))
                ]);
              } else if (state is GroupCreateError) {
                return Container(); //TODO error message
              } else {
                return GroupCreateDraggableList(
                    friends: (state as GroupCreateResources).getFriends());
              }
            })));
  }
}
