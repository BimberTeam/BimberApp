import 'package:bimber/bloc/friend_add_to_groups/friend_add_to_groups_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/group_create/draggable_animated_list.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class AddFriendToGroupsScreen extends StatelessWidget {
  final User friend;

  AddFriendToGroupsScreen({@required this.friend});

  Widget _createDraggableAnimatedList(BuildContext context, List<Group> groups){
    return DraggableAnimatedList<Group>(
        elements: groups,
        itemThumbnail: (Group group) => Column(
          children: [
            GestureDetector(
                onTap: () {
                  context.pushNamed("/group-details",
                      arguments: group);
                },
                child: GroupImageHero(
                  radius: BorderRadius.circular(15.0),
                  group: group,
                  size: Size(60, 60),
                )),
            Text(
              "Grupa",
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo',
                  decoration: TextDecoration.none),
            )
          ],
        ),
        itemCardLeading: (Group group) => GestureDetector(
            onTap: () {
              context.pushNamed("/group-details", arguments: group);
            },
            child: GroupImageHero(
              radius: BorderRadius.circular(15.0),
              group: group,
              size: Size(60, 60),
            )),
        itemCardSubtitleText: (Group group) =>
        "${group.members.length.toString()} osób",
        itemCardTitleText: (Group group) => "Grupa",
        listPlaceholder: Text(
          "Przytrzymaj i przeciągnij grupy do których chcesz zaprosić ${friend.name}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondaryVariant,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            fontFamily: 'Baloo',
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: (List<Group> AddFriendToGroupsed) {
          context.bloc<AddFriendToGroupsBloc>().add(AddFriendToGroupSubmit(
              groupsIds: AddFriendToGroupsed.map((e) => e.id).toList()));
        },
        buttonLabel: "Zaproś");
  }

  Widget _createInitialScreen(BuildContext context){
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
                      label: "Zaproś",
                      onPressed: () {},
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
          title: Text("Zaproś do grup",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo')),
        ),
        body: BlocProvider<AddFriendToGroupsBloc>(
            create: (context) => AddFriendToGroupsBloc(
                groupRepository: context.repository<GroupRepository>())
              ..add(InitAddFriendToGroups()),
            child: BlocConsumer<AddFriendToGroupsBloc, AddFriendToGroupsState>(
                listener: (context, state) {
              if (state is AddFriendToGroupsLoading) {
                showLoadingIndicator("Ładowanie...", context);
              } else if (state is AddFriendToGroupFailure) {
                hideDialog(context);
                showIconDialog(
                    Icons.error, Colors.red, "Nie udało się zaprosić do grup", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  hideDialog(context);
                  context.pop();
                });
              } else if (state is AddFriendToGroupsSuccess) {
                hideDialog(context);
                showIconDialog(Icons.check_circle,
                    Colors.green, "Wysłano zaproszenia do grup", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  hideDialog(context);
                  context.pop();
                });
              }
            }, builder: (context, state) {
              if (state is AddFriendToGroupsInitial) return _createInitialScreen(context);
              else if (state is AddFriendToGroupsError) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(state.message, textAlign: TextAlign.center, style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Baloo'))
                );
              } else return _createDraggableAnimatedList(context, (state as AddFriendToGroupsResources).getGroups());
            })));
  }
}
