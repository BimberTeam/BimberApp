import 'package:bimber/bloc/friend_requests/friend_requests_bloc.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/invitations/friend_request_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequestBlocWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  BlocProvider<FriendRequestsBloc>(
     create: (context) => FriendRequestsBloc(
         friendRepository: context.repository<FriendRepository>())
       ..add(InitFriendRequests()),
     child: BlocConsumer<FriendRequestsBloc, FriendRequestsState>(
       listener: (context, state) {
         if (state is FriendRequestsLoading) {
           showLoadingSnackbar(context, message: "");
         } else if (state is FriendRequestsCancelError) {
           showErrorSnackbar(context,
               message: "Nie udało się usunąć zaproszenia");
         } else if (state is FriendRequestsAcceptError) {
           showErrorSnackbar(context,
               message: "Nie udało się zaakceptować zaproszenia");
         } else if (state is FriendRequestsCancelSuccess) {
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
                     valueColor:
                     AlwaysStoppedAnimation<Color>(indigoDye),
                     strokeWidth: 3.0)),
           );
         } else if (state is FriendRequestsError) {
           return Container(); //TODO error message
         } else {
           return FriendRequestList(
             users: (state as FriendRequestsResources).getFriendRequests(),
           );
         }
       },
     ),
   );
  }
  
}