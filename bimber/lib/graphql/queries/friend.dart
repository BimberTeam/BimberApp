import 'package:graphql_flutter/graphql_flutter.dart';

final friendInvitationList = gql(r'''
query RequestedFriendsList {
  me {
    __typename
    id
    friendRequests {
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
  }
}
''');

final friendsList = gql(r'''
query FriendsList {
  me {
    __typename
    id
    friends {
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

  }
}
''');

final listFriendsWithoutGroupMembership = gql(r'''
query ListFriendsWithoutGroupMembership($id: ID!) {
  listFriendsWithoutGroupMembership(id: $id) {
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
}
''');

final groupMembersWithoutFriendship = gql(r'''
query GroupMembersWithoutFriendship($id: ID!) {
  groupMembersWithoutFriendship(groupId: $id) {
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
}
''');
