import 'package:graphql_flutter/graphql_flutter.dart';

final acceptFriendRequest = gql(r'''
mutation AcceptFriendRequest($friendId: String!){
    acceptFriendRequest(friendId: $friendId) {
      message
      status
    }
  }
''');

final denyFriendRequest = gql(r'''
mutation DenyFriendRequest($friendId: String!){
    denyFriendRequest(friendId: $friendId) {
      message
      status
    }
}
''');
