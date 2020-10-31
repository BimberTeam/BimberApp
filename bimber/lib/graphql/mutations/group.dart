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


final createGroup = gql(r'''
mutation CreateGroup($usersId: [ID!]!){
    createGroup(input: {
    usersId: $usersId
    }) {
      message
      status
    }
}
''');


final addToGroup = gql(r'''
mutation AddFriendToGroup($groupId: ID!, $friendId: ID!){
    addFriendToGroup(input: {
    friendId: $friendId,
    groupId: $groupId
    }) {
      message
      status
    }
}
''');