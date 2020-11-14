import 'package:graphql_flutter/graphql_flutter.dart';

final groupList = gql(r'''
query GroupList {
  me {
    __typename
    id
    groups {
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
}
''');

final groupInvitationsList = gql(r'''
query GroupInvitationsList {
  me {
    __typename
    id
    groupInvitations {
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
}
''');

final group = gql(r'''
query Group($id: ID!) {
  group(id: $id) {
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

final groupCandidates = gql(r'''
query GroupCandidates($id: ID!) {
  groupCandidates(input: {groupId: $id}) {
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

final votingResults = gql(r'''
query GroupCandidatesResult($id: ID!) {
  groupCandidatesResult(input: {groupId: $id}) {
  __typename
  user {
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
  votesAgainst
  votesInFavour
  groupCount
  }
}
''');
