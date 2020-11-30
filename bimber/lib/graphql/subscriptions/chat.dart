import 'package:graphql_flutter/graphql_flutter.dart';

final newChatMessage = gql(r"""
subscription NewChatMessage($groupId: ID!) {
  newChatMessage(input: {
    groupId: $groupId
    }) {
    userId
    name
    groupId
    message
    date
  }
}
""");
