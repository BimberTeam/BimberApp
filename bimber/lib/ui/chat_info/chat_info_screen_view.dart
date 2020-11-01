import 'package:bimber/bloc/chat_info/chat_info_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInfoViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatInfoViewScreenState();
}

class ChatInfoViewScreenState extends State<ChatInfoViewScreen> {
  Group group;
  List<String> canBeAdded;
  String currentUserId;

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
              _button(Icons.search, "Odkryj", () => 1, context),
              _button(Icons.people, "Dodaj", () => 2, context),
              _button(Icons.map, "Mapa", () => 3, context)
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
              }),
          title: Text(
            user.name,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
          trailing: canBeAdded.contains(user.id)
              ? _button(Icons.add, null, () {
                  context
                      .bloc<ChatInfoBloc>()
                      .add(AddMemberToFriends(id: user.id));
                }, context)
              : SizedBox(
                  width: 0,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatInfoBloc, ChatInfoState>(builder: (context, state) {
      if (state is ChatInfoInitial) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary),
                  strokeWidth: 3.0)),
        );
      } else if (state is ChatInfoError) {
        return Container(
            alignment: Alignment.center,
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
                        .where((element) => element.id != currentUserId)
                        .map((e) => _memberListTile(e, context))
                        .toList(),
              ),
            ));
      }
    }, listener: (context, state) {
      if (state is ChatInfoFetched) {
        group = state.group;
        canBeAdded = state.canBeAdded;
        currentUserId = state.currentUserId;
      } else if (state is ChatInfoLoading) {
        showLoadingSnackbar(context, message: "");
      } else if (state is ChatInfoAddFailure) {
        showErrorSnackbar(context, message: "Nie udało się dodać do znajomych");
      } else if (state is ChatInfoAddSuccess) {
        showSuccessSnackbar(context, message: "Dodano do znajomych");
      }
    });
  }
}
