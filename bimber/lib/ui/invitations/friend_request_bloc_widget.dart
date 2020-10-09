import 'package:bimber/bloc/friend_requests/friend_requests_bloc.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bimber/ui/invitations/invitations_list.dart';
import 'package:flutter/material.dart';

class FriendRequestBlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendRequestBloc>(
      create: (context) => FriendRequestBloc(
          friendRepository: context.repository<FriendRepository>())
        ..add(InitFriendRequests()),
      child: BlocConsumer<FriendRequestBloc, FriendRequestState>(
        listener: (context, state) {
          if (state is FriendRequestsLoading) {
            showLoadingSnackbar(context, message: "Ładowanie zaproszeń...");
          } else if (state is FriendRequestsDeclineError) {
            showErrorSnackbar(context,
                message: "Nie udało się usunąć zaproszenia");
          } else if (state is FriendRequestsAcceptError) {
            showErrorSnackbar(context,
                message: "Nie udało się zaakceptować zaproszenia");
          } else if (state is FriendRequestsDeclineSuccess) {
            showSuccessSnackbar(context, message: "Usunięto zaproszenie");
          } else if (state is FriendRequestsAcceptSuccess) {
            showSuccessSnackbar(context, message: "Dodano nowego znajomego");
          }
        },
        builder: (context, state) {
          if (state is FriendRequestsInitial) {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(indigoDye),
                      strokeWidth: 3.0)),
            );
          } else if (state is FriendRequestsError) {
            return Container(); //TODO error message
          } else {
            return InvitationsList<User>(
              list: (state as FriendRequestResources).getFriendRequests(),
              onRefresh: () {
                context.bloc<FriendRequestBloc>().add(RefetchFriendRequests());
                return Future.delayed(Duration(seconds: 1));
              },
              createLeadingWidget: (User user) => UserImageHero(
                    user: user,
                    size: Size(60, 60),
                    onTap: () {
                      context.pushNamed("/user-details", arguments: user);
                    }),
              createTitle: (User user) => user.name,
              createSubtitle: (User user) => user.age.toString(),
              onAccept: (User user) {
                context
                    .bloc<FriendRequestBloc>()
                    .add(AcceptFriendRequest(friendId: user.id));
              },
              onDecline: (User user) {
                context
                    .bloc<FriendRequestBloc>()
                    .add(DeclineFriendRequest(friendId: user.id));
              },
            );
          }
        },
      ),
    );
  }
}
