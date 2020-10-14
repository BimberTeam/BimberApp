import 'package:bimber/bloc/group_add/group_add_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/group_create/draggable_animated_list.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class AddToGroupScreen extends StatelessWidget {
  final User friend;

  AddToGroupScreen({@required this.friend});

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
        body: BlocProvider<GroupAddBloc>(
            create: (context) => GroupAddBloc(
                groupRepository: context.repository<GroupRepository>())
              ..add(InitGroupAdd()),
            child: BlocConsumer<GroupAddBloc, GroupAddState>(
                listener: (context, state) {
              if (state is GroupAddLoading) {
                DialogBuilder(context).showLoadingIndicator("Ładowanie...");
              } else if (state is AddToGroupFailure) {
                DialogBuilder(context).hideOpenDialog();
                DialogBuilder(context).showIconDialog(
                    Icons.error, Colors.red, "Nie udało się zaprosić do grup");
                Future.delayed(Duration(milliseconds: 1500), () {
                  DialogBuilder(context).hideOpenDialog();
                  context.pop();
                });
              } else if (state is AddToGroupsSuccess) {
                DialogBuilder(context).hideOpenDialog();
                DialogBuilder(context).showIconDialog(Icons.check_circle,
                    Colors.green, "Wysłano zaproszenia do grup");
                Future.delayed(Duration(milliseconds: 1500), () {
                  DialogBuilder(context).hideOpenDialog();
                  context.pop();
                });
              }
            }, builder: (context, state) {
              if (state is GroupAddInitial) {
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
                                  label: "Zaproś",
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ])))
                ]);
              } else if (state is GroupAddError) {
                return Container(); //TODO error message
              } else {
                return DraggableAnimatedList<Group>(
                    elements: Fixtures.getGroups(),
                    getThumbnail: (Group group) => Column(
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
                    getCardLeading: (Group group) => GestureDetector(
                        onTap: () {
                          context.pushNamed("/group-details", arguments: group);
                        },
                        child: GroupImageHero(
                          radius: BorderRadius.circular(15.0),
                          group: group,
                          size: Size(60, 60),
                        )),
                    getCardSubtitleText: (Group group) =>
                        "${group.members.length.toString()} osób",
                    getCardTitleText: (Group group) => "Grupa",
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
                    onPressed: (List<Group> groupAdded) {
                      context.bloc<GroupAddBloc>().add(AddToGroup(
                          groupsIds: groupAdded.map((e) => e.id).toList()));
                    },
                    buttonLabel: "Zaproś");
              }
            })));
  }
}
