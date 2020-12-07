import 'package:bimber/bloc/group_info/group_info_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GroupInfoViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupInfoViewScreenState();
}

class GroupInfoViewScreenState extends State<GroupInfoViewScreen> {
  Group group;
  List<String> friendCandidates;
  String meId;
  DateTime endTime;
  DialogUtils dialogUtils = DialogUtils();

  String infoText(DateTime date) {
    final format = DateFormat("dd-MM-yyyy HH:mm");
    return "Każda grupa, ma określony czas przez który jest aktywna. W ciągu tego czasu członkowie mogą się spotkać i wspólnie napić, a po tym czasie grupa znika na zawsze. Pamiętaj więc by ludzi, których polubisz dodać do znajomych by spotkać się jeszcze na jakiejś imprezie w przyszłości! Wasza grupa przestanie być aktywna: ${format.format(date)}";
  }

  Widget _header(BuildContext context) {
    TextStyle style = TextStyle(
        color: Theme.of(context).colorScheme.primaryVariant,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: 'Baloo');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: colorFromGroupId(group.id),
            radius: 50,
            child: GestureDetector(
              onTap: () {
                dialogUtils.showInfoDialog(
                    Icons.access_time,
                    Theme.of(context).colorScheme.primaryVariant,
                    "Pozostało wam: ${endTime.difference(DateTime.now()).inDays} dni",
                    infoText(endTime),
                    context);
              },
              child: Text(
                endTime.difference(DateTime.now()).inDays.toString(),
                style: TextStyle(
                    color: colorFromGroupId(group.id).computeLuminance() > 0.5
                        ? Colors.black
                        : Theme.of(context).colorScheme.primaryVariant,
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Baloo'),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${group.members.length} członków",
            style: style,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${group.averageAge.toInt()} średnia wieku",
            style: style,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _button(Icons.account_box, "Kandydaci", () {
                context
                    .pushNamed("/group-members-candidates", arguments: group.id)
                    .then((_) =>
                        context.bloc<GroupInfoBloc>().add(RefreshGroupInfo()));
              }, context),
              _button(Icons.group_add, "Dodaj", () {
                context.pushNamed("/add-friends-to-group", arguments: group.id);
              }, context),
              _button(Icons.map, "Mapa", () {
                context.pushNamed("/members-map",
                    arguments: {"groupMembers": group.members, "meId": meId});
              }, context)
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Theme.of(context).colorScheme.primaryVariant,
            thickness: 2,
          )
        ],
      ),
    );
  }

  Widget _button(
      IconData icon, String label, Function onPressed, BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          minWidth: 50,
          onPressed: onPressed,
          color: Theme.of(context).colorScheme.primaryVariant,
          child: Icon(
            icon,
            size: 25,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
        label != null
            ? Text(
                label,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Baloo'),
              )
            : SizedBox(
                height: 0,
              )
      ],
    );
  }

  Widget _memberListTile(User user, BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: UserImageHero(
            user: user,
            size: Size(60, 60),
            radius: BorderRadius.circular(15.0),
            onTap: () {
              context.pushNamed("/user-details", arguments: user);
            },
            showGradient: false,
          ),
          title: Text(
            user.name,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
          trailing: friendCandidates.contains(user.id)
              ? _button(Icons.person_add, null, () {
                  context
                      .bloc<GroupInfoBloc>()
                      .add(AddMemberToFriends(id: user.id));
                }, context)
              : SizedBox(
                  width: 0,
                  height: 0,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInfoBloc, GroupInfoState>(
        listener: (context, state) {
      if (state is GroupInfoFetched) {
        setState(() {
          group = state.group;
          friendCandidates = state.friendCandidates;
          meId = state.meId;
          endTime = state.endTime;
        });
      } else if (state is GroupInfoAddFailure) {
        showErrorSnackbar(context, message: "Nie udało się dodać do znajomych");
      } else if (state is GroupInfoAddSuccess) {
        showSuccessSnackbar(context,
            message: "Wysłano zaproszenie do znajomych");
      }
    }, builder: (context, state) {
      if (state is GroupInfoInitial) {
        return Center(
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary),
                  strokeWidth: 3.0)),
        );
      } else if (state is GroupInfoError) {
        return Center(
            child: Text(state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Baloo')));
      } else {
        return RefreshIndicator(
            onRefresh: () {
              context.bloc<GroupInfoBloc>().add(RefreshGroupInfo());
              showLoadingSnackbar(context, message: "");
              return Future.delayed(Duration(milliseconds: 500));
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                              _header(context),
                            ] +
                            group.members
                                .where((element) => element.id != meId)
                                .map((e) => _memberListTile(e, context))
                                .toList(),
                      ),
                    ),
                  ),
                )
              ],
            ));
      }
    });
  }
}
