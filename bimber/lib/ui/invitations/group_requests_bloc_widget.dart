import 'package:bimber/bloc/group_requests/group_requests_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:bimber/ui/invitations/invitations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class GroupRequestsBlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupRequestsBloc>(
      create: (context) => GroupRequestsBloc(
          groupRepository: context.repository<GroupRepository>())
        ..add(InitGroupRequests()),
      child: BlocConsumer<GroupRequestsBloc, GroupRequestState>(
        listener: (context, state) {
          if (state is GroupRequestsLoading) {
            showLoadingSnackbar(context, message: "Ładowanie zaproszeń...");
          } else if (state is GroupRequestDeclineError) {
            showErrorSnackbar(context,
                message: "Nie udało się usunąć zaproszenia");
          } else if (state is GroupRequestAcceptError) {
            showErrorSnackbar(context,
                message: "Nie udało się zaakceptować zaproszenia");
          } else if (state is GroupRequestDeclineSuccess) {
            showSuccessSnackbar(context, message: "Usunięto zaproszenie");
          } else if (state is GroupRequestAcceptSuccess) {
            showSuccessSnackbar(context,
                message: "Zaakaceptowano zaproszenie do grupy");
          }
        },
        builder: (context, state) {
          if (state is GroupRequestsInitial) {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(indigoDye),
                      strokeWidth: 3.0)),
            );
          } else if (state is GroupRequestsError) {
            return Container(); //TODO error message
          } else {
            return InvitationsList<Group>(
              list: (state as GroupRequestResources).getGroupRequests(),
              onRefresh: () {
                context.bloc<GroupRequestsBloc>().add(RefetchGroupRequests());
                return Future.delayed(Duration(seconds: 1));
              },
              createLeadingWidget: (Group group) => GestureDetector(
                  onTap: () {
                    context.pushNamed("/group-details", arguments: group);
                  },
                  child: GroupImageHero(group: group, size: Size(60, 60), radius: BorderRadius.circular(15.0),)),
              createTitle: (Group group) => "Grupa",
              createSubtitle: (Group group) =>
                  "${group.members.length.toString()} osób",
              onDecline: (Group group) {
                context
                    .bloc<GroupRequestsBloc>()
                    .add(DeclineGroupRequest(groupId: group.id));
              },
              onAccept: (Group group) {
                context
                    .bloc<GroupRequestsBloc>()
                    .add(AcceptGroupRequest(groupId: group.id));
              },
            );
          }
        },
      ),
    );
  }
}
