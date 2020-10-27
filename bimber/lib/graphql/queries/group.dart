import 'package:graphql_flutter/graphql_flutter.dart';

final groupList = gql(r'''
query GroupList {
  me {
    __typename
    id
    groups {
      __typename
      id
      members
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
      members
      averageAge
      averageLocation{
        latitude
        longitude
      }
    }
  }
}
''');