import 'package:graphql_flutter/graphql_flutter.dart';

final loadChatMessages = gql(r"""
query LoadChatMessages($groupId: ID!, $limit: Int, $lastDate: BimberDate) {
  loadChatMessages(input: {
    groupId: $groupId, limit: $limit, lastDate: $lastDate
    }) {
    name
    groupId
    userId
    message
    date
  }
}
""");

final chatThumbnails = gql(r"""
query ChatThumbnails {
  chatThumbnails {
    groupId
    name
    lastMessage {
      name
      userId
      groupId
      date
      message
    }
  }
}
""");
