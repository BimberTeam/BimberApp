import 'package:bimber/bloc/group_info/group_info_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInfoViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupInfoViewScreenState();
}

class GroupInfoViewScreenState extends State<GroupInfoViewScreen> {
  Group group;
  List<String> friendCandidates;
  String meId;

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
            "${group.averageAge} średnia wieku",
            style: style,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _button(Icons.account_box, "Kandydaci", () {
                context.pushNamed("/group-members-candidates",
                    arguments: group.id);
              }, context),
              _button(Icons.group_add, "Dodaj", () => 2, context),
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
              ? _button(Icons.add, null, () {
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
        group = state.group;
        friendCandidates = state.friendCandidates;
        meId = state.meId;
      } else if (state is GroupInfoLoading) {
        showLoadingSnackbar(context, message: "");
      } else if (state is GroupInfoAddFailure) {
        showErrorSnackbar(context, message: "Nie udało się dodać do znajomych");
      } else if (state is GroupInfoAddSuccess) {
        showSuccessSnackbar(context, message: "Dodano do znajomych");
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
        return Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                      _header(context),
                    ] +
                    group.members
                        .where((element) => element.id != meId)
                        .map((e) => _memberListTile(e, context))
                        .toList(),
              ),
            ));
      }
    });
  }
}
