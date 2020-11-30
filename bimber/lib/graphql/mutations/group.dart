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
mutation AddFriendToGroup($groupId: ID!, $userId: ID!){
    addFriendToGroup(input: {
    userId: $userId,
    groupId: $groupId
    }) {
      message
      status
    }
}
''');

final voteFor = gql(r'''
mutation AcceptGroupPendingUser($groupId: ID!, $userId: ID!){
    acceptGroupPendingUser(input: {
    userId: $userId,
    groupId: $groupId
    }) {
      message
      status
    }
}
''');

final voteAgainst = gql(r'''
mutation RejectGroupPendingUser($groupId: ID!, $userId: ID!){
    rejectGroupPendingUser(input: {
    userId: $userId,
    groupId: $groupId
    }) {
      message
      status
    }
}
''');

final swipeToLike = gql(r'''
mutation SwipeToLike($groupId: ID!){
    swipeToLike(input: {
    groupId: $groupId
    }) {
      message
      status
    }
}
''');

final swipeToDislike = gql(r'''
mutation SwipeToDislike($groupId: ID!){
    swipeToDislike(input: {
    groupId: $groupId
    }) {
      message
      status
    }
}
''');
