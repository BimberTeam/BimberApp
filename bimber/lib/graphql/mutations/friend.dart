import 'package:graphql_flutter/graphql_flutter.dart';

final acceptFriendRequest = gql(r'''
mutation AcceptFriendRequest($input: FriendInput!){
    acceptFriendRequest(input: $input) {
      message
      status
    }
  }
''');

final denyFriendRequest = gql(r'''
mutation DenyFriendRequest($input: FriendInput!){
    denyFriendRequest(input: $input) {
      message
      status
    }
}
''');

final removeFriend = gql(r'''
mutation RemoveFriend($input: FriendInput!){
    removeFriend(input: $input) {
      message
      status
    }
  }
''');

final addFriend = gql(r'''
mutation SendFriendRequest($input: FriendInput!){
    sendFriendRequest(input: $input) {
      message
      status
    }
  }
''');
