import 'package:graphql_flutter/graphql_flutter.dart';

final acceptGroupRequest = gql(r'''
mutation AcceptGroupInvitation($input: AcceptGroupInvitationInput!){
   acceptGroupInvitation(input: $input) {
      message
      status
    }
  }
''');

final rejectGroupRequest = gql(r'''
mutation RejectGroupInvitation($input: RejectGroupInvitationInput!){
    rejectGroupInvitation(input: $input) {
      message
      status
    }
}
''');
