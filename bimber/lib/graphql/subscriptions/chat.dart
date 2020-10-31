import 'package:graphql_flutter/graphql_flutter.dart';

final newChatMessage = gql(r"""
subscription NewChatMessage($groupId: ID!) {
  newChatMessage(groupId: $gropuId) {
    userId
    groupId
    message
    date
  }
}
""");
