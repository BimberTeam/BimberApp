import 'package:bimber/bloc/group_create/group_create_bloc.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/group_create/draggable_animated_list.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class GroupCreateScreen extends StatelessWidget {

  Widget _createDraggableAnimatedList(BuildContext context, List<User> friends){
    return DraggableAnimatedList<User>(
      elements: friends,
      itemThumbnail: (User user) => Column(
        children: [
          UserImageHero(
              radius: BorderRadius.circular(15.0),
              user: user,
              size: Size(60, 60),
              onTap: () {
                context.pushNamed("/user-details", arguments: user);
              }),
          Text(
            user.name,
            style: TextStyle(
                color:
                Theme.of(context).colorScheme.secondaryVariant,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo',
                decoration: TextDecoration.none),
          )
        ],
      ),
      itemCardLeading: (User user) => UserImageHero(
          radius: BorderRadius.circular(15.0),
          user: user,
          size: Size(60, 60),
          onTap: () {
            context.pushNamed("/user-details", arguments: user);
          }),
      itemCardTitleText: (User user) => user.name,
      itemCardSubtitleText: (User user) => user.age.toString(),
      listPlaceholder: Text(
        "Przytrzymaj i przeciągnij znajomych",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondaryVariant,
          fontSize: 20,
          fontWeight: FontWeight.w900,
          fontFamily: 'Baloo',
        ),
        textAlign: TextAlign.center,
      ),
      onPressed: (List<User> friendsAdded) {
        context.bloc<GroupCreateBloc>().add(CreateGroup(
            memberIds:
            friendsAdded.map((member) => member.id).toList()));
      },
      buttonLabel: "Stwórz",
    );
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
                      label: "Stwórz",
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
                showLoadingIndicator("Ładowanie...", context);
              } else if (state is GroupCreateFailure) {
                hideDialog(context);
                showIconDialog(
                    Icons.error, Colors.red, "Nie udało się stworzyć grupy", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  hideDialog(context);
                  context.pop();
                });
              } else if (state is GroupCreateSuccess) {
                hideDialog(context);
                showIconDialog(Icons.check_circle,
                    Colors.green, "Wysłano zaproszenia do grupy", context);
                Future.delayed(Duration(milliseconds: 1500), () {
                  hideDialog(context);
                  context.pop();
                });
              }
            }, builder: (context, state) {
              if (state is GroupCreateInitial) return _createInitialScreen(context);
              else if (state is GroupCreateError) {
                return Container(
                    alignment: Alignment.center,
                    child: Text(state.message, textAlign: TextAlign.center, style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo'))
                );
              } else return _createDraggableAnimatedList(context, (state as GroupCreateResources).getFriends());
            })));
  }
}
