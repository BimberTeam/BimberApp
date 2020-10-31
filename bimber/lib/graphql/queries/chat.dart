import 'package:graphql_flutter/graphql_flutter.dart';

final loadChatMessages = gql(r"""
query LoadChatMessages($groupId: ID!, $limit: Int, $lastDate: BimberDate) {
  loadChatMessages(input: {
    groupId: $groupId, limit: $limit, lastDate: $lastDate
    }) {
    groupId
    userId
    message
    date
  }
}
""");
