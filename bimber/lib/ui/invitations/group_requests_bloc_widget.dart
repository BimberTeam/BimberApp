import 'package:bimber/bloc/group_requests/group_requests_bloc.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/invitations/group_request_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupRequestsBlocWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<GroupRequestsBloc>(
      create: (context) => GroupRequestsBloc(
          groupRepository: context.repository<GroupRepository>())
        ..add(InitGroupRequests()),
      child: BlocConsumer<GroupRequestsBloc, GroupRequestsState>(
        listener: (context, state) {
          if (state is GroupRequestsLoading) {
            showLoadingSnackbar(context, message: "");
          } else if (state is GroupRequestsCancelError) {
            showErrorSnackbar(context,
                message: "Nie udało się usunąć zaproszenia");
          } else if (state is GroupRequestsAcceptError) {
            showErrorSnackbar(context,
                message: "Nie udało się zaakceptować zaproszenia");
          } else if (state is GroupRequestsCancelSuccess) {
            showSuccessSnackbar(context, message: "Usunięto zaproszenie");
          } else if (state is GroupRequestsAcceptSuccess) {
            showSuccessSnackbar(context, message: "Zaakaceptowano zaproszenie do grupy");
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
                      valueColor:
                      AlwaysStoppedAnimation<Color>(indigoDye),
                      strokeWidth: 3.0)),
            );
          } else if (state is GroupRequestsError) {
            return Container(); //TODO error message
          } else {
            return GroupRequestList(groups: (state as GroupRequestsResources).getGroupRequests());
          }
        },
      ),
    );
  }

}