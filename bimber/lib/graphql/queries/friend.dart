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
      email
      age
      favoriteAlcoholName
      favoriteAlcoholType
      description
      gender
      genderPreference
      alcoholPreference
      agePreferenceFrom
      agePreferenceTo  
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
      email
      age
      favoriteAlcoholName
      favoriteAlcoholType
      description
      gender
      genderPreference
      alcoholPreference
      agePreferenceFrom
      agePreferenceTo
      latestLocation {
        latitude
        longitude
      }
    }

  }
}
''');

final listFriendsWithoutGroupMembership = gql(r'''
query ListFriendWithoutGroupMembership($id: ID!) {
  listFriendWithoutGroupMembership(id: $id) {
    __typename
    id
    name
    email
    age
    favoriteAlcoholName
    favoriteAlcoholType
    description
    gender
    genderPreference
    alcoholPreference
    agePreferenceFrom
    agePreferenceTo
    latestLocation {
      latitude
      longitude
    }
  }
}
''');
