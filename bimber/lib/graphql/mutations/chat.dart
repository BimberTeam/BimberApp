import 'package:graphql_flutter/graphql_flutter.dart';

final sendChatMessage = gql(r"""
mutation SendChatMessage($groupId: ID!, $message: String!) {
  sendChatMessage(input: {
    groupId: $groupId, message: $message
  }) {
    status
    message
  }
}
""");
