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
    averageAge
    averageLocation{
      latitude
      longitude
    }
  }
}
''');
