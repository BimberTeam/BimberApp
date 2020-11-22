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

final groupSuggestions = gql(r'''
mutation SuggestGroups($limit: Int!, $range: Int!){
    suggestGroups(input: {
    limit: $limit,
    range: $range
    }) {
      __typename
      id
      members{
         __typename
        id
        name
        age
        favoriteAlcoholName
        favoriteAlcoholType
        description
        gender
        latestLocation {
          latitude
          longitude
        }   
      }
      averageAge
      averageLocation{
        latitude
        longitude
      }
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
    swipeToDisLike(input: {
    groupId: $groupId
    }) {
      message
      status
    }
}
''');
