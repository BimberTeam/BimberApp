import 'package:graphql_flutter/graphql_flutter.dart';

final acceptFriendRequest = gql(r'''
mutation AcceptFriendRequest($friendId: ID!){
    acceptFriendRequest(friendId: $friendId) {
      message
      status
    }
  }
''');

final denyFriendRequest = gql(r'''
mutation DenyFriendRequest($userId: ID!){
    denyFriendRequest(userId: $userId) {
      message
      status
    }
}
''');

final removeFriend = gql(r'''
mutation RemoveFriend($friendId: ID!){
    removeFriend(friendId: $friendId) {
      message
      status
    }
  }
''');

final addFriend = gql(r'''
mutation SendFriendRequest($friendId: ID!){
    sendFriendRequest(friendId: $friendId) {
      message
      status
    }
  }
''');